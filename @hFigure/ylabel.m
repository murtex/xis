function ylabel( this, s, varargin )
	style = hStyle.instance();
	ylabel( s, 'FontSize', style.fssmall, varargin{:} );
end % function

