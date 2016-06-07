function [ new_board, legalMoves ] = randomMoves( board, color, t )
% 1. Idee: überprüfe bei freien Feldern direkt ob ein Zug möglich ist
% und zähle die Anzahl der gegnerischen Steine die umgedreht werden würden


% Nur zum Testen
% board = zeros(8,8);
% board(4,4) = -1;
% board(5,5) = -1;
% board(1,2:7) = -1;
% board(1,8) = 1;
% board(2,8) = -1;
% board(3,8) = -1;
% board(4,5) = 1;
% board(5,4) = 1;
% % Ende Test

new_board = board;
% board1 = board(:);
gegnerPos = find(board==-color);
% gegner = board ==1;
setzmatrix = zeros(8,8);
fieldIsEmpty = zeros(8,8);

for k = 1:size(gegnerPos,1)
    umgebung = [+1, -1, +9, -9, +8, -8, +7, -7];    
%     abbruch = false; abbruch hier falsch!!!

    %Richtung der Überprüfung
    if (gegnerPos(k) == 1 || gegnerPos(k) == 8 || gegnerPos(k) == 57 || gegnerPos(k) == 64)
        % in der Ecke
        umgebung=[];
        abbruch = true;
    elseif (mod(gegnerPos(k),8) == 0 || mod(gegnerPos(k),8) == 1)
        % untere oder obere Kante erreicht
        umgebung = [+8, -8];
    elseif (gegnerPos(k) < 9 || gegnerPos(k) > 56)
        % linker oder rechter Rand erreicht
        umgebung = [+1,-1];
    end

    for n = 1:size(umgebung,2)
%        board(gegnerPos(k)+umgebung(n))
        if isequal(board(gegnerPos(k)+umgebung(n)),0) % if field is empty
%             fieldIsEmpty(gegnerPos(k)+umgebung(n)) = 2;
%             if %if field is allowed
%                 Idea: count amount of fields which would be turned over 

            abbruch = false; 
            ii=1;
            while abbruch == false

                if isequal(board(gegnerPos(k)-ii*umgebung(n)),color)
                  fieldIsEmpty(gegnerPos(k)+umgebung(n)) = 1;
                  abbruch = true;
                elseif isequal(board(gegnerPos(k)-ii*umgebung(n)), 0)
                  abbruch = true;  
                elseif isequal(board(gegnerPos(k)-ii*umgebung(n)),-color)
                    if (gegnerPos(k)-ii*umgebung(n) == 1 || gegnerPos(k)-ii*umgebung(n) == 8 || gegnerPos(k)-ii*umgebung(n) == 57 || gegnerPos(k)-ii*umgebung(n) == 64)
                        % in der Ecke
                        abbruch = true;
                    elseif (mod(gegnerPos(k)-ii*umgebung(n),8) == 0 || mod(gegnerPos(k)-ii*umgebung(n),8) == 1)
                        % prüfe, ob obere und untere Kante erreicht bei
                        % Plausibilitätsüberprüfung
                        if ~isequal(umgebung,[+8, -8])
                            abbruch=true;
                        end
                    elseif (gegnerPos(k)-ii*umgebung(n) < 9 || gegnerPos(k)-ii*umgebung(n) > 56)
                        % prüfe, ob linke und rechte Kante erreicht bei
                        % Plausibilitätsüberprüfung
                        if ~isequal(umgebung,[+1, -1])
                            abbruch=true;
                        end
                    end
                    ii = ii+1;

                end
            end % while

%             fieldIsEmpty(gegnerPos(k)+umgebung(n)) = 1;
        end % if field is empty
    end % for-loop over n
end % for-loop over k
numMoves = sum(fieldIsEmpty(:));
[rowPossibleMoves, colPossibleMoves] = find(fieldIsEmpty==color);
legalMoves = [rowPossibleMoves, colPossibleMoves];
% numMoves = sum(fieldIsEmpty(:));
% if numMoves > 0
%     [rowNextMove, colNextMove] = find(fieldIsEmpty == 2);
%     rndNum = randi(numel(rowNextMove),1,1);
%     next_move = [rowNextMove(rndNum), colNextMove(rndNum)];
%     assignin('base', 'nextMove', next_move);
%     new_board = calculateNewBoard(board, next_move, colour);
%     %Generate new board
% 
% end
end % function
  


