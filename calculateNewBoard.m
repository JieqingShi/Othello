function [ Board ] = calculateNewBoard( Board, newMove, color)

% Set new piece on board
Board(newMove(1), newMove(2)) = color;

% search right
% all the opponent's pieces in the same row (return logical array)
pcsOpponent = Board(newMove(1),:) == -color;
% all the player's pieces left from the set piece
pcsPlayer = find(Board(newMove(1),1:newMove(2)-1) == color);

% If there's at least one of the player's pieces 
if ~isempty(pcsPlayer)
%     If the number of the opponents' pieces is the same as the distance
%     between the player's pieces (i.e. there are no empty spaces
%     inbetween) -> Flip all enemies pieces inbetween the player's pieces
    if sum(pcsOpponent(pcsPlayer(end)+1:newMove(2)-1)) == newMove(2)-pcsPlayer(end)-1
        Board(newMove(1),pcsPlayer(end)+1:newMove(2)-1) = color;
    end
end

% search left
pcsPlayer = find(Board(newMove(1),newMove(2)+1:end) == color)+newMove(2);

if ~isempty(pcsPlayer)
    if sum(pcsOpponent(newMove(2)+1:pcsPlayer(1)-1)) == pcsPlayer(1)-newMove(2)-1
        Board(newMove(1),newMove(2)+1:pcsPlayer(1)-1) = color;
    end
end

% search down
pcsOpponent = Board(:,newMove(2)) == -color;
pcsPlayer = find(Board(1:newMove(1)-1,newMove(2)) == color);

if ~isempty(pcsPlayer)
    if sum(pcsOpponent(pcsPlayer(end)+1:newMove(1)-1)) == newMove(1)-pcsPlayer(end)-1
        Board(pcsPlayer(end)+1:newMove(1)-1,newMove(2)) = color;
    end
end

% search up
pcsPlayer = find(Board(newMove(1)+1:end,newMove(2)) == color)+newMove(1);

if ~isempty(pcsPlayer)
    if sum(pcsOpponent(newMove(1)+1:pcsPlayer(1)-1)) == pcsPlayer(1)-newMove(1)-1
        Board(newMove(1)+1:pcsPlayer(1)-1,newMove(2)) = color;
    end
end

% diagonal (lower left to upper right and vice versa)
if newMove(1) >= newMove(2)
    elements = diag(Board,newMove(2)-newMove(1));

    pcsOpponent = elements == -color;
    pcsPlayer = find(elements(1:newMove(2)-1) == color);

    if ~isempty(pcsPlayer)
        if sum(pcsOpponent(pcsPlayer(end)+1:newMove(2)-1)) == newMove(2)-pcsPlayer(end)-1
            vec = zeros(size(elements,1),1);
            vec(pcsPlayer(end)+1:newMove(2)-1) = 1;
            vec = diag(vec,newMove(2)-newMove(1));
            Board(logical(vec)) = color; 
        end
    end

    pcsPlayer = find(elements(newMove(2)+1:end) == color)+newMove(2);

    if ~isempty(pcsPlayer)
        if sum(pcsOpponent(newMove(2)+1:pcsPlayer(1)-1)) == pcsPlayer(1)-newMove(2)-1
            vec = zeros(size(elements,1),1);
            vec(newMove(2)+1:pcsPlayer(1)-1) = 1;
            vec = diag(vec,newMove(2)-newMove(1));
            Board(logical(vec)) = color; 
        end
    end

elseif newMove(2) > newMove(1)
    
    % diagonal (upper left to lower right and vice versa)
    
    elements = diag(Board,newMove(2)-newMove(1));
    pcsOpponent = elements == -color;
    pcsPlayer = find(elements(1:newMove(1)-1) == color);

    if ~isempty(pcsPlayer)
        if sum(pcsOpponent(pcsPlayer(end)+1:newMove(1)-1)) == newMove(1)-pcsPlayer(end)-1
            vec = zeros(size(elements,1),1);
            vec(pcsPlayer(end)+1:newMove(1)-1) = 1;
            vec = diag(vec,newMove(2)-newMove(1));
            Board(logical(vec)) = color; 
        end
    end
    
    pcsPlayer = find(elements(newMove(1)+1:end) == color)+newMove(1);

    if ~isempty(pcsPlayer)
        if sum(pcsOpponent(newMove(1)+1:pcsPlayer(1)-1)) == pcsPlayer(1)-newMove(1)-1
            vec = zeros(size(elements,1),1);
            vec(newMove(1)+1:pcsPlayer(1)-1) = 1;
            vec = diag(vec,newMove(2)-newMove(1));
            Board(logical(vec)) = color; 
        end
    end
end

%Opposite side
newMove(1) = 9-newMove(1);

if newMove(1) >= newMove(2)
    elements = diag(flipud(Board),newMove(2)-newMove(1));
    
    pcsOpponent = elements == -color;
    pcsPlayer = find(elements(1:newMove(2)-1) == color);
    
    if ~isempty(pcsPlayer)
        if sum(pcsOpponent(pcsPlayer(end)+1:newMove(2)-1)) == newMove(2)-pcsPlayer(end)-1
            vec = zeros(size(elements,1),1);
            vec(pcsPlayer(end)+1:newMove(2)-1) = 1;
            vec = diag(vec,newMove(2)-newMove(1));
            Board(logical(flipud(vec))) = color; 
        end
    end

    pcsPlayer = find(elements(newMove(2)+1:end) == color)+newMove(2);

    if ~isempty(pcsPlayer)
        if sum(pcsOpponent(newMove(2)+1:pcsPlayer(1)-1)) == pcsPlayer(1)-newMove(2)-1
            vec = zeros(size(elements,1),1);
            vec(newMove(2)+1:pcsPlayer(1)-1) = 1;
            vec = diag(vec,newMove(2)-newMove(1));
            Board(logical(flipud(vec))) = color; 
        end
    end
elseif newMove(2) > newMove(1)
    elements = diag(flipud(Board),newMove(2)-newMove(1));
    pcsOpponent = elements == -color;
    pcsPlayer = find(elements(1:newMove(1)-1) == color);

    if ~isempty(pcsPlayer)
        if sum(pcsOpponent(pcsPlayer(end)+1:newMove(1)-1)) == newMove(1)-pcsPlayer(end)-1
            vec = zeros(size(elements,1),1);
            vec(pcsPlayer(end)+1:newMove(1)-1) = 1;
            vec = diag(vec,newMove(2)-newMove(1));
            Board(logical(flipud(vec))) = color; 
        end
    end
    
    pcsPlayer = find(elements(newMove(1)+1:end) == color)+newMove(1);

    if ~isempty(pcsPlayer)
        if sum(pcsOpponent(newMove(1)+1:pcsPlayer(1)-1)) == pcsPlayer(1)-newMove(1)-1
            vec = zeros(size(elements,1),1);
            vec(newMove(1)+1:pcsPlayer(1)-1) = 1;
            vec = diag(vec,newMove(2)-newMove(1));
            Board(logical(flipud(vec))) = color; 
        end
    end
end

end

