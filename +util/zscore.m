function v = zscore( v )
% z-score ignoring nans
%
% v = ZSCORE( v )
%
% INPUT
% v : data (numeric vector)
%
% OUTPUT
% v : z-score (numeric vector)

		% safeguard
	if nargin < 1 || ~isnumeric( v ) || ~isvector( v )
		error( 'invalid argument: v' );
	end

		% compute z-score
	v = (v-mean( v(~isnan( v )) ))/std( v(~isnan( v )) );

end % function

