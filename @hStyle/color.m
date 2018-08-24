function c = color( this, hue, shade )
% styled color
%
% c = COLOR( this, hue, shade )
% 
% INPUT
% this : style reference (scalar object)
% hue : hue offset (numeric)
% shade : luma shade (numeric)
%
% OUTPUT
% c : color matrix [Nx3] (numeric)
%
% TODO: vectorize color generation!

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isnumeric( hue ) 
		error( 'invalid argument: hue' );
	end

	if nargin < 3 || ~isnumeric( shade )
		error( 'invalid argument: shade' );
	end

		% adjust arguments
	if numel( hue ) ~= numel( shade )
		if numel( hue ) == 1
			hue = repmat( hue, size( shade ) );
		elseif numel( shade ) == 1
			shade = repmat( shade, size( hue ) );
		else
			error( 'invalid combination: hue, shade' );
		end
	end

		% proceed colors
	c = NaN( [numel( hue ), 3] );

	for ci = 1:numel( hue )

			% approximate color
		tmp(1) = polyval( this.refp(:, 1), shade(ci) );
		tmp(2) = polyval( this.refp(:, 2), shade(ci) );
		tmp(3) = polyval( this.refp(:, 3), shade(ci) );

		if isnan( hue(ci) ) || this.fmono
			c(ci, :) = tmp([1, 1, 1]);

		else % hue adjustment
			cyuv(1) = tmp(1);
			cyuv(2) = sum( [cos( 2*pi*hue(ci) ), -sin( 2*pi*hue(ci) )] .* [tmp(2)/this.umax, tmp(3)/this.vmax] )*this.umax;
			cyuv(3) = sum( [sin( 2*pi*hue(ci) ), cos( 2*pi*hue(ci) )] .* [tmp(2)/this.umax, tmp(3)/this.vmax] )*this.vmax;

			c(ci, :) = rgb2ycocg_( cyuv, true );
		end

	end

		% validate colors
	c(c < 0) = 0;
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

