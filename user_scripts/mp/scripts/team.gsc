//todo: add comments
all_teleport_crosshair() {
    teleportPosition = user_scripts\mp\scripts\util::cursor_pos();

    foreach( player in level.players )
        if( isalive( player ) && player != self )
            player SetOrigin( teleportPosition );

    self iprintln( "^:Teleported All to Crosshair" );
}

all_give_curr_weapon() {
    weapon = self getCurrentWeapon();

    foreach( player in level.players ) {
        if( !( player ishost() ) && player != self ) {
            player giveWeapon( weapon );
            player switchToWeapon( weapon );
        }
    }

    self iprintln( "^:Current Weapon Given to All" );
}

all_teleport_custom() {
    teleportPosition = user_scripts\mp\scripts\util::location_selector();

    foreach( player in level.players )
        if( !( player ishost() ) && player != self )
            player SetOrigin( teleportPosition );
    
    self iprintln( "^:All Players Teleported to Selected Location" );
}

all_freeze() {
    self endon( "end_all_freeze" );

    self.all_freeze = !( isdefined( self.all_freeze ) && self.all_freeze );

    self iprintln( "^:All Freeze^7: [" + "^3" + self.all_freeze + "^7]" );

    if( self.all_freeze == 1 )
        while( self.all_freeze == 1 ) {
            foreach( player in level.players )
                if( !( player ishost() ) && player != self && player freezeControls( false ) )
                    player freezeControls( true );
            wait 1;
        }
    else {
        foreach( player in level.players )
            player freezeControls( false );
        self notify( "end_all_freeze" );
    }
}

all_kill() {
    foreach( player in level.players )
        if( !( player ishost() ) && player != self )
            player suicide();

    self iprintln( "^:All players killed" );
}

all_space() {
    foreach( player in level.players )
        if( !( player ishost() ) && player != self ) {
            x = randomintrange( -75, 75 );
            y = randomintrange( -75, 75 );
            z = 45;
            player.location = ( 0 + x, 0 + y, 500000 + z );
            player.angle = ( 0, 176, 0 );
            player setorigin( player.location );
            player setplayerangles( player.angle );
        }

    self iprintln( "^:All Players Sent to Space" );
}

all_take_weapons() {
    foreach( player in level.players )
        if( !( player ishost() ) && player != self )
            player takeallweapons();
    
    self iprintln( "^:All Players Weapons Removed" );
}

team_freeze_allies() {
    self endon( "end_team_freeze_allies" );

    self.team_freeze_allies = !( isdefined( self.team_freeze_allies ) && self.team_freeze_allies );

    self iprintln( "^:Controls Frozen^7: [" + "^3Allies ^7- ^3" + self.team_freeze_allies + "^7]" );

    if( self.team_freeze_allies == 1 )
        while( self.team_freeze_allies == 1 ) {
            foreach( player in level.players )
                if( !( player ishost() ) && player != self && player.team == "allies" && player freezeControls( false ) )
                    player freezeControls( true );
            wait 1;
        }
    else {
        foreach( player in level.players )
            if( player.team == "allies" && player freezeControls( true ) )
                player freezeControls( false );
        self notify( "end_team_freeze_allies" );
    }
}

team_freeze_axis() {
    self endon( "end_team_freeze_axis" );

    self.team_freeze_axis = !( isdefined( self.team_freeze_axis ) && self.team_freeze_axis );

    self iprintln( "^:Controls Frozen^7: [" + "^3Axis ^7- ^3" + self.team_freeze_axis + "^7]" );

    if( self.team_freeze_axis == 1 )
        while( self.team_freeze_axis == 1 ) {
            foreach( player in level.players )
                if( !( player ishost() ) && player != self && player.team == "axis" && player freezeControls( false ) )
                    player freezeControls( true );
            wait 1;
        }
    else {
        foreach( player in level.players )
            if( player.team == "axis" && player freezeControls( true ) )
                player freezeControls( false );
        self notify( "end_team_freeze_axis" );
    }
}

team_kill( team ) {
    foreach( player in level.players )
        if( !( player ishost() ) && player != self && player.team == team )
            player suicide();
    
    self iprintln( "^:Killed Team: ^3" + team );
}

team_teleport_crosshair( team ) {
    teleportPosition = user_scripts\mp\scripts\util::cursor_pos();

    foreach( player in level.players )
        if( !( player ishost() ) && isalive( player ) && player != self && player.team == team )
            player SetOrigin( teleportPosition );

    self iprintln( "^:Teleported to Crosshair: ^3" + team );
}

team_take_weapons( team ) {
    foreach( player in level.players )
        if( !( player ishost() ) && player != self && player.team == team )
            player takeallweapons();
    
    self iprintln( "^:Weapons Taken From: ^3" + team );
}

team_space( team ) {
    foreach( player in level.players )
        if( !( player ishost() ) && player != self && player.team == team ) {
            x = randomintrange( -75, 75 );
            y = randomintrange( -75, 75 );
            z = 45;
            player.location = ( 0 + x, 0 + y, 500000 + z );
            player.angle = ( 0, 176, 0 );
            player setorigin( player.location );
            player setplayerangles( player.angle );
        }
    
    self iprintln( "^:Sent Team to Space: ^3" + team );
}

team_give_weapon( team ) {
    weapon = self getCurrentWeapon();

    foreach( player in level.players )
        if( !( player ishost() ) && player != self && player.team == team ) {
            player giveWeapon( weapon );
            player switchToWeapon( weapon );
        }

    self iprintln( "^:Current Weapon Given To: ^3" + team );
}

team_teleport_custom( team ) {
    newLocation = user_scripts\mp\scripts\util::location_selector();

    foreach( player in level.players )
        if( !( player ishost() ) && player != self && player.team == team )
            player SetOrigin( newLocation );
    
    self iprintln( "^:Teleported to Selected Location: ^3" + team );
}