function writewav( filename, data, rate )
% write wav file
%
% WRITEWAV( filename, data, rate )
%
% INPUT
% filename : filename (char)
% data : audio data (numeric)
% rate : sampling ratw (scalar numeric)

		% safeguard
	if nargin < 1 || ~ischar( filename )
		error( 'invalid argument: filename' );
	end

	if nargin < 2 || ~isnumeric( data )
		error( 'invalid argument: data' );
	end

	if nargin < 3 || ~isscalar( rate ) || ~isnumeric( rate )
		error( 'invalid argument: rate' );
	end

		% write wave file
	if exist( 'audiowrite' ) == 2
		audiowrite( filename, data, rate );
	else
		wavwrite( data, rate, 32, filename );
	end

end % function

