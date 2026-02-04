//todo: refactor
//kills players after the killTime if they camp
anticamp() {
    level endon( "game_ended" );
    level endon( "gametypechanged" );
    self endon( "death" );
    self endon( "disconnect" );

    self.antiCamp[ "time" ] = 0;

    lastPosition = self.origin;
    killTime = level.antiCamp[ "killTime" ];
    minDistance = level.antiCamp[ "minDistance" ];

    maps\mp\_utility::gameflagwait( "prematch_done" );

    for( ;; ) {
        currentPosition = self.origin;
        distance = distance2d( lastPosition, currentPosition );

        if( self user_scripts\mp\source\structure::in_menu() || self.god_mode == 1 ) {
            lastPosition = currentPosition;
            self.antiCamp[ "time" ] = 0;
        }
        if( distance < minDistance ) {
            self.antiCamp[ "time" ]++;
            if( self.antiCamp[ "time" ] >= killTime - 5 )
                self iprintlnbold( "^3Camping^7: ^1" + ( level.antiCamp[ "killTime" ] - self.antiCamp[ "time" ] ) );
            if( self.antiCamp[ "time" ] == killTime )
                self suicide();
        }
        else {
            lastPosition = currentPosition;
            self.antiCamp[ "time" ] = 0;
        }
        wait 1;
    }
}