#include user_scripts\mp\source\utilities;
#include user_scripts\mp\source\structure;
#include user_scripts\mp\scripts\bot;
#include user_scripts\mp\scripts\game;
#include user_scripts\mp\scripts\player;
//#include user_scripts\mp\scripts\spawn;
#include user_scripts\mp\scripts\team;
#include user_scripts\mp\scripts\util;
#include user_scripts\mp\scripts\weapon;

menu_option() {
    menu = self get_menu();
    switch( menu ) {
        case "Main Menu":
            self add_menu( ( "^:HMW Mod Menu v2.0a" ) );
            self add_option( "Admin Options", undefined, ::new_menu, "^:Admin Options" );
			if( getDvarInt( "hmw_rtd" ) == 1 )
                self add_option( "Roll The Dice Options", undefined, ::new_menu, "^:Roll The Dice Options" );
            self add_option( "Game Options", undefined, ::new_menu, "^:Game Options" );
            self add_option( "Team Options", undefined, ::new_menu, "^:Team Options" );
            self add_option( "Weapon Options", undefined, ::new_menu, "^:Weapon Options" );
            self add_option( "Player Options", undefined, ::new_menu, "^:Player Options" );
            self add_option( "Bot Options", undefined, ::new_menu, "^:Bot Options" );
            self add_option( "Misc Options", undefined, ::new_menu, "^:Misc Options" );
            break;
        case "^:Roll The Dice Options":
            self add_menu( menu );
			self add_option( "New Roll", undefined, user_scripts\mp\scripts\gametypes\rtd::rtd_new_roll, undefined );
			self add_option( "Add Roll", undefined, user_scripts\mp\scripts\gametypes\rtd::rtd_add_roll, undefined );
			self add_increment( "Choose Roll", undefined, user_scripts\mp\scripts\gametypes\rtd::rtd_choose_roll, 0, 0, level.rtd_roll_count, 1 );
            break;
		case "^:Game Options":
            self add_menu( menu );
            self add_option( "Gametype Toggles", undefined, ::new_menu, "^:Gametype Toggles" );
            self add_option( "Gameplay Toggles", undefined, ::new_menu, "^:Gameplay Toggles" );
            self add_option( "Game Functions", undefined, ::new_menu, "^:Game Functions" );
            break;
        case "^:Weapon Options":
            self add_menu( menu );
            self add_option( "Weapon Editor", undefined, ::new_menu, "^:Weapon Editor" );
            self add_option( "Modifiers", undefined, ::new_menu, "^:Weapon Modifiers" );
			self add_option( "Killstreaks", undefined, ::new_menu, "^:Killstreaks" );
			self add_option( "Equipment", undefined, ::new_menu, "^:Equipment" );
			self add_option( "Lethal", undefined, ::new_menu, "^:Lethal" );
            break;
        case "^:Player Options":
            self add_menu( menu );
			self add_option( "Player Toggles", undefined, ::new_menu, "^:Player Toggles" );
            self add_option( "Player Functions", undefined, ::new_menu, "^:Player Functions" );
            break;
        case "^:Player Toggles":
            self add_menu( menu );
			self add_toggle( "God Mode", undefined, ::god_mode, self.god_mode );
			self add_toggle( "Third Person", undefined, ::third_person_toggle, self.third_person_toggle );
			self add_toggle( "UFO Mode", "^:Fly with [{+smoke}] | Land with [{+speed_throw}]", ::ufo_mode_toggle, self.ufo_mode_toggle );
			self add_toggle( "Wallbang", undefined, ::wallbang_toggle, self.wallbang_toggle );
			self add_toggle( "Multi-Jump", undefined, ::multi_jump_toggle, self.multi_jump_toggle );
			self add_toggle( "All Perks", undefined, ::all_perks_toggle, self.all_perks_toggle );
			self add_toggle( "Force Field", undefined, ::forcefield_toggle, self.forcefield_toggle );
			break;
        case "^:Player Functions":
            self add_menu( menu );
			self add_option( "Change Class", undefined, ::change_class, undefined );
			self add_option( "Change Teams", undefined, ::switch_teams, undefined );
			self add_option( "Teleporter", undefined, ::teleporter, undefined );
			self add_option( "Commit Sudoku", undefined, ::kill_urself, undefined );
			break;
		case "^:Trickshot Settings":
            self add_menu( menu );
			self add_toggle( "Inspect Glide", undefined, ::inspect_glide, self.inspect_glide );
			self add_toggle( "Legacy Nacs", undefined, ::legacy_nacs, self.legacy_nacs );
			self add_option( "Save / Load Position", undefined, ::new_menu, "^:Save / Load Position" );
			//self add_option( "Create Fake Bounce", undefined, ::bounce_create, undefined );
			//self add_option( "Delete Fake Bounces", undefined, ::bounce_delete, undefined );
			break;
		case "^:Minimap":
            self add_menu( menu );
			self add_option( "Fireball Minimap", undefined, ::custom_minimap, "gfx_fire_ball_atlas" );
			self add_option( "Spark Minimap", undefined, ::custom_minimap, "gfx_spark_atlas" );
			self add_option( "Red Minimap", undefined, ::custom_minimap, "gfx_spark_burst_green_atlas" );
			self add_option( "Gachi Minimap", undefined, ::custom_minimap, "specialty_oma" );
            break;
		case "^:Admin Options":
            self add_menu( menu );
            self add_option( "All Players", undefined, ::new_menu, "All Players" );
            break;
		case "^:Graphics Options":
            self add_menu( menu );
			self add_toggle( "Pro Mod", undefined, ::pro_mod_toggle, self.pro_mod_toggle );
			self add_toggle( "Thermal Vision", undefined, ::therm_vis_toggle, self.therm_vis_toggle );
			self add_option( "Sun Color", undefined, ::new_menu, "^:Sun Color" );
			self add_option( "Visions", undefined, ::new_menu, "^:Visions" );
			self add_option( "Specular Map", undefined, ::new_menu, "^:Specular Map" );
            break;
		case "^:Visions":
			self add_menu( menu );
			self add_option( "Default", undefined, ::vision_changer, "default" );
			self add_option( "Map Visions", undefined, ::new_menu, "^:Map Visions" );
			self add_option( "Other Visions", undefined, ::new_menu, "^:Other Visions" );
			break;
		case "^:Map Visions":
			self add_menu( menu );
			self add_option( "Default", undefined, ::vision_changer, "default" );
			self add_option( "mp_abandon", undefined, ::vision_changer, "mp_abandon" );
			self add_option( "mp_afghan", undefined, ::vision_changer, "mp_afghan" );
			self add_option( "mp_backlot", undefined, ::vision_changer, "mp_backlot" );
			self add_option( "mp_bloc", undefined, ::vision_changer, "mp_bloc" );
			self add_option( "mp_bog", undefined, ::vision_changer, "mp_bog" );
			self add_option( "mp_boneyard", undefined, ::vision_changer, "mp_boneyard" );
			self add_option( "mp_brecourt", undefined, ::vision_changer, "mp_brecourt" );
			self add_option( "mp_broadcast", undefined, ::vision_changer, "mp_broadcast" );
			self add_option( "mp_carentan", undefined, ::vision_changer, "mp_carentan" );
			self add_option( "mp_cargoship", undefined, ::vision_changer, "mp_cargoship" );
			self add_option( "mp_checkpoint", undefined, ::vision_changer, "mp_checkpoint" );
			self add_option( "mp_citystreets", undefined, ::vision_changer, "mp_citystreets" );
			self add_option( "mp_compact", undefined, ::vision_changer, "mp_compact" );
			self add_option( "mp_complex", undefined, ::vision_changer, "mp_complex" );
			self add_option( "mp_convoy", undefined, ::vision_changer, "mp_convoy" );
			self add_option( "mp_countdown", undefined, ::vision_changer, "mp_countdown" );
			self add_option( "mp_crash", undefined, ::vision_changer, "mp_crash" );
			self add_option( "mp_crash_damage", undefined, ::vision_changer, "mp_crash_damage" );
			self add_option( "mp_creek", undefined, ::vision_changer, "mp_creek" );
			self add_option( "mp_creek_ss", undefined, ::vision_changer, "mp_creek_ss" );
			self add_option( "mp_crossfire", undefined, ::vision_changer, "mp_crossfire" );
			self add_option( "mp_derail", undefined, ::vision_changer, "mp_derail" );
			self add_option( "mp_dusk", undefined, ::vision_changer, "mp_dusk" );
			self add_option( "mp_estate", undefined, ::vision_changer, "mp_estate" );
			self add_option( "mp_farm", undefined, ::vision_changer, "mp_farm" );
			self add_option( "mp_favela", undefined, ::vision_changer, "mp_favela" );
			self add_option( "mp_firingrange", undefined, ::vision_changer, "mp_firingrange" );
			self add_option( "mp_fuel2", undefined, ::vision_changer, "mp_fuel2" );
			self add_option( "mp_highrise", undefined, ::vision_changer, "mp_highrise" );
			self add_option( "mp_hill", undefined, ::vision_changer, "mp_hill" );
			self add_option( "mp_invasion", undefined, ::vision_changer, "mp_invasion" );
			self add_option( "mp_killhouse", undefined, ::vision_changer, "mp_killhouse" );
			self add_option( "mp_nightshift", undefined, ::vision_changer, "mp_nightshift" );
			self add_option( "mp_oilrig", undefined, ::vision_changer, "mp_oilrig" );
			self add_option( "mp_overgrown", undefined, ::vision_changer, "mp_overgrown" );
			self add_option( "mp_pipeline", undefined, ::vision_changer, "mp_pipeline" );
			self add_option( "mp_quarry", undefined, ::vision_changer, "mp_quarry" );
			self add_option( "mp_riverwalk", undefined, ::vision_changer, "mp_riverwalk" );
			self add_option( "mp_rundown", undefined, ::vision_changer, "mp_rundown" );
			self add_option( "mp_rust", undefined, ::vision_changer, "mp_rust" );
			self add_option( "mp_shipment", undefined, ::vision_changer, "mp_shipment" );
			self add_option( "mp_showdown", undefined, ::vision_changer, "mp_showdown" );
			self add_option( "mp_skidrow", undefined, ::vision_changer, "mp_skidrow" );
			self add_option( "mp_storm", undefined, ::vision_changer, "mp_storm" );
			self add_option( "mp_strike", undefined, ::vision_changer, "mp_strike" );
			self add_option( "mp_subbase", undefined, ::vision_changer, "mp_subbase" );
			self add_option( "mp_suburbia", undefined, ::vision_changer, "mp_suburbia" );
			self add_option( "mp_terminal", undefined, ::vision_changer, "mp_terminal" );
			self add_option( "mp_trailer", undefined, ::vision_changer, "mp_trailer" );
			self add_option( "mp_trailerpark", undefined, ::vision_changer, "mp_trailerpark" );
			self add_option( "mp_underpass", undefined, ::vision_changer, "mp_underpass" );
			self add_option( "mp_vacant", undefined, ::vision_changer, "mp_vacant" );
			self add_option( "mp_verdict", undefined, ::vision_changer, "mp_verdict" );
			break;
		case "^:Other Visions":
			self add_menu( menu );
			self add_option( "Default", undefined, ::vision_changer, "default" );
			self add_option( "ac130", undefined, ::vision_changer, "ac130" );
			self add_option( "ac130_inverted", undefined, ::vision_changer, "ac130_inverted" );
			self add_option( "af_caves_indoors_steamroom", undefined, ::vision_changer, "af_caves_indoors_steamroom" );
			self add_option( "airlift_nuke_flash", undefined, ::vision_changer, "airlift_nuke_flash" );
			self add_option( "airport_exterior", undefined, ::vision_changer, "airport_exterior" );
			self add_option( "airport_green", undefined, ::vision_changer, "airport_green" );
			self add_option( "armada_helitransition", undefined, ::vision_changer, "armada_helitransition" );
			self add_option( "black_bw", undefined, ::vision_changer, "black_bw" );
			self add_option( "blackout_nightvision", undefined, ::vision_changer, "blackout_nightvision" );
			self add_option( "boneyard_flyby", undefined, ::vision_changer, "boneyard_flyby" );
			self add_option( "cheat_chaplinnight", undefined, ::vision_changer, "cheat_chaplinnight" );
			self add_option( "cheat_contrast", undefined, ::vision_changer, "cheat_contrast" );
			self add_option( "cheat_invert_bright", undefined, ::vision_changer, "cheat_invert_bright" );
			self add_option( "co_break", undefined, ::vision_changer, "co_break" );
			self add_option( "cobra_down", undefined, ::vision_changer, "cobra_down" );
			self add_option( "cobra_sunset1", undefined, ::vision_changer, "cobra_sunset1" );
			self add_option( "cobra_sunset2", undefined, ::vision_changer, "cobra_sunset2" );
			self add_option( "cobra_sunset3", undefined, ::vision_changer, "cobra_sunset3" );
			self add_option( "cobrapilot", undefined, ::vision_changer, "cobrapilot" );
			self add_option( "dcburning_rooftops", undefined, ::vision_changer, "dcburning_rooftops" );
			self add_option( "dcemp_emp", undefined, ::vision_changer, "dcemp_emp" );
			self add_option( "dcemp_postemp", undefined, ::vision_changer, "dcemp_postemp" );
			self add_option( "dcemp_postemp2", undefined, ::vision_changer, "dcemp_postemp2" );
			self add_option( "default_night", undefined, ::vision_changer, "default_night" );
			self add_option( "default_night_mp", undefined, ::vision_changer, "default_night_mp" );
			self add_option( "drone_swarm", undefined, ::vision_changer, "drone_swarm" );
			self add_option( "end_game", undefined, ::vision_changer, "end_game" );
			self add_option( "exterior_concept", undefined, ::vision_changer, "exterior_concept" );
			self add_option( "generic_underwater", undefined, ::vision_changer, "generic_underwater" );
			self add_option( "grayscale", undefined, ::vision_changer, "grayscale" );
			self add_option( "helicopter_ride", undefined, ::vision_changer, "helicopter_ride" );
			self add_option( "interior_concept", undefined, ::vision_changer, "interior_concept" );
			self add_option( "introscreen", undefined, ::vision_changer, "introscreen" );
			self add_option( "jeepride_tunnel", undefined, ::vision_changer, "jeepride_tunnel" );
			self add_option( "jeepride_zak", undefined, ::vision_changer, "jeepride_zak" );
			self add_option( "london", undefined, ::vision_changer, "london" );
			self add_option( "missilecam", undefined, ::vision_changer, "missilecam" );
			self add_option( "mpnuke_aftermath", undefined, ::vision_changer, "mpnuke_aftermath" );
			self add_option( "near_death", undefined, ::vision_changer, "near_death" );
			self add_option( "near_death_hdr", undefined, ::vision_changer, "near_death_hdr" );
			self add_option( "near_death_mp", undefined, ::vision_changer, "near_death_mp" );
			self add_option( "oilrig_exterior_heli", undefined, ::vision_changer, "oilrig_exterior_heli" );
			self add_option( "oilrig_interior2", undefined, ::vision_changer, "oilrig_interior2" );
			self add_option( "oilrig_underwater", undefined, ::vision_changer, "oilrig_underwater" );
			self add_option( "school", undefined, ::vision_changer, "school" );
			self add_option( "sepia", undefined, ::vision_changer, "sepia" );
			self add_option( "so_bridge", undefined, ::vision_changer, "so_bridge" );
			self add_option( "strike", undefined, ::vision_changer, "strike" );
			self add_option( "thermal_mp", undefined, ::vision_changer, "thermal_mp" );
			self add_option( "trainer_pit", undefined, ::vision_changer, "trainer_pit" );
			self add_option( "trainer_start", undefined, ::vision_changer, "trainer_start" );
			self add_option( "tulsa", undefined, ::vision_changer, "tulsa" );
			self add_option( "warlord", undefined, ::vision_changer, "warlord" );
			self add_option( "whitehouse", undefined, ::vision_changer, "whitehouse" );
			break;
		case "^:Specular Map":
            self add_menu( menu );
			self add_option( "Unchanged (Default)", undefined, ::change_specular, 1 );
			self add_option( "White", undefined, ::change_specular, 2 );
			self add_option( "Gray", undefined, ::change_specular, 3 );
			self add_option( "Black", undefined, ::change_specular, 0 );
            break;
        case "^:Team Options":
            self add_menu( menu );
			self add_option( "Teleport Team", undefined, ::new_menu, "^:Teleport Team" );
			self add_option( "Take Team Weapons", undefined, ::new_menu, "^:Take Team Weapons" );
			self add_option( "Give Team Weapons", undefined, ::new_menu, "^:Give Team Weapons" );
			self add_option( "Team To Space", undefined, ::new_menu, "^:Team To Space" );
            self add_option( "Freeze Team", undefined, ::new_menu, "^:Freeze Team" );
            self add_option( "Kill Team", undefined, ::new_menu, "^:Kill Team" );
            break;
        case "^:Teleport Team":
            self add_menu( menu );
            self add_option( "Teleport to Crosshair: Allies", undefined, ::team_teleport_crosshair, "allies" );
			self add_option( "Teleport to Crosshair: Axis", undefined, ::team_teleport_crosshair, "axis" );
			self add_option( "Teleport to Crosshair: All", undefined, ::all_teleport_crosshair, undefined );
			self add_option( "Teleport to Position: Allies", undefined, ::team_teleport_custom, "allies" );
			self add_option( "Teleport to Position: Axis", undefined, ::team_teleport_custom, "axis" );
			self add_option( "Teleport to Position: All", undefined, ::all_teleport_custom, undefined );
            break;
        case "^:Take Team Weapons":
            self add_menu( menu );
            self add_option( "Take Weapons: Allies", undefined, ::team_take_weapons, "allies" );
			self add_option( "Take Weapons: Axis", undefined, ::team_take_weapons, "axis" );
			self add_option( "Take Weapons: All", undefined, ::all_take_weapons, undefined );
            break;
        case "^:Give Team Weapons":
            self add_menu( menu );
            self add_option( "Give Current Weapon: Allies", undefined, ::team_give_weapon, "allies" );
			self add_option( "Give Current Weapon: Axis", undefined, ::team_give_weapon, "axis" );
			self add_option( "Give Current Weapon: All", undefined, ::all_give_curr_weapon, undefined );
            break;
        case "^:Team To Space":
            self add_menu( menu );
            self add_option( "Send to Space: Allies", undefined, ::team_space, "allies" );
			self add_option( "Send to Space: Axis", undefined, ::team_space, "axis" );
			self add_option( "Send to Space: All", undefined, ::all_space, undefined );
            break;
        case "^:Freeze Team":
            self add_menu( menu );
            self add_toggle( "Freeze: Allies", undefined, ::team_freeze_allies, self.team_freeze_allies );
			self add_toggle( "Freeze: Axis", undefined, ::team_freeze_axis, self.team_freeze_axis );
			self add_toggle( "Freeze: All", undefined, ::all_freeze, self.all_freeze );
            break;
        case "^:Kill Team":
            self add_menu( menu );
            self add_option( "Kill: Allies", undefined, ::team_kill, "allies" );
			self add_option( "Kill: Axis", undefined, ::team_kill, "axis" );
			self add_option( "Kill: All", undefined, ::all_kill, undefined );
            break;
        case "^:Gametype Toggles":
            self add_menu( menu );
			self user_scripts\mp\preload::settings_check();
            self add_toggle( "Sliding", undefined, ::slide_toggle, self.slide_toggle );
            self add_toggle( "Headshots Only", undefined, ::headshots_only_toggle, self.headshots_only_toggle );
            self add_toggle( "Roll The Dice Lobby", "^:Random Effect Every Spawn", ::rtd_toggle, self.rtd_toggle );
            self add_toggle( "Snipers Only Lobby", undefined, ::sniper_only_toggle, self.sniper_only_toggle );
			self add_toggle( "Pistols Only Lobby", undefined, ::pistol_only_toggle, self.pistol_only_toggle );
            self add_toggle( "Shotguns Only Lobby", undefined, ::shotgun_only_toggle, self.shotgun_only_toggle );
            self add_toggle( "Launchers Only Lobby", undefined, ::launcher_only_toggle, self.launcher_only_toggle );
            self add_toggle( "Melee Only Lobby", undefined, ::melee_only_toggle, self.melee_only_toggle );
            break;
        case "^:Gameplay Toggles":
            self add_menu( menu );
            self add_toggle( "Infinite Game", undefined, ::infinite_game_toggle, self.infinite_game_toggle );
            self add_toggle( "Modded Lobby", "^:Jump High, Move Fast, Low Grav, No Spread", ::modded_lobby_toggle, self.modded_lobby_toggle );
			self add_toggle( "Disable Killstreaks", undefined, ::disable_streaks_toggle, self.disable_streaks_toggle );
            self add_toggle( "Allow Team Change", undefined, ::allow_team_change, self.allow_team_change );
			self add_toggle( "Constant UAV", undefined, ::constant_uav_toggle, self.constant_uav_toggle );
			self add_toggle( "Old School Mode", undefined, ::oldschool_toggle, self.oldschool_toggle );
			self add_toggle( "No Player Collision", undefined, ::collision_toggle, self.collision_toggle );
			self add_toggle( "Super Ladder Jump", undefined, ::ladder_jump_toggle, self.ladder_jump_toggle );
			self add_toggle( "Bounces", undefined, ::bounce_toggle, self.bounce_toggle );
			self add_toggle( "Elevators", undefined, ::elevator_toggle, self.elevator_toggle );
			self add_toggle( "Global Voice Chat", undefined, ::all_voice_toggle, self.all_voice_toggle );
			self add_toggle( "Death Barriers", undefined, ::death_barriers_toggle, self.death_barriers_toggle );
			self add_toggle( "More Placed Explosives", undefined, ::player_explosives_toggle, self.player_explosives_toggle );
            break;
        case "^:Game Functions":
            self add_menu( menu );
            self add_option( "Change Map", undefined, ::new_menu, "^:Change Map" );
            self add_option( "Restart Map", undefined, ::new_menu, "^:Restart Map" );
			self add_option( "End Game", undefined, ::new_menu, "^:End Game" );
			self add_option( "Gametype", undefined, ::new_menu, "^:Gametype" );
            self add_option( "Graphics Options", undefined, ::new_menu, "^:Graphics Options" );
			self add_increment( "Set Time Limit", undefined, ::set_time_limit, 10, 0, 1000, 5 );
			self add_increment( "Set Team Max Score", undefined, ::set_team_max, 10, 0, 10000, 25 );
			self add_increment( "Set Gravity", undefined, ::gravity_set, 800, 0, 1000, 25  );
			self add_increment( "Set Timescale", undefined, ::timescale_set, 1, 0.1, 20, 0.1 );
			self add_increment( "Set Move Speed", undefined, ::speed_set, 190, 0, 1000, 15 );
			self add_increment( "Set Jump Height", undefined, ::jumpheight_set, 41, 0, 1000, 15 );
			self add_increment( "Set Knockback", undefined, ::knockback_set, 1000, -100000, 100000, 250 );
            break;
		case "^:Change Map":
            self add_menu( menu );
			self add_option( "Modern Warfare Remastered", undefined, ::new_menu, "^:Modern Warfare Remastered" );
			self add_option( "Modern Warfare 2", undefined, ::new_menu, "^:Modern Warfare 2" );
			self add_option( "Modern Warfare 2: CR", undefined, ::new_menu, "^:Modern Warfare 2: CR" );
            self add_option( "Modern Warfare 3", undefined, ::new_menu, "^:Modern Warfare 3" );
			self add_option( "Advanced Warfare", undefined, ::new_menu, "^:Advanced Warfare" );
			self add_option( "Ported", undefined, ::new_menu, "^:Ported" );
			break;
		case "^:Modern Warfare Remastered":
            self add_menu( menu );
			self add_option( "Ambush", undefined, ::change_map, "mp_convoy" );
			self add_option( "Backlot", undefined, ::change_map, "mp_backlot" );
			self add_option( "Bloc", undefined, ::change_map, "mp_bloc" );
			self add_option( "Bog", undefined, ::change_map, "mp_bog" );
			self add_option( "Beach Bog", undefined, ::change_map, "mp_bog_summer" );
			self add_option( "Broadcast", undefined, ::change_map, "mp_broadcast" );
			self add_option( "Chinatown", undefined, ::change_map, "mp_carentan" );
			self add_option( "Countdown", undefined, ::change_map, "mp_countdown" );
			self add_option( "Crash", undefined, ::change_map, "mp_crash" );
			self add_option( "Winter Crash", undefined, ::change_map, "mp_crash_snow" );
			self add_option( "Creek", undefined, ::change_map, "mp_creek" );
			self add_option( "Crossfire", undefined, ::change_map, "mp_crossfire" );
			self add_option( "District", undefined, ::change_map, "mp_citystreets" );
			self add_option( "Downpour", undefined, ::change_map, "mp_farm" );
			self add_option( "Daybreak", undefined, ::change_map, "mp_farm_spring" );
			self add_option( "Killhouse", undefined, ::change_map, "mp_killhouse" );
			self add_option( "Overgrown", undefined, ::change_map, "mp_overgrown" );
			self add_option( "Pipeline", undefined, ::change_map, "mp_pipeline" );
			self add_option( "Shipment", undefined, ::change_map, "mp_shipment" );
			self add_option( "Showdown", undefined, ::change_map, "mp_showdown" );
			self add_option( "Strike", undefined, ::change_map, "mp_strike" );
			self add_option( "Vacant", undefined, ::change_map, "mp_vacant" );
			self add_option( "Wet Work", undefined, ::change_map, "mp_cargoship" );
			break;
		case "^:Modern Warfare 2":
            self add_menu( menu );
			self add_option( "Afghan", undefined, ::change_map, "mp_afghan" );
			self add_option( "Bailout", undefined, ::change_map, "mp_complex" );
			self add_option( "Carnival", undefined, ::change_map, "mp_abandon" );
			self add_option( "Derail", undefined, ::change_map, "mp_derail" );
			self add_option( "Estate", undefined, ::change_map, "mp_estate" );
			self add_option( "Favela", undefined, ::change_map, "mp_favela" );
			self add_option( "Fuel", undefined, ::change_map, "mp_fuel2" );
			self add_option( "Highrise", undefined, ::change_map, "mp_highrise" );
			self add_option( "Invasion", undefined, ::change_map, "mp_invasion" );
			self add_option( "Karachi", undefined, ::change_map, "mp_checkpoint" );
			self add_option( "Quarry", undefined, ::change_map, "mp_quarry" );
			self add_option( "Rundown", undefined, ::change_map, "mp_rundown" );
			self add_option( "Rust", undefined, ::change_map, "mp_rust" );
			self add_option( "Salvage", undefined, ::change_map, "mp_compact" );
			self add_option( "Scrapyard", undefined, ::change_map, "mp_boneyard" );
			self add_option( "Skidrow", undefined, ::change_map, "mp_nightshift" );
			self add_option( "Storm", undefined, ::change_map, "mp_storm" );
			self add_option( "Sub Base", undefined, ::change_map, "mp_subbase" );
			self add_option( "Terminal", undefined, ::change_map, "mp_terminal" );
			self add_option( "Trailer Park", undefined, ::change_map, "mp_trailerpark" );
			self add_option( "Underpass", undefined, ::change_map, "mp_underpass" );
			self add_option( "Wasteland", undefined, ::change_map, "mp_brecourt" );
			break;
		case "^:Modern Warfare 2: CR":
            self add_menu( menu );
			self add_option( "Airport", undefined, ::change_map, "airport" );
			self add_option( "Blizzard", undefined, ::change_map, "cliffhanger" );
			self add_option( "Contingency", undefined, ::change_map, "contingency" );
			self add_option( "DC Burning", undefined, ::change_map, "dcburning" );
			self add_option( "Dumpsite", undefined, ::change_map, "boneyard" );
			self add_option( "Gulag", undefined, ::change_map, "gulag" );
			self add_option( "Oilrig", undefined, ::change_map, "oilrig" );
			self add_option( "Safehouse", undefined, ::change_map, "estate" );
			self add_option( "Whiskey Hotel", undefined, ::change_map, "dc_whitehouse" );
			break;
        case "^:Modern Warfare 3":
            self add_menu(menu);
			self add_option( "Arkaden", undefined, ::change_map, "mp_plaza2" );
			self add_option( "Bakaara", undefined, ::change_map, "mp_mogadishu" );
			self add_option( "Bootleg", undefined, ::change_map, "mp_bootleg" );
			self add_option( "Dome", undefined, ::change_map, "mp_dome" );
			self add_option( "Erosion", undefined, ::change_map, "mp_courtyard_ss" );
			self add_option( "Fallen", undefined, ::change_map, "mp_lambeth" );
			self add_option( "Hardhat", undefined, ::change_map, "mp_hardhat" );
			self add_option( "Lockdown", undefined, ::change_map, "mp_alpha" );
			self add_option( "Mission", undefined, ::change_map, "mp_bravo" );
			self add_option( "Resistance", undefined, ::change_map, "mp_paris" );
			self add_option( "Seatown", undefined, ::change_map, "mp_seatown" );
			self add_option( "Underground", undefined, ::change_map, "mp_underground" );
			break;
		case "^:Advanced Warfare":
            self add_menu(menu);
			self add_option( "Big Ben 2", undefined, ::change_map, "mp_bigben2" );
			self add_option( "Climate 3", undefined, ::change_map, "mp_blackbox" );
			self add_option( "Climate 3", undefined, ::change_map, "mp_climate_3" );
			self add_option( "Clowntown 3", undefined, ::change_map, "mp_clowntown3" );
			self add_option( "Comeback", undefined, ::change_map, "mp_comeback" );
			self add_option( "Dam", undefined, ::change_map, "mp_dam" );
			self add_option( "Detroit", undefined, ::change_map, "mp_detroit" );
			self add_option( "Fracture", undefined, ::change_map, "mp_fracture" );
			self add_option( "Greenband", undefined, ::change_map, "mp_greenband" );
			self add_option( "Highrise 2", undefined, ::change_map, "mp_highrise2" );
			self add_option( "Instinct", undefined, ::change_map, "mp_instinct" );
			self add_option( "Kremlin", undefined, ::change_map, "mp_kremlin" );
			self add_option( "Lab 2", undefined, ::change_map, "mp_lab2" );
			self add_option( "Lair", undefined, ::change_map, "mp_lair" );
			self add_option( "Laser 2", undefined, ::change_map, "mp_laser2" );
			self add_option( "Levity", undefined, ::change_map, "mp_levity" );
			self add_option( "Liberty", undefined, ::change_map, "mp_liberty" );
			self add_option( "Lost", undefined, ::change_map, "mp_lost" );
			self add_option( "Perplex 1", undefined, ::change_map, "mp_perplex_1" );
			self add_option( "Prison", undefined, ::change_map, "mp_prison" );
			self add_option( "Recovery", undefined, ::change_map, "mp_recovery" );
			self add_option( "Refraction", undefined, ::change_map, "mp_refraction" );
			self add_option( "Sector 17", undefined, ::change_map, "mp_sector17" );
			self add_option( "Seoul 2", undefined, ::change_map, "mp_seoul2" );
			self add_option( "Solar", undefined, ::change_map, "mp_solar" );
			self add_option( "Spark", undefined, ::change_map, "mp_spark" );
			self add_option( "Terrace", undefined, ::change_map, "mp_terrace" );
			self add_option( "Torqued", undefined, ::change_map, "mp_torqued" );
			self add_option( "Urban", undefined, ::change_map, "mp_urban" );
			self add_option( "Venus", undefined, ::change_map, "mp_venus" );
			break;
		case "^:Ported":
            self add_menu(menu);
			self add_option( "Haus", undefined, ::change_map, "mp_haus" );
			self add_option( "Pool Day", undefined, ::change_map, "mp_poolday" );
			self add_option( "Pool Party", undefined, ::change_map, "mp_poolparty" );
			self add_option( "Shipment: Long", undefined, ::change_map, "mp_shipmentlong" );
			self add_option( "Stalingrad", undefined, ::change_map, "mp_stalingrad" );
			self add_option( "Summit", undefined, ::change_map, "mp_mountain" );
			self add_option( "WaW Castle", undefined, ::change_map, "mp_waw_castle" );
			break;
        case "^:Bot Options":
            self add_menu( menu );
            self add_option( "Bot Toggles", undefined, ::new_menu, "^:Bot Toggles" );
            self add_option( "Bot Functions", undefined, ::new_menu, "^:Bot Functions" );
            break;
        case "^:Bot Toggles":
            self add_menu( menu );
			self add_toggle( "Bot Fill", undefined, ::bot_fill_toggle, self.bot_fill_toggle );
            self add_toggle( "Bots Can't Last Kill", undefined, ::bot_last_toggle, self.bot_last_toggle );
            self add_toggle( "Freeze Bots", undefined, ::bot_freeze, self.bot_freeze );
            break;
        case "^:Bot Functions":
            self add_menu( menu );
			self add_option( "Spawn Bot x1", undefined, ::bot_spawn, 1 );
			self add_option( "Spawn Bot x6", undefined, ::bot_spawn, 6 );
			self add_option( "Remove Bots", undefined, ::bot_remove, undefined );
			self add_option( "Teleport Bots to Crosshair", undefined, ::bot_teleport, undefined );
			self add_option( "Bot Difficulty", undefined, ::new_menu, "^:Bot Difficulty" );
			self add_option( "Bot Team", undefined, ::new_menu, "^:Bot Team" );
            break;
		case "^:Bot Difficulty":
            self add_menu( menu );
			self add_option( "Recruit", undefined, ::bot_change_diff, "recruit" );
			self add_option( "Regular", undefined, ::bot_change_diff, "regular" );
			self add_option( "Hardened", undefined, ::bot_change_diff, "hardened" );
			self add_option( "Veteran", undefined, ::bot_change_diff, "veteran" );
            break;
		case "^:Bot Team":
            self add_menu( menu );
			self add_option( "Autoassign", undefined, ::bot_team, "autoassign" );
			self add_option( "Allies", undefined, ::bot_team, "allies" );
			self add_option( "Axis", undefined, ::bot_team, "axis" );
            break;
        case "^:Misc Options":
            self add_menu( menu );
            self add_option( "Misc Toggles", undefined, ::new_menu, "^:Misc Toggles" );
            self add_option( "Misc Functions", undefined, ::new_menu, "^:Misc Functions" );
            break;
        case "^:Misc Toggles":
            self add_menu( menu );
			//self add_toggle( "Wasted Mode", undefined, ::drunk_mode_toggle, self.drunk_mode_toggle );
			self add_toggle( "Fireworks", undefined, ::fireworks_toggle, self.fireworks_toggle );
			self add_toggle( "Kill Aura", undefined, ::kill_aura_toggle, self.kill_aura_toggle );
			self add_toggle( "Matrix Mode", undefined, ::matrix_mode_toggle, self.matrix_mode_toggle );
			self add_toggle( "Human Centipede", undefined, ::centipede_toggle, self.centipede_toggle );
            break;
        case "^:Misc Functions":
            self add_menu( menu );
			self add_option( "Scripted Weapons", undefined, ::new_menu, "^:Scripted Weapons" );
			self add_option( "Scripted Killstreaks", undefined, ::new_menu, "^:Scripted Killstreaks" );
			//self add_option( "Spawnables", undefined, ::new_menu, "^:Spawnables" );
			//self add_option( "Model Rain", undefined, ::new_menu, "^:Model Rain" );
			self add_option( "Custom Minimap", undefined, ::new_menu, "^:Minimap" );
			//self add_option( "Model Spawner", undefined, ::new_menu, "^:Model Spawner" );
			//self add_option( "Tornado", undefined, ::tornado_verify, undefined );
			self add_option( "Visit Space", undefined, ::space, undefined );
			self add_option( "Spawn Dead Clone", undefined, ::spawn_dead_clone, undefined );
			self add_option( "Earthquake", undefined, ::earthquake_mode, undefined );
			self add_option( "Predator Missile", undefined, ::use_pred_missile, undefined );
			self add_option( "Print Functions", undefined, ::new_menu, "^:Print Functions" );
            break;
		case "^:Scripted Killstreaks":
			self add_menu( menu );
			self add_toggle( "Jetpack", "^:Give Jetpack | Hold [{+activate}] to Fly", ::jetpack_toggle, self.jetpack_toggle );
			//self add_option( "Suicide Plane", undefined, ::suicide_plane, undefined );
			self add_option( "Exploding Crawler", undefined, ::exploding_crawler, undefined );
			//self add_option( "Mega Airdrop 1", undefined, ::mega_airdrop, undefined );
			//self add_option( "Mega Airdrop 2", undefined, ::mega_airdrop_remade, undefined );
			//self add_option( "Defense System", undefined, ::defense_system, undefined );
			self add_option( "Rocket Barrage", undefined, ::rocket_barrage, undefined );
			//self add_option( "Super AC-130", undefined, ::super_ac130, undefined );
			//self add_option( "Strafing Run", undefined, ::strafe_run_init, undefined );
			self add_option( "Sonic Boom", undefined, ::sonic_boom, undefined );
			//self add_option( "Plane Collision", undefined, ::plane_collision, undefined );
			self add_option( "Suicide Bomber", undefined, ::suicide_bomb, undefined );
			break;
		/*
		case "^:Spawnables":
			self add_menu( menu );
			self add_option( "Destroy Spawnable", undefined, ::new_menu, "^:Destroy Spawnable" );
			self add_category( "^1spawnables a lil buggy rn" );
			self add_option( "Artillery Cannon", undefined, ::artillery_verify, undefined );
			self add_option( "Skybase", undefined, ::build_skybase2, undefined );
			self add_option( "Bunker", undefined, ::spawn_bunker, undefined );
			self add_option( "Trampoline", undefined, ::trampoline, undefined );
			self add_option( "Ferris Wheel", undefined, ::ferris_verify, undefined );
			self add_option( "Roller Coaster", "^:Spawn Roller Coaster Ride ^1(use again to delete)", ::coaster_verify, undefined );
			self add_option( "The Centrox", undefined, ::centrox_verify, undefined );
			self add_option( "The Twister", undefined, ::twister_verify, undefined );
			break;
		case "^:Destroy Spawnable":
			self add_menu( menu );
			self add_option( "Destroy Centrox", undefined, ::centrox_destroy, undefined );
			self add_option( "Destroy Ferris Wheel", undefined, ::ferris_destroy, undefined );
			break;
		case "^:Model Rain":
            self add_menu( menu );
			self add_option( "Care Package Friendly Rain", undefined, ::rain_model_toggle, "com_plasticcase_friendly" );
			self add_option( "Care Package Enemy Rain", undefined, ::rain_model_toggle, "com_plasticcase_enemy" );
			self add_option( "Default Vehicle Rain", undefined, ::rain_model_toggle, "defaultvehicle" );
			self add_option( "Dogtag Enemy Rain", undefined, ::rain_model_toggle, "h1_dogtag_enemy_animated" );
			self add_option( "Dogtag Friendly Rain", undefined, ::rain_model_toggle, "h1_dogtag_friend_animated" );
			self add_option( "Neutral Flag Rain", undefined, ::rain_model_toggle, "prop_flag_neutral" );
			self add_option( "Red Chrome Sphere Rain", undefined, ::rain_model_toggle, "test_sphere_redchrome" );
			self add_option( "Chrome Sphere Rain", undefined, ::rain_model_toggle, "test_sphere_silver" );
			self add_option( "AC130 Rain", undefined, ::rain_model_toggle, "vehicle_ac130_coop" );
			self add_option( "AC130 Low Rain", undefined, ::rain_model_toggle, "vehicle_ac130_low_mp" );
			self add_option( "AV8B Harrier Rain", undefined, ::rain_model_toggle, "vehicle_av8b_harrier_jet_mp" );
			self add_option( "B2 Bomber Rain", undefined, ::rain_model_toggle, "vehicle_b2_bomber" );
			self add_option( "Little Bird Rain", undefined, ::rain_model_toggle, "vehicle_little_bird_armed" );
			self add_option( "Pavelow Rain", undefined, ::rain_model_toggle, "vehicle_pavelow" );
			self add_option( "UAV Rain", undefined, ::rain_model_toggle, "vehicle_uav_static_mp" );
			self add_option( "Sentry Gun Rain", undefined, ::rain_model_toggle, "sentry_minigun" );
			self add_option( "USMC Desert Assault Head Rain", undefined, ::rain_model_toggle, "head_usmc_desert_assault_mp" );
			self add_option( "USMC Desert Assault Body Rain", undefined, ::rain_model_toggle, "body_usmc_desert_assault_mp_camo" );
            break;
		*/
        case "^:Save / Load Position":
            self add_menu( menu );
			self add_option( "Save Position", undefined, ::save_pos, undefined );
			self add_option( "Load Position", undefined, ::load_pos, undefined );
            break;
        case "^:Print Functions":
            self add_menu( menu );
			self add_toggle( "Print FPS", undefined, ::fps_toggle, self.fps_toggle );
			self add_toggle( "Print Ping", undefined, ::ping_toggle, self.ping_toggle );
			self add_toggle( "Print Viewmodel Position", undefined, ::view_pos_toggle, self.view_pos_toggle );
			self add_option( "Print Controls", undefined, ::print_controls, undefined );
			self add_option( "Print Position", undefined, ::pos_print, undefined );
			self add_option( "Print GUID", undefined, ::print_guid, undefined );
            break;
        case "^:Weapon Modifiers":
            self add_menu( menu );
			self add_toggle( "Infinite Ammo", undefined, ::infinite_ammo_toggle, self.infinite_ammo_toggle );
			self add_toggle( "Infinite Equipment", undefined, ::infinite_equipment_toggle, self.infinite_equipment_toggle );
			self add_toggle( "Rapid Fire", "^:Rapid Fire With [{+reload}] + [{+attack}] ^7(^1Disable Infinite Ammo^7)", ::rapid_fire_toggle, self.rapid_fire_toggle );
			self add_toggle( "No Spread", undefined, ::no_spread_toggle, self.no_spread_toggle );
			self add_toggle( "No Recoil", undefined, ::no_recoil_toggle, self.no_recoil_toggle );
			self add_toggle( "Laser", undefined, ::laser_toggle, self.laser_toggle );
			self add_toggle( "Bullets Ricochet", undefined, ::bullet_ricochet_toggle, self.bullet_ricochet_toggle );
			self add_toggle( "Earthquake Rounds", undefined, ::quake_rounds_toggle, self.quake_rounds_toggle );
			self add_toggle( "Shotgun Rounds", undefined, ::shotgun_rounds_toggle, self.shotgun_rounds_toggle );
			self add_toggle( "Explosive Rounds", undefined, ::explosive_rounds_toggle, self.explosive_rounds_toggle );
			//self add_toggle( "Variable Zoom", "^:Press [{+activate}] While ADS to Cycle Zoom (Best w/ Scope)", ::variable_zoom_toggle, self.variable_zoom_toggle );
			self add_option( "Custom Projectile", undefined, ::new_menu, "^:Custom Projectile" );
			self add_option( "Give Ammo", undefined, ::give_ammo, undefined );
			self add_option( "Remove Current Weapon", undefined, ::take_weapon, undefined );
			self add_option( "Remove All Weapons", undefined, ::take_all_weapons, undefined );
			self add_option( "Reset Current Weapon", undefined, ::reset_weapon, undefined );
            break;
		case "^:Sun Color":
			self add_menu( menu );
			self add_toggle( "Disco", undefined, ::disco_sun_toggle, self.disco_sun_toggle );
			self add_option( "Default", undefined, ::sun_color, "1.1 1.05 0.85", "^7Default" );
			self add_option( "Red", undefined, ::sun_color, "2 0 0", "^1Red" );
			self add_option( "Green", undefined, ::sun_color, "0 2 0", "^2Green" );
			self add_option( "Blue", undefined, ::sun_color, "0 0 2", "^4Blue" );
			self add_option( "Yellow", undefined, ::sun_color, "2 2 0", "^3Yellow" );
			self add_option( "Cyan", undefined, ::sun_color, "0 2 2", "^5Cyan" );
			self add_option( "Pink", undefined, ::sun_color, "2 1 2", "^6Pink" );
			self add_option( "White", undefined, ::sun_color, "2 2 2", "^7White" );
			self add_option( "Black", undefined, ::sun_color, "0 0 0", "^0Black" );
			break;
		case "^:Scripted Weapons":
            self add_menu( menu );
			self add_option( "Mustang and Sally", undefined, ::mustang_sally, undefined );
			self add_option( "Nova Gas", undefined, ::nova_gas, undefined );
			self add_option( "Care Package Gun", undefined, ::care_package_gun, undefined );
			self add_option( "Grappling Gun", undefined, ::grappling_gun, undefined );
			//self add_option( "Mounted Turret", undefined, ::mounted_turret, undefined );
			self add_option( "Teleport Gun", undefined, ::teleport_gun, undefined );
			self add_option( "Death Machine", undefined, ::death_machine, undefined );
			self add_option( "Nuke AT4", undefined, ::nuke_at4, undefined );
			self add_option( "Raygun", undefined, ::raygun_give, undefined );
			self add_option( "Rocket Grenade", undefined, ::rocket_nade, undefined );
            break;
		case "^:Custom Projectile":
			self add_menu( menu );
			self add_option( "Default", undefined, ::weapon_projectile, "Default" );
			self add_option( "Predator Missile", undefined, ::weapon_projectile, "remotemissile_projectile_mp" );
			self add_option( "Stinger Missile", undefined, ::weapon_projectile, "stinger_mp" );
			self add_option( "Javelin Missile", undefined, ::weapon_projectile, "javelin_mp" );
			self add_option( "AT4 Missile", undefined, ::weapon_projectile, "at4_mp" );
			self add_option( "RPG Missile", undefined, ::weapon_projectile, "h2_rpg_mp" );
			self add_option( "M79 Grenade", undefined, ::weapon_projectile, "h2_m79_mp" );
			self add_option( "Harrier FFAR", undefined, ::weapon_projectile, "harrier_FFAR_mp" );
			self add_option( "AC-130 25mm", undefined, ::weapon_projectile, "ac130_25mm_mp" );
			self add_option( "AC-130 40mm", undefined, ::weapon_projectile, "ac130_40mm_mp" );
			self add_option( "AC-130 105mm", undefined, ::weapon_projectile, "ac130_105mm_mp" );
			self add_option( "Intervention", undefined, ::weapon_projectile, "h2_cheytac_mp" );
			break;
		case "^:Gametype":
			self add_menu( menu );
			self add_option( "Capture the Flag", undefined, ::change_gametype, "ctf" );
			self add_option( "Demolition", undefined, ::change_gametype, "dd" );
			self add_option( "Domination", undefined, ::change_gametype, "dom" );
			self add_option( "Drop Zone", undefined, ::change_gametype, "dz" );
			self add_option( "Free-for-All", undefined, ::change_gametype, "dm" );
			self add_option( "Gun Game", undefined, ::change_gametype, "gun" );
			self add_option( "Hardpoint", undefined, ::change_gametype, "hp" );
			self add_option( "Headquarters", undefined, ::change_gametype, "koth" );
			self add_option( "Kill Confirmed", undefined, ::change_gametype, "conf" );
			self add_option( "Sabotage", undefined, ::change_gametype, "sab" );
			self add_option( "Search and Destroy", undefined, ::change_gametype, "sd" );
			self add_option( "Team Deathmatch", undefined, ::change_gametype, "war" );
			break;
		case "^:Killstreaks":
			self add_menu( menu );
			self add_option( "UAV", undefined, ::give_killstreak, "radar_mp" );
			self add_option( "Counter UAV", undefined, ::give_killstreak, "counter_radar_mp" );
			self add_option( "Care Package", undefined, ::give_killstreak, "airdrop_marker_mp" );
			self add_option( "Care Package Trap", undefined, ::give_killstreak, "airdrop_trap_mp" );
			self add_option( "Sentry Gun", undefined, ::give_killstreak, "sentry_mp" );
			self add_option( "Remote Sentry Gun", undefined, ::give_killstreak, "remote_sentry_mp" );
			self add_option( "Predator Missile", undefined, ::give_killstreak, "predator_mp" );
			self add_option( "Precision Airstrike", undefined, ::give_killstreak, "airstrike_mp" );
			self add_option( "Harrier Strike", undefined, ::give_killstreak, "harrier_airstrike_mp" );
			self add_option( "Attack Helicopter", undefined, ::give_killstreak, "helicopter_mp" );
			self add_option( "Advanced UAV", undefined, ::give_killstreak, "advanced_uav_mp" );
            self add_option( "Emergency Airdrop", undefined, ::give_killstreak, "airdrop_mega_marker_mp" );
			self add_option( "AH6 Overwatch", undefined, ::give_killstreak, "ah6_mp" );
            self add_option( "Pavelow", undefined, ::give_killstreak, "pavelow_mp" );
            self add_option( "Reaper", undefined, ::give_killstreak, "reaper_mp" );
			self add_option( "Stealth Bomber", undefined, ::give_killstreak, "stealth_airstrike_mp" );
			self add_option( "Chopper Gunner", undefined, ::give_killstreak, "chopper_gunner_mp" );
			self add_option( "AC-130", undefined, ::give_killstreak, "ac130_mp" );
			self add_option( "EMP", undefined, ::give_killstreak, "emp_mp" );
			self add_option( "Nuke", undefined, ::give_killstreak, "nuke_mp" );
			break;
		case "^:Equipment":
			self add_menu( menu );
			self add_option( "C4", undefined, ::give_equipment, "h1_c4_mp" );
			self add_option( "Claymore", undefined, ::give_equipment, "h1_claymore_mp" );
			self add_option( "EMP Grenade", undefined, ::give_equipment, "h2_empgrenade_mp" );
			self add_option( "Flash Grenade", undefined, ::give_equipment, "h1_flashgrenade_mp" );
			self add_option( "Frag Grenade", undefined, ::give_equipment, "h1_fraggrenade_mp" );
			self add_option( "Frag Grenade (Short)", undefined, ::give_equipment, "h1_fraggrenadeshort_mp" );
			self add_option( "Semtex", undefined, ::give_equipment, "h2_semtex_mp" );
			self add_option( "Smoke Grenade", undefined, ::give_equipment, "h1_smokegrenade_mp" );
			self add_option( "Stun Grenade", undefined, ::give_equipment, "h1_concussiongrenade_mp" );
			self add_option( "Tactical Insertion", undefined, ::give_equipment, "flare_mp" );
			self add_option( "Throwing Knife", undefined, ::give_equipment, "iw9_throwknife_mp" );
			self add_option( "Trophy System", undefined, ::give_equipment, "h2_trophy_mp" );
			break;
		case "^:Lethal":
            self add_menu( menu );
			self add_option( "C4", undefined, ::give_lethal, "h1_c4_mp" );
			self add_option( "Claymore", undefined, ::give_lethal, "h1_claymore_mp" );
			self add_option( "EMP Grenade", undefined, ::give_lethal, "h2_empgrenade_mp" );
			self add_option( "Flash Grenade", undefined, ::give_lethal, "h1_flashgrenade_mp" );
			self add_option( "Frag Grenade", undefined, ::give_lethal, "h1_fraggrenade_mp" );
			self add_option( "Frag Grenade (Short)", undefined, ::give_lethal, "h1_fraggrenadeshort_mp" );
			self add_option( "Semtex", undefined, ::give_lethal, "h2_semtex_mp" );
			self add_option( "Smoke Grenade", undefined, ::give_lethal, "h1_smokegrenade_mp" );
			self add_option( "Stun Grenade", undefined, ::give_lethal, "h1_concussiongrenade_mp" );
			self add_option( "Tactical Insertion", undefined, ::give_lethal, "flare_mp" );
			self add_option( "Throwing Knife", undefined, ::give_lethal, "iw9_throwknife_mp" );
			self add_option( "Trophy System", undefined, ::give_lethal, "h2_trophy_mp" );
			break;
        case "^:Restart Map":
            self add_menu( menu );
			self add_option( "Confirm Restart", undefined, ::restart_map, undefined );
            break;
		case "^:End Game":
            self add_menu( menu );
			self add_option( "Confirm End Game", undefined, ::end_game, undefined );
            break;
        case "^:Weapon Editor":
            self add_menu( menu );
			if( !isDefined( level.attachments_loaded ) )
        		level user_scripts\mp\preload::load_attachments();
            self add_option( "Weapon", undefined, ::new_menu, "^:Weapons" );
            self add_option( "Camo", undefined, ::new_menu, "^:Camos" );
            self add_array( "Attachment 1", undefined, ::set_attachment, level.attach_array, 0 );
            self add_array( "Attachment 2", undefined, ::set_attachment, level.attach_array, 1 );
            self add_array( "Attachment 3", undefined, ::set_attachment, level.attach_array, 2 );
            self add_array( "Attachment 4", undefined, ::set_attachment, level.attach_array, 3 );
            self add_option( "Give Weapon Build", undefined, ::build_weapon );
            break;
		case "^:Weapons":
            self add_menu( menu );
			self add_option( "MWR Weapons", undefined, ::new_menu, "^:MWR Weapons" );
			self add_option( "MW2 Weapons", undefined, ::new_menu, "^:MW2 Weapons" );
			self add_option( "Nightshade Weapons", undefined, ::new_menu, "^:Nightshade Weapons" );
			self add_option( "Misc Weapons", undefined, ::new_menu, "^:Misc Weapons" );
            break;
        case "^:MWR Weapons":
            self add_menu( menu );
			self add_option( "Rifles", undefined, ::new_menu, "^:MWR Rifles" );
			self add_option( "SMGs", undefined, ::new_menu, "^:MWR SMGs" );
			self add_option( "Pistols", undefined, ::new_menu, "^:MWR Pistols" );
			self add_option( "Snipers", undefined, ::new_menu, "^:MWR Snipers" );
			self add_option( "Battle Rifles", undefined, ::new_menu, "^:MWR Battle Rifles" );
			self add_option( "Shotguns", undefined, ::new_menu, "^:MWR Shotguns" );
			self add_option( "LMGs", undefined, ::new_menu, "^:MWR LMGs" );
            break;
        case "^:MWR Rifles":
            self add_menu( menu );
			self add_option( "MWR MP44", undefined, ::set_weapon, "h1_mp44_mp" );
			self add_option( "MWR Galil", undefined, ::set_weapon, "h1_galil_mp" );
			self add_option( "MWR G36C", undefined, ::set_weapon, "h1_g36c_mp" );
			self add_option( "MWR M4", undefined, ::set_weapon, "h1_m4_mp" );
			self add_option( "MWR M16", undefined, ::set_weapon, "h1_m16_mp" );
            break;
		case "^:MWR SMGs":
            self add_menu( menu );
			self add_option( "MWR AK74u", undefined, ::set_weapon, "h1_ak74u_mp" );
			self add_option( "MWR P90", undefined, ::set_weapon, "h1_p90_mp" );
			self add_option( "MWR Skorpion", undefined, ::set_weapon, "h1_skorpion_mp" );
			self add_option( "MWR Mini-Uzi", undefined, ::set_weapon, "h1_mac10_mp" );
			break;
		case "^:MWR Pistols":
            self add_menu( menu );
			self add_option( "MWR M1911", undefined, ::set_weapon, "h1_colt45_mp" );
			self add_option( "MWR .44 Magnum", undefined, ::set_weapon, "h1_coltanaconda_mp" );
			self add_option( "MWR Deagle", undefined, ::set_weapon, "h1_deserteagle_mp" );
			self add_option( "MWR Commanders Deagle", undefined, ::set_weapon, "h1_deserteagle55_mp" );
			self add_option( "MWR PP2000", undefined, ::set_weapon, "h1_pp2000_mp" );
			self add_option( "MWR Beretta", undefined, ::set_weapon, "h1_beretta_mp" );
			self add_option( "MWR USP", undefined, ::set_weapon, "h1_usp_mp" );
            break;
		case "^:MWR Snipers":
            self add_menu( menu );
			self add_option( "MWR M40A3 (No Scope)", undefined, ::set_weapon, "h1_m40a3_mp" );
			self add_option( "MWR Dragunov (No Scope)", undefined, ::set_weapon, "h1_dragunov_mp" );
			self add_option( "MWR R700 (No Scope)", undefined, ::set_weapon, "h1_remington700_mp" );
			self add_option( "MWR Dragunov (Scoped)", undefined, ::set_weapon, "h1_vssvintorez_mp" );
			self add_option( "MWR Barrett (No Scope)", undefined, ::set_weapon, "h1_barrett_mp" );
            break;
		case "^:MWR Battle Rifles":
            self add_menu( menu );
			self add_option( "MWR M21 (No Scope)", undefined, ::set_weapon, "h1_m21_mp" );
			self add_option( "MWR FAL (XM-LAR)", undefined, ::set_weapon, "h1_fal_mp" );
			self add_option( "MWR M14", undefined, ::set_weapon, "h1_m14_mp" );
			self add_option( "MWR G3", undefined, ::set_weapon, "h1_g3_mp" );
			break;
		case "^:MWR Shotguns":
            self add_menu( menu );
			self add_option( "MWR M1014", undefined, ::set_weapon, "h1_m1014_mp" );
			self add_option( "MWR Striker", undefined, ::set_weapon, "h1_striker_mp" );
			self add_option( "MWR Winchester 1200", undefined, ::set_weapon, "h1_winchester1200_mp" );
            break;
		case "^:MWR LMGs":
            self add_menu( menu );
			self add_option( "MWR M60E4", undefined, ::set_weapon, "h1_m60e4_mp" );
			self add_option( "MWR M240", undefined, ::set_weapon, "h1_m240_mp" );
			self add_option( "MWR RPD", undefined, ::set_weapon, "h1_rpd_mp" );
			self add_option( "MWR SAW", undefined, ::set_weapon, "h1_saw_mp" );
			break;
		case "^:MW2 Weapons":
            self add_menu( menu );
			self add_option( "Rifles", undefined, ::new_menu, "^:MW2 ARs" );
			self add_option( "SMGs", undefined, ::new_menu, "^:MW2 SMGs" );
			self add_option( "Snipers", undefined, ::new_menu, "^:MW2 Snipers" );
			self add_option( "LMGs", undefined, ::new_menu, "^:MW2 LMGs" );
			self add_option( "Pistols", undefined, ::new_menu, "^:MW2 Pistols" );;
			self add_option( "Shotguns", undefined, ::new_menu, "^:MW2 Shotguns" );
			self add_option( "Launchers", undefined, ::new_menu, "^:MW2 Launchers" );
			self add_option( "Melee", undefined, ::new_menu, "^:MW2 Melee" );
            break;
        case "^:MW2 ARs":
            self add_menu( menu );
			self add_option( "M4", undefined, ::set_weapon, "h2_m4_mp" );
			self add_option( "FAMAS", undefined, ::set_weapon, "h2_famas_mp" );
			self add_option( "SCAR", undefined, ::set_weapon, "h2_scar_mp" );
			self add_option( "TAR-21", undefined, ::set_weapon, "h2_tavor_mp" );
			self add_option( "FAL", undefined, ::set_weapon, "h2_fal_mp" );
			self add_option( "M16", undefined, ::set_weapon, "h2_m16_mp" );
			self add_option( "ACR", undefined, ::set_weapon, "h2_masada_mp" );
			self add_option( "F2000", undefined, ::set_weapon, "h2_fn2000_mp" );
			self add_option( "AK47", undefined, ::set_weapon, "h2_ak47_mp" );
            break;
		case "^:MW2 SMGs":
            self add_menu( menu );
			self add_option( "MP5k", undefined, ::set_weapon, "h2_mp5k_mp" );
			self add_option( "UMP45", undefined, ::set_weapon, "h2_ump45_mp" );
			self add_option( "Vector", undefined, ::set_weapon, "h2_kriss_mp" );
			self add_option( "P90", undefined, ::set_weapon, "h2_p90_mp" );
			self add_option( "Uzi", undefined, ::set_weapon, "h2_uzi_mp" );
			self add_option( "AK74u", undefined, ::set_weapon, "h2_ak74u_mp" );
            break;
		case "^:MW2 Snipers":
            self add_menu( menu );
			self add_option( "Intervention", undefined, ::set_weapon, "h2_cheytac_mp" );
			self add_option( "Barrett", undefined, ::set_weapon, "h2_barrett_mp" );
			self add_option( "WA2000", undefined, ::set_weapon, "h2_wa2000_mp" );
			self add_option( "M21", undefined, ::set_weapon, "h2_m21_mp" );
			self add_option( "M40A3", undefined, ::set_weapon, "h2_m40a3_mp" );
            break;
		case "^:MW2 LMGs":
            self add_menu( menu );
			self add_option( "L86", undefined, ::set_weapon, "h2_sa80_mp" );
			self add_option( "RPD", undefined, ::set_weapon, "h2_rpd_mp" );
			self add_option( "MG4", undefined, ::set_weapon, "h2_mg4_mp" );
			self add_option( "AUG", undefined, ::set_weapon, "h2_aug_mp" );
			self add_option( "M240", undefined, ::set_weapon, "h2_m240_mp" );
            break;
		case "^:MW2 Pistols":
            self add_menu( menu );
			self add_option( "USP", undefined, ::set_weapon, "h2_usp_mp" );
			self add_option( ".44 Magnum", undefined, ::set_weapon, "h2_coltanaconda_mp" );
			self add_option( "M9", undefined, ::set_weapon, "h2_m9_mp" );
			self add_option( "M1911", undefined, ::set_weapon, "h2_colt45_mp" );
			self add_option( "Deagle", undefined, ::set_weapon, "h2_deserteagle_mp" );
			self add_option( "PP2000", undefined, ::set_weapon, "h2_pp2000_mp" );
			self add_option( "Glock 18", undefined, ::set_weapon, "h2_glock_mp" );
			self add_option( "Raffica", undefined, ::set_weapon, "h2_beretta393_mp" );
			self add_option( "TMP", undefined, ::set_weapon, "h2_tmp_mp" );
            break;
		case "^:MW2 Shotguns":
            self add_menu( menu );
			self add_option( "SPAS-12", undefined, ::set_weapon, "h2_spas12_mp" );
			self add_option( "AA-12", undefined, ::set_weapon, "h2_aa12_mp" );
			self add_option( "Striker", undefined, ::set_weapon, "h2_striker_mp" );
			self add_option( "Ranger", undefined, ::set_weapon, "h2_ranger_mp" );
			self add_option( "W1200", undefined, ::set_weapon, "h2_winchester1200_mp" );
			self add_option( "M1014", undefined, ::set_weapon, "h2_m1014_mp" );
			self add_option( "Model 1887", undefined, ::set_weapon, "h2_model1887_mp" );
            break;
		case "^:MW2 Launchers":
            self add_menu( menu );
			self add_option( "AT4", undefined, ::set_weapon, "at4_mp" );
			self add_option( "Thumper", undefined, ::set_weapon, "h2_m79_mp" );
			self add_option( "Stinger", undefined, ::set_weapon, "stinger_mp" );
			self add_option( "Javelin", undefined, ::set_weapon, "javelin_mp" );
			self add_option( "RPG", undefined, ::set_weapon, "h2_rpg_mp" );
            break;
		case "^:MW2 Melee":
            self add_menu( menu );
			self add_option( "Hatchet", undefined, ::set_weapon, "h2_hatchet_mp" );
			self add_option( "Sickle", undefined, ::set_weapon, "h2_sickle_mp" );
			self add_option( "Shovel", undefined, ::set_weapon, "h2_shovel_mp" );
			self add_option( "Ice Pick", undefined, ::set_weapon, "h2_icepick_mp" );
			self add_option( "Karambit", undefined, ::set_weapon, "h2_karambit_mp" );
            break;
        case "^:Nightshade Weapons":
            self add_menu( menu );
			self add_option("Rifles", undefined, ::new_menu, "^:Nightshade ARs" );
			self add_option("SMGs", undefined, ::new_menu, "^:Nightshade SMGs" );
			self add_option("Snipers", undefined, ::new_menu, "^:Nightshade Snipers" );
			self add_option("LMGs", undefined, ::new_menu, "^:Nightshade LMGs" );
			self add_option("Pistols", undefined, ::new_menu, "^:Nightshade Pistols" );;
			self add_option("Shotguns", undefined, ::new_menu, "^:Nightshade Shotguns" );
			self add_option("Launchers", undefined, ::new_menu, "^:Nightshade Launchers" );
			self add_option("Melee", undefined, ::new_menu, "^:Nightshade Melee" );
            break;
        case "^:Nightshade ARs":
            self add_menu( menu );
			self add_option("ACR 6.8", undefined, ::set_weapon, "h2_iw5acr_mp" );
			self add_option("CM901", undefined, ::set_weapon, "h2_cm901_mp" );
			self add_option("G36C", undefined, ::set_weapon, "h2_g36c_mp" );
			self add_option("Honey Badger", undefined, ::set_weapon, "h2_aac_mp" );
            break;
		case "^:Nightshade SMGs":
            self add_menu( menu );
			self add_option("MP5", undefined, ::set_weapon, "h2_mp5_mp" );
			self add_option("MP7", undefined, ::set_weapon, "h2_mp7_mp" );
			self add_option("PP90M1", undefined, ::set_weapon, "h2_bizon_mp" );
            break;
		case "^:Nightshade Snipers":
            self add_menu( menu );
			self add_option("AS50", undefined, ::set_weapon, "h2_as50_mp" );
			self add_option("D25S", undefined, ::set_weapon, "h2_d25s_mp" );
			self add_option("L118A", undefined, ::set_weapon, "h2_l118a_mp" );
			self add_option("MORS", undefined, ::set_weapon, "h2_mors_mp" );
			self add_option("MSR", undefined, ::set_weapon, "h2_msr_mp" );
			self add_option("USR", undefined, ::set_weapon, "h2_usr_mp" );
            break;
		case "^:Nightshade LMGs":
            self add_menu( menu );
			self add_option("PKM", undefined, ::set_weapon, "h2_pkm_mp" );
            break;
		case "^:Nightshade Pistols":
            self add_menu( menu );
			self add_option("Boomhilda", undefined, ::set_weapon, "h2_boomhilda_mp" );
			self add_option("FMG", undefined, ::set_weapon, "h2_fmg9_mp" );
			self add_option("MP412", undefined, ::set_weapon, "h2_mp412_mp" );
			self add_option("P226", undefined, ::set_weapon, "h2_p226_mp" );
            break;
		case "^:Nightshade Shotguns":
            self add_menu( menu );
			self add_option("KSG", undefined, ::set_weapon, "h2_ksg_mp" );
            break;
		case "^:Nightshade Launchers":
            self add_menu( menu );
			self add_option("M320", undefined, ::set_weapon, "h2_m320_mp" );
            break;
		case "^:Nightshade Melee":
            self add_menu( menu );
			self add_option("Axe", undefined, ::set_weapon, "h2_axe_mp" );
            break;
        case "^:Misc Weapons":
            self add_menu( menu );
			self add_option( "Default Weapon", undefined, ::set_weapon, "defaultweapon_mp" );
			self add_option( "AC130 25mm", undefined, ::set_weapon, "ac130_25mm_mp" );
			self add_option( "AC130 40mm", undefined, ::set_weapon, "ac130_40mm_mp" );
			self add_option( "AC130 105mm", undefined, ::set_weapon, "ac130_105mm_mp" );
			self add_option( "Infected", undefined, ::set_weapon, "h2_infect_mp" );
			self add_option( "Flare", undefined, ::set_weapon, "flare_mp" );
			self add_option( "One Man Army Bag", undefined, ::set_weapon, "onemanarmy_mp" );
			self add_option( "Remote Missile Projectile", undefined, ::set_weapon, "remotemissile_projectile_mp" );
			self add_option( "Harrier FFAR", undefined, ::set_weapon, "harrier_FFAR_mp" );
            self add_option( "MWR Uzi (No Model)", undefined, ::set_weapon, "h1_uzi_mp" );
			self add_option( "MWR AK-47 (No Model)", undefined, ::set_weapon, "h1_ak47_mp" );
			self add_option( "MWR MP5 (No Barrel)", undefined, ::set_weapon, "h1_mp5_mp" );
			self add_option( "Bomb Explosion", undefined, ::set_weapon, "bomb_site_mp" );
			self add_option( "Vehicle Explosion", undefined, ::set_weapon, "destructible_car" );
			self add_option( "Destructible Toy", undefined, ::set_weapon, "destructible_toy" );
			self add_option( "Stealth Bomb", undefined, ::set_weapon, "stealth_bomb_mp" );
			self add_option( "ADS Zoom 5 FOV", undefined, ::set_weapon, "camera_5fov" );
			self add_option( "ADS Zoom 10 FOV", undefined, ::set_weapon, "camera_10fov" );
			self add_option( "ADS Zoom 20 FOV", undefined, ::set_weapon, "camera_20fov" );
			self add_option( "ADS Zoom 30 FOV", undefined, ::set_weapon, "camera_30fov" );
			self add_option( "ADS Zoom 45 FOV", undefined, ::set_weapon, "camera_45fov" );
            break;
		case "^:Camos":
            self add_menu( menu );
            self add_option( "None", undefined, ::set_camo, undefined );
			self add_option( "Classic", undefined, ::new_menu, "^:Classic Camos" );
			self add_option( "Colors", undefined,  ::new_menu, "^:Color Camos" );
			self add_option( "Polyatomic", undefined,  ::new_menu, "^:Polyatomic Camos" );
			self add_option( "Elemental", undefined,  ::new_menu, "^:Elemental Camos" );
			self add_option( "Special", undefined,  ::new_menu, "^:Special Camos" );
            break;
		case "^:Classic Camos":
            self add_menu( menu );
			self add_option( "Desert", undefined, ::set_camo, "camo001" );
			self add_option( "Arctic", undefined, ::set_camo, "camo002" );
			self add_option( "Woodland", undefined, ::set_camo, "camo003" );
			self add_option( "Digital", undefined, ::set_camo, "camo004" );
			self add_option( "Urban", undefined, ::set_camo, "camo005" );
			self add_option( "Blue Tiger", undefined, ::set_camo, "camo006" );
			self add_option( "Red Tiger", undefined, ::set_camo, "camo007" );
			self add_option( "Fall", undefined, ::set_camo, "camo008" );
            break;
		case "^:Color Camos":
            self add_menu( menu );
			self add_option( "Yellow", undefined, ::set_camo, "camo010" );
			self add_option( "White", undefined, ::set_camo, "camo011" );
			self add_option( "Red", undefined, ::set_camo, "camo012" );
			self add_option( "Purple", undefined, ::set_camo, "camo013" );
			self add_option( "Pink", undefined, ::set_camo, "camo014" );
			self add_option( "Pastel Brown", undefined, ::set_camo, "camo015" );
			self add_option( "Orange", undefined, ::set_camo, "camo016" );
			self add_option( "Light Pink", undefined, ::set_camo, "camo017" );
			self add_option( "Green", undefined, ::set_camo, "camo018" );
			self add_option( "Dark Red", undefined, ::set_camo, "camo019" );
			self add_option( "Dark Green", undefined, ::set_camo, "camo020" );
			self add_option( "Cyan", undefined, ::set_camo, "camo021" );
			self add_option( "Brown", undefined, ::set_camo, "camo022" );
			self add_option( "Blue", undefined, ::set_camo, "camo023" );
			self add_option( "Black", undefined, ::set_camo, "camo024" );
            break;
		case "^:Polyatomic Camos":
            self add_menu( menu );
			self add_option( "Polyatomic", undefined, ::set_camo, "camo026" );
			self add_option( "Polyatomic Blue", undefined, ::set_camo, "camo027" );
			self add_option( "Polyatomic Cyan", undefined, ::set_camo, "camo028" );
			self add_option( "Polyatomic Dark Red", undefined, ::set_camo, "camo029" );
			self add_option( "Polyatomic Green", undefined, ::set_camo, "camo030" );
			self add_option( "Polyatomic Orange", undefined, ::set_camo, "camo031" );
			self add_option( "Polyatomic Pink", undefined, ::set_camo, "camo032" );
			self add_option( "Polyatomic Red", undefined, ::set_camo, "camo033" );
			self add_option( "Polyatomic Yellow", undefined, ::set_camo, "camo034" );
            break;
		case "^:Elemental Camos":
            self add_menu( menu );
			self add_option( "Ice", undefined, ::set_camo, "camo035" );
			self add_option( "Lava", undefined, ::set_camo, "camo036" );
			self add_option( "Storm", undefined, ::set_camo, "camo037" );
			self add_option( "Water", undefined, ::set_camo, "camo038" );
			self add_option( "Fire", undefined, ::set_camo, "camo039" );
			self add_option( "Gas", undefined, ::set_camo, "camo040" );
            break;
		case "^:Special Camos":
            self add_menu( menu );
			self add_option( "Doomsday", undefined, ::set_camo, "camo041" );
			self add_option( "Nuclear Blue", undefined, ::set_camo, "camo042" );
			self add_option( "Nuclear Red", undefined, ::set_camo, "camo043" );
			self add_option( "Soaring", undefined, ::set_camo, "camo045" );
			self add_option( "FaZe", undefined, ::set_camo, "camo046" );
			self add_option( "Spectrum", undefined, ::set_camo, "camo047" );
			self add_option( "Space Cats", undefined, ::set_camo, "camo048" );
			self add_option( "Blunt Force", undefined, ::set_camo, "camo049" );
			self add_option( "Toxic Waste", undefined, ::set_camo, "camo044" );
			self add_option( "Gold", undefined, ::set_camo, "camo009" );
			self add_option( "Gold Diamond", undefined, ::set_camo, "camo025" );
            break;
        case "All Players":
            self add_menu( menu );
            foreach( index, player in level.players ) {
                self add_option( player get_name(), undefined, ::new_menu, "Player Option" );
            }
            break;
        default:
            if( !isdefined( self.selected_player ) )
                self.selected_player = self;

            self player_option( menu, self.selected_player );
            break;
    }
}

player_option( menu, player ) {
    if( !isdefined( menu ) || !isdefined( player ) || !isplayer( player ) )
        menu = "Error";

    switch( menu ) {
        case "Player Option":
            self add_menu( "^:" + clean_name( player get_name() ) );
			self add_option( "Give Demi-God Mode", undefined, ::give_demigod_mode, player );
			self add_option( "Remove God Mode", undefined, ::remove_god_mode, player );
            self add_option( "Give Menu Access", undefined, ::menu_access, player );
            self add_option( "Give Admin Access", undefined, ::admin_access, player );
			self add_option( "Remove Menu Access", undefined, ::remove_access, player );
			self add_option( "Give Current Weapon", undefined, ::give_current_weapon, player );
            self add_option( "Give Killstreak", undefined, ::new_menu, "^:Give Killstreak" );
            self add_option( "Give All Perks", undefined, ::give_player_perks, player );
            self add_option( "Remove All Perks", undefined, ::remove_player_perks, player );
            self add_option( "Remove Weapons", undefined, ::remove_player_weapons, player );
            self add_option( "Freeze", undefined, ::freeze_player, player );
            self add_option( "Unfreeze", undefined, ::unfreeze_player, player );
            self add_option( "Teleport to Player", undefined, ::teleport_to_player, player );
			self add_option( "Teleport to Self", undefined, ::teleport_player_self, player );
            self add_option( "Teleport to Crosshair", undefined, ::teleport_player_crosshair, player );
            self add_option( "Send to Space", undefined, ::space_player, player );
            self add_option( "Warn", undefined, ::warn_player, player );
			self add_option( "Kill", undefined, ::kill_player, player );
            self add_option( "Kick", undefined, ::kick_player, player getEntityNumber() );
			self add_option( "Print GUID", undefined, ::print_player_guid, player );
            break;
		case "^:Give Killstreak":
			self add_menu( menu );
			self add_option( "UAV", undefined, ::give_player_killstreak, player, "radar_mp" );
			self add_option( "Counter UAV", undefined, ::give_player_killstreak, player, "counter_radar_mp" );
			self add_option( "Care Package", undefined, ::give_player_killstreak, player, "airdrop_marker_mp" );
			self add_option( "Care Package Trap", undefined, ::give_player_killstreak, player, "airdrop_trap_mp" );
			self add_option( "Sentry Gun", undefined, ::give_player_killstreak, player, "remote_sentry_mp" );
			self add_option( "Remote Sentry Gun", undefined, ::give_player_killstreak, player, "sentry_mp" );
			self add_option( "Predator Missile", undefined, ::give_player_killstreak, player, "predator_mp" );
			self add_option( "Precision Airstrike", undefined, ::give_player_killstreak, player, "airstrike_mp" );
			self add_option( "Harrier Strike", undefined, ::give_player_killstreak, player, "harrier_airstrike_mp" );
			self add_option( "Attack Helicopter", undefined, ::give_player_killstreak, player, "helicopter_mp" );
            self add_option( "Advanced UAV", undefined, ::give_player_killstreak, player, "advanced_uav_mp" );
			self add_option( "Emergency Airdrop", undefined, ::give_player_killstreak, player, "airdrop_mega_marker_mp" );
			self add_option( "AH6 Overwatch", undefined, ::give_player_killstreak, player, "ah6_mp" );
            self add_option( "Pavelow", undefined, ::give_player_killstreak, player, "pavelow_mp" );
            self add_option( "Reaper", undefined, ::give_player_killstreak, player, "reaper_mp" );
			self add_option( "Stealth Bomber", undefined, ::give_player_killstreak, player, "stealth_airstrike_mp" );
			self add_option( "Chopper Gunner", undefined, ::give_player_killstreak, player, "chopper_gunner_mp" );
            self add_option( "AC-130", undefined, ::give_player_killstreak, player, "ac130_mp" );
			self add_option( "EMP", undefined, ::give_player_killstreak, player, "emp_mp" );
			self add_option( "Nuke", undefined, ::give_player_killstreak, player, "nuke_mp" );
            break;
        case "Error":
            self add_menu( menu );
            self add_option( "Oops, Something Went Wrong!", "Condition: Undefined" );
            break;
        default:
            error = true;
            if( error ) {
                self add_menu( "Critical Error" );
                self add_option( "Oops, Something Went Wrong!", "Condition: Menu Index" );
            }
            break;
    }
}