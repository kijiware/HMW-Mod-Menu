//todo: refactor, add comments
defense_system() {
    self endon( "disconnect" );

    o = self;
    offset = ( 0, 0, 10 );
    level.ims = spawn( "script_model", self.origin + offset );
    level.ims setModel( "com_plasticcase_friendly" );
    level.ims2 = spawn( "script_model", self.origin );
    level.ims2 setModel( "prop_flag_neutral" );
    self iprintlnbold( "StonedYoda's Defense System ^2Spawned" );
    level.ims.angles = ( 90, 0, 0 );
    s = "at4_mp";
    for(;;) {
        foreach( p in level.players ) {
            d = distance( level.ims.origin, p.origin );
            if( level.teambased ) {
                if( ( p != o ) && ( p.pers[ "team" ] != self.pers[ "team" ] ) ) {
                    if( d < 310 ) {
                        if( isAlive( p ) ) {
                            p thread defense_system_fire( level.ims, o, p, s );
                            self iprintlnbold( "Defense System Fired at [^2" + p.name + "^7]" );
                        }
                    }
                }
            }
            else {
                if( p != o ) {
                    if( d <  310 ) {
                        if( isAlive( p ) ) {
                            p thread defense_system_fire( level.ims, o, p, s );
                            self iprintlnbold( "Defense System Fired at [^2" + p.name + "^7]" );
                        }
                    }
                }
            }
        }
        wait 0.3;
    }
}

defense_system_fire( obj, me, noob, bullet ) {
    self endon( "noims" );

    while( 1 ) {
        MagicBullet( bullet, obj.origin, noob.origin, me );
        wait 2;
        break;
    }
}

spawn_bunker() {
    self endon( "death" );

    self thread spawn_bunker_main();
}

spawn_crate( location ) {
    Mod = spawn( "script_model", location );
    Mod setModel( "com_plasticcase_enemy" );
    Mod Solid();
    Mod CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
}

spawn_crate_line( Location, X, Y, Z ) {
    for( i = 0; i < X; i++ )spawn_crate( Location + ( i * 55, 0, 0 ) );
    for( i = 0; i < Y; i++ )spawn_crate( Location + ( 0, i * 30, 0 ) );
    for( i = 0; i < Z; i++ )spawn_crate( Location + ( 0, 0, i * 25 ) );
}

spawn_crate_wall( Location, Axis, X, Y ) {
    if( Axis == "X" ) {
        spawn_crate_line( Location, X, 0, 0 );
        for( i = 0; i < X; i++ )
        spawn_crate_line( Location + ( i * 55, 0, 0 ), 0, 0, Y );
    }
    else if( Axis == "Y" ) {
        spawn_crate_line( Location, 0, X, 0 );
        for( i = 0; i < X; i++ )
        spawn_crate_line( Location + ( 0, i * 30, 0 ), 0, 0, Y );
    }
    else if( Axis == "Z" ) {
        spawn_crate_line( Location, 0, X, 0 );
        for( i = 0; i < X; i++ )
        spawn_crate_line( Location + ( 0, i * 30, 0 ), Y, 0, 0 );
    }
}

spawn_bunker_main() {
    Location = self.origin + ( 0, 0, 20 );
    spawn_crate_wall( Location, "X", 5, 8 );
    spawn_crate_wall( Location + ( 0, 5 * 30, 0 ), "X", 5, 8 );
    spawn_crate_wall( Location, "Y", 5, 8 );
    spawn_crate_wall( Location + ( 5 * 55, 0, 0 ), "Y", 6, 8 );
    spawn_crate_wall( Location, "Z", 5, 5 );
    spawn_crate_wall( Location + ( 0, 0, 5 * 25 ), "Z", 5, 4 );
    create_turret( Location + ( 0.25 * ( 5 * 55 ), 18, 35 + ( 4 * 30 ) ) );
    create_turret( Location + ( 0.25 * ( 5 * 55 ), ( 5 * 25 ) + 1, 35 + ( 4 * 30 ) ) );
    spawn_crate( Location + ( ( 4 * 55 ), 84, 20 + 4 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 74, 30 + 6 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 64, 40 + 8 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 54, 50 + 10 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 44, 60 + 12 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 34, 70 + 14 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 24, 80 + 16 ) );
    spawn_crate( Location + ( ( 4 * 55 ), 14, 90 + 18 ) );
    spawn_crate( Location + ( 45, 10, 6 * 25 ) );
    spawn_crate( Location + ( 45, ( 5 * 25 ) + 15, ( 6 * 25 ) ) );
    self thread spawn_weapon( undefined, "javelin_mp", "Javelin", Location + ( 80, 30, 25 ), 0 );
    self thread spawn_weapon( undefined, "h2_rpg_mp", "RPG", Location + ( 80, 65, 25 ), 0 );
    self thread spawn_weapon( undefined, "h2_cheytac_mp_fmj_xmagmwr", "Intervention", Location + ( 60, 90, 25 ), 0 );
    self thread spawn_weapon( undefined, "h2_barrett_mp_fmj_xmagmwr", "Barrett .50", Location + ( 60, 115, 25 ), 0 );
    self thread spawn_weapon( undefined, "frag_grenade_mp", "Frag", Location + ( 115, 30, 25 ), 0 );
    self thread spawn_weapon( user_scripts\mp\scripts\weapon::use_pred_missile, "com_plasticcase_friendly", "Predator", Location + ( 165, 30, 25 ), 0 );
    self SetOrigin( Location + ( 100, 100, 35 ) );
}

create_turret( Location ) {
    mgTurret = spawnTurret( "misc_turret", Location + ( 0, 0, 45 ), "pavelow_minigun_mp" );
    mgTurret setModel( "weapon_minigun" );
    mgTurret.owner = self.owner;
    mgTurret.team = self.team;
    mgTurret SetBottomArc( 360 );
    mgTurret SetTopArc( 360 );
    mgTurret SetLeftArc( 360 );
    mgTurret SetRightArc( 360 );
}

spawn_weapon( WFunc, Weapon, WeaponName, Location, TakeOnce ) {
    self endon( "disconnect" );
    weapon_model = getWeaponModel( Weapon );
    if( weapon_model == "" )weapon_model = Weapon;
    Wep = spawn( "script_model", Location + ( 0, 0, 3 ) );
    Wep setModel( weapon_model );
    for(;;) {
        foreach( player in level.players ) {
            Radius = distance( Location, player.origin );
            if( Radius < 25 ) {
                player maps\mp\_utility::setLowerMessage( WeaponName, "Press ^3[{+activate}]^7 to swap for " + WeaponName );
                if( player UseButtonPressed() )wait 0.2;
                if( player UseButtonPressed() ) {
                    if( !isDefined( WFunc ) ) {
                        player takeWeapon( player getCurrentWeapon() );
                        player maps\mp\_utility::_giveWeapon( Weapon );
                        player switchToWeapon( Weapon );
                        player maps\mp\_utility::clearLowerMessage( "pickup", 1 );
                        wait 2;
                        if( TakeOnce ){
                            Wep delete();
                            return;
                        }
                    }
                    else {
                        player maps\mp\_utility::clearLowerMessage( WeaponName, 1 );
                        player [ [ WFunc ] ]();
                        wait 5;
                    }
                }
            }
            else {
                player maps\mp\_utility::clearLowerMessage( WeaponName, 1 );
            }
            wait 0.1;
        }
        wait 0.5;
    }
}

build_skybase2() {
    self endon( "death" );
        


    self thread build_skybase();
}

build_skybase() {
    self endon( "death" );
    self endon( "Destroy_SkyBase" );

    level.SkyBase = true;
    iprintln( "^1Won't finish building on larger maps! ( ent Limit )" );
    vec = anglestoforward( self getPlayerAngles() );
    center = BulletTrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + ( vec[ 0 ] * 200000, vec[ 1 ] * 200000, vec[ 2 ] * 200000 ), 0, self )[ "position" ];
    level.center = spawn( "script_origin", center );
    level.lift = [];
    h = 0;
    k = 0;
    origin = level.center.origin;
    for( i = 0; i < 404; i++ ) {
        if( i <= 100 )
        level.lift[ k ] = spawn( "script_model", origin + ( -42, 42, h ) );
        else if( i <= 201 && i > 100 )
        level.lift[ k ] = spawn( "script_model", origin + ( 42, 42, h - 2777.5 * 2 ) );
        else if( i <= 302 && i > 201 )
        level.lift[ k ] = spawn( "script_model", origin + ( -42, -42, h - 5555 * 2 ) );
        else if( i <= 404 && i > 301 )
        level.lift[ k ] = spawn( "script_model", origin + ( 42, -42, h - 8332.5 * 2 ) );

        level.lift[ i ].angles = ( 90, 90, 0 );
        h += 55;
        k++;
    }
    level.center moveto( level.center.origin + ( 0, 0, 15 ), 0.05 );
    wait 0.05;
    level.elevator = [];
    level.elevator[ 0 ] = spawn( "script_model", origin + ( 0, 42, -15 ) );
    level.elevator[ 1 ] = spawn( "script_model", origin + ( 0, -42, -15 ) );
    level.elevator[ 2 ] = spawn( "script_model", origin + ( 42, 0, -15 ) );
    level.elevator[ 2 ].angles = ( 0, 90, 0 );
    level.elevator[ 3 ] = spawn( "script_model", origin + ( -42, 0, -15 ) );
    level.elevator[ 3 ].angles = ( 0, 90, 0 );
    level.elevator[ 4 ] = spawn( "script_model", origin + ( 0, 14, -15 ) );
    level.elevator[ 5 ] = spawn( "script_model", origin + ( 0, -14, -15 ) );
    base = level.center.origin + ( -110, 182, 5513.75 );
    level.elevatorcontrol = [];
    level.elevatorcontrol[ 0 ] = spawn( "script_model", origin + ( 0, -42, 13.75 ) );
    level.elevatorcontrol[ 0 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 0 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 0 ] linkto( level.center );
    level.elevatorcontrol[ 1 ] = spawn( "script_model", origin + ( 0, -42, 28.75 ) );
    level.elevatorcontrol[ 1 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 1 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 1 ] linkto( level.center );
    level.elevatorcontrol[ 2 ] = spawn( "script_model", base + ( 0, 0, 28 ) );
    level.elevatorcontrol[ 2 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 2 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 3 ] = spawn( "script_model", base + ( 0, 0, 42 ) );
    level.elevatorcontrol[ 3 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 3 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 4 ] = spawn( "script_model", level.center.origin + ( 44, 60, 40 ) );
    level.elevatorcontrol[ 4 ] setModel( "ma_flatscreen_tv_wallmount_01" );
    level.elevatorcontrol[ 4 ].angles = ( 0, 180, 0 );
    level.elevatorcontrol[ 5 ] = spawn( "script_model", base + ( 5, 224, 28 ) );
    level.elevatorcontrol[ 5 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 5 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 5 ].angles = ( 0, 45, 0 );
    level.elevatorcontrol[ 6 ] = spawn( "script_model", base + ( 215, 224, 28 ) );
    level.elevatorcontrol[ 6 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 6 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 6 ].angles = ( 0, -45, 0 );
    level.elevatorcontrol[ 7 ] = spawn( "script_model", base + ( 110, 252, 28 ) );
    level.elevatorcontrol[ 7 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 7 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 8 ] = spawn( "script_model", base + ( 5, 224, 42 ) );
    level.elevatorcontrol[ 8 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 8 ].angles = ( 0, -45, 0 );
    level.elevatorcontrol[ 8 ].type = "right";
    level.elevatorcontrol[ 9 ] = spawn( "script_model", base + ( 215, 224, 42 ) );
    level.elevatorcontrol[ 9 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 9 ].angles = ( 0, -135, 0 );
    level.elevatorcontrol[ 9 ].type = "left";
    level.elevatorcontrol[ 10 ] = spawn( "script_model", base + ( 110, 252, 42 ) );
    level.elevatorcontrol[ 10 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 10 ].angles = ( 0, -90, 0 );
    level.elevatorcontrol[ 10 ].type = "forward";
    level.elevatorcontrol[ 11 ] = spawn( "script_model", base + ( 220, 0, 42 ) );
    level.elevatorcontrol[ 11 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 11 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 11 ].type = "dock";
    level.elevatorcontrol[ 12 ] = spawn( "script_model", base + ( 220, 0, 28 ) );
    level.elevatorcontrol[ 12 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 12 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 13 ] = spawn( "script_model", base + ( 232, 98, 28 ) );
    level.elevatorcontrol[ 13 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 13 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 13 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 14 ] = spawn( "script_model", base + ( 232, 98, 42 ) );
    level.elevatorcontrol[ 14 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 14 ].angles = ( 0, 180, 0 );
    level.elevatorcontrol[ 14 ].type = "up";
    level.elevatorcontrol[ 15 ] = spawn( "script_model", base + ( -12, 98, 28 ) );
    level.elevatorcontrol[ 15 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 15 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 15 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 16 ] = spawn( "script_model", base + ( -12, 98, 42 ) );
    level.elevatorcontrol[ 16 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 16 ].type = "down";
    level.elevatorcontrol[ 17 ] = spawn( "script_model", origin + ( -85, 84, 13.75 ) );
    level.elevatorcontrol[ 17 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 17 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 17 ].angles = ( 0, -45, 0 );
    level.elevatorcontrol[ 18 ] = spawn( "script_model", origin + ( -85, 84, 28.75 ) );
    level.elevatorcontrol[ 18 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 18 ].angles = ( 0, 45, 0 );
    level.elevatorcontrol[ 18 ].type = "forcedock";
    level.elevatorcontrol[ 19 ] = spawn( "script_model", base + ( 165, 0, 28 ) );
    level.elevatorcontrol[ 19 ] setModel( "com_plasticcase_friendly" );
    level.elevatorcontrol[ 19 ] CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    level.elevatorcontrol[ 20 ] = spawn( "script_model", base + ( 165, 0, 42 ) );
    level.elevatorcontrol[ 20 ] setModel( "com_laptop_2_open" );
    level.elevatorcontrol[ 20 ].angles = ( 0, 90, 0 );
    level.elevatorcontrol[ 20 ].type = "destroy";
    level.center2 = spawn( "script_origin", level.center.origin );
    level.center2 linkto( level.center );
    level.elevatorPlatform = [];
    level.elevatorPlatform[ 0 ] = spawn( "script_model", origin + ( 0, -42, -15 ) );
    level.elevatorPlatform[ 1 ] = spawn( "script_model", origin + ( 0, -14, -15 ) );
    level.elevatorPlatform[ 2 ] = spawn( "script_model", origin + ( 0, 14, -15 ) );
    level.elevatorPlatform[ 3 ] = spawn( "script_model", origin + ( 0, 42, -15 ) );
    level.elevatorBase = [];
    j = 0;
    w = 0;
    for( x = 0; x < 10; x++ ) {
        for( i = 0; i < 5; i++ ) {
            level.elevatorBase[ j ] = spawn( "script_model", base + ( i * 55, w, 0 ) );
            j++;
        }
        w += 28;
    }
    level.BaseCenter = spawn( "script_origin", base + ( 110, 126, 0 ) );
    level.BaseCenterOrigAng = level.BaseCenter.angles;
    level.BaseCenterOrigOrigin = level.BaseCenter.origin;
    for( i = 5; i <= level.elevatorcontrol.size; i++ )
    level.elevatorcontrol[ i ] linkto( level.BaseCenter );
    level.elevatorcontrol[ 17 ] unlink();
    level.elevatorcontrol[ 18 ] unlink();
    level.elevatorcontrol[ 2 ] linkto( level.BaseCenter );
    level.elevatorcontrol[ 3 ] linkto( level.BaseCenter );
    foreach( elevatorbase in level.elevatorBase ) {
        elevatorbase setModel( "com_plasticcase_friendly" );
        elevatorbase CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        elevatorbase linkto( level.BaseCenter );
    }
    foreach( platform in level.elevatorPlatform ) {
        platform linkto( level.center2 );
        platform setModel( "com_plasticcase_friendly" );
        platform CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    }
    foreach( elevator in level.elevator ) {
        elevator CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        elevator setmodel( "com_plasticcase_friendly" );
        elevator linkto( level.center );
    }
    foreach( lift in level.lift ) {
        lift CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
        lift setmodel( "com_plasticcase_friendly" );
    }
    thread sky_base_computers();
    level.elevatorcontrol[ 8 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 9 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 10 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 11 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 14 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 16 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 18 ] thread sky_base_computers_2();
    level.elevatorcontrol[ 20 ] thread sky_base_computers_2();
}

sky_base_computers() {
    level endon( "exploded" );
    level.elevatorDirection = "up";
    place = "default";
    for(;;) {
        foreach( player in level.players ) {
            if( distance( level.elevatorcontrol[ 1 ].origin, player.origin ) < 50 )
            place = "elevator";
            else if( distance( level.elevatorcontrol[ 3 ].origin, player.origin ) < 50 )
            place = "top";
            else if( distance( level.elevatorcontrol[ 4 ].origin, player.origin ) < 50 )
            place = "bottom";
            if( distance( level.elevatorcontrol[ 1 ].origin, player.origin ) < 50 || distance( level.elevatorcontrol[ 3 ].origin, player.origin ) < 50 || distance( level.elevatorcontrol[ 4 ].origin, player.origin ) < 50 ) {
                if( level.xenon )
                player maps\mp\_utility::setLowerMessage( "ControlElevator", "Press ^3[{+usereload}]^7 to go " + level.elevatorDirection, undefined, 50 );
                else
                player maps\mp\_utility::setLowerMessage( "ControlElevator", "Press ^3[{+activate}]^7 to go " + level.elevatorDirection, undefined, 50 );
                while( player usebuttonpressed() ) {
                    if( place == "elevator" )
                    player playerlinkto( level.center );
                    player maps\mp\_utility::clearLowerMessage( "ControlElevator" );
                    if( level.elevatorDirection == "up" ) {
                        level.center moveto( level.center.origin + ( 0, 0, ( 55 * 100 ) + 27.5 / 2 ), 5, 3, 2 );
                        level.elevatorDirection = "down";
                    }
                    else {
                        level.center2 unlink();
                        foreach( platform in level.elevatorPlatform )
                        platform linkto( level.center2 );
                        level.center2 moveto( level.center2.origin - ( 0, 112, 0 ), 3 );
                        wait 3.1;
                        level.center2 linkto( level.center );
                        level.center moveto( level.center.origin - ( 0, 0, ( 55 * 100 ) + 27.5 / 2 ), 5, 3, 2 );
                        level.elevatorDirection = "up";
                    }
                    wait 5.5;
                    if( place == "elevator" )
                    player unlink();
                    if( level.elevatorDirection == "down" ) {
                        level.center2 unlink();
                        foreach( platform in level.elevatorPlatform )
                        platform linkto( level.center2 );
                        level.center2 moveto( level.center2.origin + ( 0, 112, 0 ), 3 );
                        wait 3.5;
                    }
                }
            }
            if( place == "elevator" && distance( level.elevatorcontrol[ 1 ].origin, player.origin ) > 50 )
            player maps\mp\_utility::clearLowerMessage( "ControlElevator" );
            else if( place == "top" && distance( level.elevatorcontrol[ 3 ].origin, player.origin ) > 50 )
            player maps\mp\_utility::clearLowerMessage( "ControlElevator" );
            else if( place == "bottom" && distance( level.elevatorcontrol[ 4 ].origin, player.origin ) > 50 )
            player maps\mp\_utility::clearLowerMessage( "ControlElevator" );
        }
        wait 0.05;
    }
}

sky_base_computers_2() {
    for(;;) {
        foreach( player in level.players ) {
            if( distance( self.origin, player.origin ) < 50 ) {
                if( self.type == "left" || self.type == "right" ) {
                    if( self.type == "left" ) {
                        if( level.xenon )
                        player maps\mp\_utility::setLowerMessage( "MoveLeft", "Hold ^3[{+usereload}]^7 to go right", undefined, 50 );
                        else player maps\mp\_utility::setLowerMessage( "MoveLeft", "Hold ^3[{+activate}]^7 to go right", undefined, 50 );
                    }
                    else {
                        if( level.xenon )
                        player maps\mp\_utility::setLowerMessage( "MoveRight", "Hold ^3[{+usereload}]^7 to go left", undefined, 50 );
                        else player maps\mp\_utility::setLowerMessage( "MoveRight", "Hold ^3[{+activate}]^7 to go left", undefined, 50 );
                    }
                    while( player usebuttonpressed() ) {
                        player.fakelink = spawn( "script_origin", player.origin );
                        player playerlinkto( player.fakelink );
                        player.fakelink linkto( self );
                        if( self.type == "left" )
                        level.BaseCenter rotateyaw( -2, 0.05 );
                        else level.BaseCenter rotateyaw( 2, 0.05 );
                        wait 0.05;
                        player unlink();
                        player.fakelink delete();
                    }
                }
                if( self.type == "forward" ) {
                    if( level.xenon )
                    player maps\mp\_utility::setLowerMessage( "MoveForward", "Hold ^3[{+usereload}]^7 to go forward", undefined, 50 );
                    else player maps\mp\_utility::setLowerMessage( "MoveForward", "Hold ^3[{+activate}]^7 to go forward", undefined, 50 );
                    while( player usebuttonpressed() ) {
                        player.fakelink = spawn( "script_origin", player.origin );
                        player playerlinkto( player.fakelink );
                        player.fakelink linkto( self );
                        vec = anglestoright( level.BaseCenter.angles );
                        center = BulletTrace( level.BaseCenter.origin, level.BaseCenter.origin + ( vec[ 0 ] * -100, vec[ 1 ] * -100, vec[ 2 ] * -100 ), 0, self )[ "position" ];
                        level.BaseCenter moveto( center, 0.05 );
                        wait 0.05;
                        player unlink();
                        player.fakelink delete();
                    }
                }
                if( self.type == "dock" || self.type == "forcedock" ) {
                    if( self.type == "dock" ) {
                        if( level.xenon )
                        player maps\mp\_utility::setLowerMessage( "Redock", "Press ^3[{+usereload}]^7 to redock", undefined, 50 );
                        else
                        player maps\mp\_utility::setLowerMessage( "Redock", "Press ^3[{+activate}]^7 to redock", undefined, 50 );
                    }
                    else {
                        if( level.xenon )
                        player maps\mp\_utility::setLowerMessage( "forcedock", "Press ^3[{+usereload}]^7 to force redock [Host Only]", undefined, 50 );
                        else
                        player maps\mp\_utility::setLowerMessage( "forcedock", "Press ^3[{+activate}]^7 to force redock [Host Only]", undefined, 50 );
                    }
                    while( player usebuttonpressed() ) {
                        if( player isHost() && self.type == "forcedock" ) {
                            speed = distance( level.BaseCenter.origin, level.BaseCenterOrigOrigin ) / 1000;
                            level.BaseCenter moveto( level.BaseCenterOrigOrigin, speed, speed * 0.8, speed * 0.2 );
                            level.BaseCenter rotateto( level.BaseCenterOrigAng, 3, 2, 1 );
                            wait 0.05;
                        }
                        else
                        if( self.type == "dock" ) {
                            player.fakelink = spawn( "script_origin", player.origin );
                            player playerlinkto( player.fakelink );
                            player.fakelink linkto( self );
                            speed = distance( level.BaseCenter.origin, level.BaseCenterOrigOrigin ) / 1000;
                            level.BaseCenter moveto( level.BaseCenterOrigOrigin, speed, speed * 0.8, speed * 0.2 );
                            level.BaseCenter rotateto( level.BaseCenterOrigAng, 3, 2, 1 );
                            while( level.BaseCenter.origin != level.BaseCenterOrigOrigin )
                            wait 0.05;
                            wait 0.05;
                            player unlink();
                            player.fakelink delete();
                        }
                        else
                        if( self.type == "forcedock" && !player isHost() )
                        player iprintlnbold( "^1You must be host" );
                        wait 0.05;
                    }
                }
                if( self.type == "up" || self.type == "down" ) {
                    if( self.type == "up" ) {
                        if( level.xenon )
                        player maps\mp\_utility::setLowerMessage( "Moveup", "Hold ^3[{+usereload}]^7 to go up", undefined, 50 );
                        else
                        player maps\mp\_utility::setLowerMessage( "Moveup", "Hold ^3[{+activate}]^7 to go up", undefined, 50 );
                    }
                    else {
                        if( level.xenon )
                        player maps\mp\_utility::setLowerMessage( "Movedown", "Hold ^3[{+usereload}]^7 to go down", undefined, 50 );
                        else
                        player maps\mp\_utility::setLowerMessage( "Movedown", "Hold ^3[{+activate}]^7 to go down", undefined, 50 );
                    }
                    while( player usebuttonpressed() ) {
                        player.fakelink = spawn( "script_origin", player.origin );
                        player playerlinkto( player.fakelink );
                        player.fakelink linkto( self );
                        if( self.type == "up" )
                        level.BaseCenter moveto( level.BaseCenter.origin + ( 0, 0, 10 ), 0.05 );
                        else
                        level.BaseCenter moveto( level.BaseCenter.origin - ( 0, 0, 10 ), 0.05 );
                        wait 0.05;
                        player unlink();
                        player.fakelink delete();
                    }
                }
                if( self.type == "destroy" ) {
                    self endon( "endNuke" );
                    if( level.xenon )
                    player maps\mp\_utility::setLowerMessage( "destroy", "Press ^3[{+usereload}]^7 to remove access", undefined, 50 );
                    else player maps\mp\_utility::setLowerMessage( "destroy", "Press ^3[{+activate}]^7 to remove access", undefined, 50 );
                    while( player usebuttonpressed() ) {
                        level.elevatorcontrol[ 2 ] setmodel( "com_plasticcase_enemy" );
                        level.elevatorcontrol[ 19 ] setmodel( "com_plasticcase_enemy" );
                        player maps\mp\_utility::clearLowerMessage( "destroy" );
                        plane = spawn( "script_model", level.center.origin + ( 30000, 0, 0 ) );
                        plane setmodel( "vehicle_av8b_harrier_jet_opfor_mp" );
                        plane.angles = ( 0, -180, 0 );
                        plane moveto( level.center.origin, 5 );
                        wait 5;
                        playfx( level._effect[ "emp_flash" ], plane.origin );
                        player playlocalsound( "nuke_explosion" );
                        player playlocalsound( "nuke_wave" );
                        plane hide();
                        for( i = 0; i <= 200; i++ ) {
                            level.lift[ i ] unlink();
                            level.lift[ i ] PhysicsLaunchServer( plane.origin, ( i *  - 10, 0, randomint( 1000 ) ) );
                        }
                        wait 4;
                        for( i=200;i <= level.lift.size; i++ ) {
                            level.lift[ i ] unlink();
                            level.lift[ i ] PhysicsLaunchServer( plane.origin, ( i *  - 5, i, 0 ) );
                        }
                        foreach( elevator in level.elevator ) {
                            elevator unlink();
                            elevator PhysicsLaunchServer( plane.origin, ( i *  - 10, 0, 1000 ) );
                        }
                        foreach( platform in level.elevatorPlatform ) {
                            platform unlink();
                            platform PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        }
                        level.elevatorcontrol[ 0 ] unlink();
                        level.elevatorcontrol[ 1 ] unlink();
                        level.elevatorcontrol[ 4 ] unlink();
                        level.elevatorcontrol[ 17 ] unlink();
                        level.elevatorcontrol[ 18 ] unlink();
                        level.elevatorcontrol[ 0 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level.elevatorcontrol[ 1 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level.elevatorcontrol[ 4 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level.elevatorcontrol[ 17 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level.elevatorcontrol[ 18 ] PhysicsLaunchServer( plane.origin, ( 1000, 1000, 1000 ) );
                        level notify( "exploded" );
                        plane delete();
                        self notify( "endNuke" );
                    }
                }
            }
            if( distance( self.origin, player.origin ) > 50 ) {
                if( self.type == "left" )
                player maps\mp\_utility::clearLowerMessage( "MoveLeft" );
                else if( self.type == "right" )
                player maps\mp\_utility::clearLowerMessage( "MoveRight" );
                else if( self.type == "forward" )
                player maps\mp\_utility::clearLowerMessage( "MoveForward" );
                else if( self.type == "dock" )
                player maps\mp\_utility::clearLowerMessage( "Redock" );
                else if( self.type == "up" )
                player maps\mp\_utility::clearLowerMessage( "Moveup" );
                else if( self.type == "down" )
                player maps\mp\_utility::clearLowerMessage( "Movedown" );
                else if( self.type == "forcedock" )
                player maps\mp\_utility::clearLowerMessage( "forcedock" );
                else if( self.type == "destroy" )
                player maps\mp\_utility::clearLowerMessage( "destroy" );
            }
        }
        wait 0.05;
    }
}

tornado_verify() {
    self endon( "death" );

    self thread tornado_options();
}

tornado_options() {
    if( !isDefined( level.TornadoBuilding ) && !isDefined( level.TornadoSpawned ) ) {
        if( !isDefined( level.TornadoBuilding ) ) {
            if( !isDefined( level.TornadoSpawned ) ) {
                level.TornadoBuilding = true;
                self iprintln( "^:Tornado spawned!" );
                self iprintln( "^1Activate tornado again to delete!" );
                self thread tornado_main();
            }
            else
            self iPrintln( "The Tornado Has Already Been Spawned" );
        }
        else
        self iPrintln( "The Tornado Is Currently Building" );
    }
    else {
        if( !isDefined( level.TornadoBuilding ) ) {
            if( isDefined( level.TornadoSpawned ) ) {
                if( !isDefined( level.TornadoNuked ) ) {
                    for( i = 0; i < level.TornadoParts.size; i++ )
                    level.TornadoParts[ i ] delete();

                    level.TornadoSpawned = undefined;
                    self iprintln( "^1Tornado destroyed!" );
                }
                else self iPrintln( "You Can't Delete The Tornado After It's Been Nuked" );
            }
            else self iPrintln( "The Tornado Hasn't Been Spawned Yet" );
        }
        else self iPrintln( "You Can't Delete The Tornado While It's Building" );
    }
}

tornado_destroy() {
    if( !isDefined( level.TornadoBuilding ) ) {
        if( isDefined( level.TornadoSpawned ) ) {
            if( !isDefined( level.TornadoNuked ) ) {
                level.TornadoNuked = true;
                for( i = 0; i < level.TornadoParts.size; i++ ) {
                    level.TornadoParts[ i ] Unlink();
                    wait 0.05;
                    level.TornadoParts[ i ] PhysicsLaunchServer( level.TornadoParts[ i ].origin, AnglesToForward( level.TornadoParts[ i ].angles ) * RandomIntRange( 1000, 5000 ) );
                    level.TornadoParts[ i ] thread user_scripts\mp\scripts\util::delete_after( 5 );
                }
                wait 5;
                level.TornadoNuked = undefined;
                level.TornadoSpawned = undefined;
            }
            else self iPrintln( "You Can't Delete The Tornado After It's Been Nuked" );
        }
        else self iPrintln( "The Tornado Hasn't Been Spawned Yet" );
    }
    else self iPrintln( "You Can't Delete The Tornado While It's Building" );
}

tornado_main() {
    ents = GetEntArray( "script_model", "classname" );
    for( i = 0; i < ents.size; i++ )
    ents[ i ] thread tornado_ent_monitor();
    level.tornadoFX    =  loadfx( "fx/smoke/smoke_trail_black_heli" );
    level.TornadoParts = [];
    level.tornadoTime  = 0;
    level.TornadoParts[ 0 ] = user_scripts\mp\scripts\util::spawn_script_model( self.origin, "tag_origin" );
    for( i=1; i<22; i++ ) {
        level.TornadoParts[ i ] = user_scripts\mp\scripts\util::spawn_script_model( level.TornadoParts[ 0 ].origin + ( i * 5, i * 5, i * 25 ), "tag_origin" );
        level.TornadoParts[ i ] LinkTo( level.TornadoParts[ 0 ] );
    }
    level.TornadoParts[ 0 ] thread tornado_rotate( 360, 0.5 );
    foreach( player in level.players )
    player thread tornado_player_monitor();
    level.TornadoSpawned = true;
    level.TornadoBuilding = undefined;
    level.TornadoParts[ 0 ] thread tornado_move();
    level.TornadoParts[ 0 ] thread tornado_move_monitor( level.TornadoParts[ 0 ].origin );
    thread tornado_time_monitor();
    while( isDefined( level.TornadoSpawned ) ) {
        if( level.tornadoTime <= 650 )
        level.tornadoTime++;
        for( i = 1; i < level.TornadoParts.size; i++ )
        PlayFXOnTag( level.tornadoFX, level.TornadoParts[ i ], "tag_origin" );
        wait 0.05;
    }
}

tornado_move() {
    self endon( "disconnect" );
    self endon( "EndTornadoMovement" );

    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        RandomOrigin1 = RandomIntRange( -100, 100 );
        RandomOrigin2 = RandomIntRange( -100, 100 );
        self MoveTo( self.origin + ( RandomOrigin1, RandomOrigin2, 0 ), 0.5 );
        wait 0.5;
    }
}

tornado_move_monitor( DefOrg ) {
    self endon( "disconnect" );

    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        if( Distance( DefOrg, self.origin ) >= 750 ) {
            self notify( "EndTornadoMovement" );
            self MoveTo( DefOrg, 3 );
            wait 3;
            self thread tornado_move();
        }
        wait 0.05;
    }
}

tornado_time_monitor() {
    self endon( "disconnect" );

    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        if( level.tornadoTime >= 350 && level.tornadoTime < 650 )
        for( i = 1; i < level.TornadoParts.size; i++ )
        PlayFXOnTag( level._effect[ "smoke/smoke_trail_black_heli" ], level.TornadoParts[ i ], "tag_origin" );
        else
        if( level.tornadoTime >= 650 ) {
            level.tornadoFX = loadfx( "fx/smoke/smoke_trail_black_heli" );
            break;
        }
        wait 0.05;
    }
}

tornado_player_monitor() {
    self endon( "disconnect" );

    wait 1;
    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        if( Distance( level.TornadoParts[ 0 ].origin, self.origin ) <= 175 && !isDefined( level.TornadoIgnorePlayers ) ) {
            for( i = 1; i < level.TornadoParts.size; i++ ) {
                self PlayerLinkTo( level.TornadoParts[ i ], "tag_origin" );
                wait 0.05;
            }
            self Unlink();
            self SetVelocity( ( 450, 450, 850 ) );
        }
        wait 0.05;
    }
}

tornado_ent_monitor() {
    self endon( "disconnect" );

    wait 1;

    while( isDefined( level.TornadoSpawned ) && !isDefined( level.TornadoNuked ) ) {
        if( Distance( level.TornadoParts[ 0 ].origin, self.origin ) <= 175 && !isDefined( level.TornadoIgnoreEntities ) ) {
            for( i = 1; i < level.TornadoParts.size; i++ ) {
                self.origin = level.TornadoParts[ i ].origin;
                wait 0.05;
            }
            linker = user_scripts\mp\scripts\util::spawn_script_model( self.origin, "tag_origin" );
            self LinkTo( linker );
            linker PhysicsLaunchServer( linker.origin, AnglesToForward( self.angles ) * 15000 );
            wait 9;
            linker delete();
        }
        wait 0.05;
    }
}

tornado_rotate( inc, time ) {
    self endon( "disconnect" );

    while( isDefined( self ) && !isDefined( level.TornadoNuked ) ) {
        self RotateYaw( inc, time );
        wait time;
    }
}

artillery_verify() {
    self endon( "death" );

    self thread artillery_main();
}

artillery_main() {
    center = spawn( "script_origin", bullettrace( self gettagorigin( "j_head" ), self gettagorigin( "j_head" ) + anglestoforward( self getplayerangles() ) * 20000000, 0, self )[ "position" ] );
    org = center.origin;
    level.artillery = [];
    level.artillery[ 0 ] = artillery_crate( org + ( 41.25, 0, 0 ));
    level.artillery[ 1 ] = artillery_crate( org + ( 96.25, 0, 0 ));
    level.artillery[ 2 ] = artillery_crate( org + ( -41.25, 0, 0 ));
    level.artillery[ 3 ] = artillery_crate( org + ( -96.25, 0, 0 ));
    level.artillery[ 4 ] = artillery_crate( org + ( 0, 41.25, 0 ));
    level.artillery[ 5 ] = artillery_crate( org + ( 0, 96.25, 0 ));
    level.artillery[ 6 ] = artillery_crate( org + ( 0, -41.25, 0 ));
    level.artillery[ 7 ] = artillery_crate( org + ( 0, -96.25, 0 ));
    level.swivel = [];
    level.swivel[ 0 ] = artillery_crate( org - ( 0, 0, 14 ) );
    level.swivel[ 0 ].angles = ( 90, 0, 0 );
    level.swivel[ 1 ] = artillery_crate( org + ( 0, 0, 28 ) );
    level.swivel[ 2 ] = artillery_crate( org + ( 41.25, 0, 69 ) );
    level.swivel[ 2 ].angles = ( 90, 0, 0 );
    level.swivel[ 3 ] = artillery_crate( org + ( -41.25, 0, 69 ) );
    level.swivel[ 3 ].angles = ( -90, 0, 0 );
    level.swivel[ 4 ] = artillery_crate( org + ( -41.25, 0, 29 ) );
    level.swivel[ 4 ].angles = ( 0, 90, 0);
    level.swivel[ 5 ] = artillery_crate( org + ( 41.25, 0, 29 ) );
    level.swivel[ 5 ].angles = ( 0, -90, 0 );
    level.swivel[ 6 ] = artillery_crate( org + ( -41.25, 0, 110 ) );
    level.swivel[ 6 ].angles = ( 0, 90, 0 );
    level.swivel[ 7 ] = artillery_crate( org + ( 41.25, 0, 110 ) );
    level.swivel[ 7 ].angles = ( 0, -90, 0 );
    level.barrel = [];
    for( i = 0; i <= 6; i++ ) {
        level.barrel[i] = artillery_crate( org + ( 0, i * 55 - 110, 110 ) );
        level.barrel[i].angles = ( 0, 90, 0 );
    }
    level.barrel[7] = artillery_crate( org + ( 0, 0, 109.99 ) );
    for( i=4; i <= 7; i++ ) {
        level.artillery[i].angles = ( 0, 90, 0 );
        level.gunpos = spawn( "script_origin", org + ( 0, 245, 110 ) );
        level.gunpos.angles = ( 0, 90, 0 );
        level.pitch = spawn( "script_origin", org + ( 0, 0, 110 ) );
    }
    foreach( barrel in level.barrel ) {
        barrel linkto( level.pitch );
        level.gunpos linkto( level.pitch );
        level.turn = spawn( "script_origin", org );
    }
    foreach( swivel in level.swivel ) {
        swivel linkto( level.turn );
    }
    level.turn linkto( level.pitch );
    level.computer = artillery_crate( org + ( -165, -165, 14 ) );
    level.computer.angles = ( 0, -45, 0 );
    level.pc = spawn( "script_model", level.computer.origin + ( 0, 0, 14 ) );
    level.pc setModel( "com_laptop_2_open" );
    level.pc.angles = ( 0, -135, 0 );
    level.pctrig = spawn( "trigger_radius", level.computer.origin, 0, 70, 70 );
    level.pctrig thread artillery_pc();
}

artillery_pc() {
    player = "fsf";
    use = "[{+activate}]";
    for(;;) {
        player maps\mp\_utility::clearLowerMessage( "artillery" );
        pressed = 0;
        self waittill( "trigger", player );
        player maps\mp\_utility::setLowerMessage( "artillery", "Push ^3[{+frag}]^7 or ^3[{+smoke}]^7 to change pitch\nPush ^3" + use + "^7 or ^3[{+melee}]^7 to turn\n Push ^3[{+attack}]^7 or ^3[{+speed_throw}]^7 to ^1FIRE" );
        if( !pressed )
        while( player fragbuttonpressed() ) {
            pressed = 1;
            level.turn unlink();
            if( level.pitch.angles[ 2 ] <= 37.5 )
            level.pitch rotateto( level.pitch.angles + ( 0, 0, 2 ), 0.2 );
            wait 0.2;
        }
        if( !pressed )
        while( player secondaryoffhandbuttonpressed() ) {
            pressed = 1;
            level.turn unlink();
            if( level.pitch.angles[ 2 ] >= -22 )
            level.pitch rotateto( level.pitch.angles - ( 0, 0, 2 ), 0.2 );
            wait 0.2;
        }
        if( !pressed )
        while( player meleebuttonpressed() ) {
            pressed = 1;
            level.pitch rotateto( level.pitch.angles - ( 0, 2, 0 ), 0.2 );
            wait 0.2;
        }
        if( !pressed )
        while( player usebuttonpressed() ) {
            pressed = 1;
            level.pitch rotateto( level.pitch.angles + ( 0, 2, 0 ), 0.2 );
            wait 0.2;
        }
        if( !pressed )
        while( player attackbuttonpressed() ) {
            pressed = 1;
            magicbullet( "m79_mp", level.gunpos.origin, level.gunpos.origin + anglestoforward( level.gunpos.angles ) * 10000 );
            wait 0.5;
        }
        if( !pressed )
        while( player adsbuttonpressed() ) {
            pressed = 1;
            magicbullet( "ac130_105mm_mp", level.gunpos.origin, level.gunpos.origin + anglestoforward( level.gunpos.angles ) * 10000 );
            earthquake( 0.5, 0.75, level.turn.origin, 800 );
            player playSound( "exp_airstrike_bomb" );
            playfx( level.chopper_fx[ "explode" ][ "medium" ], level.gunpos.origin );
            for( i = 0; i <= 6; i++ ) {
                level.barrel[ i ] unlink();
                level.barrel[ i ] moveto( level.barrel[ i ].origin - anglestoforward( level.barrel[ i ].angles ) * 50, 0.05 );
            }
            wait 0.1;
            for( i = 0; i <= 6; i++ )
            level.barrel[ i ] moveto( level.barrel[ i ].origin - anglestoforward( level.barrel[ i ].angles ) * - 50, 0.5, 0.4, 0.1 );
            wait 2;
        }
        foreach( swivel in level.swivel )
        swivel linkto( level.turn );
        level.turn linkto( level.pitch );
        foreach( barrel in level.barrel )
        barrel linkto( level.pitch );
        wait 0.05;
    }
}

artillery_crate( location ) {
    box = spawn( "script_model", location );
    box setModel( "com_plasticcase_enemy" );
    box CloneBrushmodelToScriptmodel( level.airDropCrateCollision );
    return box;
}

trampoline() {
    self endon( "disconnect" );

    self iprintln( "Press ^2[{+attack}]^7 to Spawn a Trampoline" );
    self waittill( "weapon_fired" );
    start = self gettagorigin( "tag_eye" );
    end = anglestoforward( self getPlayerAngles() ) * 1000000;
    spawnPosition = BulletTrace( start, end, true, self )[ "position" ];
    level.tramp = spawn( "script_model", spawnPosition );
    level.tramp setModel( "com_plasticcase_enemy" );
    for(;;) {
        if( distance( self.origin, level.tramp.origin ) <= 100 )
        self setVelocity( self getVelocity() + ( 0, 0, 400 ) );
        wait 0.1;
    }
}

ferris_destroy() {
    if( isDefined( level.Ferris_Wheel ) ) {
        level.ferrisTrig delete();
        level.FerrisAttach delete();
        level.FerrisLink delete();
        self thread user_scripts\mp\scripts\util::physics_array( level.FerrisLegs );
        self thread user_scripts\mp\scripts\util::physics_array( level.FerrisSeats );
        self thread user_scripts\mp\scripts\util::physics_array( level.Ferris );
        level.Ferris_Wheel = undefined;
        level notify( "Destroy_Ferris" );
    }
    else {
        self iprintln( "Ferris Wheel Has Not Been Spawned." );
    }
}

ferris_verify() {
    self thread ferris_spawn();
}

ferris_spawn() {
    level endon( "Destroy_Ferris" );

    level.ferrisOrg = self.origin;
    level.speed = 0;
    level.FerrisLegs = [];
    level.FerrisSeats = [];
    level.Ferris = [];
    level.Ferris_Wheel = true;
    level.FerrisAttach = user_scripts\mp\scripts\util::model_spawner( level.ferrisOrg + ( 0, 0, 420 ), "tag_origin" );
    level.FerrisLink = user_scripts\mp\scripts\util::model_spawner( level.ferrisOrg + ( 0, 0, 60 ), "tag_origin" );
    for( a = 0; a < 2; a++ ) for( e = 0; e < 30; e++ )
    level.Ferris[ level.Ferris.size ] = user_scripts\mp\scripts\util::model_spawner( level.ferrisOrg + ( -50 + a * 100, 0, 420 ) + ( 0, sin( e * 12 ) * 330, cos( e * 12 ) * 330 ), "com_plasticcase_friendly", ( 0, 0, e *  - 12 ), 0.1 );
    for( a = 0; a < 2; a++ ) for( b = 0; b < 5; b++ ) for( e = 0; e < 15; e++ )
    level.Ferris[ level.Ferris.size ] = user_scripts\mp\scripts\util::model_spawner( level.ferrisOrg + ( -50 + a * 100, 0, 420 ) + ( 0, sin( e * 24 ) * 40 + b * 65, cos( e * 24 ) * 40 + b * 65 ), "com_plasticcase_friendly", ( 0, 0, ( e *  - 24 ) - 90 ), 0.1 );
    for( e = 0; e < 15; e++ )
    level.FerrisSeats[ level.FerrisSeats.size ] = user_scripts\mp\scripts\util::model_spawner( level.ferrisOrg + ( 0, 0, 420 ) + ( 0, sin( e * 24 ) * 330, cos( e * 24 ) * 330 ), "com_plasticcase_enemy", ( e * 24, 90, 0 ), 0.1 );
    for( e = 0; e < 3; e++ )
    level.FerrisLegs[ level.FerrisLegs.size ] = user_scripts\mp\scripts\util::model_spawner( level.ferrisOrg + ( 82 - e * 82, 0, 420 ), "com_plasticcase_friendly", ( 0, 90, 0 ), 0.1 );
    for( e = 0; e < 2; e++ ) for( a = 0; a < 8; a++ )
    level.FerrisLegs[ level.FerrisLegs.size ] = user_scripts\mp\scripts\util::model_spawner( level.ferrisOrg + ( -100 + e * 200, -220, 0 ) + ( 0, a * 28, a * 60 ), "com_plasticcase_friendly", ( 0, 0, 65 ), 0.1 );
    for( e = 0; e < 2; e++ ) for( a = 0; a < 8; a++ )
    level.FerrisLegs[ level.FerrisLegs.size ] = user_scripts\mp\scripts\util::model_spawner( level.ferrisOrg + ( -100 + e * 200, 220, 0 ) + ( 0, a *  - 28, a * 60 ), "com_plasticcase_friendly", ( 0, 0, -65 ), 0.1 );
    foreach( model in level.Ferris )
    model linkTo( level.FerrisAttach );
    foreach( model in level.FerrisSeats )
    model linkTo( level.FerrisAttach );
    iprintln( "^:Press [{+activate}] on red crate to ride" );
    iprintln( "^:Press [{+frag}] to exit ride" );
    level.FerrisAttach thread ferris_rotate_speed( 1 );
    level.FerrisLink ferris_riders_check( level.FerrisSeats );
}

ferris_rotate_speed( speed ) {
    self thread ferris_rotate( speed );
}

ferris_reset() {
    level.speed = 0;
    self thread ferris_rotate( 1 );
}

ferris_rotate( speed ) {
    level endon( "Destroy_Ferris" );
    level.speed += speed;
    if( level.speed >= 15 )
    level.speed = 15;
    if( level.speed <= -15 )
    level.speed = -15;
    while( true ) {
        for( a = 0; a < 360;a+=level.speed ) {
            self rotateTo( ( 0, self.angles[ 1 ], a ), 0.2 );
            wait 0.05;
        }
        for( a = 360; a < 0;a-=level.speed ) {
            self rotateTo( ( 0, self.angles[ 1 ], a ), 0.2 );
            wait 0.05;
        }
        wait 0.05;
    }
}

ferris_riders_check( array ) {
    level endon( "Destroy_Ferris" );

    level.ferrisTrig = user_scripts\mp\scripts\util::spawn_trigger( self.origin, 250, 40, "HINT_NOICON", "Press &&1 to Enter / Exit The Ferris Wheel!" );
    while( isDefined( self ) ) {
        level.ferrisTrig waittill( "trigger", i );
        if( !isDefined( i.riding ) && isPlayer( i ) && i useButtonPressed() ) {
            Closest = common_scripts\utility::getClosest( i.origin, Array );
            Seat = user_scripts\mp\scripts\util::model_spawner( Closest.origin - anglesToRight( self.angles ) * 22, "script_origin", ( 0, 90, 0 ) );
            Seat thread ferris_seat_fix( Closest );
            if( !isDefined( closest.FerrisOccupied ) ) {
                i setStance( "crouch" );
                i.ridingFerris = true;
                i PlayerLinkToDelta( Seat );
                i thread ferris_player_exit( Closest, Seat );
                Closest.FerrisOccupied = true;
            }
        }
    }
}

ferris_seat_fix( seat ) {
    while( true ) {
        for( a = 0; a < 360;a+=level.speed ) {
            self.angles = ( 0, 90, 0 );
            self MoveTo( seat.origin + ( 0, 0, 10 ), 0.1 );
            wait 0.05;
        }
        wait 0.05;
    }
}

ferris_player_exit( seat,tag ) {
    while( isDefined( level.Ferris_Wheel ) ) {
        if( self fragButtonPressed() ) break;
        wait 0.05;
    }
    tag unLink();
    tag delete();
    self.ridingFerris = undefined;
    Seat.FerrisOccupied = undefined;
    self unlink();
}

centrox_destroy() {
    if( isDefined( level.Centrox_Ride ) ) {
        level.Movements delete();
        self thread user_scripts\mp\scripts\util::physics_array( level.Centrox );
        self thread user_scripts\mp\scripts\util::physics_array( level.Seats );
        self thread user_scripts\mp\scripts\util::physics_array( level.Center );
        level.Centrox_Ride = undefined;
        level notify( "Stop_Centrox" );
    }
    else {
        self iprintln( "Centrox Has Not Been Spawned." );
    }
}

centrox_verify() {
    self thread centrox_spawn();
}

centrox_spawn() {
    level endon( "Stop_Centrox" );

    level.Centrox = [];
    level.Seats = [];
    level.Center = [];
    level.Centrox_Ride = true;
    level.Movements = user_scripts\mp\scripts\util::model_spawner( self.origin + ( 40, 0, 20 ), "tag_origin" );
    time = 0.1;
    for( e = 0; e < 2; e++ )
    for( i = 0; i < 6; i++ )
    level.Center[ level.Center.size ] = user_scripts\mp\scripts\util::model_spawner( level.Movements.origin + ( cos( i * 60 ) * 20, sin( i * 60 ) * 20, e * 70 ), "com_plasticcase_friendly", ( 0, ( i * 60 ) + 90, 90 ), time ); //Center
    for( i = 0; i < 15; i++ )
    level.Centrox[ level.Centrox.size ] = user_scripts\mp\scripts\util::model_spawner( level.Movements.origin + ( cos( i * 24 ) * 70, sin( i * 24 ) * 70, -20 ), "com_plasticcase_friendly", ( 0, ( i * 24 ) + 90, 0 ), time ); //floor inner
    for( i = 0; i < 25; i++ )
    level.Centrox[ level.Centrox.size ] = user_scripts\mp\scripts\util::model_spawner( level.Movements.origin + ( cos( i * 14.4 ) * 140, sin( i * 14.4 ) * 140, -20 ), "com_plasticcase_friendly", ( 0, ( i * 14.4 ) + 90, 0 ), time ); //floor outer
    for( i = 0; i < 30; i++ )
    level.Centrox[ level.Centrox.size ] = user_scripts\mp\scripts\util::model_spawner( level.Movements.origin + ( cos( i * 12 ) * 185, sin( i * 12 ) * 185, 30 ), "com_plasticcase_friendly", ( 0, ( i * 12 ) + 90, 90 ), time ); //Wall
    for( i = 0; i < 10; i++ )
    level.Centrox[ level.Centrox.size ] = user_scripts\mp\scripts\util::model_spawner( level.Movements.origin + ( cos( i * 36 ) * 178, sin( i * 36 ) * 178, 30 ), "com_plasticcase_enemy", ( 0, ( i * 36 ) + 90, 90 ), time ); //Seats Visual
    for( i = 0; i < 10; i++ )
    level.Seats[ level.Seats.size ] = user_scripts\mp\scripts\util::model_spawner( level.Movements.origin + ( 0, 0, -40 ) + ( cos( i * 36 ) * 165, sin( i * 36 ) * 165, 30 ), "com_plasticcase_enemy", ( 0, ( i * 36 ) + 180, 0 ) ); //Seats
    level.Centrox[ 68 ] MoveTo( level.Centrox[ 67 ].origin, 0.3 ); //Doors Open
    level.Centrox[ 69 ] MoveTo( level.Centrox[ 40 ].origin, 0.3 ); //Doors Open
    iprintln( "Press [{+activate}] on a red crate to ride!" );
    iprintln( "Takes a few seconds to start once seated!" );
    level.Movements thread centrox_player_monitor( level.Seats );
    wait 5;
    level.Movements thread centrox_monitor();
    level.Movements thread centrox_spin();
}

centrox_monitor() {
    level endon( "Stop_Centrox" );

    while( isDefined( self ) ) {
        wait 10;
        level.RideActive = true;
        level.Centrox[ 68 ] MoveTo( level.Centrox[ 67 ].origin + ( 13, 40, 0 ), 0.3 );
        level.Centrox[ 69 ] MoveTo( level.Centrox[ 40 ].origin + ( -13, -40, 0 ), 0.3 );
        wait 3;
        foreach( model in level.Centrox )
        model LinkTo( level.Movements );
        foreach( model in level.Seats )
        model LinkTo( level.Movements );
        for( ext = 0; Ext < 22; Ext += 2 ) {
            self MoveTo( ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] + Ext ), 0.7 );
            wait 0.6;
        }
        wait 8;
        for( e = 0; e < 2; e++ ) {
            for( ext = 0; Ext < 40; Ext++ ) {
                self RotateRoll( Ext * 0.1, 0.7 );
                wait 0.1;
            }
            wait 5;
        }
        wait 8;
        for( e = 0; e < 2; e++ ) {
            for( ext = 0; Ext < 40; Ext++ ) {
                self RotateRoll( 0 - Ext * 0.1, 0.7 );
                wait 0.1;
            }
            wait 8;
        }
        level.RideActive = undefined;
        for( ext = 0; Ext < 22; Ext += 2 ) {
            self MoveTo( ( self.origin[ 0 ], self.origin[ 1 ], self.origin[ 2 ] - Ext ), 0.7 );
            wait 0.6;
        }
        foreach( model in level.Seats )
        model unlink();
        foreach( model in level.Centrox )
        model Unlink();
        wait 0.3;
        level.Centrox[ 68 ] MoveTo( level.Centrox[ 67 ].origin, 0.3 );
        level.Centrox[ 69 ] MoveTo( level.Centrox[ 40 ].origin, 0.3 );
        foreach( rider in level.players )
        rider unlink();
        for( e = 0; e < 10; e++ )
        level.seatTaken[ e ] = undefined;
        wait 0.05;
    }
}

centrox_spin() {
    level endon( "Stop_Centrox" );

    Speed = 0;
    for(;;) {
        while( isDefined( self ) && isDefined( level.RideActive ) ) {
            self RotateYaw( Speed * 0.4, 0.9 );
            Speed++;
            wait 0.1;
        }
        Speed = 0;
        wait 0.05;
    }
}

centrox_player_monitor( array ) {
    level endon( "Stop_Centrox" );

    level.CentroxTrig = user_scripts\mp\scripts\util::spawn_trigger( self.origin, 250, 40, "HINT_NOICON", "Press &&1 to Enter / Exit The Centrox!" );
    while( isDefined( self ) ) {
        level.CentroxTrig waittill( "trigger", i );
        if( i useButtonPressed() && !i.riding ) {
            closest = common_scripts\utility::getClosest( i.origin, Array );
            if( !closest.occupied ) {
                i setStance( "stand" );
                i.ridingCentox = true;
                i PlayerLinkToAbsolute( closest );
                i thread centrox_player_exit( closest );
                closest.CentroxOccupied = true;
            }
        }
    }
}

centrox_player_exit( seat ) {
    level endon( "Stop_Centrox" );
    self endon( "death" );
    self endon( "disconnect" );

    wait 1.5;
    while( isDefined( seat ) ) {
        if( self useButtonPressed() && !isDefined( level.RideActive ) )
        break;
        wait 0.05;
    }
    seat.CentroxOccupied = undefined;
    self setStance( "stand" );
    self unlink();
    wait 1.5;
    self.ridingCentox = undefined;
}

twister_verify() {
    self thread twister_build();
}

twister_build() {
    level.skyBaseIsBuilding = true;
    pos = self.origin + ( 0, 0, 15 );
    level.TwistSeatsAttach = [];
    level.TwistSeats = [];
    level.CenterLink = user_scripts\mp\scripts\util::spawn_script_model( pos, "tag_origin" );
    level.CenterLink sky_base_array( true );
    model = "com_plasticcase_friendly";
    time = 0.05;
    level.bog = [];
    for( a = 0; a < 11; a++ )for( b = 0; b < 6; b++ )level.bog[ level.bog.size ] = user_scripts\mp\scripts\util::spawn_script_model( pos + ( 0, 0, a * 27 ), model, ( 0, b * 51.43, 0 ), time );
    for( a = 0; a < 4; a++ )for( b = 0; b < 2; b++ )for( c =0; c < 3; c++ )level.bog[ level.bog.size ] = user_scripts\mp\scripts\util::spawn_script_model( pos + ( sin( a * 90 ) * ( c * 57 + 50 ), cos( a * 90 ) * ( c * 57 + 50 ), 125 ), model, ( 0, 90 + a * 90 + b * 180, 0 ), time );
    for( a = 0; a < 4; a++ )for( b = 0; b < 2; b++ )for( c =0; c < 3; c++ )level.bog[ level.bog.size ] = user_scripts\mp\scripts\util::spawn_script_model( pos + ( sin( a * 90 + 45 ) * ( c * 57 + 50 ), cos( a * 90 + 45 ) * ( c * 57 + 50 ), 270 ), model, ( 0, 45 + a * 90 + b * 180, 0 ), time );
    common_scripts\utility::array_thread( level.bog, ::twister_array, level.CenterLink );
    level.rows = [];
    for( a = 0; a < 4; a++ )level.rows[ level.rows.size ] = user_scripts\mp\scripts\util::spawn_script_model( pos + ( sin( a * 90 ) * ( 3 * 57 + 35 ), cos( a * 90 ) * ( 3 * 57 + 35 ), 111 ), model, ( 90, 90 + a * 90, 0 ), time );
    for( a = 0; a < 4; a++ )level.rows[ level.rows.size ] = user_scripts\mp\scripts\util::spawn_script_model( pos + ( sin( a * 90 + 45 ) * ( 3 * 57 + 35 ), cos( a * 90 + 45 ) * ( 3 * 57 + 35 ), 256 ), model, ( 90, 45 + a * 90, 0 ), time );
    common_scripts\utility::array_thread( level.rows, ::sky_base_array, true );
    level.ss = [];
    for( a = 0; a < 4; a++ )for( b = 0; b < 3; b += 2 )level.ss[ level.ss.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rows[ a ].origin + ( 0, cos( b * 90 ) * ( 35 ), -50 ), model, ( 17 + b * 163, 90, 0 ), time );
    for( a = 0; a < 4; a++ )for( b = 1; b < 4; b += 2 )level.ss[ level.ss.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rows[ a ].origin + ( sin( b * 90 ) * ( 35 ), 0, -50 ), model, ( 343 + ( b - 1 ) * -163, 180, 0 ), time );
    num = 0;
    count = 0;
    for( a = 0; a < level.ss.size; a++ ) {
        level.ss[ a ] thread twister_array( level.rows[ num ]);
        if( count == 1 ) {
            num++;
            count = -1;
        }
        if( num > 3 )num = 0;
        count++;
    }
    level.ss = [];
    for( a = 0; a < 4; a++ )for( b = 0; b < 3; b += 2 )level.ss[ level.ss.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rows[ a + 4].origin + ( sin( b * 90 + 45 ) * ( 35 ), cos( b * 90 + 45 ) * ( 35 ), -50 ), model, ( 17 + b * 163, 45, 0 ), time );
    for( a = 0; a < 4; a++ )for( b = 1; b < 4; b += 2 )level.ss[ level.ss.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rows[ a + 4].origin + ( sin( b * 90 + 45 ) * ( 35 ), cos( b * 90 + 45 ) * ( 35 ), -50 ), model, ( 343 + ( b - 1 ) * -163, 135, 0 ), time );
    num = 4;
    count = 0;
    for( a = 0; a < level.ss.size; a++ ) {
        level.ss[ a ] thread twister_array( level.rows[ num ]);
        if( count == 1 ) {
            num++;
            count = -1;
        }
        if( num>7 )num = 4;
        count++;
    }
    for( a = 0; a < 4; a++ ) {
        for( b = 0; b < 8; b++ ) {
            level.TwistSeats[ a ] = user_scripts\mp\scripts\util::spawn_script_model( level.rows[ a ].origin + ( sin( b * 45 ) * ( 77 ), cos( b * 45 ) * ( 77 ), -58 ), model, ( 0, 315 * b, 0 ), time );
            level.TwistSeatsAttach[ level.TwistSeatsAttach.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.TwistSeats[ a ].origin + ( sin( b * 90 ) * ( 22 ), cos( b * 90 ) * ( 22 ), 0 ), "tag_origin", undefined, time );
            level.TwistSeats[ a ] thread twister_array( level.rows[ a ]);
            level.TwistSeatsAttach[ level.TwistSeatsAttach.size - 1] thread twister_array( level.rows[ a ], true );
        }
    }
    for( a = 0; a < 4; a++ ) {
        for( b = 0; b < 8; b++ ) {
            level.TwistSeats[ a+4] = user_scripts\mp\scripts\util::spawn_script_model( level.rows[ a + 4].origin + ( sin( b * 45 ) * ( 77 ), cos( b * 45 ) * ( 77 ), -58 ), model, ( 0, 315 * b, 0 ), time );
            level.TwistSeatsAttach[ level.TwistSeatsAttach.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.TwistSeats[ a + 4].origin + ( sin( b * 90 + 45 ) * ( 22 ), cos( b * 90 + 45 ) * ( 22 ), 0 ), "tag_origin", undefined, time );
            level.TwistSeats[ a+4] thread twister_array( level.rows[ a + 4]);
            level.TwistSeatsAttach[ level.TwistSeatsAttach.size - 1] thread twister_array( level.rows[ a + 4], true );
        }
    }
    level.top = user_scripts\mp\scripts\util::spawn_script_model( pos + ( 0, 0, 280 ), "test_sphere_silver", undefined, time );
    level.tag = user_scripts\mp\scripts\util::spawn_script_model( level.top.origin, "tag_origin", undefined, time );
    level.top sky_base_array( true );
    level.tag sky_base_array( true );
    level.top thread twister_array( level.CenterLink );
    level.TwistSeatsAttach thread twister_check( pos, level.TwistSeatsAttach );
    for( a = 0; a < 4; a++ ) {
        level.rows[ a ] thread twister_orbit( pos, a * 90, 111 );
        level.rows[ a + 4 ] thread twister_orbit( pos, a * 90 + 45, 256 );
        level.rows[ a ] thread user_scripts\mp\scripts\util::rotate_ent_yaw( -360, 3 );
        level.rows[ a + 4 ] thread user_scripts\mp\scripts\util::rotate_ent_yaw( -360, 3 );
    }
    level.CenterLink thread user_scripts\mp\scripts\util::rotate_ent_yaw( 360, 4 );
    level.notifyIcon = user_scripts\mp\scripts\util::text_marker( undefined, level.top.origin, "The Twister", false );
    level.notifyIcon setTargetEnt( level.tag );
    wait 0.05;
    level.skyBaseIsBuilding = undefined;
}

twister_array( link, bool ) {
    self sky_base_array( bool );
    self linkTo( link );
}

twister_check( area, Seat ) {
    level endon( "SKYBASE_FAIL" );

    triger = user_scripts\mp\scripts\util::spawn_trigger( area, 80, 80, "HINT_NOICON", "Press &&1 to Enter / Exit The Twister" );
    triger sky_base_array( true );
    while( true ) {
        triger waittill( "trigger", i );
        if( !isDefined( i.riding ) && isPlayer( i ) && isDefined( i.SpawnableTrig ) )
            i.SpawnableTrig destroy();
        if( !isDefined( i.riding ) && isPlayer( i ) ) {
            row = randomIntRange( 0, 64 );
            if( !isDefined( seat[ row ].Occupied ) ) {
                i allowSprint( false );
                i setStance( "crouch" );
                i.riding = true;
                i PlayerLinkTo( Seat[ row ] );
                i.SpawnableTrig = i iprintlnbold( "Press [{+frag}] to Exit The Twister" );
                Seat[ row ].Occupied = true;
                i thread twister_exit( Seat[ row ], i );
            }
        }
        wait 0.05;
    }
}

twister_exit( seat, player ) {
    level endon( "SKYBASE_FAIL" );

    while( isDefined( seat ) ) {
        if( self fragButtonPressed() ) break;
        wait 0.05;
    }
    if( isDefined( player.SpawnableTrig ) )
        player.SpawnableTrig destroy();
    self allowSprint( true );
    self.riding = undefined;
    Seat.Occupied = undefined;
    self unlink();
    self setStance( "stand" );
}

twister_orbit( pos, int, z ) {
    level endon( "SKYBASE_FAIL" );

    while( true ) {
        for( a = int - 4.5; a < 370; a -= 9 ) {
            loc = ( pos + ( sin( a ) * 200, cos( a ) * 200, z ) );
            self moveTo( loc, 0.1 );
            wait 0.09;
        }
        wait 0.05;
    }
}

coaster_verify() {
    self thread coaster_main();
}

coaster_main() {
    if( !isDefined( level.coaster ) && !isDefined( level.bigSpawn ) ) {
        level.bigSpawn = true;
        level.coaster = true;
        iprintln( "^1Won't finish building on larger maps! ( ent limit )" );
        iprintln( "^1Activate roller coaster again to delete!" );
        self thread coaster_build();
    }
    if( isDefined( level.coaster ) && isDefined( level.bigSpawn ) ) {
        if( isDefined( level.skyBaseIsBuilding ) )
            return;
        level notify( "SKYBASE_DELETED" );
        level notify( "SKYBASE_FAIL" );
        self iprintln( "^1Roller Coaster destroyed!" );
        level thread sky_base_delete();
        level thread user_scripts\mp\scripts\util::icon_delete();
        for( a = 0; a < user_scripts\mp\scripts\util::get_players().size; a++ ) {
            player = user_scripts\mp\scripts\util::get_players()[ a ];

            if( isDefined( player.riding ) ) {
                if( isDefined( player.SpawnableTrig ) )
                    player.SpawnableTrig destroy();
                player unLink();
                player allowSprint( true );
                player.riding = undefined;
            }
        }
        level.coaster = undefined;
        level.bigSpawn = undefined;
    }
}

coaster_build() {
    level endon( "Coaster_End" );

    level.skyBaseIsBuilding = true;
    level.Roller_Coaster = true;
    model = "test_sphere_silver";
    self iPrintln( "^:Press [{+activate}] on the platform to ride" );
    self iPrintln( "^:Press [{+frag}] to exit" );
    level.org = self.origin;
    level.rail = [];
    level.floor = [];
    level.seat = [];
    //DONE
    for( a = 0; a < 4; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.org + ( -50, 22 - ( a * 44 ), 15 ), model, ( 0, 90, 0 ), 0.05 );
    for( a = 0; a < 17; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 3 ].origin + ( 0, sin( 184 + ( a * 4 ) ) * 625, cos( 184 + ( a * 4 ) ) * 625 + 624 ), model, ( 4 + ( a * 4 ), 90, 0 ), 0.05 );
    for( a = 1; a < 35; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 20 ].origin + ( 0, sin( 338 ) * ( a * 44 ), cos( 338 ) * ( a * 44 ) ), model, ( 68, 90, 0 ), 0.05 );
    for( a = 0; a < 17; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 54 ].origin + ( 0, sin( 64 - ( a * 4 ) ) * 625 - 579, cos( 64 - ( a * 4 ) ) * 625 - 235 ), "test_sphere_silver", ( level.rail[ level.rail.size - 1 ].angles[ 0 ] - 4, 90, 0 ), 0.05 );
    //CURRENT
    for( a = 0; a < 109; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 70 ].origin + ( sin( 90 + ( a * 5 ) ) * 491 - 491, cos( 90 + ( a * 5 ) ) * 491 - 87, cos( 90 - ( a * 1 ) ) * ( a * 2 ) + 1.5 ), model, ( level.rail[ level.rail.size - 1 ].angles[ 0 ] + 0.055, 90 - ( a * 5 ), 0 ), 0.05 );
    //NOT DONE
    for( a = 0; a < 10; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 180 ].origin + ( sin( 0 ) * ( a * 44 ), cos( 0 ) * ( a * 44 ) + 44, 0 ), model, ( 90, 90, 0 ), 0.05 );
    for( a = 0; a < 17; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 190 ].origin + ( 0, sin( 4 + ( a * 4 ) ) * 625, cos( 4 + a * 4 ) * 625 - 625 ), model, ( 86 - ( a * 4 ), 90, 0 ), 0.05 );
    for( a = 0; a < 25; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 207 ].origin + ( 0, sin( 158 ) * ( a * 44 ) + 16, cos( 158 ) * ( a * 44 ) - 40 ), model, ( 22, 90, 0 ), 0.05 );
    for( a = 0; a < 17; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 232 ].origin + ( 0, sin( 244 - ( a * 4 ) ) * 625 + 580, cos( 244 - ( a * 4 ) ) * 625 + 236 ), model, ( 26 + ( a * 4 ), 90, 0 ), 0.05 );
    for( a = 0; a < 91; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 249 ].origin + ( sin( 180 - ( a * 1 ) ) * ( a * 1 ), sin( 180 - ( a * 4 ) ) * 625 + 44, cos( 180 - ( a * 4 ) ) * 625 + 625 ), model, ( 90 + ( a * 4 ), -0.5 - ( a * 0.05 ), 0 ), 0.05 );
    for( a = 0; a < 15; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 340 ].origin + ( sin( 1 ) * ( a * 44 ), cos( 1 ) * ( a * 44 ) + 44, 0 ), model, ( 90, 90, 0 ), 0.05 );
    for( a = 0; a < 38; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 355 ].origin + ( sin( 270 + ( a * 5 ) ) * 491 + 491, cos( 270 + ( a * 5 ) ) * 491 + 44, 0 ), model, ( 90, -1 - ( a * 5 ), 0 ), 0.05 );
    for( a = 0; a < 5; a++ )level.rail[ level.rail.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 393 ].origin + ( -3 * ( a + 1 ), sin( 184 + ( a * 4 ) ) * 621, cos( 184 + ( a * 4 ) ) * 621 + 621 ), model, ( 266 - ( a * 4 ), -4, 0 ), 0.05 );
    for( a = 0; a < level.rail.size; a++ )level.rail[ a ] sky_base_array();
    level.attacher = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 0 ].origin, "test_sphere_redchrome" );
    level.attacher sky_base_array();
    for( a = 0; a < 4; a++ )level.floor[ level.floor.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.org + ( -50, 70 - a * 24, 35 ), "com_plasticcase_enemy", ( 0, 0, 180 ), 0.05 );
    for( a = 0; a < 2; a++ )level.floor[ level.floor.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.rail[ 0 ].origin + ( 45 - a * 90, 0, 20 ), "com_plasticcase_enemy", ( 0, 90 + a * 180, 90 ), 0.05 );
    for( a = 0; a < 2; a++ )level.floor[ level.floor.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.floor[ 3 ].origin + ( 0, sin( 20 ) * ( a * 24 ) - 24, cos( 20 ) * ( a * 24 ) ), "com_plasticcase_enemy", ( 0, 0, 70 ), 0.05 );
    for( a = 0; a < 2; a++ )level.floor[ level.floor.size ] = user_scripts\mp\scripts\util::spawn_script_model( level.floor[ 3 ].origin + ( 0, -3, 5 ), "com_plasticcase_enemy", ( 90 + a * 180, 0, 0 ), 0.05 );
    level.back = user_scripts\mp\scripts\util::spawn_script_model( level.floor[ 0 ].origin, "com_plasticcase_enemy", ( 0, 180, 180 ), 0.05 );
    level.back sky_base_array();
    for( a = 0; a < level.floor.size; a++ )level.floor[ a ] thread twister_array( level.attacher );
    for( a = 0; a < 2; a++ ) {
        level.seat[ a ] = user_scripts\mp\scripts\util::spawn_script_model( level.org + ( -39 - a * 22, 18, 39 ), "script_origin", ( 0, 270, 0 ) );
        level.seat[ a ] twister_array( level.attacher );
    }
    level endon( "SKYBASE_FAIL" );
    level thread coaster_cart_monitor( level.seat, level.attacher );
    wait 0.05;
    level.skyBaseIsBuilding = undefined;
    level waittill( "Roller_Coaster_Countdown" );
    level coaster_countdown( level.seat );
    level.back rotateTo( ( 0, 180, 90 ), 0.5 );
    wait 0.5;
    level.back linkTo( level.attacher );
    while( true ) {
        for( a = 1; a < 4; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.25 );
            earthquake( 0.1, 1, level.rail[ a ].origin, 150 );
            wait 0.2;
        }
        for( a = 4; a < 21; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.25 );
            level.attacher rotateTo( ( 0, 0, -4 - ( a - 4 ) * 4 ), 0.25 );
            earthquake( 0.15, 0.5, level.rail[ a ].origin, 100 );
            wait 0.2;
        }
        for( a = 21; a < 55; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.25 );
            earthquake( 0.15, 0.5, level.rail[ a ].origin, 100 );
            wait 0.2;
        }
        if( !isDefined( level.attacher.mode ) ) {
            level.attacher.mode = true;
            for( a = 250; a < 295; a++ ) {
                level.attacher moveTo( level.rail[ a ].origin, 0.08 );
                level.attacher rotateTo( ( 0 + ( a - 249 ) * 8, -180, 0 ), 0.08 );
                if( a > 252 && a <= 272 )level.attacher rotateTo( ( 0 + ( a - 250 ) * 8.21, -180, 0 + ( a - 253 ) * 4 ), 0.08 );
                if( a > 272 )level.attacher rotateTo( ( 180, -180, 76 + ( a - 273 ) * 4.727 ), 0.08 );
                earthquake( 0.2, 1, level.rail[ a ].origin, 150 );
                wait 0.05;
            }
            for( a = 295; a < 341; a++ ) {
                level.attacher moveTo( level.rail[ a ].origin, 0.08 );
                level.attacher rotateTo( ( 180 - ( a - 294 ) * 8, -180, 180 ), 0.08 );
                if( a > 297 && a <= 317 )level.attacher rotateTo( ( 180 - ( a - 295 ) * 8.21, -180, 180 - ( a - 298 ) * 4 ), 0.08 );
                if( a > 317 )level.attacher rotateTo( ( 0, -180, 104 - ( a - 318 ) * 4.727 ), 0.08 );
                earthquake( 0.2, 1, level.rail[ a ].origin, 150 );
                wait 0.05;
            }
        }
        else {
            level.attacher.mode = undefined;

            for( a = 250; a < 341; a++ ) {
                level.attacher moveTo( level.rail[ a ].origin, 0.08 );
                level.attacher rotateTo( ( 0, -180.5 - ( a - 250 ) * 0.05, 0 - ( a - 250 ) * 4 ), 0.08 );
                earthquake( 0.15, 1, level.rail[ a ].origin, 150 );
                wait 0.05;
            }
        }
        for( a = 341; a < 356; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.08 );
            level.attacher rotateTo( ( 0, -180, 0 ), 0.08 );
            earthquake( 0.2, 0.5, level.rail[ a ].origin, 100 );
            wait 0.05;
        }
        for( a = 356; a < 394; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.08 );
            level.attacher rotateTo( ( 0, -181 - ( a - 356 ) * 5, 0 ), 0.08 );
            earthquake( 0.15, 1, level.rail[ a ].origin, 150 );
            wait 0.05;
        }
        for( a = 394; a < 399; a++ ) {
            level.attacher moveTo( level.rail[ a ].origin, 0.08 );
            level.attacher rotateTo( ( 0, -4, -4 - ( a - 394 ) * 4 ), 0.08 );
            earthquake( 0.15, 1, level.rail[ a ].origin, 150 );
            wait 0.05;
        }
        level.attacher rotateTo( ( 0, 0, 0 ), 1 );
        for( a = 0; a < 19; a++ ) {
            level.attacher moveTo( level.rail[ 398 ].origin + ( -4.3 * ( a + 1 ), sin( -16.5 - a * 3.3 ) * 775 + 145, cos( -16.5 - a * 3.3 ) * 775 - 735 ), 0.11 );
            wait 0.06;
        }
        wait 0.05;
        level.attacher notify( "Catch_A_Ride" );
        earthquake( 0.8, 1.5, level.rail[ 0 ].origin, 200 );
        wait 0.05;
    }
}

coaster_cart_monitor( seat, tag ) {
    level endon( "SKYBASE_FAIL" );
    level endon( "Roller_Coaster_Started" );

    trig = user_scripts\mp\scripts\util::spawn_trigger( tag.origin, 150, 150, "HINT_NOICON", "Press &&1 to Enter / Exit The Coaster" );
    trig sky_base_array( true );
    level thread coaster_wait_start( trig, "Please Wait Until The Roller Coaster Passes to Catch a Ride!", seat, tag );
    while( true ) {
        for( a = 0; a < user_scripts\mp\scripts\util::get_players().size; a++ ) {
            if( distance( tag.origin, user_scripts\mp\scripts\util::get_players()[ a ].origin ) <= 150 ) {
                if( !user_scripts\mp\scripts\util::get_players()[ a ].riding && isPlayer( user_scripts\mp\scripts\util::get_players()[ a ] ) && !isDefined( user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig ) )user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig = user_scripts\mp\scripts\util::get_players()[ a ] maps\mp\_utility::setLowerMessage( "Press [{+activate}] to Ride The Roller Coaster" );

                if( !user_scripts\mp\scripts\util::get_players()[ a ].riding && isPlayer( user_scripts\mp\scripts\util::get_players()[ a ]) && user_scripts\mp\scripts\util::get_players()[ a ] useButtonPressed() ) {
                    X = randomInt( seat.size );
                    if( isDefined( user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig ) )user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig user_scripts\mp\scripts\util::set_safe_text_1( "Press [{+frag}] to Exit" );
                    user_scripts\mp\scripts\util::get_players()[ a ].riding = true;
                    user_scripts\mp\scripts\util::get_players()[ a ] playerLinkToAbsolute( seat[ X ] );
                    user_scripts\mp\scripts\util::get_players()[ a ] setStance( "stand" );
                    user_scripts\mp\scripts\util::get_players()[ a ] thread coaster_exit( user_scripts\mp\scripts\util::get_players()[ a ].riding, user_scripts\mp\scripts\util::get_players()[ a ] );
                    level notify( "Roller_Coaster_Countdown" );
                }
            }
            else if( !user_scripts\mp\scripts\util::get_players()[ a ].riding && isPlayer( user_scripts\mp\scripts\util::get_players()[ a ] ) && isDefined( user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig ) && Distance( tag.origin, user_scripts\mp\scripts\util::get_players()[ a ].origin ) > 150 )user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig destroy();
        }
        wait 0.05;
    }
}

coaster_wait_start( trig, text, seat, tag ) {
    level endon( "SKYBASE_FAIL" );
    level waittill( "Roller_Coaster_Countdown" );

    wait 10;
    level thread coaster_monitor( trig, text );
    if( isDefined( tag ) ) trig thread coaster_start_new( seat, tag );
}

coaster_monitor( trig,text ) {
    level endon( "SKYBASE_FAIL" );

    while( 1 ) {
        for( a = 0; a < user_scripts\mp\scripts\util::get_players().size; a++ ) {
            if( distance( trig.origin, user_scripts\mp\scripts\util::get_players()[ a ].origin ) <= 150 && isPlayer( user_scripts\mp\scripts\util::get_players()[ a ]) && !user_scripts\mp\scripts\util::get_players()[ a ].riding ) {
                if( isDefined( user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig ) )user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig user_scripts\mp\scripts\util::set_safe_text_2( text );
                else user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig = user_scripts\mp\scripts\util::get_players()[ a ] iprintlnbold( text );
            }
            else if( isDefined( user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig ) && !user_scripts\mp\scripts\util::get_players()[ a ].riding )user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig destroy();
        }
        wait 0.05;
    }
}

coaster_exit( arg, player ) {
    level endon( "SKYBASE_FAIL" );

    while( isDefined( arg ) ) {
        if( self fragButtonPressed() )break;
        wait 0.05;
    }
    if( isDefined( player.SpawnableTrig ) )player.SpawnableTrig destroy();
    self.riding = undefined;
    self unlink();
    self setStance( "stand" );
}

coaster_countdown( seat ) {
    level endon( "SKYBASE_FAIL" );

    for( a = 3; a > 0; a-- ) {
        earthquake( 0.5, 1, seat[ 0 ].origin - ( 11, 0, 0 ), 100 );
        wait 1;
    }
    level notify( "Roller_Coaster_Started" );
}

coaster_start_new( seat, attacher ) {
    level endon( "SKYBASE_FAIL" );

    while( true ) {
        attacher waittill( "Catch_A_Ride" );
        self thread coaster_pickup_monitor( seat );
        wait 1.5;
        level notify( "Roller_Coaster_Pickup_Over" );
    }
}

coaster_pickup_monitor( seat ) {
    level endon( "SKYBASE_FAIL" );
    level endon( "Roller_Coaster_Pickup_Over" );

    while( 1 ) {
        for( a = 0; a < user_scripts\mp\scripts\util::get_players().size; a++ ) {
            if( distance( self.origin, user_scripts\mp\scripts\util::get_players()[ a ].origin ) <= 150 && !user_scripts\mp\scripts\util::get_players()[ a ].riding && isPlayer( user_scripts\mp\scripts\util::get_players()[ a ]) ) {
                X = randomInt( seat.size );
                user_scripts\mp\scripts\util::get_players()[ a ].riding = true;
                user_scripts\mp\scripts\util::get_players()[ a ] playerLinkToAbsolute( seat[ X ] );
                user_scripts\mp\scripts\util::get_players()[ a ] setStance( "stand" );
                user_scripts\mp\scripts\util::get_players()[ a ] thread coaster_exit( user_scripts\mp\scripts\util::get_players()[ a ].riding );
                if( isDefined( user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig ) )user_scripts\mp\scripts\util::get_players()[ a ].SpawnableTrig user_scripts\mp\scripts\util::set_safe_text_2( "Press [{+frag}] to Exit" );
            }
        }
        wait 0.05;
    }
}

sky_base_built( base ) {
    if( base == "Twister" ) {
        return level.twister;
    }
    if( base == "Coaster" ) {
        return level.coaster;
    }
    if( base == "Tornado" ) {
        return level.TornadoSpawned;
    }
}

sky_base_delete() {
    if ( isDefined( level.sky_base_array ) ) {
        for ( a = 0; a < level.sky_base_array.size; a++ ) {
            if ( isDefined( level.sky_base_array[ a ] ) ) {
                level.sky_base_array[ a ] delete();
            }
        }
    }
    if ( isDefined( level.physicsArray ) ) {
        for ( a = 0; a < level.sky_base_array.size; a++ ) {
            if ( isDefined( level.physicsArray[ a ] ) ) {
                level.physicsArray[ a ] delete();
            }
        }
    }
    level.sky_base_array = undefined;
    level.physicsArray = undefined;
    level.sky_base_destroyed = undefined;
}

sky_base_destroy( base ) {
    if( isDefined( level.skyBaseIsBuilding ) || !isDefined( sky_base_built( base ) ) || sky_base_used() || isDefined( level.sky_base_destroyed ) ) {
        return;
    }
    level notify( "SKYBASE_FAIL" );
    level.sky_base_destroyed = true;
    level thread user_scripts\mp\scripts\util::icon_delete();
    for ( a = 0; a < user_scripts\mp\scripts\util::get_players().size; a++ ) {
        player = user_scripts\mp\scripts\util::get_players()[ a ];
        player.riding = undefined;
        player user_scripts\mp\scripts\util::stance_allowed( true );

        if ( isDefined( player.inSkyBase ) ) {
            player setStance( "stand" );
            player thread sky_base_fall();
        }

        player.inSkyBase = undefined;
    }
}

sky_base_array( delete ) {
    if ( isDefined( delete ) ) {
        self thread sky_base_delete_2();
    } else {
        self thread sky_base_physics();
    }
    if ( !isDefined( level.sky_base_array ) ) {
        level.sky_base_array = [];
    }
    level.sky_base_array[ level.sky_base_array.size ] = self;
}

sky_base_delete_2() {
    level waittill( "SKYBASE_FAIL" );
    if( isDefined( self ) ) {
        self delete();
    }
}

sky_base_physics() {
    level endon( "SKYBASE_DELETED" );

    level waittill( "SKYBASE_FAIL" );
    while( true ) {
        self PhysicsLaunchServer( self.origin, AnglesToForward( self.angles ) * 400 );
        wait 0.1;
    }
}

sky_base_used() {
    for ( a = 0; a < user_scripts\mp\scripts\util::get_players().size; a++ ) {
        if ( isDefined( user_scripts\mp\scripts\util::get_players()[ a ].usingSkyBase ) && isalive( user_scripts\mp\scripts\util::get_players()[ a ] ) ) {
            return 1;
        }
    }
    return 0;
}

sky_base_fall() {
    fly = spawn( "script_origin", self.origin );
    self playerLinkToDelta( fly );
    fly moveto( self.origin + ( 0, 0, -200 ), 0.7 );
    wait 0.8;
    self unlink();
    self allowJump( true );
    fly delete();
}

suicide_plane() {
    self endon( "disconnect" );
    self endon( "death" );

    Location = user_scripts\mp\scripts\util::location_selector();
    self iPrintln( "^:Suicide Plane Inbound!" );
    SuicidePlane = spawn( "script_model", self.origin + ( 24000, 15000, 25000 ) );
    SuicidePlane setModel( "vehicle_ac130_low_mp" );
    Angles = vectorToAngles( Location - ( self.origin + ( 8000, 5000, 10000 ) ) );
    SuicidePlane.angles = Angles;
    SuicidePlane moveto( Location, 3.5 );
    SuicidePlane playsound( "veh_b2_close_loop" );
    playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], SuicidePlane, "tag_origin" );
    wait 3.6;
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 400, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 400, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 0, 400 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 400, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 0, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 400, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 0, 800 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 200, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 200, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 0, 200 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 200, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 0, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin - ( 200, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], SuicidePlane.origin + ( 0, 0, 200 ) );
    playFX( level._effect[ "vfx/explosion/mp_gametype_bomb" ], SuicidePlane.origin + ( 0, 0, 0 ) );
    SuicidePlane playsound( level.heli_sound[ "crash" ] );
    SuicidePlane playsound( "nuke_explosion" );
    self RadiusDamage( SuicidePlane.origin, 4000, 4000, 100, self );
    SuicidePlane delete();
    Earthquake( 0.4, 4, SuicidePlane.origin, 800 );
}

plane_collision() {
    self endon( "disconnect" );
    self endon( "death" );
    self endon( "PilotsCrashed" );

    ElectricHaze = spawn( "script_model", self.origin + ( 18000, 0, 2400 ) );
    ElectricHaze2 = spawn( "script_model", self.origin + ( -18000, 0, 2400 ) );
    ElectricHaze setModel( "vehicle_ac130_low_mp" );
    ElectricHaze2 setModel( "vehicle_ac130_low_mp" );
    ElectricHaze MoveTo( self.origin + ( 0, 0, 2400 ), 5 );
    ElectricHaze2 MoveTo( self.origin + ( 0, 0, 2400 ), 5 );
    ElectricHaze.angles = ( 0, 180, 0 );
    ElectricHaze2.angles = ( 0, 0, 0 );
    playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], ElectricHaze, "tag_origin" );
    playFxOnTag( level.chopper_fx[ "damage" ][ "light_smoke" ], ElectricHaze2, "tag_origin" );
    wait 5;
    PlayFX( level._effect[ "aerial_explosion_large" ], ElectricHaze.origin );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 400, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 400, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 0, 400 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 400, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 0, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 400, 400, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 0, 800 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 200, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 200, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 0, 200 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 200, 0, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 0, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin - ( 200, 200, 0 ) );
    playFX( level.chopper_fx[ "explode" ][ "large" ], ElectricHaze.origin + ( 0, 0, 200 ) );
    ElectricHaze playsound( level.heli_sound[ "crash" ] );
    ElectricHaze playsound( "nuke_explosion" );
    scripts\utility::_visionsetnaked( "coup_sunblind", 0.1 );
    PlayFX( level._effect[ "nuke_flash" ] );
    wait ( 0.1 );
    scripts\utility::_visionsetnaked( "coup_sunblind", 0 );
    scripts\utility::_visionsetnaked( "", 3.0 );
    self thread plane_collision_fx();
    ElectricHaze delete();
    ElectricHaze2 delete();
}

plane_collision_fx() {
    self endon( "disconnect" );
    self endon( "death" );

    earthquake( 0.6, 4, self.origin, 100000 );
    foreach( player in level.players ) {
        player playlocalsound( "nuke_explosion" );
        player playlocalsound( "nuke_wave" );
    }
}

mega_airdrop_remade() {
    self iPrintln( "^:Mega Airdrop Inbound!" );
    planeHalfDistance = 24000;
    planeFlySpeed     = 3500;
    yaw               = vectorToYaw( self.origin );
    direction         = ( 0, yaw, 0 );
    flyHeight         = self maps\mp\h2_killstreaks\_airdrop::getFlyHeightOffset( self.origin );
    pathStart         = self.origin + scripts\utility::Vector_Multiply( AnglesToForward( direction ), -1 * planeHalfDistance );
    pathStart         = pathStart * ( 1, 1, 0 ) + ( 0, 0, flyHeight );
    pathEnd           = self.origin + scripts\utility::Vector_Multiply( AnglesToForward( direction ), planeHalfDistance );
    pathEnd           = pathEnd * ( 1, 1, 0 ) + ( 0, 0, flyHeight );
    d                 = length( pathStart - pathEnd );
    flyTime           = ( d / planeFlySpeed );
    c130              = maps\mp\h2_killstreaks\_airdrop::c130Setup( self, pathStart, pathEnd );
    c130.dropType     = "airdrop_marker_mp";
    c130 PlayLoopSound( "veh_ac130_dist_loop" );
    c130.angles = direction;
    forward     = AnglesToForward( direction );
    c130 MoveTo( pathEnd, flyTime, 0, 0 );
    minDist    = Distance2D( c130.origin, self.origin );
    boomPlayed = false;
    for(;;) {
        dist = Distance2D( c130.origin, self.origin );
        if( dist < minDist )
            minDist = dist;
        else if( dist > minDist )
            break;
        if( dist < 256 )
            break;
        else if( dist < 768 ) {
            Earthquake( 0.15, 1.5, self.origin, 1500 );

            if( !boomPlayed ) {
                c130 PlaySound( "veh_ac130_sonic_boom" );
                boomPlayed = true;
            }
        }
        wait 0.05;
    }
    for( a = 0;  a < 15; a++ ) {
        c130 notify( "drop_crate" );
        c130 thread maps\mp\h2_killstreaks\_airdrop::dropTheCrate( self.origin, "airdrop_marker_mp", flyHeight, false, undefined, pathStart );
        wait 0.055;
    }
    wait 7;
    c130 delete();
}

mega_airdrop() {
    self thread mega_airdrop_text( "^:Mega Airdrop Incoming...", 5, ( 0, 1, 1 ) );
    wait 5;
    self thread mega_airdrop_main();
}

mega_airdrop_main() {
    self endon( "death" );
    self endon( "disconnect" );

    thread maps\mp\_utility::teamPlayerCardSplash( "used_airdrop_mega", self );
    o = self;
    sn = level.heli_start_nodes[ randomInt( level.heli_start_nodes.size ) ];
    hO = sn.origin;
    hA = sn.angles;
    lb = spawnHelicopter( o, hO, hA, "cobra_mp", "vehicle_ac130_low_mp" );
    if( !isDefined( lb ) ) return;
    lb maps\mp\_helicopter::addToHeliList();
    lb.zOffset = ( 0, 0, lb getTagOrigin( "tag_origin" )[ 2 ] - lb getTagOrigin( "tag_ground" )[ 2 ] );
    lb.team = o.team;
    lb.attacker = undefined;
    lb.lifeId = 0;
    lb.currentstate = "ok";
    lN = level.heli_loop_nodes[ randomInt( level.heli_loop_nodes.size ) ];
    lb maps\mp\_helicopter::heli_fly_simple_path( sn );
    lb thread mega_airdrop_crate( lb );
    lb thread maps\mp\_helicopter::heli_fly_loop_path( lN );
    lb thread mega_airdrop_leave( 20 );
}

mega_airdrop_crate( lb ) {
    self endon( "disconnect" );

    for(;;) {
        mega_airdrop_text_wait( 0.1 );
        dC = maps\mp\h2_killstreaks\_airdrop::createAirDropCrate( self.owner, "airdrop_marker_mp", maps\mp\h2_killstreaks\_airdrop::getCrateTypeForDropType( "airdrop_marker_mp" ), lb.origin );
        dC.angles = lb.angles;
        dC PhysicsLaunchServer( ( 0, 0, 0 ), anglestoforward( lb.angles ) * 1 );
        dC thread maps\mp\h2_killstreaks\_airdrop::physicsWaiter( "airdrop_marker_mp", maps\mp\h2_killstreaks\_airdrop::getCrateTypeForDropType( "airdrop_marker_mp" ) );
        mega_airdrop_text_wait( 0.1 );
    }
}

mega_airdrop_leave( t ) {
    self endon( "death" );
    self endon( "helicopter_done" );
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause( T );
    self thread mega_airdrop_exit();
}

mega_airdrop_exit() {
    self notify( "leaving" );
    lN = level.heli_leave_nodes[ randomInt( level.heli_leave_nodes.size ) ];
    self maps\mp\_helicopter::heli_reset();
    self Vehicle_SetSpeed( 100, 45 );
    self setvehgoalpos( lN.origin, 1 );
    self waittillmatch( "goal" );
    self notify( "death" );
    mega_airdrop_text_wait( 0.05 );
    self delete();
}

mega_airdrop_text( l, m, c ) {
    self endon( "std" );
    P = maps\mp\gametypes\_hud_util::createServerFontString( "hudbig", 1.2 );
    P maps\mp\gametypes\_hud_util::setPoint( "CENTER", "CENTER", 0, -40 );
    P.sort = 1001;
    P.color = ( c );
    P iPrintlnBold( l );
    P.foreground = false;
    P1 = maps\mp\gametypes\_hud_util::createServerFontString( "hudbig", 1.4 );
    P1 maps\mp\gametypes\_hud_util::setPoint( "CENTER", "CENTER", 0, 0 );
    P1.sort = 1001;
    P1.color = ( c );
    P1.foreground = false;
    P1 setTimer( m );
    self thread mega_airdrop_text_destroy( m, P, P1 );
    P1 maps\mp\gametypes\_hud::fontPulseInit();
    while( 1 ) {
        self playSound( "ui_mp_nukebomb_timer" );
        mega_airdrop_text_wait( 1 );
    }
}

mega_airdrop_text_destroy( m, a, b ) {
    wait( m );
    self notify( "std" );
    a destroy();
    b destroy();
}

mega_airdrop_text_wait( V ) {
    wait( V );
}

super_ac130() {
    self iPrintln( "^:Super AC-130 Inbound!" );
    owner = self;
    startNode = level.heli_start_nodes[ randomInt( level.heli_start_nodes.size ) ];
    heliOrigin = startnode.origin;
    heliAngles = startnode.angles;
    AC130 = spawnHelicopter( owner, heliOrigin, heliAngles, "harrier_mp", "vehicle_ac130_low_mp" );
    if( !isDefined( AC130 ) )return;
    AC130 playLoopSound( "veh_b2_dist_loop" );
    AC130 maps\mp\_helicopter::addToHeliList();
    AC130.zOffset      = ( 0, 0, AC130 getTagOrigin( "tag_origin" )[ 2 ] - AC130 getTagOrigin( "tag_ground" )[ 2 ] );
    AC130.team         = owner.team;
    AC130.attacker     = undefined;
    AC130.lifeId       = 0;
    AC130.currentstate = "ok";
    AC130 thread maps\mp\_helicopter::heli_leave_on_disconnect( owner );
    AC130 thread maps\mp\_helicopter::heli_leave_on_changeTeams( owner );
    AC130 thread maps\mp\_helicopter::heli_leave_on_gameended( owner );
    AC130 endon( "helicopter_done" );
    AC130 endon( "crashing" );
    AC130 endon( "leaving" );
    AC130 endon( "death" );
    attackAreas = getEntArray( "heli_attack_area", "targetname" );
    loopNode = level.heli_loop_nodes[ randomInt( level.heli_loop_nodes.size ) ];
    AC130 maps\mp\_helicopter::heli_fly_simple_path( startNode );
    AC130 thread super_ac130_timeout( 100 );
    AC130 thread maps\mp\_helicopter::heli_fly_loop_path( loopNode );
    AC130 thread super_ac130_bomb( owner );
}

super_ac130_bomb( owner ) {
    self endon( "death" );
    self endon( "helicopter_done" );
    level endon( "game_ended" );
    self endon( "crashing" );
    self endon( "leaving" );

    waittime = 5;
    for(;;) {
        wait( waittime );
        AimedPlayer = undefined;

        foreach( player in level.players ) {
            if( ( player == owner ) || ( !isAlive( player ) ) || ( level.teamBased && owner.pers[ "team" ] == player.pers[ "team" ] ) || ( !bulletTracePassed( self getTagOrigin( "tag_origin" ), player getTagOrigin( "back_mid" ), 0, self ) ) )
                continue;
            if( isDefined( AimedPlayer ) ) {
                if( closer( self getTagOrigin( "tag_origin" ), player getTagOrigin( "back_mid" ), AimedPlayer getTagOrigin( "back_mid" ) ) )AimedPlayer = player;
            }
            else {
                AimedPlayer = player;
            }
        }
        if( isDefined( AimedPlayer ) ) {
            AimLocation = ( AimedPlayer getTagOrigin( "back_mid" ) );
            Angle       = VectorToAngles( AimLocation - self getTagOrigin( "tag_origin" ) );
            MagicBullet( "ac130_105mm_mp", self getTagOrigin( "tag_origin" ) - ( 0, 0, 180 ), AimLocation, owner );
            wait 0.3;
            MagicBullet( "ac130_40mm_mp", self getTagOrigin( "tag_origin" ) - ( 0, 0, 180 ), AimLocation, owner );
            wait 0.3;
            MagicBullet( "ac130_40mm_mp", self getTagOrigin( "tag_origin" ) - ( 0, 0, 180 ), AimLocation, owner );
        }
    }
}

super_ac130_timeout( t ) {
    self endon( "death" );
    self endon( "helicopter_done" );
    maps\mp\gametypes\_hostmigration::waitLongDurationWithHostMigrationPause( T );
    self thread super_ac130_leave();
}

super_ac130_leave() {
    self notify( "leaving" );
    leaveNode = level.heli_leave_nodes[ randomInt( level.heli_leave_nodes.size ) ];
    self maps\mp\_helicopter::heli_reset();
    self Vehicle_SetSpeed( 100, 45 );
    self setvehgoalpos( leaveNode.origin, 1 );
    self waittillmatch( "goal" );
    self notify( "death" );
    wait 0.05;
    self stopLoopSound();
    self delete();
}

strafe_run_init() {
    if( !level.AwaitingPreviousStrafe ) {
        Location = user_scripts\mp\scripts\util::location_selector();
        self iPrintln( "^:Strafing Run Inbound!" );
        level.AwaitingPreviousStrafe = true;
        locationYaw = 180;
        flightPath1 = strafe_run_path( Location, locationYaw, 0 );
        flightPath2 = strafe_run_path( Location, locationYaw, -620 );
        flightPath3 = strafe_run_path( Location, locationYaw, 620 );
        flightPath4 = strafe_run_path( Location, locationYaw, -1140 );
        flightPath5 = strafe_run_path( Location, locationYaw, 1140 );
        level thread strafe_run_move( self, flightPath1 );
        wait 0.3;
        level thread strafe_run_move( self, flightPath2 );
        level thread strafe_run_move( self, flightPath3 );
        wait 0.3;
        level thread strafe_run_move( self, flightPath4 );
        level thread strafe_run_move( self, flightPath5 );
        wait 60;
        level.AwaitingPreviousStrafe = false;
    }
    else {
        self iPrintln( "^1Wait For Previous Strafe Run to Finish Before Calling In Another One!" );
    }
}

strafe_run_move( owner, flightPath ) {
    level endon( "game_ended" );

    if( !isDefined( owner ) )
    return;
    forward = vectorToAngles( flightPath[ "end" ] - flightPath[ "start" ] );
    StrafeHeli = strafe_run_spawn( owner, flightPath[ "start" ], forward );
    StrafeHeli thread strafe_run_attack();
    StrafeHeli setYawSpeed( 120, 60 );
    StrafeHeli Vehicle_SetSpeed( 48, 4 );
    StrafeHeli setVehGoalPos( flightPath[ "end" ], 0 );
    StrafeHeli waittill( "goal" );
    StrafeHeli setYawSpeed( 30, 40 );
    StrafeHeli Vehicle_SetSpeed( 32, 32 );
    StrafeHeli setVehGoalPos( flightPath[ "start" ], 0 );
    wait 2;
    StrafeHeli setYawSpeed( 100, 60 );
    StrafeHeli Vehicle_SetSpeed( 64, 64 );
    StrafeHeli waittill( "goal" );
    self notify( "chopperdone" );
    StrafeHeli delete();
}

strafe_run_attack() {
    self endon( "chopperdone" );

    self setVehWeapon( self.defaultweapon );
    for( ;; ) {
        for( i = 0; i < level.players.size; i++ ) {
            if( strafe_run_target( level.players[ i ] ) ) {
                self setturrettargetent( level.players[ i ] );
                self FireWeapon( "tag_flash", level.players[ i ] );
            }
        }
        wait 0.5;
    }
}

strafe_run_spawn( owner, origin, angles ) {
    Team = owner.pers[ "team" ];
    SentryGun = spawnHelicopter( owner, origin, angles, "cobra_mp", "vehicle_little_bird_armed" );
    SentryGun.team = Team;
    SentryGun.pers[ "team" ] = Team;
    SentryGun.owner = owner;
    SentryGun.currentstate = "ok";
    SentryGun setdamagestage( 4 );
    SentryGun.killCamEnt = SentryGun;
    return SentryGun;
}

strafe_run_target( player ) {
    CanTarget = true;
    if( !IsAlive( player ) || player.sessionstate != "playing" )
        return false;
    if( distance( player.origin, self.origin ) > 5000 )
        return false;
    if( !isDefined( player.pers[ "team" ]) )
        return false;
    if( level.teamBased && player.pers[ "team" ] == self.team )
        return false;
    if( player == self.owner )
        return false;
    if( player.pers[ "team" ] == "spectator" )
        return false;
    if( !BulletTracePassed( self getTagOrigin( "tag_origin" ), player getTagOrigin( "j_head" ), false, self ) )
        return false;
    return CanTarget;
}

strafe_run_path( location, locationYaw, rightOffset ) {
    location = location * ( 1, 1, 0 );
    initialDirection = ( 0, locationYaw, 0 );
    planeHalfDistance = 12000;
    flightPath = [];
    if( isDefined( rightOffset ) && rightOffset != 0 ) {
        location = location + ( AnglesToRight( initialDirection ) * rightOffset ) + ( 0, 0, RandomInt( 300 ) );
        startPoint = ( location + ( AnglesToForward( initialDirection ) * ( -1 * planeHalfDistance ) ) );
        endPoint = ( location + ( AnglesToForward( initialDirection ) * planeHalfDistance ) );
        flyheight = 1500;
        flightPath[ "start" ] = startPoint + ( 0, 0, flyHeight );
        flightPath[ "end" ] = endPoint + ( 0, 0, flyHeight );
        return flightPath;
    }
}

mounted_turret() {
    self iPrintln( "^:Mounted Turret Spawned!" );
    mounted_turret = spawnTurret( "misc_turret", self.origin, "pavelow_minigun_mp" );
    mounted_turret setModel( "weapon_minigun" );
    mounted_turret.owner = self.owner;
    mounted_turret.team = self.team;
    mounted_turret SetBottomArc( 360 );
    mounted_turret SetTopArc( 360 );
    mounted_turret SetLeftArc( 360 );
    mounted_turret SetRightArc( 360 );
}

bounce_create() {
    if( !isDefined( level.bounce_amount ) )
        level.bounce_amount = 0;
    if( !isDefined( level.bounce_limit ) )
        level.bounce_limit = 10;
    if( level.bounce_amount >= level.bounce_limit )
        self thread bounce_delete();
    level.BL[ level.bounce_amount ] = self.origin;
    level.bounce_amount++;
    self iPrintln( "^:Fake Bounce ^2Spawned!" );
    foreach( player in level.players )
        player notify( "BounceCreated" );
}

bounce_delete() {
    if( !isDefined( level.bounce_amount ) )
        level.bounce_amount = 0;
    if( !isDefined( level.bounce_limit ) )
        level.bounce_limit = 10;
    for( i = 0; i < level.bounce_amount; i++ )
        level.BL[ i ] destroy();
    level.bounce_amount = 0;
    self iPrintln( "^:Fake Bounces ^1Deleted!" );
}

bounce_monitor() {
    self endon( "disconnect" );
    self waittill( "BounceCreated" );

    for(;;) {
        for( i = 0; i < level.bounce_amount; i++ ) {
            if( distance( self.origin, level.BL[ i ] ) < 85 ) {
                self setVelocity( self getVelocity() + ( 0, 0, 350 ) );
            }
            wait 0.05;
        }
        wait 0.05;
    }
}

rain_model_toggle( model ) {
    if( level.rain_model_toggle == false ) {
        self thread rain_model( model );
        level.rain_model_toggle = true;
        self iPrintln( "^:Model Rain: ^7[^2On^7]" );
    }
    else {
        self notify( "Stop_RM" );
        level.rain_model_toggle = false;
        self iPrintln( "^:Model Rain: ^7[^1Off^7]" );
    }
}

rain_model( model ) {
    self endon( "Stop_RM" );
    self endon( "gameStart" );

    lr = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
    lc = user_scripts\mp\scripts\util::get_above_buildings( lr );
    for(;;) {
        Z = 2000;
        X = randomintrange( -3000, 3000 );
        Y = randomintrange( -3000, 3000 );
        l= lr + ( x, y, z );
        bomb = spawn( "script_model", l );
        bomb setModel( model );
        bomb.angles = bomb.angles + ( 90, 90, 90 );
        bomb moveto( bomb.origin - ( 0, 0, 2012 ), 5, 0 );
        bomb thread user_scripts\mp\scripts\util::delete_after_time( 10 );
        wait 0.2;
    }
}