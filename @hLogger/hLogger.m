classdef (Sealed = true) hLogger < handle
% hierarchic logging (singleton)
%
% TODO: silently stop never entered progress bars!

		% properties
	properties (Access = public)

		logfile = ''; % log filename used

		hierarchy = 0; % hierarchy (scalar numeric)
		hierarchymax = Inf; % maximum hierarchy (scalar numeric)

		tics = tic(); % timing (matlab internal)

		module = ''; % current module

		fprogress = false; % flags
		fcritical = false;

		fonce = false;

	end

		% static methods
	methods (Static = true)

		that = instance( logfile ); % class singleton

	end % static methods

		% private methods
	methods (Access = private)

		function this = hLogger()
		% class constructor
		%
		% this = HLOGGER()
		%
		% OUTPUT
		% this : logger (scalar object)

			% nop

		end

		function delete( this )
		% class destructor
		%
		% DELETE( this )
		%
		% INPUT
		% this : logger (scalar object)

				% safeguard
			if ~isscalar( this )
				error( 'invalid argument: this' );
			end

				% stop logging
			diary( 'off' );

		end

	end % private methods

end % classdef

