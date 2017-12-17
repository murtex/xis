function p = peakmem( this )
% get peak memory
%
% mem = PEAKMEM( this )
%
% INPUT
% this : logger (scalar object)
%
% OUTPUT
% p : peak memory usage in bytes (scalar numeric)

		% safeguard
	if ~isscalar( this )
		error( 'invalid argument: this' );
	end

		% get peak memory
	p = NaN;

	if isunix() % unix/linux

			% use proc interface
		[~, ret] = unix( sprintf( 'cat /proc/%d/status', feature( 'getpid' ) ) ); % TODO: using undocumented function 'feature'!

			% extract peak info
		retlines = regexp( ret, '\n', 'split' );

		n = numel( retlines );
		for i = 1:n
			if strncmp( retlines{i}, 'VmPeak:', 7 )
				valstring = regexp( retlines{i}, ' ', 'split' );
				p = str2double( valstring{2} ) * 1024;
				break;
			end
		end

	end

end % function

