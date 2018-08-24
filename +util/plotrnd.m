function h = plotrnd( varargin )
% plot with randomized z-data
%
% h = PLOTRND( ... )
%
% INPUT
% ... : plot arguments
%
% OUTPUT
% h : plot output

		% plot and randomize z-data
	h = plot( varargin{:} );

	set( h, 'ZData', rand( size( get( h, 'XData' ) ) ) );
		
end % functions

