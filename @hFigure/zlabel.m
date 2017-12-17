function xlabel( this, s, varargin )
	style = hStyle.instance();
	zlabel( s, 'FontSize', style.fsnorm, varargin{:} );
end % function

