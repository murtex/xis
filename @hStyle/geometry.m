function geometry( this, celldim, figdim, scale, pad )
% set geometry
%
% GEOMETRY( this, celldim, figdim, scale, pad )
%
% INPUT
% this : style reference (scalar object)
% celldim : cell dimension [width, height] (numeric)
% figdim : figure dimension, number of cells [width, height] (numeric)
% scale : overall scale (scalar numeric)
% pad : padding description [left, bottom, right, top] (numeric)
%
% REMARKS
% - padding example: [-2.1] gives space for sign, decimal point and two digits before and one digit after it

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isnumeric( celldim ) || numel( celldim ) ~= 2
		error( 'invalid argument: celldim' );
	end

	if nargin < 3 || ~isnumeric( figdim ) || numel( figdim ) ~= 2
		error( 'invalid argument: figdim' );
	end

	if nargin < 4 || ~isscalar( scale ) || ~isnumeric( scale )
		error( 'invalid argument: scale' );
	end

	if nargin < 5 || ~isnumeric( pad ) || numel( pad ) ~= 4
		error( 'invalid argument: pad' );
	end

		% set geometry
	totaldim = celldim.*figdim;
	totalr = totaldim(1)/totaldim(2);

	this.size(1) = scale*this.refwidth;
	this.size(2) = this.size(1)/totalr;

	this.pad = pad;

end % function

