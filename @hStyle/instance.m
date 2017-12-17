function that = instance()
% class singleton
%
% that = INSTANCE()
%
% OUTPUT
% that : style reference (scalar object)

		% ensure singleton existence
	persistent this;

	if isempty( this ) || ~isvalid( this )
		this = hStyle();
	end

		% return singleton
	that = this;

end % function

