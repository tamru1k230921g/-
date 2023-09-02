--Это представление будет содержать информацию о прослушанных композициях, включая логин пользователя, имя исполнителя, название альбома, название песни и дату прослушивания. 

CREATE VIEW listened_songs_view AS
SELECT u.user_login, a.artist_name, al.album_name, s.song_name, lt.listened_tracks_date
FROM user_table u
JOIN listened_tracks_table lt ON u.user_id = lt.listened_tracks_user
JOIN song_table s ON lt.listened_tracks_song = s.song_id
JOIN album_table al ON s.song_album = al.album_id
JOIN artist_table a ON al.album_artist = a.artist_id;

SELECT * FROM listened_songs_view;

--Самые прослушиваемые композиции
--В этом представлении будут показаны наиболее прослушиваемые композиции в зависимости от того, сколько раз они были прослушаны.
CREATE VIEW most_listened_compositions AS
SELECT song_name, COUNT(*) AS number_of_times_listened
FROM listened_tracks_table
GROUP BY song_name
ORDER BY number_of_times_listened DESC;

--Самые прослушиваемые композиции исполнителя
--В этом представлении будут показаны самые прослушиваемые композиции с разбивкой по исполнителям.
CREATE VIEW most_listened_compositions_by_artist AS
SELECT artist_name, COUNT(*) AS number_of_times_listened
FROM listened_tracks_table
GROUP BY artist_name
ORDER BY number_of_times_listened DESC;


--Самые прослушиваемые композиции по альбомам
--В этом представлении будут показаны самые прослушиваемые композиции с разбивкой по альбомам.
CREATE VIEW most_listened_compositions_by_album AS
SELECT album_name, COUNT(*) AS number_of_times_listened
FROM listened_tracks_table
GROUP BY album_name
ORDER BY number_of_times_listened DESC;


--Самые прослушиваемые композиции пользователем
--В этом представлении будут показаны самые прослушиваемые композиции в разбивке по пользователям.
CREATE VIEW most_listened_compositions_by_user AS
SELECT user_name, COUNT(*) AS number_of_times_listened
FROM listened_tracks_table
GROUP BY user_name
ORDER BY number_of_times_listened DESC;


--Самые прослушиваемые композиции за определенный период времени
--В этом представлении будут показаны самые прослушиваемые композиции за указанный период времени.
CREATE VIEW most_listened_compositions_in_time_period AS
SELECT song_name, COUNT(*) AS number_of_times_listened
FROM listened_tracks_table
WHERE listened_tracks_date BETWEEN '2023-05-01' AND '2023-05-17'
GROUP BY song_name
ORDER BY number_of_times_listened DESC;


--Самые прослушиваемые композиции по часам дня
--В этом представлении будут показаны самые прослушиваемые композиции с разбивкой по часам суток.
CREATE VIEW most_listened_compositions_by_hour_of_day AS
SELECT listened_tracks_date, EXTRACT(HOUR FROM listened_tracks_date) AS hour, COUNT(*) AS number_of_times_listened
FROM listened_tracks_table
GROUP BY listened_tracks_date, EXTRACT(HOUR FROM listened_tracks_date)
ORDER BY listened_tracks_date, EXTRACT(HOUR FROM listened_tracks_date);


--Самые прослушиваемые композиции на устройствах
--В этом представлении будут показаны самые прослушиваемые композиции с разбивкой по устройствам.
CREATE VIEW most_listened_compositions_by_device AS
SELECT listened_tracks_date, user_device, COUNT(*) AS number_of_times_listened
FROM listened_tracks_table
GROUP BY listened_tracks_date, user_device
ORDER BY listened_tracks_date, user_device;

-------------------------USER & ROLE-------------------------
--В этом представлении отображаются логин пользователя, пароль пользователя и имя роли для всех пользователей.
CREATE VIEW user_role_view AS SELECT user_table.user_login, user_table.user_password, role_table.role_name
FROM user_table LEFT JOIN role_table ON user_table.user_role = role_table.role_id;

SELECT * FROM user_role_view;

DROP VIEW user_role_view;

-------------------------USER & ROLE FULL-------------------------
--В этом представлении отображаются идентификатор пользователя, логин пользователя, расшифрованный пароль и имя роли для всех пользователей.
CREATE VIEW user_role_full_view AS SELECT user_table.user_id, user_table.user_login, decryption_password(user_table.user_password) as decr, role_table.role_name
FROM user_table LEFT JOIN role_table ON user_table.user_role = role_table.role_id;

SELECT * FROM user_role_full_view;

DROP VIEW user_role_full_view;

-------------------------ARTIST & ALBUM-------------------------
--В этом представлении отображаются идентификатор альбома, имя исполнителя, название альбома, дата выпуска альбома и большой двоичный объект альбома для всех альбомов.
CREATE VIEW artist_album_view AS SELECT album_table.album_id, artist_table.artist_name, album_table.album_name, album_table.album_released, album_table.album_blob
FROM artist_table JOIN album_table ON artist_table.artist_id = album_table.album_artist;

SELECT * FROM artist_album_view;

DROP VIEW artist_album_view;

-------------------------ARTIST & ALBUM & SONG-------------------------
--В этом представлении отображаются идентификатор песни, имя исполнителя, название альбома, название песни, дата выпуска альбома,
CREATE VIEW artist_album_song_view AS SELECT song_table.song_id, artist_table.artist_name, 
    album_table.album_name, song_table.song_name, album_table.album_released, 
    album_table.album_blob, song_table.song_blob
FROM artist_table JOIN album_table ON artist_table.artist_id = album_table.album_artist
    JOIN song_table on song_table.song_album = album_table.album_id;

SELECT * FROM artist_album_song_view;
commit;
DROP VIEW artist_album_song_view;

------------------------- 
--В этом представлении отображаются идентификатор пользователя, идентификатор песни, имя исполнителя, название альбома, название песни, дата выпуска альбома,
CREATE VIEW artist_album_song_user_view AS SELECT user_table.user_id, song_table.song_id, artist_table.artist_name, 
    album_table.album_name, song_table.song_name, album_table.album_released, 
    album_table.album_blob, song_table.song_blob
FROM artist_table JOIN album_table ON artist_table.artist_id = album_table.album_artist
    JOIN song_table on song_table.song_album = album_table.album_id JOIN saved_table on song_table.song_id = saved_table.saved_song
    JOIN user_table on saved_table.saved_user = user_table.user_id;
    
select * from artist_album_song_user_view;
drop view artist_album_song_user_view;








