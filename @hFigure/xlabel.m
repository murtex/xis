function xlabel( this, s, varargin )
	style = hStyle.instance();
	xlabel( s, 'FontSize', style.fsnorm, varargin{:} );
end % function

