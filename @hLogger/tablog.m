function tablog( this, msg, varargin )
% tabbed message logging
%
% TABLOG( this, msg, ... )
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

	if this.hierarchy > this.hierarchymax
		return;
	end

		% tabbed logging
	this.tab();
	this.log( msg, varargin{:} );
	this.untab();

end % function

