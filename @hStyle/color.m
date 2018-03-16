function c = color( this, hue, shade )
% styled color
%
% c = COLOR( this, hue, shade )
% 
% INPUT
% this : style reference (scalar object)
% hue : hue offset (scalar numeric)
% shade : luma shade (scalar numeric)
%
% OUTPUT
% c : color (row numeric [r, g, b])

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( hue ) || ~isnumeric( hue ) 
		error( 'invalid argument: hue' );
	end

	if nargin < 3 || ~isscalar( shade ) || ~isnumeric( shade ) 
		error( 'invalid argument: shade' );
	end

		% approximate color
	tmp(1) = polyval( this.refp(:, 1), shade );
	tmp(2) = polyval( this.refp(:, 2), shade );
	tmp(3) = polyval( this.refp(:, 3), shade );

	if isnan( hue ) || this.fmono
		c = tmp([1, 1, 1]);

	else % hue adjustment
		cyuv(1) = tmp(1);
		cyuv(2) = sum( [cos( 2*pi*hue ), -sin( 2*pi*hue )] .* [tmp(2)/this.umax, tmp(3)/this.vmax] )*this.umax;
		cyuv(3) = sum( [sin( 2*pi*hue ), cos( 2*pi*hue )] .* [tmp(2)/this.umax, tmp(3)/this.vmax] )*this.vmax;

		c = rgb2ycocg_( cyuv, true );
	end

	c(c < 0) = 0; % clamp values
	c(c > 1) = 1;

end % function

	% local functions
function [dst, umax, vmax] = rgb2ycocg_( src, finv )
	umax = 1/2;
	vmax = 1/2;

	if finv % ycocg -> rgb
		for ci = 1:size( src, 1 )
			%dst(ci, 1) = sum( [1, -1, 1] .* src(ci, :) );
			%dst(ci, 2) = sum( [1, 1, 0] .* src(ci, :) );
			%dst(ci, 3) = sum( [1, -1, -1] .* src(ci, :) );
			dst(ci, 1) = sum( [1, 1, -1] .* src(ci, :) );
			dst(ci, 2) = sum( [1, 0, 1] .* src(ci, :) );
			dst(ci, 3) = sum( [1, -1, -1] .* src(ci, :) );
		end
	else % rgb -> ycocg
		for ci = 1:size( src, 1 )
			%dst(ci, 1) = sum( [1/4, 1/2, 1/4] .* src(ci, :) );
			%dst(ci, 2) = sum( [-1/4, 1/2, -1/4] .* src(ci, :) );
			%dst(ci, 3) = sum( [1/2, 0, -1/2] .* src(ci, :) );
			dst(ci, 1) = sum( [1/4, 1/2, 1/4] .* src(ci, :) );
			dst(ci, 2) = sum( [1/2, 0, -1/2] .* src(ci, :) );
			dst(ci, 3) = sum( [-1/4, 1/2, -1/4] .* src(ci, :) );
		end
	end
end % function

