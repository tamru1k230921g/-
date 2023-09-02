--------------------
------- XML --------
--------------------

CREATE TABLE role_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;

CREATE TABLE user_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;

CREATE TABLE artist_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;

CREATE TABLE album_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;

CREATE TABLE song_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;

CREATE TABLE saved_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;

CREATE TABLE playlist_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;

CREATE TABLE playlist_song_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;

CREATE TABLE listened_tracks_table_XML (xml_data XMLType) XMLTYPE COLUMN xml_data STORE AS BINARY XML;


/-- insert
CREATE OR REPLACE TRIGGER trg_role_table
AFTER INSERT ON role_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<role>' ||
'<role_id>' || :new.role_id || '</role_id>' ||
'<role_name>' || :new.role_name || '</role_name>' ||
'</role>'
)
INTO v_xml
FROM dual;
INSERT INTO role_table_XML (xml_data) VALUES (v_xml);
END;

CREATE OR REPLACE TRIGGER trg_user_table
AFTER INSERT ON user_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<user>' ||
'<user_id>' || :new.user_id || '</user_id>' ||
'<user_login>' || :new.user_login || '</user_login>' ||
'<user_password>' || :new.user_password || '</user_password>' ||
'<user_role>' || :new.user_role || '</user_role>' ||
'</user>'
)
INTO v_xml
FROM dual;
INSERT INTO user_table_XML (xml_data) VALUES (v_xml);
END;
/

CREATE OR REPLACE TRIGGER trg_artist_table
AFTER INSERT ON artist_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<artist>' ||
'<artist_id>' || :new.artist_id || '</artist_id>' ||
'<artist_name>' || :new.artist_name || '</artist_name>' ||
'</artist>'
)
INTO v_xml
FROM dual;
INSERT INTO artist_table_XML (xml_data) VALUES (v_xml);
END;
/

CREATE OR REPLACE TRIGGER trg_album_table
AFTER INSERT ON album_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<album>' ||
'<album_id>' || :new.album_id || '</album_id>' ||
'<album_artist>' || :new.album_artist || '</album_artist>' ||
'<album_name>' || :new.album_name || '</album_name>' ||
'<album_released>' || :new.album_released || '</album_released>' ||
'</album>'
)
INTO v_xml
FROM dual;
INSERT INTO album_table_XML (xml_data) VALUES (v_xml);
END;
/

CREATE OR REPLACE TRIGGER trg_song_table
AFTER INSERT ON song_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<song>' ||
'<song_id>' || :new.song_id || '</song_id>' ||
'<song_artist>' || :new.song_artist || '</song_artist>' ||
'<song_album>' || :new.song_album || '</song_album>' ||
'<song_name>' || :new.song_name || '</song_name>' ||
'</song>'
)
INTO v_xml
FROM dual;
INSERT INTO song_table_XML (xml_data) VALUES (v_xml);
END;
/

CREATE OR REPLACE TRIGGER trg_saved_table
AFTER INSERT ON saved_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<saved>' ||
'<saved_id>' || :new.saved_id || '</saved_id>' ||
'<saved_user>' || :new.saved_user || '</saved_user>' ||
'<saved_song>' || :new.saved_song || '</saved_song>' ||
'</saved>'
)
INTO v_xml
FROM dual;
INSERT INTO saved_table_XML (xml_data) VALUES (v_xml);
END;
/

CREATE OR REPLACE TRIGGER trg_playlist_table
AFTER INSERT ON playlist_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<playlist>' ||
'<playlist_id>' || :new.playlist_id || '</playlist_id>' ||
'<playlist_name>' || :new.playlist_name || '</playlist_name>' ||
'<playlist_user>' || :new.playlist_user || '</playlist_user>' ||
'</playlist>'
)
INTO v_xml
FROM dual;
INSERT INTO playlist_table_XML (xml_data) VALUES (v_xml);
END;
/

CREATE OR REPLACE TRIGGER trg_playlist_song_table
AFTER INSERT ON playlist_song_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<playlist_song>' ||
'<playlist_song_id>' || :new.playlist_song_id || '</playlist_song_id>' ||
'<playlist_song_playlist>' || :new.playlist_song_playlist || '</playlist_song_playlist>' ||
'<playlist_song_song>' || :new.playlist_song_song || '</playlist_song_song>' ||
'</playlist_song>'
)
INTO v_xml
FROM dual;
INSERT INTO playlist_song_table_XML (xml_data) VALUES (v_xml);
END;
/

CREATE OR REPLACE TRIGGER trg_listened_tracks_table
AFTER INSERT ON listened_tracks_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<listened_track>' ||
'<listened_track_id>' || :new.listened_tracks_id || '</listened_track_id>' ||
'<listened_track_user>' || :new.listened_tracks_user || '</listened_track_user>' ||
'<listened_track_song>' || :new.listened_tracks_song || '</listened_track_song>' ||
'<listened_track_date>' || :new.listened_tracks_date || '</listened_track_date>' ||
'</listened_track>'
)
INTO v_xml
FROM dual;
INSERT INTO listened_tracks_table_XML (xml_data) VALUES (v_xml);
END;
/
----


---- update
CREATE OR REPLACE TRIGGER trg_role_table_update
AFTER UPDATE ON role_table
FOR EACH ROW
DECLARE
  v_xml XMLType;
BEGIN
  SELECT XMLType(
           '<role>' ||
           '<role_id>' || :new.role_id || '</role_id>' ||
           '<role_name>' || :new.role_name || '</role_name>' ||
           '</role>'
         )
  INTO v_xml
  FROM dual;

  UPDATE role_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/role/role_id/text()') = :new.role_id;
END;
/

CREATE OR REPLACE TRIGGER trg_user_table_update
AFTER UPDATE ON user_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<user>' ||
'<user_id>' || :new.user_id || '</user_id>' ||
'<user_login>' || :new.user_login || '</user_login>' ||
'<user_password>' || :new.user_password || '</user_password>' ||
'<user_role>' || :new.user_role || '</user_role>' ||
'</user>'
)
INTO v_xml
FROM dual;
UPDATE user_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/user/user_id/text()') = :new.user_id;
END;
/

CREATE OR REPLACE TRIGGER trg_album_table_update
AFTER UPDATE ON album_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<album>' ||
'<album_id>' || :new.album_id || '</album_id>' ||
'<album_artist>' || :new.album_artist || '</album_artist>' ||
'<album_name>' || :new.album_name || '</album_name>' ||
'<album_released>' || :new.album_released || '</album_released>' ||
'</album>'
)
INTO v_xml
FROM dual;
UPDATE album_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/album/album_id/text()') = :new.album_id;
END;
/

CREATE OR REPLACE TRIGGER trg_song_table_update
AFTER UPDATE ON song_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<song>' ||
'<song_id>' || :new.song_id || '</song_id>' ||
'<song_artist>' || :new.song_artist || '</song_artist>' ||
'<song_album>' || :new.song_album || '</song_album>' ||
'<song_name>' || :new.song_name || '</song_name>' ||
'</song>'
)
INTO v_xml
FROM dual;
UPDATE song_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/song/song_id/text()') = :new.song_id;
END;
/

CREATE OR REPLACE TRIGGER trg_saved_table_update
AFTER UPDATE ON saved_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<saved>' ||
'<saved_id>' || :new.saved_id || '</saved_id>' ||
'<saved_user>' || :new.saved_user || '</saved_user>' ||
'<saved_song>' || :new.saved_song || '</saved_song>' ||
'</saved>'
)
INTO v_xml
FROM dual;
UPDATE saved_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/saved/saved_id/text()') = :new.saved_id;
END;
/

CREATE OR REPLACE TRIGGER trg_playlist_table_update
AFTER UPDATE ON playlist_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<playlist>' ||
'<playlist_id>' || :new.playlist_id || '</playlist_id>' ||
'<playlist_name>' || :new.playlist_name || '</playlist_name>' ||
'<playlist_user>' || :new.playlist_user || '</playlist_user>' ||
'</playlist>'
)
INTO v_xml
FROM dual;
UPDATE playlist_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/playlist/playlist_id/text()') = :new.playlist_id;
END;
/

CREATE OR REPLACE TRIGGER trg_playlist_song_table_update
AFTER UPDATE ON playlist_song_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<playlist_song>' ||
'<playlist_song_id>' || :new.playlist_song_id || '</playlist_song_id>' ||
'<playlist_song_playlist>' || :new.playlist_song_playlist || '</playlist_song_playlist>' ||
'<playlist_song_song>' || :new.playlist_song_song || '</playlist_song_song>' ||
'</playlist_song>'
)
INTO v_xml
FROM dual;
UPDATE playlist_song_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/playlist_song/playlist_song_id/text()') = :new.playlist_song_id;
END;
/

CREATE OR REPLACE TRIGGER trg_listened_t_update
AFTER UPDATE ON listened_tracks_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<listened_track>' ||
'<listened_track_id>' || :new.listened_tracks_id || '</listened_track_id>' ||
'<listened_track_user>' || :new.listened_tracks_user || '</listened_track_user>' ||
'<listened_track_song>' || :new.listened_tracks_song || '</listened_track_song>' ||
'<listened_track_date>' || :new.listened_tracks_date || '</listened_track_date>' ||
'</listened_track>'
)
INTO v_xml
FROM dual;
UPDATE listened_tracks_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/listened_track/listened_track_id/text()') = :new.listened_tracks_id;
END;
/

CREATE OR REPLACE TRIGGER trg_artist_t_update
AFTER UPDATE ON artist_table
FOR EACH ROW
DECLARE
v_xml XMLType;
BEGIN
SELECT XMLType(
'<artist>' ||
'<artist_id>' || :new.artist_id || '</artist_id>' ||
'<artist_name>' || :new.artist_name || '</artist_name>' ||
'</artist>'
)
INTO v_xml
FROM dual;
UPDATE artist_table_XML SET xml_data = v_xml WHERE EXTRACTVALUE(xml_data, '/artist/artist_id/text()') = :new.artist_id;
END;
/
----


---- delete
CREATE OR REPLACE TRIGGER trg_role_table_delete
AFTER DELETE ON role_table
FOR EACH ROW
BEGIN
    DELETE FROM role_table_XML WHERE EXTRACTVALUE(xml_data, '/role/role_id/text()') = :old.role_id;
END;
/

CREATE OR REPLACE TRIGGER trg_user_table_delete
AFTER DELETE ON user_table
FOR EACH ROW
BEGIN
DELETE FROM user_table_XML WHERE EXTRACTVALUE(xml_data, '/user/user_id/text()') = :old.user_id;
END;
/

CREATE OR REPLACE TRIGGER trg_album_table_delete
AFTER DELETE ON album_table
FOR EACH ROW
BEGIN
DELETE FROM album_table_XML WHERE EXTRACTVALUE(xml_data, '/album/album_id/text()') = :old.album_id;
END;
/

CREATE OR REPLACE TRIGGER trg_song_table_delete
AFTER DELETE ON song_table
FOR EACH ROW
BEGIN
DELETE FROM song_table_XML WHERE EXTRACTVALUE(xml_data, '/song/song_id/text()') = :old.song_id;
END;
/

CREATE OR REPLACE TRIGGER trg_saved_table_delete
AFTER DELETE ON saved_table
FOR EACH ROW
BEGIN
DELETE FROM saved_table_XML WHERE EXTRACTVALUE(xml_data, '/saved/saved_id/text()') = :old.saved_id;
END;
/

CREATE OR REPLACE TRIGGER trg_playlist_table_delete
AFTER DELETE ON playlist_table
FOR EACH ROW
BEGIN
DELETE FROM playlist_table_XML WHERE EXTRACTVALUE(xml_data, '/playlist/playlist_id/text()') = :old.playlist_id;
END;
/

CREATE OR REPLACE TRIGGER trg_playlist_s_t_delete
AFTER DELETE ON playlist_song_table
FOR EACH ROW
BEGIN
DELETE FROM playlist_song_table_XML WHERE EXTRACTVALUE(xml_data, '/playlist_song/playlist_song_id/text()') = :old.playlist_song_id;
END;
/

CREATE OR REPLACE TRIGGER trg_listened_t_delete
AFTER DELETE ON listened_tracks_table
FOR EACH ROW
BEGIN
DELETE FROM listened_tracks_table_XML WHERE EXTRACTVALUE(xml_data, '/listened_track/listened_track_id/text()') = :old.listened_tracks_id;
END;
/

CREATE OR REPLACE TRIGGER trg_artist_t_delete
AFTER DELETE ON artist_table
FOR EACH ROW
BEGIN
DELETE FROM artist_table_XML WHERE EXTRACTVALUE(xml_data, '/artist/artist_id/text()') = :old.artist_id;
END;
/
----








EXECUTE SAVE_role_table_XML;
EXECUTE SAVE_ALBUM_TABLE_XML;
EXECUTE SAVE_USER_TABLE_XML;
EXECUTE SAVE_SAVED_TABLE_XML;
EXECUTE SAVE_SONG_TABLE_XML;
EXECUTE SAVE_PLAYLIST_TABLE_XML;
EXECUTE SAVE_PLAYLIST_SONG_TABLE_XML;
EXECUTE SAVE_LISTENED_TRACKS_TABLE_XML;
EXECUTE SAVE_ARTIST_TABLE_XML;

GRANT READ, WRITE ON DIRECTORY XMLIMPORT TO administrator;
CREATE OR REPLACE DIRECTORY XMLIMPORT AS 'C:\app\Kursach\XMLIMPORT';
CREATE OR REPLACE DIRECTORY XML_DIR AS 'C:\app\Kursach\XMLDIR';
GRANT READ, WRITE ON DIRECTORY XML_DIR TO administrator;
-- role
CREATE OR REPLACE PROCEDURE SAVE_role_table_XML AS
    v_xml XMLType;
    v_file UTL_FILE.file_type;
BEGIN
    v_file := UTL_FILE.FOPEN('XML_DIR', 'role.xml', 'W');

    UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
    UTL_FILE.PUT_LINE(v_file, '<roles>');
    
    FOR rec IN (SELECT xml_data FROM role_table_XML)
    LOOP
        v_xml := rec.xml_data;
        UTL_FILE.put_line(v_file, v_xml.getClobVal());
    END LOOP;
    
    UTL_FILE.PUT_LINE(v_file, '</roles>');

    UTL_FILE.FCLOSE(v_file);
END;
/
--album_table
CREATE OR REPLACE PROCEDURE SAVE_ALBUM_TABLE_XML AS
v_xml XMLType;
v_file UTL_FILE.file_type;
BEGIN
v_file := UTL_FILE.FOPEN('XML_DIR', 'album_table.xml', 'W');
UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
UTL_FILE.PUT_LINE(v_file, '<album_table>');

FOR rec IN (SELECT xml_data FROM album_table_XML)
LOOP
    v_xml := rec.xml_data;
    UTL_FILE.put_line(v_file, v_xml.getClobVal());
END LOOP;

UTL_FILE.PUT_LINE(v_file, '</album_table>');

UTL_FILE.FCLOSE(v_file);
END;
/
--user_table
CREATE OR REPLACE PROCEDURE SAVE_USER_TABLE_XML AS
v_xml XMLType;
v_file UTL_FILE.file_type;
BEGIN
v_file := UTL_FILE.FOPEN('XML_DIR', 'user_table.xml', 'W');
UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
UTL_FILE.PUT_LINE(v_file, '<user_table>');

FOR rec IN (SELECT xml_data FROM user_table_XML)
LOOP
    v_xml := rec.xml_data;
    UTL_FILE.put_line(v_file, v_xml.getClobVal());
END LOOP;

UTL_FILE.PUT_LINE(v_file, '</user_table>');

UTL_FILE.FCLOSE(v_file);
END;
/
--song_table
CREATE OR REPLACE PROCEDURE SAVE_SONG_TABLE_XML AS
v_xml XMLType;
v_file UTL_FILE.file_type;
BEGIN
v_file := UTL_FILE.FOPEN('XML_DIR', 'song_table.xml', 'W');
UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
UTL_FILE.PUT_LINE(v_file, '<song_table>');

FOR rec IN (SELECT xml_data FROM song_table_XML)
LOOP
    v_xml := rec.xml_data;
    UTL_FILE.put_line(v_file, v_xml.getClobVal());
END LOOP;

UTL_FILE.PUT_LINE(v_file, '</song_table>');

UTL_FILE.FCLOSE(v_file);
END;
/
--saved_table
CREATE OR REPLACE PROCEDURE SAVE_SAVED_TABLE_XML AS
v_xml XMLType;
v_file UTL_FILE.file_type;
BEGIN
v_file := UTL_FILE.FOPEN('XML_DIR', 'saved_table.xml', 'W');
UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
UTL_FILE.PUT_LINE(v_file, '<saved_table>');

FOR rec IN (SELECT xml_data FROM saved_table_XML)
LOOP
    v_xml := rec.xml_data;
    UTL_FILE.put_line(v_file, v_xml.getClobVal());
END LOOP;

UTL_FILE.PUT_LINE(v_file, '</saved_table>');

UTL_FILE.FCLOSE(v_file);
END;
/
--playlist_table
CREATE OR REPLACE PROCEDURE SAVE_PLAYLIST_TABLE_XML AS
v_xml XMLType;
v_file UTL_FILE.file_type;
BEGIN
v_file := UTL_FILE.FOPEN('XML_DIR', 'playlist_table.xml', 'W');
UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
UTL_FILE.PUT_LINE(v_file, '<playlist_table>');

FOR rec IN (SELECT xml_data FROM playlist_table_XML)
LOOP
    v_xml := rec.xml_data;
    UTL_FILE.put_line(v_file, v_xml.getClobVal());
END LOOP;

UTL_FILE.PUT_LINE(v_file, '</playlist_table>');

UTL_FILE.FCLOSE(v_file);
END;
/
--playlist_song_table
CREATE OR REPLACE PROCEDURE SAVE_PLAYLIST_SONG_TABLE_XML AS
v_xml XMLType;
v_file UTL_FILE.file_type;
BEGIN
v_file := UTL_FILE.FOPEN('XML_DIR', 'playlist_song_table.xml', 'W');
UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
UTL_FILE.PUT_LINE(v_file, '<playlist_song_table>');

FOR rec IN (SELECT xml_data FROM playlist_song_table_XML)
LOOP
    v_xml := rec.xml_data;
    UTL_FILE.put_line(v_file, v_xml.getClobVal());
END LOOP;

UTL_FILE.PUT_LINE(v_file, '</playlist_song_table>');

UTL_FILE.FCLOSE(v_file);
END;
/
--listened_tracks_table
CREATE OR REPLACE PROCEDURE SAVE_LISTENED_TRACKS_TABLE_XML AS
v_xml XMLType;
v_file UTL_FILE.file_type;
BEGIN
v_file := UTL_FILE.FOPEN('XML_DIR', 'listened_tracks_table.xml', 'W');
UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
UTL_FILE.PUT_LINE(v_file, '<listened_tracks_table>');

FOR rec IN (SELECT xml_data FROM listened_tracks_table_XML)
LOOP
    v_xml := rec.xml_data;
    UTL_FILE.put_line(v_file, v_xml.getClobVal());
END LOOP;

UTL_FILE.PUT_LINE(v_file, '</listened_tracks_table>');

UTL_FILE.FCLOSE(v_file);
END;
/
--artist_table
CREATE OR REPLACE PROCEDURE SAVE_ARTIST_TABLE_XML AS
v_xml XMLType;
v_file UTL_FILE.file_type;
BEGIN
v_file := UTL_FILE.FOPEN('XML_DIR', 'artist_table.xml', 'W');
UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
UTL_FILE.PUT_LINE(v_file, '<artist_table>');

FOR rec IN (SELECT xml_data FROM artist_table_XML)
LOOP
    v_xml := rec.xml_data;
    UTL_FILE.put_line(v_file, v_xml.getClobVal());
END LOOP;

UTL_FILE.PUT_LINE(v_file, '</artist_table>');

UTL_FILE.FCLOSE(v_file);
END;
/
--------import

--import_role_table_XML
CREATE OR REPLACE PROCEDURE import_role_table_XML AS
    xml_data XMLType; 
    v_xml XMLType;
    v_file UTL_FILE.file_type;
BEGIN
    v_file := UTL_FILE.FOPEN('XML_DIR', 'role.xml', 'W');

    UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0" encoding="utf-8"?>');
    UTL_FILE.PUT_LINE(v_file, '<roles>');
    
    FOR rec IN (SELECT xml_data FROM role_table_XML)
    LOOP
        v_xml := rec.xml_data;
        UTL_FILE.put_line(v_file, v_xml.getClobVal());
    END LOOP;    
    UTL_FILE.PUT_LINE(v_file, '</roles>');
    UTL_FILE.FCLOSE(v_file);
END;


---test
/
BEGIN
    import_role_xml('role.xml');
END;
CREATE OR REPLACE PROCEDURE IMPORT_ALL_XML_DATA
IS
v_clob CLOB;
BEGIN
FILE_TO_CLOB('role', v_clob);
import_role_xml(v_clob);
COMMIT;
END;

EXECUTE IMPORT_ALL_XML_DATA;

create or replace procedure import_role_xml (
    p_file in varchar2
)
as
    v_xml xmltype := xmltype(p_file);
begin
    for item in (
        select extractvalue(value(r), '/ROW/role_id') as role_id,
               extractvalue(value(r), '/ROW/role_name') as role_name
        from table (xmlsequence(extract(v_xml, '/ROWSET/ROW')))r
    )
    loop
        insert into role_table values (
            item.role_id,
            item.role_name
        );
    end loop;
exception
    when others then
        dbms_output.put_line('Error occurred: ' || sqlerrm);
end;
/
create or replace procedure file_to_clob (
    p_file_name in varchar2,
    p_clob out clob
)
as
    v_file utl_file.file_type;
    v_filename varchar2(100);
    v_buffer varchar2(32767);
begin
    -- Генерирование имени файла на основе имени таблицы
    v_filename := p_file_name || '.xml';
    -- Чтение XML из файла
    v_file := utl_file.fopen('XMLIMPORT', v_filename, 'r');
    loop
        utl_file.get_line(v_file, v_buffer);
        if v_buffer = '</rowset>' then
            p_clob := p_clob || v_buffer;
            exit;
        else
            p_clob := p_clob || v_buffer;
        end if;
    end loop;
    utl_file.fclose(v_file);
end;
/


