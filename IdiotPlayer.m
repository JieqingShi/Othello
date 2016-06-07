function [ Board ] = IdiotPlayer( Board, colour, t )

addpath(['players' filesep 'IdiotPlayer']);
timer = tic;
Board = randomMoves(Board, colour, timer);