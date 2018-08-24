function gencols( this )
% generate styled colors
%
% GENCOLS( this )
%
% INPUT
% this : style reference (scalar object)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

		% up reference colors
	rrgb = [...
		[0, 48, 94]; ...
		[129, 139, 172]; ...
		[193, 211, 224]] / 255; % uni potsdam (print)

	rrgb = [...
		[0, 66, 96]; ...
		[89, 132, 152]; ...
		[207, 218, 227]] / 255; % uni potsdam (web)

	[ryuv, this.umax, this.vmax] = rgb2ycocg_( rrgb, false );

		% fit reference colors
	this.refp(:, 1) = polyfit( ryuv(:, 1), ryuv(:, 1), 1 );
	this.refp(:, 2) = polyfit( ryuv(:, 1), ryuv(:, 2), 1 );
	this.refp(:, 3) = polyfit( ryuv(:, 1), ryuv(:, 3), 1 );

		% preset shades
	this.shadelo = ryuv(1, 1);
	this.shademed = ryuv(2, 1);
	this.shadehi = ryuv(3, 1);

end % function

	% local functions
function [dst, umax, vmax] = rgb2ycocg_( src, finv )
	umax = 1/2;
	vmax = 1/2;

	if finv % ycocg -> rgb
		for ci = 1:size( src, 1 )
			dst(ci, 1) = sum( [1, 1, -1] .* src(ci, :) );
			dst(ci, 2) = sum( [1, 0, 1] .* src(ci, :) );
			dst(ci, 3) = sum( [1, -1, -1] .* src(ci, :) );
		end

	else % rgb -> ycocg
		for ci = 1:size( src, 1 )
			dst(ci, 1) = sum( [1/4, 1/2, 1/4] .* src(ci, :) );
			dst(ci, 2) = sum( [1/2, 0, -1/2] .* src(ci, :) );
			dst(ci, 3) = sum( [-1/4, 1/2, -1/4] .* src(ci, :) );
		end
	end
end % function

