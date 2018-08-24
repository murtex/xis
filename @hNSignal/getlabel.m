function lab = getlabel( this, ch, type )
% get label
%
% lab = GETLABEL( this, ch, type )
%
% INPUT
% this : signal (scalar object)
% ch : channel (scalar numeric)
% type : type ['long', 'short', 'symbol', 'unit'] (char)
%
% OUTPUT
% lab : label string (char)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hNSignal' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( ch ) || ~isnumeric( ch )
		error( 'invalid argument: ch' );
	end

	if nargin < 3 || ~ischar( type ) || ~ismember( type, {'long', 'short', 'symbol', 'unit'} )
		error( 'invalid argument: type' );
	end

		% get label
	ch(isnan( ch )) = 0;
	ch = ch+1;

	if ch > numel( this.long ) || (isempty( this.long{ch} ) && isempty( this.short{ch} ) && isempty( this.symbol{ch} ) && isempty( this.unit{ch} ))
		lab = '';
	else
		lab = this.(type){ch};
	end


end % function

