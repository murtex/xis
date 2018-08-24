function linkprop( this, h, props )
% persistently link axes properties
%
% LINKPROP( this, h, props )
%
% INPUT
% this : figure reference (scalar object)
% h : axis handles (graphics handle)
% props : properties (cell string)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~all( arrayfun( @ishghandle, h(:) ) )
		error( 'invalid argument: h' );
	end

	if nargin < 3 || ~iscellstr( props )
		error( 'invalid argument: props' );
	end

		% link properties
	this.hlink(end+1) = linkprop( h, props );

end % function

