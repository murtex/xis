classdef hFigure < handle
% plotting

	properties

		hfig = NaN; % figure handle
		root = NaN; % root axis

		framerate = NaN; % animation frame rate
		frames = {}; % hardcopied frames

		btnpos = NaN( [1, 2] ); % pointer position

		hlink = matlab.graphics.internal.LinkProp.empty(); % property links

	end % properties

	methods

		function this = hFigure( varargin )
		% class constructor
		%
		% this = HFIGURE( ... )
		%
		% INPUT
		% ... : figure properties
		%
		% OUTPUT
		% this : figure reference (scalar object)

			style = hStyle.instance();

				% set figure properties
			props = {...
				'Visible', 'off', ...
				'Renderer', 'opengl', ...
				'defaultAxesNextPlot', 'add' };

			props = cat( 2, props, ... % size
				'Units', style.units, ...
				'Position', [0, 0, style.size], ...
				'PaperUnits', style.units, ...
				'PaperPosition', [0, 0, style.size], ...
				'PaperSize', style.size );

			if style.fmono % background
				props = cat( 2, props, 'Color', [1, 1, 1] );
			else
				props = cat( 2, props, 'Color', style.background );
			end
			props = cat( 2, props, 'InvertHardCopy', 'off' );

			props = cat( 2, props, ... % fonts
				'defaultTextInterpreter', 'tex', ...
				'defaultTextFontUnits', style.units, ...
				'defaultTextFontName', style.fontname, ...
				'defaultTextFontSize', style.fsnorm, ...
				'defaultAxesFontUnits', style.units, ...
				'defaultAxesFontName', style.fontname, ...
				'defaultAxesFontSize', style.fsnorm );

			props = cat( 2, props, ... % axes grid
				'defaultAxesGridLineStyle', ':', ...
				'defaultAxesXGrid', 'on', ...
				'defaultAxesYGrid', 'on', ...
				'defaultAxesZGrid', 'on', ...
				'defaultAxesBox', 'on', ...
				'defaultAxesLineWidth', style.lwthin, ...
				'defaultAxesLayer', 'bottom' );
				% 'defaultAxesTickLength', [0.015, 0.0375], ... % default: [0.01, 0.025]

			props = cat( 2, props, ... % axes colors
				'defaultAxesXColor', [0, 0, 0], ...
				'defaultAxesYColor', [0, 0, 0], ...
				'defaultAxesZColor', [0, 0, 0] );

			props = cat( 2, props, ... % hg1 smoothing
				'defaultLineLineSmoothing', 'on', ...
				'defaultPatchLineSmoothing', 'on' );

			if util.ishg2() % hg2 settings
				props = cat( 2, props, ...
					'GraphicsSmoothing', 'on', ...
					'defaultLineAlignVertexCenters', 'on', ...
					'defaultAxesFontSmoothing', 'on', ...
					'defaultAxesTitleFontSizeMultiplier', 1, ...
					'defaultAxesLabelFontSizeMultiplier', 1 );
				props = cat( 2, props, ...
					'defaultAxesGridColor', [0, 0, 0], ...
					'defaultAxesGridAlpha', 0.2 );
			end

				% create figure
			this.hfig = figure( props{:}, ...
				'Units', style.units, ...
				'Position', [0, 0, style.size], ...
				'PaperUnits', style.units, ...
				'PaperPosition', [0, 0, style.size], ...
				'PaperSize', style.size, ...
				varargin{:} );

				% hide menu
			if ~style.fmenu
				set( this.hfig, 'MenuBar', 'none' );
			end

				% maximize visible windows
			if style.ffull && strcmp( get( this.hfig, 'Visible' ), 'on' )
				ws = warning( 'off', 'MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame' );

				pause( 0.01 );
				set( get( handle( this.hfig ), 'JavaFrame' ), 'Maximized', 1 );

				warning( ws );
			end

				% add default dispatcher for visible windows
			if strcmp( get( this.hfig, 'Visible' ), 'on' )
				set( this.hfig, 'CloseRequestFcn', {@this.dispatch, 'close'} );
				set( this.hfig, 'WindowKeyPressFcn', {@this.dispatch, 'keypress'} );
				set( this.hfig, 'WindowButtonDownFcn', {@this.dispatch, 'buttondown'} );
				set( this.hfig, 'WindowButtonMotionFcn', {@this.dispatch, 'buttonmove'} );
				set( this.hfig, 'WindowButtonUpFcn', {@this.dispatch, 'buttonup'} );
			end

				% create root axis
			this.root = this.blank();

		end % function

		function delete( this )
		% class destructor
		%
		% DELETE( this )
		%
		% INPUT
		% this : figure reference (scalar object)

			if ishandle( this.hfig )
				delete( this.hfig );
			end

		end % function

	end % methods

end % classdef

