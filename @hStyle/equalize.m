function varargout = equalize( this, varargin )
% equalize axes limits
%
% [xl, ...] = EQUALIZE( this, xl, ... )
%
% INPUT
% this : style reference (scalar object)
% ... : data limits (row vector [upper, lower])
%
% OUTPUT
% ... : adjusted data limits (row vector [upper, lower])

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hStyle' )
		error( 'invalid argument: this' );
	end

		% equalize limits
	xc = cell( size( varargin ) );
	for vi = 1:numel( varargin )
		[varargout{vi}, xc{vi}] = this.limits( varargin{vi} );
	end

	dxl = cellfun( @diff, varargout ); % equal scales
	d = max( ~isinf( dxl ).*dxl );

	for vi = 1:numel( varargout )
		if isinf( dxl(vi) ) || dxl(vi) < d
			varargout{vi}(1) = xc{vi}-d/2;
			varargout{vi}(2) = xc{vi}+d/2;
		end
	end

end % function

