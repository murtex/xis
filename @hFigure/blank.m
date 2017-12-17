function h = blank( this, varargin )
% blank axis
%
% h = BLANK( this, ... )
%
% INPUT
% this : figure reference (scalar object)
% ... : axis properties
%
% OUTPUT
% h : axis handle (scalar TODO)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

		% create blank axis
	h = axes( ...
		'Visible', 'off', ...
		'Units', 'normalized', ...
		'Position', [0, 0, 1, 1], ...
		'XTick', [], 'YTick', [], ...
		'XLim', [0, 1], 'Ylim', [0, 1] );

end

