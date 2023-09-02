--role_table
BEGIN
INSERT_ROLE('Admin');
INSERT_ROLE('Author');
INSERT_ROLE('User');
INSERT_ROLE('User');
INSERT_ROLE('User');
INSERT_ROLE('Author');
INSERT_ROLE('User');
INSERT_ROLE('Author');
INSERT_ROLE('User');
INSERT_ROLE('Author');
INSERT_ROLE('User');
INSERT_ROLE('Author');
INSERT_ROLE('Author');
INSERT_ROLE('User');
INSERT_ROLE('Author');
INSERT_ROLE('Author');
INSERT_ROLE('User');
INSERT_ROLE('Author');
INSERT_ROLE('Author');
INSERT_ROLE('User');
INSERT_ROLE('Author');
INSERT_ROLE('Admin');
END;
select * from role_table

--user_table
begin
INSERT_USER('john_doe', 'password123', 1);
INSERT_USER('jane_doe', 'password456', 1);
INSERT_USER('bob_smith', 'password789', 2);
INSERT_USER('alice_jones', 'passwordabc', 2);
INSERT_USER('_wilson', 'passworddef', 1);
INSERT_USER('sara_johnson', 'passwordghi', 2);
INSERT_USER('mike_brown', 'passwordjkl', 1);
INSERT_USER('emily_davis', 'passwordmno', 2);
INSERT_USER('chris_lee', 'passwordpqr', 1);
INSERT_USER('jessica_kim', 'passwordstu', 2);
end
select * from user_table

EXECUTE INSERT_ARTIST('The');
EXECUTE INSERT_ARTIST('Queen');
EXECUTE INSERT_ARTIST('Led Zeppelin');
EXECUTE INSERT_ARTIST('Pink Floyd');
EXECUTE INSERT_ARTIST('The Rolling Stones');
EXECUTE INSERT_ARTIST('AC/DC');
EXECUTE INSERT_ARTIST('Metallica');
EXECUTE INSERT_ARTIST('Nirvana');
EXECUTE INSERT_ARTIST('Guns N' Roses');


EXECUTE INSERT_SONG(1, 1, 'Boian Rhapsody', BFILENAME('SONGS_DIR', 'bohemian_rhapsody.mp3'));
EXECUTE INSERT_SONG(1, 1, 'Another One Bites the Dust', BFILENAME('SONGS_DIR', 'another_one_bites_the_dust.mp3'));
EXECUTE_SONG(2, 2, 'Stairway to Heaven', BFILENAME('SONGS_DIR', 'stairway_to_heaven.mp3'));
EXECUTE INSERT_SONG(2, 2, 'Black Dog', BFILENAME('SONGS_DIR', 'black_dog3'));
EXECUTE INSERT_SONG(3, 3, 'Wish You Were Here', BFILENAME('SONGS_DIR', 'wish_you_were_here.mp3'));
EXECUTE INSERT_SONG(3, 3, 'Comfortably Numb BFILENAME('SONGS_DIR', 'comfortably_numb.mp3'));
EXECUTE INSERT_SONG(4, 4, 'Sympathy for the Devil', BFILENAME('SONGS_DIR', 'sympathy_for_the_devil.mp3'));
EXECUTE INSERT_SONG(4, 4, 'Gimme Shelter', BFILENAME('SONGS_DIR', 'gimme_shelter.mp3'));
EXECUTE INSERT_SONG(5, 5, 'Highway to Hell', BFILENAME('SONGS_DIR', 'highway_to_hell.mp3'));
EXECUTE INSERT_SONG(5, 5, 'Back in Black', BFILENAME('SONGS_DIR', 'back_in_black.mp3'));

