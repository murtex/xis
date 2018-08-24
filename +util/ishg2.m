function tf = ishg2()
% check for HG2 backend
%
% tf = ISHG2()
%
% OUPUT
% tf : HG2 backend flag (scalar logical)

	tf = ~verLessThan( 'matlab', '8.4' );

end % function

