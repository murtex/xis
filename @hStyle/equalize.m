function varargout = equalize( this, varargin )
% equalize axes limits
%
% ... = EQUALIZE( this, ... )
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

		% determine centers and widths
	xc = zeros( size( varargin ) );
	xw = zeros( size( varargin ) );

	for vi = 1:numel( varargin )
		[lim, xc(vi)] = this.limits( varargin{vi} );
		xw(vi) = diff( lim );
	end

		% equalize limits
	xwmax = max( ~isinf( xw ).*xw );

	for vi = 1:numel( varargin )
		varargout{vi} = xc(vi)+[-xwmax, xwmax]/2;
	end

end % function

