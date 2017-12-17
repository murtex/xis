classdef hFigure < handle

	properties

		hfig = NaN; % figure handle
		root = NaN; % root axis

		framerate = NaN; % animation frame rate
		frames = {}; % hardcopied frames

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

				% create figure
			props = {...
				'Visible', 'off', ...
				'Renderer', 'opengl', ...
				'defaultAxesNextPlot', 'add' };

			props = cat( 2, props, ... % size
				'Units', style.units, ...
				'Position', [0, 0, style.size(1), style.size(2)], ...
				'PaperUnits', style.units, ...
				'PaperPosition', [0, 0, style.size(1), style.size(2)], ...
				'PaperSize', [style.size(1), style.size(2)] );

			props = cat( 2, props, ... % background
				'Color', style.background, ...
				'InvertHardCopy', 'off' );

			props = cat( 2, props, ... % fonts
				'defaultTextInterpreter', 'none', ...
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
				'defaultAxesLineWidth', style.lwnorm, ...
				'defaultAxesLayer', 'bottom' );

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

			this.hfig = figure( props{:}, varargin{:} );

			this.resize( 1, 1 );

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
				if strcmp( get( this.hfig, 'Visible' ), 'on' )
					waitfor( this.hfig );
				end
				if ishandle( this.hfig )
					delete( this.hfig );
				end
			end

		end % function

	end % methods

end % classdef

