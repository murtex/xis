function lims = even( this, lims, fvert )
% even axes limits
%
% lims = EVEN( this, lims, fvert )
%
% INPUT
% this : style reference (scalar object)
% lims : data limits [count, dims, [upper, lower]] (numeric)
% fvert : vertical adjustment flag (scalar logical)
%
% OUTPUT
% lims : adjusted data limits (numeric)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isnumeric( lims ) || ndims( lims ) ~= 3 || size( lims, 2 ) < 2
		error( 'invalid argument: lims' );
	end

	if nargin < 3 || ~isscalar( fvert ) || ~islogical( fvert )
		error( 'invalid argument: fvert' );
	end

		% determine aspect ratios
	q = NaN( [size( lims, 1 ), 1] );

	for li = 1:size( lims, 1 )
		dx = diff( lims(li, 1, :) );
		dy = diff( lims(li, 2, :) );
		q(li) = dx/dy;
	end

		% equalize aspect ratios
	qmin = min( q );
	qmax = max( q );

	for li = 1:size( lims, 1 )
		if fvert && q(li) > qmin % adjust vertical scale
			lims(li, 2, 2) = lims(li, 2, 1)+diff( lims(li, 1, :) )/qmin;
		elseif ~fvert && q(li) < qmax % adjust horizontal scale
			lims(li, 1, 2) = lims(li, 1, 1)+qmax*diff( lims(li, 2, :) );
		end
	end

end % function

