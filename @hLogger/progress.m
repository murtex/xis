function progress( this, varargin )
% progression logging
%
% PROGRESS( this )
% PROGRESS( this, msg, ... )
% PROGRESS( this, step, n )
%
% INPUT
% this : logger (scalar object)
% msg : initial message, fprintf-format (row char)
% step: current progressing step (scalar numeric)
% n : maximum progressing steps (scalar numeric)

		% safeguard
	if ~isscalar( this )
		error( 'invalid argument: this' );
	end

		% start progression
	persistent decile_last;

	if nargin == 1 || ischar( varargin{1} )

			% safeguard
		if nargin > 1 && ~isrow( varargin{1} )
			error( 'invalid argument: msg' );
		end

			% start logging
		if nargin > 1
			this.tab( varargin{:} );
		else
			this.tab();
		end

		if this.hierarchy <= this.hierarchymax
			tic = sprintf( '[%10.3f]', toc( this.tics(1) ) );
			ind = repmat( '..', 1, this.hierarchy );
			msg = '0%..';

			fprintf( '%s %s%s', tic, ind, msg );
		end

		decile_last = 0;
		this.fprogress = true;

		% continue/stop progression
	elseif isnumeric( varargin{1} ) && numel( varargin ) > 1

			% safeguard
		step = varargin{1};
		if ~isscalar( step )
			error( 'invalid argument: step' );
		end

		n = varargin{2};
		if ~isscalar( n ) || ~isnumeric( n )
			error( 'invalid argument: n' );
		end

			% continue logging
		decile_cur = floor( 10 * step / n );

		if this.hierarchy <= this.hierarchymax
			for i = decile_last+1:decile_cur
				fprintf( '%d%%', 10 * i );
				if i ~= 10
					fprintf( '..' );
				end
			end
		end

		decile_last = decile_cur;

			% stop logging
		if step == n
			if this.hierarchy <= this.hierarchymax
				fprintf( '\n' );
			end
			this.untab();
			this.fprogress = false;
		end

		% safeguard
	else
		error( 'invalid arguments' );
	end

end % function

