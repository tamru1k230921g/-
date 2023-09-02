ALTER SESSION SET CONTAINER = PDB_KURS;

CREATE USER administrator IDENTIFIED BY 2003
    DEFAULT TABLESPACE TS_MAIN QUOTA UNLIMITED ON TS_MAIN
    TEMPORARY TABLESPACE TS_TEMP
    ACCOUNT UNLOCK;
grant dba to administrator;


CREATE OR REPLACE DIRECTORY XML_DIR AS 'C:\XMLDIR';
GRANT READ, WRITE ON DIRECTORY TOUR TO TA_ADMIN;
ALTER SESSION SET CONTAINER = pdb_ta;
ALTER SESSION SET CONTAINER = cdb$root;


------------------- ROLE -------------------
CREATE ROLE ROLE_USER;

GRANT CREATE SESSION TO ROLE_USER;
GRANT SELECT ON role_view TO ROLE_USER;
GRANT SELECT ON user_view TO ROLE_USER;
GRANT SELECT ON album_view TO ROLE_USER;
GRANT SELECT ON artist_view TO ROLE_USER;
GRANT SELECT ON song_view TO ROLE_USER;
GRANT SELECT ON saved_view TO ROLE_USER;
GRANT SELECT ON playlist_view TO ROLE_USER;
GRANT SELECT ON playlist_song_view TO ROLE_USER;
GRANT SELECT ON listened_tracks_view TO ROLE_USER;

CREATE ROLE ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_USERS  ON ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_ROLES ON ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_ARTISTS ON ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_ALBUMS ON ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_SONGS ON ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_SAVED ON ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_PLAYLISTS ON ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_PLAYLIST_SONGS ON ROLE_AUTHOR;
grant execute on PROCEDURE SELECT_LISTENED_TRACKS ON ROLE_AUTHOR;
grant execute on PROCEDURE INSERT_ARTIST on ROLE_AUTHOR;
grant execute on PROCEDURE INSERT_SONG on ROLE_AUTHOR;
grant execute on PROCEDURE INSERT_PLAYLIST on ROLE_AUTHOR;
grant execute on PROCEDURE INSERT_PLAYLIST_SONG on ROLE_AUTHOR;
CREATE ROLE ROLE_ADMIN;
grant execute on  INSERT_ALBUM on ROLE_ADMIN;
grant execute on PROCEDURE INSERT_USER on ROLE_ADMIN;
grant execute on PROCEDURE INSERT_ROLE on ROLE_ADMIN;
grant execute on PROCEDURE INSERT_ARTIST on ROLE_ADMIN;
grant execute on PROCEDURE INSERT_SONG on ROLE_ADMIN;
grant execute on PROCEDURE INSERT_SAVED on ROLE_ADMIN
grant execute on PROCEDURE INSERT_PLAYLIST on ROLE_ADMIN;
grant execute on PROCEDURE INSERT_PLAYLIST_SONG on ROLE_ADMIN;
grant execute on PROCEDURE INSERT_LISTENED_TRACKS on ROLE_ADMIN;
grant execute on PROCEDURE UPDATE_ALBUM on ROLE_ADMIN;
grant execute on procedure UPDATE_ROLE on ROLE_ADMIN;
grant execute on procedure UPDATE_USER on ROLE_ADMIN;
grant execute on procedure UPDATE_ARTIST on ROLE_ADMIN;
grant execute on procedure UPDATE_SONG on ROLE_ADMIN;
grant execute on procedure UPDATE_SAVED on ROLE_ADMIN;
grant execute on procedure UPDATE_PLAYLIST on ROLE_ADMIN;
grant execute on procedure UPDATE_PLAYLIST_SONG on ROLE_ADMIN;
grant execute on procedure UPDATE_LISTENED_TRACKS on ROLE_ADMIN;
------------------- PROFILE -------------------
-- PROFILE PROFILE_CLIENT --
CREATE PROFILE PROLE_USER LIMIT
  PASSWORD_LIFE_TIME UNLIMITED
  SESSIONS_PER_USER 3
  FAILED_LOGIN_ATTEMPTS 5
  PASSWORD_LOCK_TIME 1
  PASSWORD_REUSE_TIME 365
  PASSWORD_GRACE_TIME DEFAULT
  CONNECT_TIME 120
  IDLE_TIME 30;
  grant administrator to ROLE_ADMIN;
  -- PROFILE PROFILE_ANALYST --
CREATE PROFILE PROLE_AUTHOR LIMIT
  PASSWORD_LIFE_TIME 30
  SESSIONS_PER_USER 2
  FAILED_LOGIN_ATTEMPTS 3
  PASSWORD_LOCK_TIME 30
  PASSWORD_REUSE_TIME UNLIMITED
  PASSWORD_GRACE_TIME 7
  CONNECT_TIME 300
  IDLE_TIME 60;
  -- PROFILE ROLE_ADMIN --
CREATE PROFILE PROFILE_ADMIN LIMIT
  PASSWORD_LIFE_TIME 1
  SESSIONS_PER_USER 1
  FAILED_LOGIN_ATTEMPTS 2
  PASSWORD_LOCK_TIME UNLIMITED
  PASSWORD_REUSE_TIME 30
  PASSWORD_GRACE_TIME 1
  CONNECT_TIME UNLIMITED
  IDLE_TIME UNLIMITED;
grant ROLE_ADMIN to PROFILE_ADMIN;

CREATE TABLESPACE TS_MAIN
    DATAFILE 'C:\app\Kursach\TS_MAIN.dbf'
    SIZE 500M
    AUTOEXTEND ON
    EXTENT MANAGEMENT LOCAL;

CREATE TEMPORARY TABLESPACE TS_TEMP
    TEMPFILE 'C:\app\Kursach\TS_TEMP.dbf'
    SIZE 100M
    AUTOEXTEND ON
    EXTENT MANAGEMENT LOCAL;













BEGIN
INSERT_ROLE('ADMIN');
END;
BEGIN
INSERT_ROLE('ADMIN');
INSERT_USER('john_doe', 'password123', 1);
    INSERT_SAVED(1, 1);
INSERT_ARTIST('Led Zeppelin');
INSERT_PLAYLIST('My Playlist', 1);
INSERT_PLAYLIST_SONG(1, 1);
   INSERT_LISTENED_TRACKS(1, 1, SYSDATE);
   INSERT_SONG(1, 1, 'O.D.', BFILENAME('SONGS_DIR', 'OD.mp3'));
   INSERT_ALBUM(1, 'Led Zeppelin IV', 1971, 'ALBUMS_DIR', 'led_zeppelin_iv.jpg');
END;

BEGIN
    UPDATE_ALBUM(1, 2, 'New Album Name', 2023, 'C:\Oracle\Images', 'new_album_image.jpg');
    UPDATE_ROLE(1, 'New Role Name');
    UPDATE_USER(1, 'new_user_login', 'new_user_password', 2);
    UPDATE_ARTIST(1, 'New Artist Name');
    UPDATE_SONG(1, 2, 3, 'New Song Name');
    UPDATE_SAVED(1, 2, 3);
    UPDATE_PLAYLIST(1, 'New Playlist Name', 2);
    UPDATE_PLAYLIST_SONG(1, 2, 3);
    UPDATE_LISTENED_TRACKS(1, 2, 3, SYSDATE);
END;

BEGIN
INSERT_ALBUM(1, 'Led Zeppelin IV', 1971, 'PICTURE', 'PICTURE.jpg');
END;
SELECT * FROM album_table
SELECT * FROM song_table
CREATE OR REPLACE DIRECTORY PICTURE AS 'C:\app\Kursach\PICTURE';
GRANT READ, WRITE ON DIRECTORY PICTURE TO ADMINISTRATOR;
ALTER SESSION SET CONTAINER = PDB_KURS;
ALTER SESSION SET CONTAINER = cdb$root;
 select 
SELECT * FROM album_table WHERE album_id = 1;
SELECT * FROM DBA_DIRECTORIES;
-------------------------ROLE-------------------------

CREATE TABLE role_table (
    role_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
    role_name VARCHAR2(30) NOT NULL,
    CONSTRAINT role_pk PRIMARY KEY (role_id)
);

INSERT INTO role_table(role_name) VALUES('USER');
INSERT INTO role_table(role_name) VALUES('OWNER');

SELECT * FROM role_table;
DROP TABLE role_table;



-------------------------USER-------------------------

CREATE TABLE user_table (
    user_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
    user_login VARCHAR2(30) NOT NULL,
    user_password VARCHAR2(200) NOT NULL,
    user_role NUMBER(10) NOT NULL,
    CONSTRAINT user_pk PRIMARY KEY (user_id),
    CONSTRAINT user_role_fk FOREIGN KEY (user_role) REFERENCES role_table(role_id)
);

SELECT * FROM user_table;
select count(*) from user_table;
DROP TABLE user_table;

-------------------------ARTIST-------------------------

CREATE TABLE artist_table (
    artist_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
    artist_name VARCHAR2(30) NOT NULL,
    CONSTRAINT artist_pk PRIMARY KEY (artist_id)
);

INSERT INTO artist_table(artist_name) VALUES('Polyphia');
INSERT INTO artist_table(artist_name) VALUES('Radiohead');
INSERT INTO artist_table(artist_name) VALUES('Arctic Monkeys');
INSERT INTO artist_table(artist_name) VALUES('Pink Floyd');
INSERT INTO artist_table(artist_name) VALUES('Placebo');

SELECT * FROM artist_table;
DROP TABLE artist_table;

-------------------------ALBUM-------------------------

CREATE TABLE album_table (
    album_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
    album_artist NUMBER(10) NOT NULL,
    album_name VARCHAR2(30) NOT NULL,
    album_released NUMBER(10) NOT NULL,
    album_image BLOB ,
    image_link BFILE,
    picture ORDImage NOT NULL,
    CONSTRAINT album_pk PRIMARY KEY (album_id),
    CONSTRAINT album_artist_fk FOREIGN KEY (album_artist) REFERENCES artist_table(artist_id)
);

alter table album_table add constraint fk_artist_album foreign key (album_artist) references artist_table (artist_id) on delete cascade;

INSERT INTO album_table(album_artist, album_name, album_released) VALUES(1, 'New Levels New Devils', 2018);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(2, 'OK Computer', 1997);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(2, 'In Rainbows', 2007);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(2, 'Kid A', 2000);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(3, 'AM', 2013);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(3, 'Favourite Worst Nightmare', 2007);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(4, 'The Wall', 1979);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(4, 'Wish You Were Here', 1975);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(5, 'Loud Like Love', 2013);
INSERT INTO album_table(album_artist, album_name, album_released) VALUES(5, 'Meds', 2013);

SELECT * FROM album_table;

delete from album_table;
commit;
DROP TABLE album_table;

-------------------------SONG-------------------------

CREATE TABLE song_table (
    song_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
    song_artist NUMBER(10) NOT NULL,
    song_album NUMBER(10) NOT NULL,
    song_name VARCHAR2(30) NOT NULL,
    song_link BFILE,
    CONSTRAINT song_pk PRIMARY KEY (song_id),
    CONSTRAINT song_artist_fk FOREIGN KEY (song_artist) REFERENCES artist_table(artist_id),
    CONSTRAINT song_album_fk FOREIGN KEY (song_album) REFERENCES album_table(album_id)
);
/
SELECT * FROM song_table;
delete from song_table;
commit;
DROP TABLE song_table;

------------------------ SAVED

CREATE TABLE saved_table (
    saved_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
    saved_user NUMBER(10) NOT NULL,
    saved_song NUMBER(10) NOT NULL,
    CONSTRAINT saved_pk PRIMARY KEY (saved_id),
    CONSTRAINT saved_user_fk FOREIGN KEY (saved_user) REFERENCES user_table(user_id),
    CONSTRAINT saved_song_fk FOREIGN KEY (saved_song) REFERENCES song_table(song_id)
);
-------------------------PLAYLIST-------------------------
CREATE TABLE playlist_table (
playlist_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
playlist_name VARCHAR2(30) NOT NULL,
playlist_user NUMBER(10) NOT NULL,
CONSTRAINT playlist_pk PRIMARY KEY (playlist_id),
CONSTRAINT playlist_user_fk FOREIGN KEY (playlist_user) REFERENCES user_table(user_id)
);
SELECT * FROM playlist_table;
delete from playlist_table;
commit;
DROP TABLE playlist_table;
-------------------------PLAYLIST_SONG-------------------------
CREATE TABLE playlist_song_table (
playlist_song_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
playlist_song_playlist NUMBER(10) NOT NULL,
playlist_song_song NUMBER(10) NOT NULL,
CONSTRAINT playlist_song_pk PRIMARY KEY (playlist_song_id),
CONSTRAINT playlist_song_playlist_fk FOREIGN KEY (playlist_song_playlist) REFERENCES playlist_table(playlist_id),
CONSTRAINT playlist_song_song_fk FOREIGN KEY (playlist_song_song) REFERENCES song_table(song_id)
);
SELECT * FROM playlist_song_table;
delete from playlist_song_table;
commit;
DROP TABLE playlist_song_table;
-------------------------LISTENED_TRACKS-------------------------
CREATE TABLE listened_tracks_table (
listened_tracks_id NUMBER(10) GENERATED AS IDENTITY(START WITH 1 INCREMENT BY 1),
listened_tracks_user NUMBER(10) NOT NULL,
listened_tracks_song NUMBER(10) NOT NULL,
listened_tracks_date DATE NOT NULL,
CONSTRAINT listened_tracks_pk PRIMARY KEY (listened_tracks_id),
CONSTRAINT listened_tracks_user_fk FOREIGN KEY (listened_tracks_user) REFERENCES user_table(user_id),
CONSTRAINT listened_tracks_song_fk FOREIGN KEY (listened_tracks_song) REFERENCES song_table(song_id)
); 



------------------- SYNONYM -------------------
CREATE SYNONYM role_t FOR role_table;
CREATE SYNONYM user_t FOR user_table;
CREATE SYNONYM artist_t FOR artist_table;
CREATE SYNONYM album_t FOR album_table;
CREATE SYNONYM song_t FOR song_table;
CREATE SYNONYM saved_t FOR saved_table;
CREATE SYNONYM playlist_t FOR playlist_table;
CREATE SYNONYM playlist_song_t FOR playlist_song_table;
CREATE SYNONYM listened_t FOR listened_tracks_table;
DROP PUBLIC SYNONYM role_t;
DROP PUBLIC SYNONYM user_t;
DROP PUBLIC SYNONYM artist_t;
DROP PUBLIC SYNONYM album_t;
DROP PUBLIC SYNONYM song_t;
DROP PUBLIC SYNONYM saved_t;
DROP PUBLIC SYNONYM playlist_t;
DROP PUBLIC SYNONYM playlist_song_t;
DROP PUBLIC SYNONYM listened_t;
------------------- MATERIALIZED VIEW -------------------
CREATE MATERIALIZED VIEW playlist_view
BUILD IMMEDIATE
REFRESH ON DEMAND
ENABLE QUERY REWRITE
AS SELECT * FROM playlist_table;

CREATE MATERIALIZED VIEW playlist_song_view
BUILD IMMEDIATE
REFRESH ON DEMAND
ENABLE QUERY REWRITE
AS SELECT * FROM playlist_song_table;

CREATE MATERIALIZED VIEW listened_tracks_view
BUILD IMMEDIATE
REFRESH ON DEMAND
ENABLE QUERY REWRITE
AS SELECT * FROM listened_tracks_table;

DROP MATERIALIZED VIEW playlist_view;
DROP MATERIALIZED VIEW playlist_song_view;
DROP MATERIALIZED VIEW listened_tracks_table;
------------------- INDEX -------------------
CREATE INDEX role_name_idx ON role_table (role_name);

CREATE INDEX user_login_idx ON user_table (user_login);
CREATE INDEX user_role_idx ON user_table (user_role);

CREATE INDEX artist_name_idx ON artist_table (artist_name);

CREATE INDEX album_name_idx ON album_table (album_name);
CREATE INDEX album_artist_idx ON album_table (album_artist);

CREATE INDEX song_name_idx ON song_table (song_name);
CREATE INDEX song_artist_idx ON song_table (song_artist);
CREATE INDEX album_name_idx ON song_table (album_name);

CREATE INDEX saved_user_idx ON saved_table (saved_user);
CREATE INDEX saved_song_idx ON saved_table (saved_song);

CREATE INDEX playlist_name_idx ON playlist_table (playlist_name);
CREATE INDEX playlist_user_idx ON playlist_table (playlist_user);

CREATE INDEX playlist_song_playlist_idx ON playlist_song_table (playlist_song_playlist);
CREATE INDEX playlist_song_song_idx ON playlist_song_table (playlist_song_song);

CREATE INDEX listened_tracks_user_idx ON listened_tracks_table (listened_tracks_user);
CREATE INDEX listened_tracks_song_idx ON listened_tracks_table (listened_tracks_song);
CREATE INDEX listened_tracks_date_idx ON listened_tracks_table (listened_tracks_date);
------------------- VIEW -------------------
CREATE VIEW role_view AS SELECT role_id, role_name FROM role_table;
CREATE VIEW user_view AS SELECT user_id, user_login, user_role FROM user_table;
CREATE VIEW artist_view AS SELECT artist_id, artist_name FROM artist_table;
CREATE VIEW album_view AS SELECT album_id, album_artist, album_name, album_released FROM album_table;
CREATE VIEW song_view AS SELECT song_id, song_artist, song_album, song_name FROM song_table;
CREATE VIEW saved_view AS SELECT saved_id, saved_user, saved_song FROM saved_table;
CREATE VIEW playlist_view AS SELECT playlist_id, playlist_name, playlist_user FROM playlist_table;
CREATE VIEW playlist_song_view AS SELECT playlist_song_id, playlist_song_playlist, playlist_song_song FROM playlist_song_table;
CREATE VIEW listened_tracks_view AS SELECT listened_tracks_id, listened_tracks_user, listened_tracks_song, listened_tracks_date FROM listened_tracks_table;
------------------- SYNONYM VIEW -------------------
CREATE SYNONYM role_synonym FOR role_view;
CREATE SYNONYM user_synonym FOR user_view;
CREATE SYNONYM artist_synonym FOR artist_view;
CREATE SYNONYM album_synonym FOR album_view;
CREATE SYNONYM song_synonym FOR song_view;
CREATE SYNONYM saved_synonym FOR saved_view;
CREATE SYNONYM playlist_synonym FOR playlist_view;
CREATE SYNONYM playlist_song_synonym FOR playlist_song_view;
CREATE SYNONYM listened_tracks_synonym FOR listened_tracks_view;
/
------------------- PROCEDURE INSERT -------------------
CREATE OR REPLACE PROCEDURE INSERT_ALBUM(pAlbum_artist NUMBER,pAlbum_name VARCHAR2,
pAlbum_released NUMBER,pOraDir VARCHAR2,pFileName VARCHAR2) IS
    l_bfile BFILE;
    l_blob BLOB;
    l_dest_offset INTEGER := 1;
    l_src_offset INTEGER := 1;
    l_lobmaxsize CONSTANT INTEGER := DBMS_LOB.LOBMAXSIZE;
    l_img ORDImage;
BEGIN
    l_bfile := BFILENAME(pOraDir, pFileName);
    l_img := ORDSYS.ORDImage(l_blob);
    INSERT INTO album_table(album_id,album_artist,album_name,album_released,album_image,image_link,picture) 
    VALUES(NULL,pAlbum_artist,pAlbum_name,pAlbum_released,empty_blob(),l_bfile,l_img) 
    RETURNING album_image INTO l_blob;
    DBMS_LOB.fileopen(l_bfile, DBMS_LOB.file_readonly);
    DBMS_LOB.loadblobfromfile(l_blob, l_bfile, l_lobmaxsize, l_dest_offset, l_src_offset);
    DBMS_LOB.fileclose(l_bfile);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------------

CREATE OR REPLACE PROCEDURE INSERT_ROLE(
    pRole_name VARCHAR2
) IS
BEGIN
    INSERT INTO role_table(role_name) VALUES(pRole_name);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/-----------

CREATE OR REPLACE PROCEDURE INSERT_USER(
    pUser_login VARCHAR2,
    pUser_password VARCHAR2,
    pUser_role NUMBER
) IS
BEGIN
    INSERT INTO user_table(user_login, user_password, user_role) VALUES(pUser_login, pUser_password, pUser_role);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/--------------

CREATE OR REPLACE PROCEDURE INSERT_ARTIST(
    pArtist_name VARCHAR2
) IS
BEGIN
    INSERT INTO artist_table(artist_name) VALUES(pArtist_name);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/---------------
CREATE OR REPLACE PROCEDURE INSERT_SONG(
    pSong_artist NUMBER,
    pSong_album NUMBER,
    pSong_name VARCHAR2,
    pSong_link BFILE
) IS
BEGIN
    INSERT INTO song_table(song_artist, song_album, song_name, song_link) VALUES(pSong_artist, pSong_album, pSong_name, pSong_link);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------
CREATE OR REPLACE PROCEDURE INSERT_SAVED(
    pSaved_user NUMBER,
    pSaved_song NUMBER
) IS
BEGIN
    INSERT INTO saved_table(saved_user, saved_song) VALUES(pSaved_user, pSaved_song);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------
CREATE OR REPLACE PROCEDURE INSERT_PLAYLIST(
    pPlaylist_name VARCHAR2,
    pPlaylist_user NUMBER
) IS
BEGIN
    INSERT INTO playlist_table(playlist_name, playlist_user) VALUES(pPlaylist_name, pPlaylist_user);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/-----------
CREATE OR REPLACE PROCEDURE INSERT_PLAYLIST_SONG(
    pPlaylist_song_playlist NUMBER,
    pPlaylist_song_song NUMBER
) IS
BEGIN
    INSERT INTO playlist_song_table(playlist_song_playlist, playlist_song_song) VALUES(pPlaylist_song_playlist, pPlaylist_song_song);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/----------
CREATE OR REPLACE PROCEDURE INSERT_LISTENED_TRACKS(
    pListened_tracks_user NUMBER,
    pListened_tracks_song NUMBER,
    pListened_tracks_date DATE
) IS
BEGIN
    INSERT INTO listened_tracks_table(listened_tracks_user, listened_tracks_song, listened_tracks_date) VALUES(pListened_tracks_user, pListened_tracks_song, pListened_tracks_date);
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;

------------------- PROCEDURE UPDATE -------------------

/------------
CREATE OR REPLACE PROCEDURE UPDATE_ALBUM(pAlbum_id NUMBER,pAlbum_artist NUMBER,pAlbum_name VARCHAR2,pAlbum_released NUMBER,pOraDir VARCHAR2,pFileName VARCHAR2
) IS
    l_bfile BFILE;
    l_blob BLOB;
    l_dest_offset INTEGER := 1;
    l_src_offset INTEGER := 1;
    l_lobmaxsize CONSTANT INTEGER := DBMS_LOB.LOBMAXSIZE;
    l_img ORDImage;
BEGIN
    l_bfile := BFILENAME(pOraDir, pFileName);
    DBMS_LOB.fileopen(l_bfile, DBMS_LOB.file_readonly);
    DBMS_LOB.loadblobfromfile(l_blob, l_bfile, l_lobmaxsize, l_dest_offset, l_src_offset);
    DBMS_LOB.fileclose(l_bfile);
    l_img := ORDSYS.ORDImage(l_blob);
    UPDATE album_table SET 
        album_artist = pAlbum_artist,
        album_name = pAlbum_name,
        album_released = pAlbum_released,
        album_image = empty_blob(),
        image_link = l_bfile,
        picture = l_img
    WHERE album_id = pAlbum_id
    RETURNING album_image INTO l_blob;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

create or replace procedure UPDATE_ROLE(pId_role number, pRole_name nvarchar2)
is
begin
UPDATE ROLE_TABLE SET ROLE_NAME = pRole_name
WHERE ROLE_ID = pId_role;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
end;
/------------

create or replace procedure UPDATE_USER(pId_user number, pUser_login nvarchar2, pUser_password nvarchar2, pUser_role number)
is
begin
UPDATE USER_TABLE SET USER_LOGIN = pUser_login, USER_PASSWORD = pUser_password, USER_ROLE = pUser_role
WHERE USER_ID = pId_user;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
end;
/------------

create or replace procedure UPDATE_ARTIST(pId_artist number, pArtist_name nvarchar2)
is
begin
UPDATE ARTIST_TABLE SET ARTIST_NAME = pArtist_name
WHERE ARTIST_ID = pId_artist;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
end;
/------------

create or replace procedure UPDATE_SONG(pId_song number, pSong_artist number, pSong_album number, pSong_name nvarchar2)
is
begin
UPDATE SONG_TABLE SET SONG_ARTIST = pSong_artist, SONG_ALBUM = pSong_album, SONG_NAME = pSong_name
WHERE SONG_ID = pId_song;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
end;
/------------

create or replace procedure UPDATE_SAVED(pId_saved number, pSaved_user number, pSaved_song number)
is
begin
UPDATE SAVED_TABLE SET SAVED_USER = pSaved_user, SAVED_SONG = pSaved_song
WHERE SAVED_ID = pId_saved;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
end;
/------------

create or replace procedure UPDATE_PLAYLIST(pId_playlist number, pPlaylist_name nvarchar2, pPlaylist_user number)
is
begin
UPDATE PLAYLIST_TABLE SET PLAYLIST_NAME = pPlaylist_name, PLAYLIST_USER = pPlaylist_user
WHERE PLAYLIST_ID = pId_playlist;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
end;
/------------

create or replace procedure UPDATE_PLAYLIST_SONG(pId_playlist_song number, pPlaylist_song_playlist number, pPlaylist_song_song number)
is
begin
UPDATE PLAYLIST_SONG_TABLE SET PLAYLIST_SONG_PLAYLIST = pPlaylist_song_playlist, PLAYLIST_SONG_SONG = pPlaylist_song_song
WHERE PLAYLIST_SONG_ID = pId_playlist_song;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
end;
/------------

create or replace procedure UPDATE_LISTENED_TRACKS(pId_listened_tracks number, pListened_tracks_user number, pListened_tracks_song number, pListened_tracks_date date)
is
begin
UPDATE LISTENED_TRACKS_TABLE SET LISTENED_TRACKS_USER = pListened_tracks_user, LISTENED_TRACKS_SONG = pListened_tracks_song, LISTENED_TRACKS_DATE = pListened_tracks_date
WHERE LISTENED_TRACKS_ID = pId_listened_tracks;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
end;
/------------


------------------- PROCEDURE SELECT -------------------

CREATE OR REPLACE PROCEDURE SELECT_ALBUM
AS
pAlbum_id ALBUM_TABLE.ALBUM_ID%TYPE;
pAlbum_artist ALBUM_TABLE.ALBUM_ARTIST%TYPE;
pAlbum_name ALBUM_TABLE.ALBUM_NAME%TYPE;
pAlbum_released ALBUM_TABLE.ALBUM_RELEASED%TYPE;
pAlbum_image ALBUM_TABLE.ALBUM_IMAGE%TYPE;
pImage_link ALBUM_TABLE.IMAGE_LINK%TYPE;
pPicture ALBUM_TABLE.PICTURE%TYPE;
CURSOR ALBUM_CURSOR IS
SELECT ALBUM_ID, ALBUM_ARTIST, ALBUM_NAME, ALBUM_RELEASED, ALBUM_IMAGE, IMAGE_LINK, PICTURE
FROM ALBUM_TABLE;
BEGIN
OPEN ALBUM_CURSOR;
LOOP
FETCH ALBUM_CURSOR INTO pAlbum_id, pAlbum_artist, pAlbum_name, pAlbum_released, pAlbum_image, pImage_link, pPicture;
EXIT WHEN ALBUM_CURSOR%NOTFOUND;
IF ALBUM_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pAlbum_id||' '||pAlbum_artist||' '||pAlbum_name||' '||pAlbum_released||' '||pAlbum_image||' '||pImage_link||' '||pPicture);
END LOOP;
CLOSE ALBUM_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

CREATE OR REPLACE PROCEDURE SELECT_ROLE
AS
pRole_name ROLE_TABLE.ROLE_NAME%TYPE;
CURSOR ROLE_CURSOR IS
SELECT ROLE_NAME
FROM ROLE_TABLE;
BEGIN
OPEN ROLE_CURSOR;
LOOP
FETCH ROLE_CURSOR INTO pRole_name;
EXIT WHEN ROLE_CURSOR%NOTFOUND;
IF ROLE_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pRole_name);
END LOOP;
CLOSE ROLE_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

CREATE OR REPLACE PROCEDURE SELECT_USER
AS
pUser_login USER_TABLE.USER_LOGIN%TYPE;
pUser_password USER_TABLE.USER_PASSWORD%TYPE;
pUser_role USER_TABLE.USER_ROLE%TYPE;
CURSOR USER_CURSOR IS
SELECT USER_LOGIN, USER_PASSWORD, USER_ROLE
FROM USER_TABLE;
BEGIN
OPEN USER_CURSOR;
LOOP
FETCH USER_CURSOR INTO pUser_login, pUser_password, pUser_role;
EXIT WHEN USER_CURSOR%NOTFOUND;
IF USER_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pUser_login||' '||pUser_password||' '||pUser_role);
END LOOP;
CLOSE USER_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

CREATE OR REPLACE PROCEDURE SELECT_ARTIST
AS
pArtist_name ARTIST_TABLE.ARTIST_NAME%TYPE;
CURSOR ARTIST_CURSOR IS
SELECT ARTIST_NAME
FROM ARTIST_TABLE;
BEGIN
OPEN ARTIST_CURSOR;
LOOP
FETCH ARTIST_CURSOR INTO pArtist_name;
EXIT WHEN ARTIST_CURSOR%NOTFOUND;
IF ARTIST_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pArtist_name);
END LOOP;
CLOSE ARTIST_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

CREATE OR REPLACE PROCEDURE SELECT_SONG
AS
pSong_artist SONG_TABLE.SONG_ARTIST%TYPE;
pSong_album SONG_TABLE.SONG_ALBUM%TYPE;
pSong_name SONG_TABLE.SONG_NAME%TYPE;
CURSOR SONG_CURSOR IS
SELECT SONG_ARTIST, SONG_ALBUM, SONG_NAME
FROM SONG_TABLE;
BEGIN
OPEN SONG_CURSOR;
LOOP
FETCH SONG_CURSOR INTO pSong_artist, pSong_album, pSong_name;
EXIT WHEN SONG_CURSOR%NOTFOUND;
IF SONG_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pSong_artist||' '||pSong_album||' '||pSong_name);
END LOOP;
CLOSE SONG_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

CREATE OR REPLACE PROCEDURE SELECT_SAVED
AS
pSaved_user SAVED_TABLE.SAVED_USER%TYPE;
pSaved_song SAVED_TABLE.SAVED_SONG%TYPE;
CURSOR SAVED_CURSOR IS
SELECT SAVED_USER, SAVED_SONG
FROM SAVED_TABLE;
BEGIN
OPEN SAVED_CURSOR;
LOOP
FETCH SAVED_CURSOR INTO pSaved_user, pSaved_song;
EXIT WHEN SAVED_CURSOR%NOTFOUND;
IF SAVED_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pSaved_user||' '||pSaved_song);
END LOOP;
CLOSE SAVED_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

CREATE OR REPLACE PROCEDURE SELECT_PLAYLIST
AS
pPlaylist_name PLAYLIST_TABLE.PLAYLIST_NAME%TYPE;
pPlaylist_user PLAYLIST_TABLE.PLAYLIST_USER%TYPE;
CURSOR PLAYLIST_CURSOR IS
SELECT PLAYLIST_NAME, PLAYLIST_USER
FROM PLAYLIST_TABLE;
BEGIN
OPEN PLAYLIST_CURSOR;
LOOP
FETCH PLAYLIST_CURSOR INTO pPlaylist_name, pPlaylist_user;
EXIT WHEN PLAYLIST_CURSOR%NOTFOUND;
IF PLAYLIST_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pPlaylist_name||' '||pPlaylist_user);
END LOOP;
CLOSE PLAYLIST_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

CREATE OR REPLACE PROCEDURE SELECT_PLAYLIST_SONG
AS
pPlaylist_song_playlist PLAYLIST_SONG_TABLE.PLAYLIST_SONG_PLAYLIST%TYPE;
pPlaylist_song_song PLAYLIST_SONG_TABLE.PLAYLIST_SONG_SONG%TYPE;
CURSOR PLAYLIST_SONG_CURSOR IS
SELECT PLAYLIST_SONG_PLAYLIST, PLAYLIST_SONG_SONG
FROM PLAYLIST_SONG_TABLE;
BEGIN
OPEN PLAYLIST_SONG_CURSOR;
LOOP
FETCH PLAYLIST_SONG_CURSOR INTO pPlaylist_song_playlist, pPlaylist_song_song;
EXIT WHEN PLAYLIST_SONG_CURSOR%NOTFOUND;
IF PLAYLIST_SONG_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pPlaylist_song_playlist||' '||pPlaylist_song_song);
END LOOP;
CLOSE PLAYLIST_SONG_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

CREATE OR REPLACE PROCEDURE SELECT_LISTENED_TRACKS
AS
pListened_tracks_user LISTENED_TRACKS_TABLE.LISTENED_TRACKS_USER%TYPE;
pListened_tracks_song LISTENED_TRACKS_TABLE.LISTENED_TRACKS_SONG%TYPE;
pListened_tracks_date LISTENED_TRACKS_TABLE.LISTENED_TRACKS_DATE%TYPE;
CURSOR LISTENED_TRACKS_CURSOR IS
SELECT LISTENED_TRACKS_USER, LISTENED_TRACKS_SONG, LISTENED_TRACKS_DATE
FROM LISTENED_TRACKS_TABLE;
BEGIN
OPEN LISTENED_TRACKS_CURSOR;
LOOP
FETCH LISTENED_TRACKS_CURSOR INTO pListened_tracks_user, pListened_tracks_song, pListened_tracks_date;
EXIT WHEN LISTENED_TRACKS_CURSOR%NOTFOUND;
IF LISTENED_TRACKS_CURSOR%NOTFOUND THEN
RAISE_APPLICATION_ERROR(-20003, 'Data is not found');
END IF;
DBMS_OUTPUT.PUT_LINE(pListened_tracks_user||' '||pListened_tracks_song||' '||pListened_tracks_date);
END LOOP;
CLOSE LISTENED_TRACKS_CURSOR;
EXCEPTION
WHEN OTHERS
THEN DBMS_OUTPUT.PUT_LINE('CODE ERROR: '||SQLCODE||' MESSAGE: '||SQLERRM);
END;
/------------

------------------- FUNCTION PACKAGE SELECT  -------------------
--Функция для получения списка всех альбомов, выпущенных в указанном году
CREATE OR REPLACE FUNCTION GET_ALBUMS_BY_YEAR(pYear NUMBER) RETURN SYS_REFCURSOR AS
    albums_cursor SYS_REFCURSOR;
BEGIN
    OPEN albums_cursor FOR
        SELECT album_name, artist_name, album_released
        FROM album_table
        JOIN artist_table ON album_table.album_artist = artist_table.artist_id
        WHERE album_released = pYear;
    RETURN albums_cursor;
END;

--Функция для получения списка всех песен, сохраненных пользователем
CREATE OR REPLACE FUNCTION GET_SAVED_SONGS_BY_USER(pUserId NUMBER) RETURN SYS_REFCURSOR AS
    saved_songs_cursor SYS_REFCURSOR;
BEGIN
    OPEN saved_songs_cursor FOR
        SELECT song_name, artist_name, album_name
        FROM saved_table
        JOIN song_table ON saved_table.saved_song = song_table.song_id
        JOIN album_table ON song_table.song_album = album_table.album_id
        JOIN artist_table ON song_table.song_artist = artist_table.artist_id
        WHERE saved_user = pUserId;
    RETURN saved_songs_cursor;
END;

--Функция для получения списка всех песен, прослушанных пользователем в указанный период времени:
CREATE OR REPLACE FUNCTION GET_LISTENED_TRACKS_BY_DATE(pUserId NUMBER, pStartDate DATE, pEndDate DATE) RETURN SYS_REFCURSOR AS
    listened_tracks_cursor SYS_REFCURSOR;
BEGIN
    OPEN listened_tracks_cursor FOR
        SELECT song_name, artist_name, album_name, listened_tracks_date
        FROM listened_tracks_table
        JOIN song_table ON listened_tracks_table.listened_tracks_song = song_table.song_id
        JOIN album_table ON song_table.song_album = album_table.album_id
        JOIN artist_table ON song_table.song_artist = artist_table.artist_id
        WHERE listened_tracks_user = pUserId AND listened_tracks_date BETWEEN pStartDate AND pEndDate;
    RETURN listened_tracks_cursor;
END;

--Функция для получения списка всех песен, добавленных в указанный плейлист:
CREATE OR REPLACE FUNCTION GET_SONGS_BY_PLAYLIST(pPlaylistId NUMBER) RETURN SYS_REFCURSOR AS
    playlist_songs_cursor SYS_REFCURSOR;
BEGIN
    OPEN playlist_songs_cursor FOR
        SELECT song_name, artist_name, album_name
        FROM playlist_song_table
        JOIN song_table ON playlist_song_table.playlist_song_song = song_table.song_id
        JOIN album_table ON song_table.song_album = album_table.album_id
        JOIN artist_table ON song_table.song_artist = artist_table.artist_id
        WHERE playlist_song_playlist = pPlaylistId;
    RETURN playlist_songs_cursor;
END;

--Функция для получения списка всех пользователей, имеющих определенную роль:
CREATE OR REPLACE FUNCTION GET_USERS_BY_ROLE(pRoleName VARCHAR2) RETURN SYS_REFCURSOR AS
    users_cursor SYS_REFCURSOR;
BEGIN
    OPEN users_cursor FOR
        SELECT user_login, user_role, role_name
        FROM user_table
        JOIN role_table ON user_table.user_role = role_table.role_id
        WHERE role_name = pRoleName;
    RETURN users_cursor;
END;

--Функция для получения списка всех альбомов, выпущенных определенным исполнителем:
CREATE OR REPLACE FUNCTION GET_ALBUMS_BY_ARTIST(pArtistName VARCHAR2) RETURN SYS_REFCURSOR AS
    albums_cursor SYS_REFCURSOR;
BEGIN
    OPEN albums_cursor FOR
        SELECT album_name, artist_name, album_released
        FROM album_table
        JOIN artist_table ON album_table.album_artist = artist_table.artist_id
        WHERE artist_name = pArtistName;
    RETURN albums_cursor;
END;

--Функция для получения списка всех песен, входящих в определенный альбом:
CREATE OR REPLACE FUNCTION GET_SONGS_BY_ALBUM(pAlbumName VARCHAR2) RETURN SYS_REFCURSOR AS
    songs_cursor SYS_REFCURSOR;
BEGIN
    OPEN songs_cursor FOR
        SELECT song_name, artist_name, album_name
        FROM song_table
        JOIN album_table ON song_table.song_album = album_table.album_id
        JOIN artist_table ON song_table.song_artist = artist_table.artist_id
        WHERE album_name = pAlbumName;
    RETURN songs_cursor;
END;

--Функция для получения списка всех плейлистов, созданных пользователем:
CREATE OR REPLACE FUNCTION GET_PLAYLISTS_BY_USER(pUserId NUMBER) RETURN SYS_REFCURSOR AS
    playlists_cursor SYS_REFCURSOR;
BEGIN
    OPEN playlists_cursor FOR
        SELECT playlist_name
        FROM playlist_table
        WHERE playlist_user = pUserId;
    RETURN playlists_cursor;
END;

--функцию, которая будет проверять, существует ли пользователь с таким же логином
CREATE OR REPLACE FUNCTION FN_CHECK_USER_LOGIN(p_user_login IN VARCHAR2)
RETURN BOOLEAN
IS
v_count NUMBER;
BEGIN
SELECT COUNT(*) INTO v_count
FROM user_table
WHERE user_login = p_user_login;
IF v_count > 0 THEN
RETURN FALSE;
ELSE
RETURN TRUE;
END IF;
END;

--функцию, которая будет проверять, существует ли артист с таким же именем
CREATE OR REPLACE FUNCTION FN_CHECK_ARTIST_NAME(p_artist_name IN VARCHAR2)
RETURN BOOLEAN
IS
v_count NUMBER;
BEGIN
SELECT COUNT(*) INTO v_count
FROM artist_table
WHERE artist_name = p_artist_name;
IF v_count > 0 THEN
RETURN FALSE;
ELSE
RETURN TRUE;
END IF;
END;

--функцию, которая будет проверять, существует ли плейлист с таким же именем
CREATE OR REPLACE FUNCTION FN_CHECK_PLAYLIST_NAME(p_playlist_name IN VARCHAR2)
RETURN BOOLEAN
IS
v_count NUMBER;
BEGIN
SELECT COUNT(*) INTO v_count
FROM playlist_table
WHERE playlist_name = p_playlist_name;
IF v_count > 0 THEN
RETURN FALSE;
ELSE
RETURN TRUE;
END IF;
END;



--Для таблицы role_table можно создать функцию, которая будет проверять, существует ли роль с таким же именем
CREATE OR REPLACE FUNCTION FN_CHECK_ROLE_NAME(p_role_name IN VARCHAR2)
RETURN BOOLEAN
IS
v_count NUMBER;
BEGIN
SELECT COUNT(*) INTO v_count
FROM role_table
WHERE role_name = p_role_name;
IF v_count > 0 THEN
RETURN FALSE;
ELSE
RETURN TRUE;
END IF;
END;




------------------- TRIGGER -------------------
--проверяет, что артист песни, добавляемой в плейлист, разрешен для пользователя, 
--создавшего плейлист. Если артист песни не разрешен для пользователя, создавшего плейлист, то триггер вызывает ошибку
CREATE OR REPLACE TRIGGER TRG_CHECK_PLAYLIST_SONG
BEFORE INSERT ON playlist_song_table
FOR EACH ROW
DECLARE
v_song_artist NUMBER(10);
v_playlist_user NUMBER(10);
BEGIN
SELECT song_artist INTO v_song_artist
FROM song_table
WHERE song_id = :NEW.playlist_song_song;
SELECT user_id INTO v_playlist_user
FROM playlist_table
WHERE playlist_id = :NEW.playlist_song_playlist;
IF v_song_artist NOT IN (SELECT user_role FROM user_table WHERE user_id = v_playlist_user) THEN
RAISE_APPLICATION_ERROR(-20001, 'The song artist is not allowed in this playlist.');
END IF;
END;
-------------------------LISTENED_TRACKS-------------------------
--этот триггер проверяет, что дата прослушивания песни не находится в будущем. 
--Если дата прослушивания песни находится в будущем, то триггер вызывает ошибку
CREATE OR REPLACE TRIGGER TRG_CHECK_LISTENED_TRACKS_DATE
BEFORE INSERT ON listened_tracks_table
FOR EACH ROW
BEGIN
IF :NEW.listened_tracks_date > SYSDATE THEN
RAISE_APPLICATION_ERROR(-20001, 'The listened date cannot be in the future.');
END IF;
END;



CREATE OR REPLACE PROCEDURE insert_roles AS
BEGIN

    FOR i IN 1..100000 LOOP
        INSERT INTO role_table (
 role_name
        ) VALUES (
            'Role ' || i
        );

    END LOOP;
    COMMIT;
END;
select count(*) from role_table




