/*sets the player_sponsor_id value in the Nba_Schedule.Player table when a new record is inserted, if this value is not explicitly specified*/

CREATE OR REPLACE FUNCTION set_default_sponsor_id()
RETURNS trigger AS $$
BEGIN
    IF NEW.player_sponsor_id IS NULL THEN
        SELECT team_sponsor_id INTO NEW.player_sponsor_id
        FROM Nba_Schedule.Team
        WHERE team_lineup_id = NEW.player_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_player_sponsor_id
    BEFORE INSERT ON Nba_Schedule.Player
    FOR EACH ROW
    EXECUTE FUNCTION set_default_sponsor_id();

/*prohibits deleting a team from the Nba Schedule.Team table if this team has matches in the Nba_Schedule.Match table*/

CREATE OR REPLACE FUNCTION prevent_team_deletion()
RETURNS trigger AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM Nba_Schedule.Match WHERE match_home_team_id = OLD.team_id OR match_guest_team_id = OLD.team_id
    ) THEN
        RAISE EXCEPTION 'Cannot delete team with active matches';
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER prevent_team_deletion
    BEFORE DELETE ON Nba_Schedule.Team
    FOR EACH ROW
    EXECUTE FUNCTION prevent_team_deletion();

/*removes all records from the Nba_Schedule.History_Players_Lineup table associated with a player when deleting his record from the Nba_Schedule.Player table*/

CREATE OR REPLACE FUNCTION delete_player_history()
RETURNS trigger AS $$
BEGIN
    DELETE FROM Nba_Schedule.History_Players_Lineup
    WHERE history_player_id = OLD.player_id;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_player_history
    BEFORE DELETE ON Nba_Schedule.Player
    FOR EACH ROW
    EXECUTE FUNCTION delete_player_history();
