function that = instance( logfile )
% class singleton
%
% that = INSTANCE()
% that = INSTANCE( logfile )
%
% INPUT
% logfile : logging filename (row char)
%
% OUTPUT
% that : logger (scalar object)

		% ensure singleton existence
	persistent this;

	if isempty( this ) || ~isvalid( this )
		this = hLogger();
	end

		% reset logger
	if nargin > 0

			% safeguard
		if ~isrow( logfile ) || ~ischar( logfile )
			error( 'invalid argument: logfile' );
		end

			% reset
		delete( this ); % stop logging

		this = hLogger.instance(); % (re-)start logging

		if exist( logfile, 'file' ) == 2
			delete( logfile );
		end

		diary( logfile );
		this.tics = tic();

	end

		% return singleton
	that = this;

end % function

