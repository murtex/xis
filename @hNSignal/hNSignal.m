classdef hNSignal < handle
% piecewise n-th order spline approximated signal

		% properties
	properties ( Access = public )

		rate = NaN; % sampling rate

		time = []; % temporal values
		data = []; % spatial values

		long = {}; % long label
		short = {}; % short label
		symbol = {}; % symbol label
		unit = {}; % unit label

		coeff = []; % polynomial coefficients

	end % properties

		% methods
	methods ( Access = public )

		function this = hNSignal( rate )
		% signal constructor
		%
		% this = HQSIGNAL( rate )
		%
		% INPUT
		% rate : sampling rate (scalar numeric)
		%
		% OUTPUT
		% this : signal (scalar object)

				% create signal object
			this.rate = rate;

		end % function

	end % methods

end % classdef

