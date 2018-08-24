function [hp, vp] = padding( this, pdesc, fsize )
% compute tick padding
%
% [hp, vp] = PADDING( this, pdesc, fsize )
%
% INPUT
% this : figure reference (scalar object)
% pdesc : padding description (scalar numeric)
% fsize : font size (scalar numeric)
%
% OUTPUT
% hp : horizontal padding (scalar numeric)
% vp : vertical padding (scalar numeric)
%
% REMARKS
% - padding example: [-2.1] gives space for sign, decimal point and two digits before and one digit after it

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( pdesc ) || ~isnumeric( pdesc )
		error( 'invalid argument: pdesc' );
	end

	if nargin < 3 || ~isscalar( fsize ) || ~isnumeric( fsize )
		error( 'invalid argument: fsize' );
	end

	style = hStyle.instance();

		% prepare sample string
	sample = ' ';

	if ~isnan( pdesc )
		sample = '';

		if pdesc < 0
			sample = [sample, '-'];
		end

		sample = [sample, repmat( '9', [1, floor( abs( pdesc ) )] )];

		nd = round( 10*mod( abs( pdesc ), 1 ) );
		if nd > 0
			sample = [sample, '.'];
			sample = [sample, repmat( '9', [1, nd] )];
		end
	end

		% determine sample size
	hb = this.blank();

	ht = text( 0.5, 0.5, sample, ...
		'Units', 'normalized', ...
		'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', ...
		'FontSize', fsize );

	htext = get( ht, 'Extent' );

	delete( ht );
	delete( hb );

		% set padding
	vp = 0.5*htext(4);
	hp = vp*style.size(2)/style.size(1);

	if ~isnan( pdesc )
		hp = htext(3)+hp;
		vp = pdesc*htext(4)+vp/2;
	end

end % function


