//todo: refactor, add comments, add hold to slide
slide_monitor() {
    level endon( "game_ended" );
    level endon( "endslide" );
    self endon( "death" );
    self endon( "disconnect" );

    for(;;) {
        self notifyOnPlayercommand( "start_slide", "+stance" );
        self waittill( "start_slide" );
        if( self IsOnGround() && self getvelocity() != ( 0, 0, 0 ) ) {
            self setVelocity( self getvelocity() * level.slide_multiplier );
            slide_begin();
            wait level.slide_time;
            slide_end();
        }
    }
    wait 1;
}

slide_begin( var_0, var_1, var_2 ) {
    level endon( "game_ended" );
    level endon( "endslide" );
    self endon( "death" );
    self endon( "disconnect" );

    slide_target = self;
    var_4 = isdefined( level.custom_linkto_slide );
    if ( !isdefined( var_0 ) )
        var_0 = slide_target getvelocity() + ( 0, 0, -10 );
    if ( !isdefined( var_1 ) )
        var_1 = 10;
    if ( !isdefined( var_2 ) )
        if ( isdefined( level.slide_dampening ) )
            var_2 = level.slide_dampening;
        else
            var_2 = 0.035;
    var_5 = spawn( "script_origin", slide_target.origin );
    var_5.angles = slide_target.angles;
    slide_target.slidemodel = var_5;
    var_5 moveslide( ( 0, 0, 15 ), 15, var_0 );
    if ( var_4 )
        slide_target playerlinktoblend( var_5, undefined, 1 );
    else
        slide_target playerlinkto( var_5 );
    slide_target allowprone( false );
    slide_target allowstand( false );
    slide_target allowsprint( false );
    slide_target thread slide_main( var_5, var_1, var_2 );
    slide_target playlocalsound( "slide_start_plr_default" );
    //slide_target playloopsound( "slide_loop_plr_default" );
}

slide_main( var_0, var_1, var_2 ) {
    level endon( "game_ended" );
    level endon( "endslide" );
    self endon( "death" );
    self endon( "disconnect" );
    self endon( "stop_sliding" );

    slide_target = self;
    var_4 = undefined;
    for (;;) {
        var_5 = slide_target getnormalizedmovement();
        var_6 = anglestoforward( slide_target.angles );
        var_7 = anglestoright( slide_target.angles );
        var_5 = ( var_5[ 1 ] * var_7[ 0 ] + var_5[ 0 ] * var_6[ 0 ], var_5[ 1 ] * var_7[ 1 ] + var_5[ 0 ] * var_6[ 1 ], 0 );
        var_0.slidevelocity = var_0.slidevelocity + var_5 * var_1;
        wait 0.05;
        var_0.slidevelocity = var_0.slidevelocity * ( 1 - var_2 );
    }
}

slide_end() {
    level endon( "game_ended" );
    level endon( "endslide" );
    self endon( "death" );
    self endon( "disconnect" );

    slide_target = self;
    slide_target unlink();
    slide_target setvelocity( slide_target.slidemodel.slidevelocity );
    slide_target.slidemodel delete();
    //slide_target notify( "stop soundslide_loop_plr_default" );
    slide_target playlocalsound( "slide_ease_out_plr_default" );
    slide_target notify( "stop_sliding" );
    slide_target allowprone( true );
    slide_target allowstand( true );
    slide_target allowsprint( true );
    slide_target setstance( "crouch" );
    wait 0.5;
}