function xlabel( this, s, varargin )
	style = hStyle.instance();
	xlabel( s, 'FontSize', style.fssmall, varargin{:} );
end % function

