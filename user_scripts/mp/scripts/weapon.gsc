//todo: refactor, add comments
give_weapon( weapon ) {
	self giveWeapon( weapon );
    wait 0.05;
	self switchToWeapon( weapon );
	self iprintln( "^:" + weapon + " added!" );
}

give_current_weapon( selected ) {
    weapon = self getCurrentWeapon();
    selected giveWeapon( weapon );
    selected switchToWeapon( weapon );
    self iprintln( "^:" + weapon + " ^2given to: " + "^7" + selected.name );
}

give_loadout( primary, secondary, lethal, equipment ) {
    self takeAllWeapons();
    self user_scripts\mp\scripts\player::remove_all_perks();
    self user_scripts\mp\scripts\player::give_sniper_perks();
    self giveWeapon( primary );
    self setWeaponAmmoStock( primary, 999 );
    self giveMaxAmmo( primary );
    self giveWeapon( secondary );
    self setWeaponAmmoClip( secondary, 0 );
    self setWeaponAmmoStock( secondary, 0 );
    self setWeaponAmmoClip( secondary, 0, "left" );
    self setWeaponAmmoStock( secondary, 0, "left" );
    self setLethalWeapon( lethal );
    self giveWeapon( lethal );
    self setWeaponAmmoStock( lethal, 99 );
    self giveMaxAmmo( lethal );
    self setTacticalWeapon( equipment );
    self giveWeapon( equipment );
    self setWeaponAmmoStock( equipment, 99 );
    self giveMaxAmmo( equipment );
    wait 0.05;
    self switchToWeapon( primary );
}

set_weapon( weapon ) {
    self.set_weapon = weapon;
    self iprintln( "^:Weapon Set To: " + weapon );
}

set_camo( camo ) {
    self.set_camo = camo;
    self iprintln( "^:Camo Set To: " + camo );
}

set_attachment( attachment, slot ) {
    if( !isDefined( self.attachments ) || self.attachments.size != 4 )
        self.attachments = [ "", "", "", "" ];
    self.attachments[ slot ] = attachment;
    self iprintln( "^:Attachment Slot " + ( slot + 1 ) + " Set: " + attachment );
}

build_weapon() {
    if( !isDefined( self.set_weapon ) ) {
        currentWeap = self getCurrentWeapon();
        currentWeapBase = self maps\mp\_utility::getBaseWeaponName( currentWeap );
        currentWeapName = currentWeapBase + "_mp";
        self.set_weapon = currentWeapName;
    }
    if( !isDefined( self.attachments ) )
        self.attachments = [];
    if( !isDefined( self.set_camo ) )
        self.set_camo = "";
    if( IsDefined( self.attachments ) )
        self.attachments = common_scripts\utility::alphabetize( self.attachments );
    weapon_build = self.set_weapon;
    for( i = 0; i < self.attachments.size; i++ ) {
        attachment = self.attachments[ i ];
        if( isDefined( attachment ) && attachment != "" && attachment != "none" )
            weapon_build += "_" + attachment;
    }
    if( isDefined( self.set_camo ) && self.set_camo != "" )
        weapon_build += "_" + self.set_camo;
    self takeWeapon( self.currentWeap );
    self giveWeapon( weapon_build );
    wait 0.05;
    self switchToWeapon( weapon_build );
    self iPrintln( "^:" + weapon_build + " added!" );
    self user_scripts\mp\source\custom_structure::close_menu();
}

give_ammo() {
    weapon = self getCurrentWeapon();
    offhand = self getCurrentOffhand();

    self setWeaponAmmoStock( weapon, 999 );
    self setWeaponAmmoStock( offhand, 999 );

    self GiveMaxAmmo( weapon );
    self GiveMaxAmmo( offhand );
}

infinite_ammo_toggle() {
    self.infinite_ammo_toggle = !( isdefined( self.infinite_ammo_toggle ) && self.infinite_ammo_toggle );

    if( level.infinite_ammo_toggle == false ) {
        level.infinite_ammo_toggle = true;
        self iPrintln( "^:Infinite Ammo: ^7[^2On^7]" );
        while( level.infinite_ammo_toggle == true ) {
            weapon = self GetCurrentWeapon();
            self setWeaponAmmoStock( weapon, weaponmaxammo( weapon ) );
            self setWeaponAmmoClip( weapon, weaponClipSize( weapon ) );
            self setWeaponAmmoClip( weapon, weaponClipSize( weapon ), "left" );
            self common_scripts\utility::waittill_any( "weapon_fired" );
        }
    }
    else {
        level.infinite_ammo_toggle = false;
        self iPrintln( "^:Infinite Ammo: ^7[^1Off^7]" );
    }
}

take_weapon() {
    weapon = self getCurrentWeapon();

    self takeWeapon( weapon );
    self iprintln( "^:" + weapon + " removed" );
}

take_all_weapons() {
    self takeAllWeapons();
}

reset_weapon() {
    weapon = self getCurrentWeapon();
    weaponbase = self maps\mp\_utility::getBaseWeaponName( weapon );
    newWeapon = weaponbase + "_mp";
    if( newWeapon == weapon ) {
        self giveWeapon( newWeapon );
        self switchToWeapon( newWeapon );
        self iprintln( "^:Weapon reset" );
    }
    else {
        self giveWeapon( newWeapon );
        self takeWeapon( weapon );
        self switchToWeapon( newWeapon );
        self iprintln( "^:Weapon reset" );
    }
}

give_killstreak( killstreak ) {
    self maps\mp\gametypes\_hardpoints::giveHardpoint( killstreak );
    self iprintln( "^:Killstreak Given: " + killstreak );
}

give_equipment( equipment ) {
    self settacticalweapon( equipment );
    self setweaponammoclip( equipment, 99 );
    self GiveMaxAmmo( equipment );
    self iprintln( "^:Equipment Given: " + equipment );
}

give_lethal( lethal ) {
    self setlethalweapon( lethal );
    self setweaponammoclip( lethal, 99 );
    self GiveMaxAmmo( lethal );
    self iprintln( "^:Lethal Given: " + lethal );
}

rapid_fire_toggle() {
    self endon( "endRapid" );

    self.rapid_fire_toggle = !( isdefined( self.rapid_fire_toggle ) && self.rapid_fire_toggle );

    if( level.rapid_fire_toggle == false ) {
        level.rapid_fire_toggle = true;
        self maps\mp\_utility::giveperk( "specialty_fastreload", 0 );
        setDvar( "perk_weapReloadMultiplier", 0.0001 );
        self iPrintln( "^:Rapid Fire: ^7[^2On^7]" );
        self iPrintln( "^:Hold [{+reload}] & [{+attack}]! " );
        while( 1 ) {
            self setWeaponAmmoStock( self getCurrentWeapon(), 999 );
            wait 0.05;
        }
    }
    else {
        level.rapid_fire_toggle = false;
        setDvar( "perk_weapReloadMultiplier", 0.5 );
        self iPrintln( "^:Rapid Fire: ^7[^1Off^7]" );
        self notify ( "endRapid" );
    }
}

no_recoil_toggle() {
    self endon( "disconnect" );

    self.no_recoil_toggle = !( isdefined( self.no_recoil_toggle ) && self.no_recoil_toggle );

    if( level.no_recoil_toggle == false ) {
        maps\mp\_utility::setrecoilscale( 100, 0 );
        level.no_recoil_toggle = true;
        self iPrintln( "^:No Recoil: ^7[^2On^7] ^1( bugged, doesn't turn off )" );
    }
    else {
        maps\mp\_utility::setrecoilscale( 0, 0 );
        level.no_recoil_toggle = false;
        self iPrintln( "^:No Recoil: ^7[^1Off^7] ^1( bugged, doesn't turn off )" );
    }
}

no_spread_toggle() {
    self endon( "disconnect" );

    self.no_spread_toggle = !( isdefined( self.no_spread_toggle ) && self.no_spread_toggle );

    if( level.no_spread_toggle == false ) {
        level.no_spread_toggle = true;
        self maps\mp\_utility::giveperk( "specialty_bulletaccuracy", 0 );
        setdvar( "perk_weapSpreadMultiplier", 0.0001 );
        self iPrintln( "^:No Spread: ^7[^2On^7]" );
    }
    else {
        level.no_spread_toggle = false;
        setdvar( "perk_weapSpreadMultiplier", 0.65 );
        self iPrintln( "^:No Spread: ^7[^1Off^7]" );
    }
}

wallbang_toggle() {
    self endon( "disconnect" );

    self.wallbang_toggle = !( isdefined( self.wallbang_toggle ) && self.wallbang_toggle );

    if( level.wallbangs == false ) {
        setdvar( "bg_surfacePenetration", 9999 );
        setdvar( "perk_bulletPenetrationMultiplier", 30 );
        setdvar( "perk_armorPiercing", 9999 );
        self maps\mp\_utility::giveperk( "specialty_armorpiercing", 0 );
        self maps\mp\_utility::giveperk( "specialty_stopping_power", 0 );
        self maps\mp\_utility::giveperk( "specialty_bulletdamage", 0 );
        self iPrintln( "^:Wallbang All: ^7[^2On^7]" );
        level.wallbangs = true;
    }
    else {
        setdvar( "bg_surfacePenetration", 0 );
        setdvar( "perk_bulletPenetrationMultiplier", 2 );
        setdvar( "perk_armorPiercing", 40 );
        self iPrintln( "^:Wallbang All: ^7[^1Off^7]" );
        level.wallbangs = false;
    }
}

quake_rounds_toggle() {
    self endon( "disconnect" );
    self endon( "endQuakeRounds" );

    self.quake_rounds_toggle = !( isdefined( self.quake_rounds_toggle ) && self.quake_rounds_toggle );

    if( level.quake_rounds_toggle == false ) {
        level.quake_rounds_toggle = true;
        self iPrintln( "^:Earthquake Rounds: ^7[^2On^7]" );
        for(;;) {
            self waittill( "weapon_fired" );
            earthquake( 0.5, 1, self.origin, 90 );
            radiusDamage( 150, 300, 100, self );
            earthquake( 1.5, 1, 90 );
        }
    }
    else {
        level.quake_rounds_toggle = false;
        self iPrintln( "^:Earthquake Rounds: ^7[^1Off^7]" );
        self notify( "endQuakeRounds" );
    }
}

bullet_ricochet_toggle() {
    self endon( "disconnect" );
    self endon( "endRicochet" );

    self.bullet_ricochet_toggle = !( isdefined( self.bullet_ricochet_toggle ) && self.bullet_ricochet_toggle );

    if( level.bullet_ricochet_toggle == false ) {
        level.bullet_ricochet_toggle = true;
        self iPrintln( "^:Bullet Ricochet: ^7[^2On^7]" );
        for(;;) {
            self waittill( "weapon_fired" );
            self thread bullet_ricochet_reflect( 30, self getcurrentweapon() );
        }
    }
    else {
        level.bullet_ricochet_toggle = false;
        self iPrintln( "^:Bullet Ricochet: ^7[^1Off^7]" );
        self notify( "endRicochet" );
    }
}

bullet_ricochet_reflect( times, weapon ) {
    incident = anglestoforward( self getplayerangles() );
    trace = bullettrace( self geteye(), self geteye() + incident * 100000, 0, self );
    reflection = incident - ( 2 * trace[ "normal" ] * vectordot( incident, trace[ "normal" ] ) );
    magicbullet( weapon, trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ) );
    wait 0.05;
    for( i = 0; i < times - 1; i++ ) {
        trace = bullettrace( trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ), 0, self );
        incident = reflection;
        reflection = incident - ( 2 * trace[ "normal" ] * vectordot( incident, trace[ "normal" ] ) );
        magicbullet( weapon, trace[ "position" ], trace[ "position" ] + ( reflection * 100000 ) );
        wait 0.05;
    }
}

infinite_equipment_toggle() {
    self.infinite_equipment_toggle = !( isdefined( self.infinite_equipment_toggle ) && self.infinite_equipment_toggle );

    if( level.infinite_equipment_toggle == false ) {
        level.infinite_equipment_toggle2 = true;
        level.infinite_equipment_toggle = true;
        self iPrintln( "^:Infinite Equipment: ^7[^2On^7]" );
        while( isdefined( level.infinite_equipment_toggle2 ) ) {
            foreach( weapon in self getweaponslistall() ) {
                if( user_scripts\mp\scripts\util::is_offhand( weapon ) && self getweaponammoclip( weapon ) != 1 )
                    self setweaponammoclip( weapon, 1 );
                if( issubstr( weapon, "alt" ) && issubstr( weapon, "gl" ) && self getweaponammoclip( weapon ) != weaponmaxammo( weapon ) )
                    self setweaponammoclip( weapon, weaponmaxammo( weapon ) );

                if( weapon == "h1_rpg_mp" && self getweaponammoclip( weapon ) != weaponmaxammo( weapon ) ) {
                    self setweaponammoclip( weapon, weaponclipsize( weapon ) );
                    self setweaponammostock( weapon, 4 );
                }
            }
            self common_scripts\utility::waittill_any( "grenade_fire", "missile_fire" );
        }
    }
    else {
        level.infinite_equipment_toggle2 = undefined;
        level.infinite_equipment_toggle = false;
        self iPrintln( "^:Infinite Equipment: ^7[^1Off^7]" );
    }
}

weapon_projectile( projectile ) {
    self endon( "disconnect" );

    if( projectile != "Default" && level.custom_proj == false ) {
        self iPrintln( "^:Custom Projectile Set: " + projectile );
        self endon( "disconnect" );
        self endon( "defaultproj" );
        self endon( "newproj" );
        self notify( "newproj2" );
        level.custom_proj = true;
        for(;;) {
            self waittill( "weapon_fired" );
            forward = self getTagOrigin( "j_head" );
	        end = self thread user_scripts\mp\scripts\util::vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
	        location = BulletTrace( forward, end, 0, self )[ "position" ];
            MagicBullet( projectile, self getTagOrigin("tag_eye"), location, self );
        }
	}
	else if( projectile != "Default" && level.custom_proj == true ) {
        self notify( "newproj" );
        self endon( "defaultproj" );
        self endon( "newproj2" );
        self iPrintln( "^:Custom Projectile Set: " + projectile );
        level.custom_proj = false;
        for(;;) {
            self waittill( "weapon_fired" );
            forward = self getTagOrigin( "j_head" );
	        end = self thread user_scripts\mp\scripts\util::vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
	        location = BulletTrace( forward, end, 0, self )[ "position" ];
            MagicBullet( projectile, self getTagOrigin( "tag_eye" ), location, self );
        }
	}
    else {
        self notify( "defaultproj" );
        self iPrintln( "^:Custom Projectile: ^7[^1Off^7]" );
    }
}

explosive_rounds_toggle() {
    self endon( "disconnect" );
    self endon( "ExplosiveRoundsEnd" );

    self.explosive_rounds_toggle = !( isdefined( self.explosive_rounds_toggle ) && self.explosive_rounds_toggle );

    if( level.explosive_rounds_toggle == false ) {
        level.explosive_rounds_toggle = true;
        self iPrintln( "^:Explosive Rounds: ^7[^2On^7]" );
        for(;;) {
            self waittill ( "weapon_fired" );
            forward = self getTagOrigin( "j_head" );
            end = self thread user_scripts\mp\scripts\util::vec_scal( anglestoforward ( self getPlayerAngles() ), 1000000 );
            SPLOSIONlocation = BulletTrace( forward, end, 0, self )[ "position" ];
            self playsound( "h1_wpn_rpg_exp_default" );
            playfx( level._effect[ "frag_grenade_default" ], SPLOSIONlocation );
            RadiusDamage( SPLOSIONlocation, 180, 180, 180, self );
        }
    }
    else {
        level.explosive_rounds_toggle = false;
        self iPrintln( "^:Explosive Rounds: ^7[^1Off^7]" );
        self notify( "ExplosiveRoundsEnd" );
    }
}

shotgun_rounds_toggle() {
    self endon( "disconnect" );
    self endon( "ShotgunRoundsEnd" );

    self.shotgun_rounds_toggle = !( isdefined( self.shotgun_rounds_toggle ) && self.shotgun_rounds_toggle );

    if( level.shotgun_rounds_toggle == false ) {
        level.shotgun_rounds_toggle = true;
        self iPrintln( "^:Shotgun Rounds: ^7[^2On^7]" );
        for(;;) {
            self waittill( "weapon_fired" );
            MagicBullet( "h2_spas12_mp", self getEye(), self user_scripts\mp\scripts\util::trace_bullet(), self );
            MagicBullet( "h2_spas12_mp", self getEye(), self user_scripts\mp\scripts\util::trace_bullet(), self );
            MagicBullet( "h2_spas12_mp", self getEye(), self user_scripts\mp\scripts\util::trace_bullet(), self );
        }
    }
    else {
        level.shotgun_rounds_toggle = false;
        self iPrintln( "^:Shotgun Rounds: ^7[^1Off^7]" );
        self notify( "ShotgunRoundsEnd" );
    }
}

weapon_reticle() {
    //todo
}

mustang_sally() {
    self endon( "death" );

    self iPrintln( "^:Mustang and Sally added!" );
    self giveWeapon( "h2_colt45_mp_akimbo_xmagmwr_camo036" );
    self switchToWeapon( "h2_colt45_mp_akimbo_xmagmwr_camo036" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon() == "h2_colt45_mp_akimbo_xmagmwr_camo036" ) {
            forward = self getTagOrigin( "tag_eye" );
            end = self thread user_scripts\mp\scripts\util::vec_scal( anglestoforward( self getPlayerAngles() ), 1000000 );
            location = BulletTrace( forward, end, 0, self )[ "position" ];
            MagicBullet( "h2_m79_mp", forward, location, self );
        }
        wait 0.05;
    }
}

death_machine() {
    self endon( "disconnect" );

    self iprintlnBold( "^1Death Machine Ready." );
    self attach( "weapon_minigun", "tag_weapon_left", 0 );
    self giveWeapon( "defaultweapon_mp" );
    self switchToWeapon( "defaultweapon_mp" );
    self.bullets = 998;
    self.notshown = false;
    self.ammoDeathMachine = spawnstruct();
    self.ammoDeathMachine = self maps\mp\gametypes\_hud_util::CreateFontString( "default", 2.0 );
    self.ammoDeathMachine maps\mp\gametypes\_hud_util::setPoint( "TOPRIGHT", "TOPRIGHT", -20, 40 );
    for(;;) {
        if( self AttackButtonPressed() && self getCurrentWeapon() == "defaultweapon_mp" ) {
            self.notshown = false;
            self allowADS( false );
            self.bullets--;
            self.ammoDeathMachine setValue( self.bullets );
            self.ammoDeathMachine.color = ( 0, 1, 0 );
            tagorigin = self getTagOrigin( "tag_weapon_left" );
            firing = user_scripts\mp\scripts\util::cursor_pos();
            x = randomIntRange( -50, 50 );
            y = randomIntRange( -50, 50 );
            z = randomIntRange( -50, 50 );
            MagicBullet( "ac130_25mm_mp", tagorigin, firing + ( x, y, z ), self );
            self setWeaponAmmoClip( "defaultweapon_mp", 100, "left" );
            self setWeaponAmmoClip( "defaultweapon_mp", 100, "right" );
        }
        else {
            if( self.notshown == false ) {
                self.ammoDeathMachine setText( " " );
                self.notshown = true;
            }
            self allowADS( true );
        }
        if( self.bullets == 0 ) {
            self takeWeapon( "defaultweapon_mp" );
            self.ammoDeathMachine destroy();
            self allowADS( true );
            break;
        }
        if( !isAlive( self ) ) {
            self.ammoDeathMachine destroy();
            self allowADS( true );
            break;
        }
        wait 0.07;
    }
}

teleport_gun() {
    self endon( "death" );

    self iPrintln( "^:Teleport Gun added!" );
    self giveWeapon( "h2_m40a3_mp_ogscope_xmagmwr_camo025" );
    self switchToWeapon( "h2_m40a3_mp_ogscope_xmagmwr_camo025" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon() == "h2_m40a3_mp_ogscope_xmagmwr_camo025" ) {
            vec2 = anglestoforward( self getPlayerAngles() );
            e1nd = ( vec2[ 0 ] * 200000, vec2[ 1 ] * 200000, vec2[ 2 ] * 200000 );
            BulletLocation = BulletTrace( self gettagorigin( "tag_eye" ), self gettagorigin( "tag_eye" ) + e1nd, 0, self )[ "position" ];
            self SetOrigin( BulletLocation );
        }
        wait 0.05;
    }
}

care_package_gun() {
    self endon( "death" );

    self iPrintln( "^:Care Package gun added!" );
    self giveWeapon( "h2_m40a3_mp_silencerlmg_xmagmwr_camo033" );
    self SwitchToWeapon( "h2_m40a3_mp_silencerlmg_xmagmwr_camo033" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon()=="h2_m40a3_mp_silencerlmg_xmagmwr_camo033" ) {
            dropCrate = maps\mp\h2_killstreaks\_airdrop::createAirDropCrate( self.owner, "airdrop_marker_mp", maps\mp\h2_killstreaks\_airdrop::getCrateTypeForDropType( "airdrop_marker_mp" ), self geteye() + anglestoforward( self getplayerangles() ) * 70 );
            dropCrate.angles = self getplayerangles();
            dropCrate PhysicsLaunchServer( ( 0, 0, 0 ), anglestoforward( self getplayerangles() ) * 1000 );
            dropCrate thread maps\mp\h2_killstreaks\_airdrop::physicsWaiter( "airdrop_marker_mp", maps\mp\h2_killstreaks\_airdrop::getCrateTypeForDropType( "airdrop_marker_mp" ) );
        }
    }
}

nuke_at4() {
    self endon ( "disconnect" );
    self endon ( "death" );

    self iPrintln( "^:Nuke AT4 added" );
    self giveWeapon( "at4_mp" );
    self switchToWeapon( "at4_mp" );
    for(;;) {
        self waittill ( "weapon_fired" );
        if( self getCurrentWeapon() == "at4_mp" ) {
            if( level.teambased )
                thread maps\mp\_utility::teamPlayerCardSplash( "used_nuke", self, self.team );
            else
                self iprintlnbold( &"MP_FRIENDLY_TACTICAL_NUKE" );
            wait 1;
            me2 = self;
            level thread nuke_sound();
            level thread nuke_fx( me2 );
            level thread nuke_slow_mo();
            wait 1.5;
            foreach( player in level.players )
                if( player.name != me2.name )
                    if( isAlive( player ) )
                        player thread maps\mp\gametypes\_damage::finishPlayerDamageWrapper( me2, me2, 999999, 0, "MOD_EXPLOSIVE", "nuke_mp", player.origin, player.origin, "none", 0, 0 );
            wait 0.1;
            level notify ( "done_nuke2" );
            self suicide();
        }
    }
}

nuke_slow_mo() {
    level endon ( "done_nuke2" );
    setSlowMotion( 1.0, 0.25, 0.5 );
}

nuke_fx( me2 ) {
    level endon ( "done_nuke2" );

    foreach( player in level.players ) {
        player thread nuke_slow_mo_fix( player );
        playerForward = anglestoforward( player.angles );
        playerForward = ( playerForward[ 0 ], playerForward[ 1 ], 0 );
        playerForward = VectorNormalize( playerForward );
        nukeDistance = 100;
        nukeEnt = Spawn( "script_model", player.origin + scripts\utility::Vector_Multiply( playerForward, nukeDistance ) );
        nukeEnt setModel( "tag_origin" );
        nukeEnt.angles = ( 0, ( player.angles[ 1 ] + 180 ), 90 );
        nukeEnt thread nuke_fx_2( player );
        player.nuked = true;
    }
}

nuke_slow_mo_fix( player ) {
    player endon( "disconnect" );
    player waittill( "death" );
    setSlowMotion( 0.25, 1, 2.0 );
}

nuke_fx_2( player ) {
    player endon( "death" );
    waitframe();
    PlayFXOnTagForClients( level._effect[ "nuke_flash" ], self, "tag_origin", player );
}

nuke_sound() {
    level endon ( "done_nuke2" );

    foreach( player in level.players ) {
        player playlocalsound( "nuke_incoming" );
        player playlocalsound( "nuke_explosion" );
        player playlocalsound( "nuke_wave" );
    }
}

nova_gas() {
    self endon( "disconnect" );

    self iPrintln( "^:Nova Gas added!" );
    cur = self getCurrentWeapon();
    wait 0.1;
    self giveweapon( "h1_smokegrenade_mp" );
    self SwitchToWeapon( "h1_smokegrenade_mp" );
    self waittill( "grenade_fire", grenade );
    if( self getCurrentWeapon() == "h1_smokegrenade_mp" ) {
        nova = spawn( "script_model", grenade.origin );
        nova setModel( "wpn_h1_grenade_smoke_proj" );
        nova Linkto( grenade );
        wait 1;
        self switchToWeapon( cur );
        for( i = 0; i <= 10; i++ ) {
            RadiusDamage( nova.origin, 300, 100, 50, self );
            wait 1;
        }
        nova delete();
    }
}

grappling_gun() {
    self endon( "death" );

    self iPrintln( "^:Grappling Gun added!" );
    self giveWeapon( "h2_usp_mp_silencersmg_xmagmwr_camo027" );
    self switchToWeapon( "h2_usp_mp_silencersmg_xmagmwr_camo027" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon() == "h2_usp_mp_silencersmg_xmagmwr_camo027" ) {
            endLocSY = user_scripts\mp\scripts\util::trace_bullet();
            self.grappler = spawn( "script_model", self.origin );
            self playerlinkto( self.grappler, undefined );
            self.grappler moveTo( endLocSY, 1 );
            wait 1.02;
            self unlink();
            self.grappler delete();
        }
        wait 0.05;
    }
}

suicide_bomb() {
    self endon( "disconnect" );
    self endon( "death" );

    self iprintlnBold( "^:Press ^1[{+attack}] ^:to Detonate" );
    self waittill( "weapon_fired" );
    for(;;) {
        self iPrintlnBold( "^:Bomb ^1Activated" );
        self takeAllWeapons();
        self giveWeapon( "onemanarmy_mp" );
        self switchToWeapon( "onemanarmy_mp" );
        wait 1;
        foreach( player in level.players ) {
            self playSound( "ui_mp_timer_countdown" );
            wait( 0.4 );
            self playSound( "ui_mp_timer_countdown" );
            wait( 0.4 );
            for( i = 0.4; i > 0; i -= 0.1 ) {
                self playSound( "ui_mp_timer_countdown" );
                wait( i );
                self playSound( "ui_mp_timer_countdown" );
                wait( i );
            }
            playfx( level.chopper_fx[ "explode" ][ "large" ], self.origin );
            player playlocalsound( "nuke_explosion" );
            player playlocalsound( "nuke_wave" );
            RadiusDamage( self.origin, 4000, 4000, 1, self );
            Earthquake( 0.5, 4, self.origin, 800 );
            self suicide();
            wait 8;
        }
    }
}

sonic_boom() {
    self endon( "disconnect" );
    self endon( "WentBoom" );

    self iPrintln( "^1Sonic Boom ^7Ready!" );
    self iPrintln( "^2Created By^7: ^6Cmd-X" );
    self giveWeapon( "h2_usp_mp_fmj_silencerpistol_camo031" );
    wait 0.1;
    //level.harrier_deathfx = loadfx ( "explosions/aerial_explosion_harrier" );
    self switchToWeapon( "h2_usp_mp_fmj_silencerpistol_camo031" );
    self setWeaponAmmoClip( "h2_usp_mp_fmj_silencerpistol_camo031", 1 );
    self setWeaponAmmoStock( "h2_usp_mp_fmj_silencerpistol_camo031", 0 );
    self setClientDvar( "laserForceOn", 1 );
    self iPrintlnBold( "Shoot For Bomb Location!" );
    for(;;) {
        self waittill( "weapon_fired" );
        if( self getCurrentWeapon() == "h2_usp_mp_fmj_silencerpistol_camo031" ) {
            self setClientDvar( "laserForceOn", 0 );
            self takeweapon( "h2_usp_mp_fmj_silencerpistol_camo031" );
            fff2 = self getTagOrigin( "tag_eye" );
            eee2 = self user_scripts\mp\scripts\util::vec_scal( anglestoforward( self getPlayerAngles() ), 10000 );
            ss2 = BulletTrace( fff2, eee2, 0, self )[ "position" ];
            self thread sonic_boom_fx_2();
            SBcmdx = spawn( "script_model", ss2 );
            SBcmdx setModel( "projectile_cbu97_clusterbomb" );
            SBcmdx.angles = ( 270, 270, 270 );
            SBcmdx MoveTo( ss2 + ( 0, 0, 200 ), 5 );
            self thread sonic_boom_rotate( SBcmdx );
            wait 5;
            self thread sonic_boom_fx();
            wait 1;
            playfx( level.stealthbombfx, ss2 );
            PlayFX( level._effect[ "aerial_explosion_large" ], ss2 );
            playFX( level.chopper_fx[ "explode" ][ "large" ], ss2 );
            RadiusDamage( ss2, 900, 900, 900, self );
            SBcmdx delete();
            self notify( "WentBoom" );
            wait 4;
        }
    }
}

sonic_boom_rotate( Val ) {
    self endon( "disconnect" );

    for(;;) {
        Val rotateyaw( -360, 0.3 );
        wait 0.3;
    }
}

sonic_boom_fx() {
    self endon( "disconnect" );

    foreach( player in level.players )
        player thread sonic_boom_fx1();
}

sonic_boom_fx_2() {
    self endon( "disconnect" );

    foreach( player in level.players )
        player thread sonic_boom_fx2();
}

sonic_boom_fx1() {
    self playLocalSound( "mp_killstreak_emp" );
    self VisionSetNakedForPlayer( "cheat_contrast", 1 );
    wait 1;
    self playLocalSound( "nuke_explosion" );
    self VisionSetNakedForPlayer( "cargoship_blast", 0.1 );
    wait 1;
    self VisionSetNakedForPlayer( "mpnuke_aftermath", 2 );
    wait 3;
    self VisionSetNakedForPlayer( getDvar( "mapname" ), 1 );
}

sonic_boom_fx2() {
    self iPrintlnBold( "^3Sonic Boom Incoming!" );
}

raygun_give() {
    if( !isDefined( level.fx_count ) )
        level.fx_count = 0;
    self giveWeapon( "h2_boomhilda_mp_fastfire_xmagmwr_camo029" );
    self switchToWeapon( "h2_boomhilda_mp_fastfire_xmagmwr_camo029" );
    self thread raygun_main();
}

raygun_main() {
    for( ;; ) {
        self waittill( "weapon_fired", weaponName );
        if( self getCurrentWeapon() != "h2_boomhilda_mp_fastfire_xmagmwr_camo029" )
            continue;
        start = self getTagOrigin( "tag_eye" );
        end = self getTagOrigin( "tag_eye" ) + user_scripts\mp\scripts\util::vec_scal( anglestoforward( self getPlayerAngles() ), 100000 );
        trace = bulletTrace( start, end, true, self );
        thread raygun_fx( self getTagOrigin( "tag_eye" ), anglestoforward( self getPlayerAngles() ), trace[ "position" ] );
    }
}

raygun_fx( startPos, direction, endPos ) {
    doDamage = 1;
    for( i = 1; ; i ++ ) {
        pos = startPos + user_scripts\mp\scripts\util::vec_scal( direction, i * 150 );
        if( distance( startPos, pos ) > 9000 ) {
            doDamage = 0;
            break;
        }
        trace = bulletTrace( startPos, pos, true, self );
        if( !bulletTracePassed( startPos, pos, true, self ) ) {
            impactFX = spawnFX( level._effect[ "flare_ambient" ], bulletTrace( startPos, pos, true, self )[ "position" ] );
            level.fx_count++;
            triggerFX( impactFX );
            wait( 0.2 );
            impactFX delete();
            level.fx_count--;
            break;
        }
        laserFX = spawnFX( level._effect[ "aircraft_light_wingtip_red" ], pos );
        level.fx_count++;
        triggerFX( laserFX );
        laserFX thread user_scripts\mp\scripts\util::delete_after_time( 0.1 );
        if( level.fx_count < 200 ) {
            for( j = 0; j < 3; j ++ ) {
                laserFX = spawnFX( level.large_metalhit_1, pos + ( randomInt( 50 ) / 10, randomInt( 50 ) / 10, randomInt( 50 ) / 10 ) - user_scripts\mp\scripts\util::vec_scal( direction, i * randomInt( 10 ) * 3 ) );
                level.fx_count++;
                triggerFX( laserFX );
                laserFX thread user_scripts\mp\scripts\util::delete_after_time( 0.05 + randomInt( 3 ) * 0.05 );
            }
        }
        wait( 0.05 );
    }
    if( doDamage )
        radiusDamage( endPos, 60, 150, 60, self );
}

rocket_nade() {
    self iprintln( "^:Rocket Grenade Added!" );
    self setlethalweapon( "h1_fraggrenade_mp" );
    self SetWeaponAmmoClip( "h1_fraggrenade_mp", 1 );
    self waittill( "grenade_fire", grenade, weaponName );
    if( weaponName == "h1_fraggrenade_mp" ) {
        grenade hide();
        self.rocket_nade = spawn( "script_model", grenade.origin );
        self.rocket_nade setModel( "projectile_hellfire_missile" );
        self.rocket_nade linkTo( grenade );
        self.rocket_nade playSound( "h2_nuke_timer" );
        grenade waittill( "death" );
        self.glow = spawnfx( loadfx( "vfx/explosion/mp_gametype_bomb" ), self.rocket_nade.origin );
        TriggerFX( self.glow );
        radiusDamage( self.rocket_nade.origin, 550, 550, 550, self );
        self.rocket_nade delete();
        self switchToWeapon( self.oldWeapon );
    }
}

use_pred_missile() {
    maps\mp\h2_killstreaks\_remotemissile::tryUsePredatorMissile( self.pers[ "killstreaks" ][ 0 ].lifeId );
}

exploding_crawler() {
    self thread maps\mp\gametypes\_hud_message::hintMessage( "^:Press [{+actionslot 3}] For Exploding Crawler" );
    self notifyOnPlayerCommand( "AS1", "+actionslot 3" );
    self waittill( "AS1" );
    self thread exploding_crawler_main();
}

exploding_crawler_prone() {
    self endon( "death" );
    self endon( "disconnect" );

    while( 1 ) {
        self SetStance( "prone" );
        self SetMoveSpeedScale( 10 );
        wait 0.5;
    }
}

exploding_crawler_main() {
    self setModel( "body_infect" );
    self setviewmodel( "viewhands_infect" );
    self takeAllWeapons();
    self giveweapon( "h2_infect_mp" );
    self switchtoweapon( "h2_infect_mp" );
    //self attach( "weapon_c4_mp", "j_shouldertwist_le", 0 );
    self thread exploding_crawler_prone();
    self SetMoveSpeedScale( 10 );
    self maps\mp\_utility::giveperk( "specialty_class_coldblooded", 0 );
    self maps\mp\_utility::giveperk( "specialty_thermal", 0 );
    self setClientDvar( "friction", 0.5 );
    self setClientDvar( "g_gravity", 500 );
    self iPrintLnBold( "^:Press [[{+activate}]] to explode" );
    self notifyOnPlayerCommand( "AS3", "+activate" );

    self waittill( "AS3" ); {
        MagicBullet( "ac130_105mm_mp", self.origin + ( 0, 0, 1 ), self.origin, self );
        self suicide();
    }
    self notifyOnPlayerCommand( "AS3", "+activate" );
}

rocket_barrage() {
    level.killed_stoners = 0;
    self iprintlnbold( "^:Rocket Barrage ^2Launched" );
    level.mapCenter = maps\mp\gametypes\_spawnlogic::findBoxCenter( level.spawnMins, level.spawnMaxs );
    foreach( player in level.players ) {
        if( isAlive( player ) && !( player ishost() ) ) {
            level.killed_stoners += 1;
            MagicBullet( "remotemissile_projectile_mp", level.mapCenter + ( 0, 0, 4000 ), player getTagOrigin( "j_spineupper" ), self );
        }
    }
    if( level.killed_stoners > 0 )
        self iprintlnbold( "Rocket Barrage Targeted ^1" + level.killed_stoners + "^7 enemies!" );
    if( level.killed_stoners <= 0 )
        self iprintlnbold( "^1Error^7: No enemies found!" );
}

/*
variable_zoom_toggle() {
    self.variable_zoom_toggle = !( isdefined( self.variable_zoom_toggle ) && self.variable_zoom_toggle );

    if( self.variable_zoom == false ) {
        self.variable_zoom = true;
        thread variable_zoom_main();
        self iPrintln( "^:Variable Zoom: ^7[^2On^7]" );
    }
    else {
        for( k = 0; k < 8; k++ )
            if( isDefined( self.zoomElem[ k ]) )
                self.zoomElem[ k ] destroy();
        self.variable_zoom = false;
        self iPrintln( "^:Variable Zoom: ^7[^1Off^7]" );
    }
}

variable_zoom_main() {
    self endon( "lobby_choose" );
    self endon( "disconnect" );

    dvar = [];
    curs = 1;
    elemNames = strTok( "1x;2x;4x;8x;16x;32x;64x", ";" );
    for( k = 0; k < 8; k++ )
        dvar[ 8 - k ] = int( k * 10 );
    while( self.variable_zoom ) {
        while( self adsButtonPressed() && self useButtonPressed() && self playerAds() ) {
            for( k = 0; k < 8; k++ ) {
                if( !isDefined( self.zoomElem[ k ] ) ) {
                    self.zoomElem[ k ] = user_scripts\mp\scripts\util::create_text_2( "default", 1.4, "", "TOP", ( ( k * 40 ) - 120 ), 35, 1, 200, elemNames[ k ] );
                    if( k == curs - 1 )
                        self.zoomElem[ curs - 1 ].color = ( 1, 0, 0 );
                }
            }
            if( self useButtonPressed() ) {
                self playsound( "wpn_dryfire_lmg_plr" );
                self.zoomElem[ curs - 1 ].color = ( 1, 1, 1 );
                curs++;
                if( curs >= dvar.size )
                    curs = 1;
                self.zoomElem[ curs - 1 ].color = ( 1, 0, 0 );
                wait 0.2;
            }
            setDvar( "cg_fovmin", int( dvar[ curs ] ) );
            wait 0.05;
        }
        for( k = 0; k < 8; k++ )
            self.zoomElem[ k ] destroy();
        wait 0.05;
    }
}
*/