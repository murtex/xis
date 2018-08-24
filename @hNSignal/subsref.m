function varargout = subsref( this, ss )
% indexing
%
% SUBSREF( this, ss )
%
% INPUT
% this : signal (object)
% ss : subscription definition (struct)
%
% OUTPUT
% ... : TODO

		% safeguard
	if nargin < 1
		error( 'invalid argument: this' );
	end

	if nargin < 2 || ~isstruct( ss )
		error( 'invalid argument: ss' );
	end

		% objects indexing
	if strcmp( ss(1).type, '()' ) || strcmp( ss(1).type, '{}' )
		this = builtin( 'subsref', this, ss(1) );
		ss(1) = [];
	end

	if numel( ss ) == 0
		[varargout{1:nargout}] = this;
		return;
	end

		% builtin properties indexing
	fbuiltin = true;

	if numel( ss ) > 1 ...
			&& strcmp( ss(1).type, '.' ) && ismember( ss(1).subs, {'time', 'data'} ) ...
			&& strcmp( ss(2).type, '{}' )
		fbuiltin = false;
	end

	if fbuiltin
		[varargout{1:nargout}] = builtin( 'subsref', this, ss );
		return;
	end

		% interpolated indexing
	switch ss(1).subs

			% temporal values
		case 'time'
			if numel( ss(2).subs ) ~= 1
				error( 'invalid value: ss' );
			end

				% linear interpolation
			ti = ss(2).subs{1}; % temporal
			if islogical( ti )
				ti = find( ti );
			elseif ischar( ti ) && ismember( ti, {':'} )
				ti = 1:numel( this.time );
			end

			ret = interp1( 1:numel( this.time ), this.time, ti, 'linear' );
			varargout = {ret};

			% spatial values
		case 'data'
			if numel( ss(2).subs ) ~= 2
				error( 'invalid value: ss' );
			end

				% prepare indices
			ci = ss(2).subs{1}; % channel
			if ischar( ci ) && ismember( ci, {':'} )
				ci = 1:size( this.data, 1 );
			end

			ti = ss(2).subs{2}; % temporal
			if islogical( ti )
				ti = find( ti );
			elseif ischar( ti ) && ismember( ti, {':'} )
				ti = 1:size( this.data, 2 );
			end

				% interpolate data
			cti = floor( ti );
			cti(cti == size( this.data, 2 )) = size( this.data, 2 )-1;
			ti = ti-cti;

			ret = NaN( [numel( ci ), numel( ti )] );
			if ~isempty( ret )
				for cj = 1:numel( ci )
					if ~isempty( this.coeff )
						coeff = polyderiv_( this.coeff, ci(cj)-1 );
						ret(cj, :) = polyval_( coeff(:, cti), ti ) * this.rate^(ci(cj)-1);
					elseif ci(cj) <= size( this.data, 1 )
						ret(cj, :) = this.data(ci(cj), cti);
					end
				end
			end

			varargout = {ret};

	end

end % function

