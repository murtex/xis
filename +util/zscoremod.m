function zm = zscoremod( x )
% modified zscore
%
% zm = ZSCOREMOD( x )
%
% INPUT
% x : data (vector numeric)
%
% OUTPUT
% zm : modified z-score (vector numeric)

		% safeguard
	if nargin < 1 || ~isvector( x ) || ~isnumeric( x )
		error( 'invalid argument: x' );
	end

		% compute modified z-score
	zm = 0.67449*(x-median( x(~isnan( x )) )) / util.mad( x );

end % function

