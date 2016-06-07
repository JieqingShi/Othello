function [ new_Board ] = calculateLegalMoves( Board, colour, timer )

%% Test-Brett
%% Stellung 1
% Board = zeros(8,8);
% Board(3,4) = -1;
% Board(4,3) = 1; Board(4,4) = 1; Board(4,5) = -1; Board(4,6) = 1;
% Board(5,4) = 1; Board(5,5) = -1; Board(5,6) = -1;
% Board(6,5) = 1;

% Weiﬂ (-1) am Zug
%% richtig klassifiziert

%% Stellung 2
% Board = zeros(8,8);
% Board(1,1) = 1; Board(2,2) = 1; Board(3,3) = 1;
% Board(1,2:end-1) = -1;
% Board(3,4) = -1; Board(3,5) = 1;
% Board(4,3) = 1; Board(4,4) = 1; Board(4,5) = 1; Board(4,6) = -1;
% Board(5,3) = 1; Board(5,4) = -1; Board(5,5) = -1;
% Board(6,4) = -1;

new_Board = Board;

% Schwarz (1) am zug
%% richtig klassifiziert

%% Stellung 3 http://www.yourturnmyturn.com/rules/reversi.php Figure 4
% Board = zeros(8,8);
% Board(:,1) = 1;
% Board(1:end-1,2) = -1;
% Board(1,2:end) = -1;
% Board(2:3,3:4) = 1;
% Board(4:7, 3) = -1;
% Board(4:6, 4) = -1;
% Board(1:end-1, 5) = -1;
% Board(end, 1:end-1) = 1; Board(7,4) = 1;

% Weiﬂ (-1) am Zug
%% richtig klassifiziert

% Initialisierung: 

[rowOpponent, colOpponent] = find(Board==-colour);
emptyFields = zeros(8,8);
legalFields = zeros(8,8);

for m = 1:numel(rowOpponent)
    rowIdx = rowOpponent(m); colIdx = colOpponent(m);
    checkLeftRightFlag = 1; checkUpDownFlag = 1;
    if colIdx == 1 || colIdx == 8
        checkLeftRightFlag = 0;
    end
     
    if rowIdx == 1 || rowIdx == 8
        checkUpDownFlag = 0;
    end
    
% search direction: left
if checkLeftRightFlag
    tempField = Board(rowIdx, colIdx-1);
    
    if tempField == 0
        emptyFields(rowIdx, colIdx-1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_colIdx < 8
            if Board(search_rowIdx, search_colIdx+1) == colour
                legalFields(rowIdx, colIdx-1) = 1;
                break;
            elseif Board(search_rowIdx, search_colIdx+1) == -colour
                search_colIdx = search_colIdx + 1;
            else
                break;
            end
        end
    end
end
% search direction: right
if checkLeftRightFlag
    tempField = Board(rowIdx, colIdx+1);
    if tempField == 0
        emptyFields(rowIdx, colIdx+1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_colIdx > 1
            if Board(search_rowIdx, search_colIdx-1) == colour
                legalFields(rowIdx, colIdx+1) = 1;
                break;
            elseif Board(search_rowIdx, search_colIdx-1) == -colour
                search_colIdx = search_colIdx - 1;
            else
                break;
            end
        end
    end
end
%     search direction: up
if checkUpDownFlag
    tempField = Board(rowIdx-1, colIdx);
    if tempField == 0
        emptyFields(rowIdx-1, colIdx) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx < 8
            if Board(search_rowIdx+1, search_colIdx) == colour
                legalFields(rowIdx-1, colIdx) = 1;
                break;
            elseif Board(search_rowIdx+1, search_colIdx) == -colour
                search_rowIdx = search_rowIdx + 1;
            else
                break;
            end
        end
    end
end
%     search direction: down
if checkUpDownFlag
    tempField = Board(rowIdx+1, colIdx);
   if tempField == 0
        emptyFields(rowIdx+1, colIdx) = 1;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx >1
            if Board(search_rowIdx-1, search_colIdx) == colour
                legalFields(rowIdx+1, colIdx) = 1;
                break;
            elseif Board(search_rowIdx-1, search_colIdx) == -colour
                search_rowIdx = search_rowIdx - 1;
            else
                break;
            end
        end
   end
end
%     search direction: upper left
if checkLeftRightFlag && checkUpDownFlag
    tempField = Board(rowIdx-1, colIdx-1);
    if tempField == 0
        emptyFields(rowIdx-1, colIdx-1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx < 8 && search_colIdx < 8
            if Board(search_rowIdx+1, search_colIdx+1) == colour
                legalFields(rowIdx-1, colIdx-1) = 1;
                break;
            elseif Board(search_rowIdx+1, search_colIdx+1) == -colour
                search_colIdx = search_colIdx + 1;
                search_rowIdx = search_rowIdx + 1;
            else
                break;
            end
        end
    end
end
    
%     search direction: upper right
if checkLeftRightFlag && checkUpDownFlag
    tempField = Board(rowIdx-1, colIdx+1);
    if tempField == 0
%         emptyFields(rowIdx-1, colIdx+1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx < 8 && search_colIdx > 1
            if Board(search_rowIdx+1, search_colIdx-1) == colour
                legalFields(rowIdx-1, colIdx+1) = 1;
                break;
            elseif Board(search_rowIdx+1, search_colIdx-1) == -colour
                search_colIdx = search_colIdx - 1;
                search_rowIdx = search_rowIdx + 1;
            else
                break;
            end
        end
    end
end
%    search direction: lower left
if checkLeftRightFlag && checkUpDownFlag
    tempField = Board(rowIdx+1, colIdx-1);
    if tempField == 0
        emptyFields(rowIdx+1, colIdx-1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx > 1 && search_colIdx < 8
            if Board(search_rowIdx-1, search_colIdx+1) == colour
                legalFields(rowIdx+1, colIdx-1) = 1;
                break;
            elseif Board(search_rowIdx-1, search_colIdx+1) == -colour
                search_colIdx = search_colIdx + 1;
                search_rowIdx = search_rowIdx - 1;
            else
                break;
            end
        end
    end
end

%     search direction: lower right
if checkLeftRightFlag && checkUpDownFlag
    tempField = Board(rowIdx+1, colIdx+1);
    if tempField == 0
        emptyFields(rowIdx+1, colIdx+1) = 2;
        search_rowIdx = rowIdx; search_colIdx = colIdx;
        while search_rowIdx > 1 && search_colIdx > 1
            if Board(search_rowIdx-1, search_colIdx-1) == colour
                legalFields(rowIdx+1, colIdx+1) = 1;
                break;
            elseif Board(search_rowIdx-1, search_colIdx-1) == -colour
                search_colIdx = search_colIdx - 1;
                search_rowIdx = search_rowIdx - 1;
            else
                break;
            end
        end
    end
end

end
assignin('base', 'board', Board);
assignin('base', 'emptyFields', emptyFields);
assignin('base', 'legalFields', legalFields);   

% Make random move (if possible), if not --> pass
numMoves = sum(legalFields(:));
if numMoves > 0
    [rowNextMove, colNextMove] = find(legalFields == 1);
    rndNum = randi(numel(rowNextMove),1,1);
    next_move = [rowNextMove(rndNum), colNextMove(rndNum)];
    assignin('base', 'nextMove', next_move);
    new_Board = calculateNewBoard(Board, next_move, colour); %Why fliplr??
    %Generate new board

end
% Generate new Board



end
  

% Possible alternative: use regexp to check row, column, diagonals for word patterns
% Consider the following board:
% board = zeros(8,8);
% board(3,4) = -1; board(3,5) = 1;
% board(4,3) = 1; board(4,4) = 1; board(4,5) = 1; board(4,6) = -1;
% board(5,3) = 1; board(5,4) = -1; board(5,5) = -1;
% board(6,4) = -1;

% Let's look at the fifth row: (5,6) would e.g. be eligible field
% row = 5;
% a = num2str(board(row,:));
% a(isspace(a)) = [];
% [~, endIdx] = regexp(a, '(1+)(-1+)'); %gives endIdx = 5
% then board(row, endIdx+1) would be eligible field

% % Let's look at the fifth column
% col = 5;
% a = num2str(board(:,col)');
% a(isspace(a)) = [];
% [startIdx, endIdx] = regexp(a, '(1+-1+)');
% board(endIdx, col) would be eligible field
% 
% Let's look at the diagonal from (1,3) to (6,8)
% startRow = 1; startCol = 3;
% b = board(startRow, startCol);
% for ii = 0:5
%     b = [b num2str(board(startRow+ii, startCol+ii))];
% end
% [startIdx, endIdx] = regexp(b, '(1+)(-1+)');

