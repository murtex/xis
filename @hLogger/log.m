function log( this, msg, varargin )
% message logging
%
% LOG( this, msg, ... )
%
% INPUT
% this : logger (scalar object)
% msg : message, fprintf format (row char)
% ... : format arguments

		% safeguard
	if ~isscalar( this )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isrow( msg ) || ~ischar( msg )
		error( 'invalid argument: msg' );
	end

	if this.hierarchy > this.hierarchymax
		return;
	end

		% log header and message
	tic = sprintf( '[%10.3f]', toc( this.tics(1) ) );
	ind = repmat( '..', 1, this.hierarchy );
	msg = sprintf( msg, varargin{:} );

	%fprintf( '%s %s%s %s\n', tic, ind, mod, msg );
	
	if ~isempty( this.module )
		fprintf( '%s %s[%s] %s\n', tic, ind, this.module, msg );
	else
		fprintf( '%s %s%s\n', tic, ind, msg );
	end

end % function

