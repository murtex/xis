function xlabel( this, s, varargin )
	style = hStyle.instance();
	ylabel( s, 'FontSize', style.fsnorm, varargin{:} );
end % function

