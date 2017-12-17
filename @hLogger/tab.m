function tab( this, msg, varargin )
% raise hierarchy
%
% TAB( this )
% TAB( this, msg, ... )
%
% INPUT
% this : logger (scalar object)
% msg : message, fprintf-format (row char)
% ... : format arguments

		% safeguard
	if ~isscalar( this )
		error( 'invalid argument: this' );
	end

	if nargin > 1 && (~isrow( msg ) || ~ischar( msg ))
		error( 'invalid argument: msg' );
	end

		% log message and raise hierarchy
	if nargin > 1
		this.log( msg, varargin{:} );
	end

	this.hierarchy = this.hierarchy + 1;

		% start hierarchy timing
	this.tics(this.hierarchy + 1) = tic();

end % function

