-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

CREATE DATABASE tournament IF NOT EXISTS;

-- Connect to tournament database
\connect tournament;

-- Create the players table
CREATE TABLE players (
	id SERIAL PRIMARY KEY,
	name text
);

-- Create the matches table
CREATE TABLE matches (
	winner SERIAL REFERENCES players(id) ON DELETE CASCADE,
	loser SERIAL REFERENCES players(id) ON DELETE CASCADE
);

-- Create view for player standings
CREATE VIEW players_standings AS
    SELECT players.id, players.name,
        (SELECT COUNT(*) FROM matches WHERE matches.winner=players.id) AS wins,
        (SELECT COUNT(*) FROM matches WHERE matches.winner=players.id OR matches.loser=players.id) AS matches
    FROM players
    ORDER BY wins DESC;