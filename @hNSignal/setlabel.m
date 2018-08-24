function setlabel( this, ch, long, short, symbol, unit )
% set labels
%
% SETLABEL( this, ch, long, short, symbol, unit )
%
% INPUT
% this : signal (scalar object)
% ch : channel (scalar numeric)
% long : long name (char)
% short : short name (char)
% symbol : symbol (char)
% unit : unit (char)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hNSignal' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( ch ) || ~isnumeric( ch )
		error( 'invalid argument: ch' );
	end

	if nargin < 3 || ~ischar( long )
		error( 'invalid argument: long' );
	end

	if nargin < 4 || ~ischar( short )
		error( 'invalid argument: short' );
	end

	if nargin < 5 || ~ischar( symbol )
		error( 'invalid argument: symbol' );
	end

	if nargin < 6 || ~ischar( unit )
		error( 'invalid argument: unit' );
	end

		% set labels
	ch(isnan( ch )) = 0;
	ch = ch+1;

	this.long{ch} = long;
	this.short{ch} = short;
	this.symbol{ch} = symbol;
	this.unit{ch} = unit;

end % function
