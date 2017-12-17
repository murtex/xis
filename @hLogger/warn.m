function warn( this, msg, varargin )
% issue warning
%
% WARN( this )
% WARN( this, msg, ... )
%
% INPUT
% this : logger (scalar object)
% msg : message, fprintf-format (row char)
% ... : format arguments

		% safeguard
	if ~isscalar( this )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isrow( msg ) || ~ischar( msg )
		error( 'invalid argument: msg' );
	end

		% issue warning
	ws = warning();
	warning( 'off', 'verbose' );
	warning( 'off', 'backtrace' );
	warning( sprintf( msg, varargin{:} ) );
	warning( ws );

	if this.fcritical
		input( 'press return to continue' );
	end

end % function

