function zlabel( this, s, varargin )
	style = hStyle.instance();
	zlabel( s, 'FontSize', style.fssmall, varargin{:} );
end % function

