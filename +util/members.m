function [imembers, nmembers] = members( A, B )
% array member indices
%
% [imembers, nmembers] = MEMBERS( A, B )
%
% INPUT
% A : querry array
% B : set array
%
% OUTPUT
% imembers : locations in B (numeric)
% nmembers : number of locations (scalar numeric)

		% safeguard
	if nargin < 1
		error( 'invalid argument: A' );
	end

	if nargin < 2
		error( 'invalid argument: B' );
	end

		% find members
	[~, imembers] = ismember( A, B );
	imembers(imembers == 0) = [];

	nmembers = numel( imembers );

end % function

