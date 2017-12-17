function untab( this, msg, varargin )
% lower hierarchy
%
% UNTAB( this )
% UNTAB( this, msg, ... )
%
% INPUT
% this : logger (scalar object)
% msg : message, fprintf-format (row char)
% ... : format arguments

		% safeguard
	if ~isscalar( this ) || this.hierarchy < 1
		error( 'invalid argument: this' );
	end

	if nargin > 1 && (~isrow( msg ) || ~ischar( msg ))
		error( 'invalid argument: msg' );
	end

		% log message, timing and lower hierarchy
	if nargin > 1
		this.log( msg, varargin{:} );
	end

	timing = toc( this.tics(this.hierarchy + 1) ); % log timing >10s
	if timing > 10
		this.log( '(%.3f)', timing );
	end

	this.hierarchy = this.hierarchy - 1;

end % function

