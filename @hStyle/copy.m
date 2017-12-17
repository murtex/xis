function that = copy( this )
% deep copy
%
% that = COPY( this )
%
% INPUT
% this : style reference (scalar object)
%
% OUTPUT
% that : style reference (scalar object)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

		% copy properties
	that = hStyle();

	props = properties( 'hStyle' );
	for i = 1:numel( props )
		that.(props{i}) = this.(props{i});
	end

end % function

