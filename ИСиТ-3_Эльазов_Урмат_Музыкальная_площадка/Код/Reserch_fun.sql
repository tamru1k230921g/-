--процедура которая будет искать песни по названию
CREATE OR REPLACE PROCEDURE search_songs_by_name(
    p_song_name IN VARCHAR2,
    p_results OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_results FOR
        SELECT *
        FROM song_table
        WHERE song_name LIKE '%' || p_song_name || '%';
END;


--испрльзование 
DECLARE
    search_results SYS_REFCURSOR;
    song_id NUMBER;
    song_name VARCHAR2(30);
BEGIN
    search_songs_by_name('New', search_results);
    LOOP
        FETCH search_results INTO song_id, song_name;
        EXIT WHEN search_results%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Song ID: ' || song_id || ', Song Name: ' || song_name);
    END LOOP;
    CLOSE search_results;
END;



-----------------------------------
--Поиск пользователей по имени:
CREATE OR REPLACE PROCEDURE search_users_by_name(
    p_search_term IN VARCHAR2,
    p_results OUT SYS_REFCURSOR
)
AS
BEGIN
    OPEN p_results FOR
        SELECT *
        FROM user_table
        WHERE user_name LIKE '%' || p_search_term || '%';
END;

--испрльзование 
DECLARE
    search_term VARCHAR2() := 'John';
    results_cursor SYS_REFCURSOR;
    user_id user_table.user_id%TYPE;
    user_name user_table.user_name%TYPE;
BEGIN
    search_users_by_name(search_term, results_cursor    LOOP
        FETCH results_cursor INTO user_id, user_name;
        EXIT WHEN results_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('User ID: ' || user_id || ', User Name: ' || user_name);
    END LOOP;
    CLOSE results_cursor;
END;


-----------------------------------
--Поиск ролей по имени:
CREATE OR REPLACE PROCEDURE search_roles_by_name(
p_search_term IN VARCHAR2,
p_results OUT SYS_REFCURSOR
)
AS
BEGIN
OPEN p_results FOR
SELECT *
FROM role_table
WHERE role_name LIKE '%' || p_search_term || '%';
END;



--испрльзование 
DECLARE
    search_term VARCHAR2(50) := 'admin';
    results_cursor SYS_REFCURSOR;
    role_id role_table.role_id%TYPE;
    role_name role_table.role_name%TYPE;
BEGIN
    search_roles_by_name(search_term, results_cursor);
    LOOP
        FETCH results_cursor INTO role_id, role_name;
        EXIT WHEN results_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Role ID: ' || role_id || ', Role Name: ' || role_name);
    END LOOP;
    CLOSE results_cursor;
END;


--Поиск плейлистов по имени:
CREATE OR REPLACE PROCEDURE search_playlists_by_name(
p_search_term IN VARCHAR2,
p_results OUT SYS_REFCURSOR
)
AS
BEGIN
OPEN p_results FOR
SELECT *
FROM playlist_table
WHERE playlist_name LIKE '%' || p_search_term || '%';
END;

--испрльзование 
DECLARE
    search_term VARCHAR2(50) := 'rock';
    results_cursor SYS_REFCURSOR;
    playlist_id playlist_table.playlist_id%TYPE;
    playlist_name playlist_table.playlist_name%TYPE;
BEGIN
    search_playlists_by_name(search_term, results_cursor);
    LOOP
        FETCH results_cursor INTO playlist_id, playlist_name;
        EXIT WHEN results_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Playlist ID: ' || playlist_id || ', Playlist Name: ' || playlist_name);
    END LOOP;
    CLOSE results_cursor;
END;


-----------------------------------
--Поиск альбомов по имени:
CREATE OR REPLACE PROCEDURE search_album_by_name(
p_search_term IN VARCHAR2,
p_results OUT SYS_REFCURSOR
)
AS
BEGIN
OPEN p_results FOR
SELECT *
FROM album_table
WHERE album_name LIKE '%' || p_search_term || '%';
END;


--испрльзование 
DECLARE
    search_term VARCHAR2(50) := 'Abbey Road';
    results_cursor SYS_REFCURSOR;
    album_id album_table.album_id%TYPE;
    album_name album_table.album_name%TYPE;
BEGIN
    search_album_by_name(search_term, results_cursor);
    LOOP
        FETCH results_cursor INTO album_id, album_name;
        EXIT WHEN results_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Album ID: ' || album_id || ', Album Name: ' || album_name);
    END LOOP;
    CLOSE results_cursor;
END;
