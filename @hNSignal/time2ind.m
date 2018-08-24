function i = time2ind( this, t )
% convert temporal values to index values
%
% i = TIME2IND( this, t )
%
% INPUT
% this : signal (scalar object)
% t : temporal values (numeric)
%
% OUTPUT
% i : index values (numeric)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hNSignal' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isnumeric( t )
		error( 'invalid argument: t' );
	end

		% convert values
	i = (t-this.time(1))/(this.time(end)-this.time(1))*(numel( this.time )-1) + 1;
end

