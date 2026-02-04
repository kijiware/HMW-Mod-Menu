//disables hardscoping for weapons in level.sniper_array
antihardscope( time ) {
    level endon( "game_ended" );
    level endon( "gametypechanged" );
    self endon( "death" );
    self endon( "disconnect" );

    if( !isDefined( time ) || time < 0.05 )
        time = 0.15;

    adsTime = 0;

    for( ;; ) {
        weapon = self getCurrentWeapon();

        if( user_scripts\mp\scripts\util::array_contains_weapon( level.sniper_array, weapon ) ) {
            if( self playerAds() == 1 )
                adsTime ++;
            else
                adsTime = 0;

            if( adsTime >= int( time / 0.05 ) ) {
                adsTime = 0;
                self allowAds( false );

                while( self playerAds() > 0 )
                    wait( 0.05 );

                self allowAds( true );
            }
        }
        wait 0.05;
    }
}