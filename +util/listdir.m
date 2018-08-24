function dl = listdir( dirname )
% list directories
%
% dl = LISTDIR( dirname )
%
% INPUT
% dirname : directory name (char)
%
% OUTPUT
% dl : directory list (cell string)

		% safeguard
	if nargin < 1 || ~ischar( dirname )
		error( 'invalid argument: dirname' );
	end

		% get directories
	dl = dir( dirname );
	dl(~[dl.isdir]) = [];
	dl(ismember( {dl.name}, {'.', '..'} )) = [];
	dl = {dl.name};

end % function


