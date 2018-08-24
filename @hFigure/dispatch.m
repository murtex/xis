function dispatch( this, hfig, event, msg )
% figure message dispatcher
%
% DISPATCH( hfig, event, msg )
%
% INPUT
% hfig : figure handle (TODO)
% event : TODO
% msg : message string (char)

		% safeguard
	if nargin < 1 || ~isscalar( this ) || ~isa( this, 'hFigure' )
		error( 'invalid argument: this' );
	end

	if nargin < 2
		error( 'invalid argument: hfig' );
	end
	
	if nargin < 3
		error( 'invalid argument: event' );
	end

	if nargin < 4 || ~ischar( msg )
		error( 'invalid argument: msg' );
	end

	style = hStyle.instance();

		% dispatch messages
	if ismember( msg, {'close'} ) % delete close
		delete( hfig );

	elseif ismember( msg, {'keypress'} )
		if iskey_( event, {'escape'}, {} ) % close request
			close( hfig );
		elseif iskey_( event, {'p'}, {} ) % print figure
			plotfile = strcat( datestr( now(), 'yyyymmdd-HHMMSS-FFF' ), '.png' );
			disp( sprintf( 'print ''%s''...', plotfile ) );
			this.print( plotfile );

		elseif iskey_( event, {'t'}, {} ) % views (top, right, front, 3d)
			r0 = camtarget( gca() );
			campos( gca(), r0+[0, sqrt( sum( (r0-campos( gca() )).^2 ) ), 0] );
			camup( gca(), [0, 0, -1] );
		elseif iskey_( event, {'r'}, {} )
			r0 = camtarget( gca() );
			campos( gca(), r0+[0, 0, sqrt( sum( (r0-campos( gca() )).^2 ) )] );
			camup( gca(), [0, 1, 0] );
		elseif iskey_( event, {'f'}, {} )
			r0 = camtarget( gca() );
			campos( gca(), r0+[sqrt( sum( (r0-campos( gca() )).^2 ) ), 0, 0] );
			camup( gca(), [0, 1, 0] );
		elseif iskey_( event, {'3'}, {} )
			view( [225, 60] );
			camup( gca(), [0, 1, 0] );
		end

	elseif ismember( msg, {'buttondown'} )
		this.btnpos = get( hfig, 'CurrentPoint' );

	elseif ismember( msg, {'buttonmove'} )
		if ~any( isnan( this.btnpos ) )
			oldpos = this.btnpos;
			this.btnpos = get( hfig, 'CurrentPoint' );
			delta = this.btnpos-oldpos;
			camorbit( -delta(1), -delta(2), 'data', [0, 1, 0] );
		end

	elseif ismember( msg, {'buttonup'} )
		this.btnpos = NaN( [1, 2] );

	end
	
end % function

	% local functions
function tf = iskey_( event, keys, chars )
	tf = false;
	if (isempty( keys ) || ismember( event.Key, keys )) && (isempty( chars ) || ismember( event.Character, chars ))
		tf = true;
	end
end % function

