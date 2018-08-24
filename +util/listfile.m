function fl = listfile( dirname, pattern )
% list files
%
% fl = LISTFILE( dirname, pattern )
%
% INPUT
% dirname : directory name (char)
% pattern : filename patern (char)
%
% OUTPUT
% fl : file list (cell string)

		% safeguard
	if nargin < 1 || ~ischar( dirname )
		error( 'invalid argument: dirname' );
	end

	if nargin < 2 || ~ischar( pattern )
		error( 'invalid argument: pattern' );
	end

		% get files
	fl = dir( fullfile( dirname, pattern ) );
	fl([fl.isdir]) = [];
	fl = {fl.name};

end % function


