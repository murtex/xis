function w = width( this, wf )
% point width
%
% WIDTH( this, wf )
%
% INPUT
% this : style reference (scalar object)
% wf : width factor (scalar numeric)
%
% OUTPUT
% w : point width (scalar numeric)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isscalar( wf ) || ~isnumeric( wf )
		error( 'invalid argument: wf' );
	end

		% set point width
	w = this.refstroke_ * 2^(wf/2);

end

