#include user_scripts\mp\m203\source\utilities;
#include user_scripts\mp\m203\source\structure;
#include user_scripts\mp\m203\scripts\common;
#include user_scripts\mp\m203\scripts\rtd_func;
#include maps\mp\_utility;

menu_option() {
    menu = self get_menu();
    switch( menu ) {
        case "Main Menu":
            self add_menu( ( "^:HMW Mod Menu" ) );
            self add_option( "Admin Options", "^:Admin Functions", ::new_menu, "^:Admin Options" );
            //self add_option( "Testing Options", "^:Testing Functions", ::new_menu, "^:Testing Options" );
            if( getDvarInt( "hmw_rtd" ) == 1 ) {
                self add_option( "Roll The Dice Options", "^:Roll The Dice Functions", ::new_menu, "^:Roll The Dice Options" );
            }
            self add_option( "Game Options", "^:Game Functions", ::new_menu, "^:Game Options" );
            self add_option( "Team Options", "^:Team Functions", ::new_menu, "^:Team Options" );
            self add_option( "Weapon Options", "^:Weapon Functions", ::new_menu, "^:Weapon Options" );
            self add_option( "Player Options", "^:Player Functions", ::new_menu, "^:Player Options" );
            self add_option( "Bot Options", "^:Bot Functions", ::new_menu, "^:Bot Options" );
            self add_option( "Misc Options", "^:Miscellaneous Functions", ::new_menu, "^:Misc Options" );
            break;
        /*
        case "^:Testing Options":
            self add_menu( menu );
            break;
        */
        case "^:Roll The Dice Options":
            self add_menu( menu );
			self add_option( "New Roll", "^:Gives You a New Roll", ::new_roll, "" );
			self add_option( "Add Roll", "^:Adds a New Roll", ::add_roll, "" );
			self add_increment( "Choose Roll", "^:Choose a New Roll", ::choose_roll, 0, 0, level.roll_count, 1 );
            break;
        case "^:Game Options":
            self add_menu( menu );
            self add_option( "Gametype Toggles", "^:Gametype Related Toggles", ::new_menu, "^:Gametype Toggles" );
            self add_option( "Gameplay Toggles", "^:Gameplay Related Toggles", ::new_menu, "^:Gameplay Toggles" );
            self add_option( "Game Functions", "^:Game Related Functions", ::new_menu, "^:Game Functions" );
            break;
        case "^:Weapon Options":
            self add_menu( menu );
            self add_option( "Weapon Editor", "^:Weapon Editor", ::new_menu, "^:Weapon Editor" );
            self add_option( "Modifiers", "^:Weapon Modifiers", ::new_menu, "^:Weapon Modifiers" );
			//self add_option( "Weapons", "^:Give Weapons", ::new_menu, "^:Weapons" );
			self add_option( "Killstreaks", "^:Give Killstreak", ::new_menu, "^:Killstreaks" );
			self add_option( "Equipment", "^:Give Equipment", ::new_menu, "^:Equipment" );
			self add_option( "Lethal", "^:Give Lethal", ::new_menu, "^:Lethal" );
            break;
        case "^:Player Options":
            self add_menu( menu );
			self add_option( "Player Toggles", "^:Player Related Toggles", ::new_menu, "^:Player Toggles" );
            self add_option( "Player Functions", "^:Player Related Functions", ::new_menu, "^:Player Functions" );
            break;
        case "^:Player Toggles":
            self add_menu( menu );
			self add_toggle( "God Mode", "^:Invincibility", ::god_mode_toggle, self.god_mode_toggle );
			self add_toggle( "Third Person", "^:Third Person Mode", ::third_person_toggle, self.third_person_toggle );
			self add_toggle( "UFO Mode", "^:Fly with [{+smoke}] | Land with [{+speed_throw}]", ::ufo_mode_toggle, self.ufo_mode_toggle );
			self add_toggle( "Wallbang", "^:Shoot Through Walls", ::wallbang_toggle, self.wallbang_toggle );
			self add_toggle( "Multi-Jump", "^:Jump Multiple Times", ::multi_jump_toggle, self.multi_jump_toggle );
			self add_toggle( "All Perks", "^:Give/Remove All Perks", ::all_perks_toggle, self.all_perks_toggle );
			self add_toggle( "Force Field", "^:Pushes Away Nearby Players", ::forcefield_toggle, self.forcefield_toggle );
			break;
        case "^:Player Functions":
            self add_menu( menu );
			self add_option( "Change Class", "^:Change Current Class", ::change_class, "" );
			self add_option( "Change Teams", "^:Choose Current Team", ::switch_teams, "" );
			self add_option( "Teleporter", "^:Teleport to Selected Location", ::teleporter, "" );
			self add_option( "Commit Sudoku", "^:Kill Yourself", ::kill_urself, "" );
			break;
		case "^:Trickshot Settings":
            self add_menu( menu );
			self add_option( "Sniper Loadouts", "^:Various Sniper Loadouts", ::new_menu, "^:Sniper Loadouts" );
			self add_toggle( "Inspect Glide", "^:Enables Glides On Inspect Animation", ::inspect_glide, self.inspect_glide );
			self add_toggle( "Legacy Nacs", "^:Allows Fake Nac/Fast Swap by Holding Shift", ::legacy_nacs, self.legacy_nacs );
			self add_option( "Save / Load Position", "^:Save / Load Current Position", ::new_menu, "^:Save / Load Position" );
			self add_option( "Create Fake Bounce", "^:Creates a Fake Bounce", ::bounce_create, "" );
			self add_option( "Delete Fake Bounces", "^:Deletes All Fake Bounces", ::bounce_delete, "" );
			break;
		case "^:Sniper Loadouts":
            self add_menu( menu );
			self add_option( "Intervention Loadout", "^:Give Intervention Loadout", ::give_loadout, "h2_cheytac_mp_fmj_ogscope_camo009", "h1_deserteagle55_mp_xmagmwr_camo025", "iw9_throwknife_mp", "h1_flashgrenade_mp" );
			self add_option( "Barrett Loadout", "^:Give Barrett Loadout", ::give_loadout, "h2_barrett_mp_fmj_ogscope_camo009", "h1_deserteagle55_mp_xmagmwr_camo025", "iw9_throwknife_mp", "h1_flashgrenade_mp" );
			self add_option( "M40A3 Loadout", "^:Give M40A3 Loadout", ::give_loadout, "h2_m40a3_mp_fmj_ogscope_camo009", "h1_deserteagle55_mp_xmagmwr_camo025", "iw9_throwknife_mp", "h1_flashgrenade_mp" );
			break;
		case "^:Model Rain":
            self add_menu( menu );
			self add_option( "Care Package Friendly Rain", "^:Models Rain From Sky", ::rain_model_toggle, "com_plasticcase_friendly" );
			self add_option( "Care Package Enemy Rain", "^:Models Rain From Sky", ::rain_model_toggle, "com_plasticcase_enemy" );
			self add_option( "Default Vehicle Rain", "^:Models Rain From Sky", ::rain_model_toggle, "defaultvehicle" );
			self add_option( "Dogtag Enemy Rain", "^:Models Rain From Sky", ::rain_model_toggle, "h1_dogtag_enemy_animated" );
			self add_option( "Dogtag Friendly Rain", "^:Models Rain From Sky", ::rain_model_toggle, "h1_dogtag_friend_animated" );
			self add_option( "Neutral Flag Rain", "^:Models Rain From Sky", ::rain_model_toggle, "prop_flag_neutral" );
			self add_option( "Red Chrome Sphere Rain", "^:Models Rain From Sky", ::rain_model_toggle, "test_sphere_redchrome" );
			self add_option( "Chrome Sphere Rain", "^:Models Rain From Sky", ::rain_model_toggle, "test_sphere_silver" );
			self add_option( "AC130 Rain", "^:Models Rain From Sky", ::rain_model_toggle, "vehicle_ac130_coop" );
			self add_option( "AC130 Low Rain", "^:Models Rain From Sky", ::rain_model_toggle, "vehicle_ac130_low_mp" );
			self add_option( "AV8B Harrier Rain", "^:Models Rain From Sky", ::rain_model_toggle, "vehicle_av8b_harrier_jet_mp" );
			self add_option( "B2 Bomber Rain", "^:Models Rain From Sky", ::rain_model_toggle, "vehicle_b2_bomber" );
			self add_option( "Little Bird Rain", "^:Models Rain From Sky", ::rain_model_toggle, "vehicle_little_bird_armed" );
			self add_option( "Pavelow Rain", "^:Models Rain From Sky", ::rain_model_toggle, "vehicle_pavelow" );
			self add_option( "UAV Rain", "^:Models Rain From Sky", ::rain_model_toggle, "vehicle_uav_static_mp" );
			self add_option( "Sentry Gun Rain", "^:Models Rain From Sky", ::rain_model_toggle, "sentry_minigun" );
			self add_option( "USMC Desert Assault Head Rain", "^:Models Rain From Sky", ::rain_model_toggle, "head_usmc_desert_assault_mp" );
			self add_option( "USMC Desert Assault Body Rain", "^:Models Rain From Sky", ::rain_model_toggle, "body_usmc_desert_assault_mp_camo" );
            break;
		case "^:Minimap":
            self add_menu( menu );
			self add_option( "Fireball Minimap", "^:customMinimap", ::custom_minimap, "gfx_fire_ball_atlas" );
			self add_option( "Spark Minimap", "^:customMinimap", ::custom_minimap, "gfx_spark_atlas" );
			self add_option( "Red Minimap", "^:customMinimap", ::custom_minimap, "gfx_spark_burst_green_atlas" );
			self add_option( "Gachi Minimap", "^:customMinimap", ::custom_minimap, "specialty_oma" );
            break;
		case "^:Admin Options":
            self add_menu( menu );
            self add_option( "All Players", "^:Specific Player Functions", ::new_menu, "All Players" );
			self add_option( "IW4MAdmin", "^:IW4MAdmin Related Functions", ::new_menu, "^:IW4MAdmin" );
            break;
		case "^:IW4MAdmin":
            self add_menu( menu );
			self add_option( "Restart", "^:Restarts IW4MAdmin ^1(IW4MAdmin)", ::new_menu, "^:Confirm Restart (IW4MAdmin)" );
			self add_option( "Fast Restart", "^:Fast Restarts IW4MAdmin ^1(IW4MAdmin)", ::new_menu, "^:Confirm Fast Restart (IW4MAdmin)" );
			self add_option( "Map Rotate", "^:Rotates to Next Map ^1(IW4MAdmin)", ::new_menu, "^:Confirm Map Rotate (IW4MAdmin)" );
			self add_option( "Reset AntiCheat", "^:Resets IW4MAdmin AntiCheat ^1(IW4MAdmin)", ::new_menu, "^:Confirm Reset AntiCheat (IW4MAdmin)" );
            self add_option( "Quit", "^:Quits IW4MAdmin ^1(IW4MAdmin)", ::new_menu, "^:Confirm Quit (IW4MAdmin)" );
			self add_option( "Print Next Map", "^:Prints Next Map ^1(IW4MAdmin)", ::print_iw4madmin, "nextmap" );
			self add_option( "Print Rules", "^:Prints Server Rules ^1(IW4MAdmin)", ::print_iw4madmin, "rules" );
			self add_option( "Print Stats", "^:Prints Server Stats ^1(IW4MAdmin)", ::print_iw4madmin, "stats" );
			self add_option( "Print Top Stats", "^:Prints Server Top Stats ^1(IW4MAdmin)", ::print_iw4madmin, "topstats" );
			self add_option( "Print Most Played", "^:Prints Server Most Played ^1(IW4MAdmin)", ::print_iw4madmin, "mostplayed" );
			self add_option( "Print Most Kills", "^:Prints Server Most Kills ^1(IW4MAdmin)", ::print_iw4madmin, "mostkills" );
			self add_option( "Print Usage", "^:Prints IW4MAdmin Usage ^1(IW4MAdmin)", ::print_iw4madmin, "usage" );
			self add_option( "Print Uptime", "^:Prints IW4MAdmin Uptime ^1(IW4MAdmin)", ::print_iw4madmin, "uptime" );
			self add_option( "Print Admins", "^:Prints Server Admins ^1(IW4MAdmin)", ::print_iw4madmin, "admins" );
			self add_option( "Print Who Am I", "^:Prints Who You Are ^1(IW4MAdmin)", ::print_iw4madmin, "whoami" );
			self add_option( "Print Ping", "^:Prints Ping ^1(IW4MAdmin)", ::print_iw4madmin, "ping" );
			self add_option( "Print External IP", "^:Prints Your IP ^1(IW4MAdmin)", ::print_iw4madmin, "getexternalip" );
			self add_option( "Print Plugins", "^:Prints Server Plugins ^1(IW4MAdmin)", ::print_iw4madmin, "plugins" );
			break;
		case "^:Confirm Restart (IW4MAdmin)":
            self add_menu( menu );
			self add_option( "Confirm Restart (IW4MAdmin)", "^:Restarts IW4MAdmin", ::restart_iw4madmin, "" );
            break;
		case "^:Confirm Fast Restart (IW4MAdmin)":
            self add_menu( menu );
			self add_option( "Confirm Fast Restart (IW4MAdmin)", "^:Fast Restarts IW4MAdmin", ::fastrestart_iw4madmin, "" );
            break;
		case "^:Confirm Map Rotate (IW4MAdmin)":
            self add_menu( menu );
			self add_option( "Confirm Map Rotate (IW4MAdmin)", "^:Rotates Map IW4MAdmin", ::maprotate_iw4madmin, "" );
            break;
		case "^:Confirm Reset AntiCheat (IW4MAdmin)":
            self add_menu( menu );
			self add_option( "Confirm Reset AntiCheat (IW4MAdmin)", "^:Resets AntiCheat IW4MAdmin", ::resetac_iw4madmin, "" );
            break;
		case "^:Confirm Quit (IW4MAdmin)":
            self add_menu( menu );
			self add_option( "Confirm Quit (IW4MAdmin)", "^:Quits IW4MAdmin", ::quit_iw4madmin, "" );
            break;
		case "^:Graphics Options":
            self add_menu( menu );
			self add_toggle( "Pro Mod", "^:Pro Mod (Graphics Only)", ::pro_mod_toggle, self.pro_mod_toggle );
			self add_toggle( "Thermal Vision", "^:Thermal Vision", ::therm_vis_toggle, self.therm_vis_toggle );
			self add_option( "Sun Color", "^:Change Sun/Fog Color", ::new_menu, "^:Sun Color" );
			self add_option( "Visions", "^:Change Vision", ::new_menu, "^:Visions" );
			self add_option( "Specular Map", "^:Change Specular Map", ::new_menu, "^:Specular Map" );
            break;
		case "^:Specular Map":
            self add_menu( menu );
			self add_option( "Unchanged (Default)", "^:Change Specular Map to Unchanged", ::change_specular, 1 );
			self add_option( "White", "^:Change Specular Map to White", ::change_specular, 2 );
			self add_option( "Gray", "^:Change Specular Map to Gray", ::change_specular, 3 );
			self add_option( "Black", "^:Change Specular Map to Black", ::change_specular, 0 );
            break;
        case "^:Team Options":
            self add_menu( menu );
			self add_option( "Teleport Team", "^:Teleport Selected Teams", ::new_menu, "^:Teleport Team" );
			self add_option( "Take Team Weapons", "^:Take Selected Teams Weapons", ::new_menu, "^:Take Team Weapons" );
			self add_option( "Give Team Weapons", "^:Give Selected Teams Weapons", ::new_menu, "^:Give Team Weapons" );
			self add_option( "Team To Space", "^:Send Selected Teams To Space", ::new_menu, "^:Team To Space" );
            self add_option( "Freeze Team", "^:Freeze Selected Teams", ::new_menu, "^:Freeze Team" );
            self add_option( "Kill Team", "^:Kill Selected Teams", ::new_menu, "^:Kill Team" );
            break;
        case "^:Teleport Team":
            self add_menu( menu );
            self add_option( "Teleport to Crosshair: Allies", "^:Teleports Allies Players to Crosshair", ::team_teleport_crosshair, "allies" );
			self add_option( "Teleport to Crosshair: Axis", "^:Teleports Axis Players to Crosshair", ::team_teleport_crosshair, "axis" );
			self add_option( "Teleport to Crosshair: All", "^:Teleports All Players to Crosshair", ::all_teleport_crosshair, "" );
			self add_option( "Teleport to Position: Allies", "^:Teleports Allies Players to Position", ::team_teleport_custom, "allies" );
			self add_option( "Teleport to Position: Axis", "^:Teleports Axis Players to Position", ::team_teleport_custom, "axis" );
			self add_option( "Teleport to Position: All", "^:Teleports All Players to Position", ::all_teleport_custom, "" );
            break;
        case "^:Take Team Weapons":
            self add_menu( menu );
            self add_option( "Take Weapons: Allies", "^:Removes Weapons From Allies Players", ::team_take_weapons, "allies" );
			self add_option( "Take Weapons: Axis", "^:Removes Weapons From Axis Players", ::team_take_weapons, "axis" );
			self add_option( "Take Weapons: All", "^:Removes Weapons From All Players", ::all_take_weapons, "" );
            break;
        case "^:Give Team Weapons":
            self add_menu( menu );
            self add_option( "Give Current Weapon: Allies", "^:Gives Your Current Weapon to Allies Players", ::team_give_weapon, "allies" );
			self add_option( "Give Current Weapon: Axis", "^:Gives Your Current Weapon to Axis Players", ::team_give_weapon, "axis" );
			self add_option( "Give Current Weapon: All", "^:Gives Your Current Weapon to All Players", ::all_give_curr_weapon, "" );
            break;
        case "^:Team To Space":
            self add_menu( menu );
            self add_option( "Send to Space: Allies", "^:Send Allies Players to Space", ::team_space, "allies" );
			self add_option( "Send to Space: Axis", "^:Send Axis Players to Space", ::team_space, "axis" );
			self add_option( "Send to Space: All", "^:Send All Players to Space", ::all_space, "" );
            break;
        case "^:Freeze Team":
            self add_menu( menu );
            self add_option( "Freeze: Allies", "^:All Players On Allies Team Are Frozen", ::team_freeze, "allies" );
			self add_option( "Freeze: Axis", "^:All Players On Axis Team Are Frozen", ::team_freeze, "axis" );
			self add_option( "Freeze: All", "^:All Players Are Frozen", ::all_freeze, "" );
            break;
        case "^:Kill Team":
            self add_menu( menu );
            self add_option( "Kill: Allies", "^:All Players On Allies Team Commit Suicide", ::team_kill, "allies" );
			self add_option( "Kill: Axis", "^:All Players On Axis Team Commit Suicide", ::team_kill, "axis" );
			self add_option( "Kill: All", "^:All Players Commit Suicide", ::all_kill, "" );
            break;
        case "^:Gametype Toggles":
            self add_menu( menu );
            if( getDvarInt( "hmw_slide" ) == 1 ) {
                self.slide_toggle = true;
                level.slide_toggle = true;
            }
            if( getDvarInt( "hmw_headshots_only" ) == 1 ) {
                self.headshots_only_toggle = true;
                level.headshots_only_toggle = true;
            }
            if( getDvarInt( "hmw_isnipe" ) == 1 ) {
                self.isnipe_toggle = true;
                level.isnipe_toggle = true;
            }
            if( getDvarInt( "hmw_rtd" ) == 1 ) {
                self.rtd_toggle = true;
                level.rtd_toggle = true;
            }
            if( getDvarInt( "hmw_pistol_only" ) == 1 ) {
                self.pistol_only_toggle = true;
                level.pistol_only_toggle = true;
            }
            if( getDvarInt( "hmw_shotgun_only" ) == 1 ) {
                self.shotgun_only_toggle = true;
                level.shotgun_only_toggle = true;
            }
            if( getDvarInt( "hmw_launcher_only" ) == 1 ) {
                self.launcher_only_toggle = true;
                level.launcher_only_toggle = true;
            }
            if( getDvarInt( "hmw_melee_only" ) == 1 ) {
                self.melee_only_toggle = true;
                level.melee_only_toggle = true;
            }
            self add_toggle( "Sliding", "^:Slide With [{+stance}] While Moving", ::slide_toggle, self.slide_toggle );
            self add_toggle( "Headshots Only", "^:Only Headshots Do Damage", ::headshots_only_toggle, self.headshots_only_toggle );
			self add_toggle( "iSnipe Lobby", "^:Quickscope Only, No Camping", ::isnipe_toggle, self.isnipe_toggle );
            self add_toggle( "Roll The Dice Lobby", "^:Random Effect Every Spawn", ::rtd_toggle, self.rtd_toggle );
            self add_toggle( "Pistols Only Lobby", "^:Pistols Only Lobby", ::pistol_only_toggle, self.pistol_only_toggle );
            self add_toggle( "Shotguns Only Lobby", "^:Shotguns Only Lobby", ::shotgun_only_toggle, self.shotgun_only_toggle );
            self add_toggle( "Launchers Only Lobby", "^:Launchers Only Lobby", ::launcher_only_toggle, self.launcher_only_toggle );
            self add_toggle( "Melee Only Lobby", "^:Melee Only Lobby", ::melee_only_toggle, self.melee_only_toggle );
            break;
        case "^:Gameplay Toggles":
            self add_menu( menu );
            self add_toggle( "Infinite Game", "^:Stop Game Timer and Disable Score Limit", ::infinite_game_toggle, self.infinite_game_toggle );
            self add_toggle( "Modded Lobby", "^:Jump High, Move Fast, Low Grav, No Spread", ::modded_lobby_toggle, self.modded_lobby_toggle );
			self add_toggle( "Disable Killstreaks", "^:Disable/Enable Killstreaks", ::disable_streaks_toggle, self.disable_streaks_toggle );
            self add_toggle( "Allow Team Change", "^:Allows Changing Teams", ::allow_team_change, self.allow_team_change );
			self add_toggle( "Constant UAV", "^:Enable/Disable UAV", ::constant_uav_toggle, self.constant_uav_toggle );
			self add_toggle( "Old School Mode", "^:Enable/Disable Old School Mode", ::oldschool_toggle, self.oldschool_toggle );
			self add_toggle( "No Player Collision", "^:Enable/Disable Player Collision", ::collision_toggle, self.collision_toggle );
			self add_toggle( "Super Ladder Jump", "^:Ladder Jump Further", ::ladder_jump_toggle, self.ladder_jump_toggle );
			self add_toggle( "Bounces", "^:Enable/Disable Bouncing / BouncingAllAngles", ::bounce_toggle, self.bounce_toggle );
			self add_toggle( "Elevators", "^:Enable/Disable Elevators", ::elevator_toggle, self.elevator_toggle );
			self add_toggle( "Global Voice Chat", "^:Enable/Disable Global Voice Chat", ::all_voice_toggle, self.all_voice_toggle );
			self add_toggle( "Death Barriers", "^:Removes Kill Barriers", ::death_barriers_toggle, self.death_barriers_toggle );
			self add_toggle( "More Placed Explosives", "^:Place More Claymores and C4 ^7(^1Requires Restart!^7)", ::player_explosives_toggle, self.player_explosives_toggle );
            break;
        case "^:Game Functions":
            self add_menu( menu );
            self add_option( "Change Map", "^:Changes Current Map", ::new_menu, "^:Change Map" );
            self add_option( "Restart Map", "^:Restart Current Game", ::new_menu, "^:Restart Map" );
			self add_option( "End Game", "^:End Current Game", ::new_menu, "^:End Game" );
			self add_option( "Gametype", "^:Change Current Gametype", ::new_menu, "^:Gametype" );
            self add_option( "Graphics Options", "^:Graphics Related Options", ::new_menu, "^:Graphics Options" );
			self add_option( "Set Time Limit", "^:Set Game Time Limit", ::new_menu, "^:Time Limit" );
			self add_option( "Set Team Max Score", "^:Set Team Max Score", ::new_menu, "^:Score Max" );
			self add_option( "Set Gravity", "^:Set Gravity", ::new_menu, "^:Gravity Menu" );
			self add_option( "Set Timescale", "^:Set Timescale", ::new_menu, "^:Timescale Menu" );
			self add_option( "Set Move Speed", "^:Set Movement Speed", ::new_menu, "^:Move Speed Menu" );
			self add_option( "Set Jump Height", "^:Set Jump Height", ::new_menu, "^:Jump Height Menu" );
			self add_option( "Set Knockback", "^:Set Knockback", ::new_menu, "^:Knockback Menu" );
            break;
        case "^:Bot Options":
            self add_menu( menu );
            self add_option( "Bot Toggles", "^:Bot Related Toggles", ::new_menu, "^:Bot Toggles" );
            self add_option( "Bot Functions", "^:Bot Related Functions", ::new_menu, "^:Bot Functions" );
            break;
        case "^:Bot Toggles":
            self add_menu( menu );
            if( getDvarInt( "hmw_bot_fill" ) == 1 ) {
                self.bot_fill_toggle = true;
                level.bot_fill_toggle = true;
            }
            if( getDvarInt( "hmw_bot_fill_allies" ) == 1 ) {
                self.bot_fill_allies_toggle = true;
                level.bot_fill_allies_toggle = true;
            }
            if( getDvarInt( "hmw_bot_fill_axis" ) == 1 ) {
                self.bot_fill_axis_toggle = true;
                level.bot_fill_axis_toggle = true;
            }
            if( getDvarInt( "hmw_bot_last" ) == 1 ) {
                self.bot_last_toggle = true;
                level.bot_last_toggle = true;
            }
            if( getDvarInt( "hmw_bot_last_allies" ) == 1 ) {
                self.bot_last_allies_toggle = true;
                level.bot_last_allies_toggle = true;
            }
            if( getDvarInt( "hmw_bot_last_axis" ) == 1 ) {
                self.bot_last_axis_toggle = true;
                level.bot_last_axis_toggle = true;
            }
			self add_toggle( "Bot Fill: Auto", "^:Automatically Fills Lobby With Bots", ::bot_fill_toggle, self.bot_fill_toggle );
            self add_toggle( "Bot Fill: Allies", "^:Automatically Fills Allies Team With Bots", ::bot_fill_allies_toggle, self.bot_fill_allies_toggle );
            self add_toggle( "Bot Fill: Axis", "^:Automatically Fills Axis Team With Bots", ::bot_fill_axis_toggle, self.bot_fill_axis_toggle );
            self add_toggle( "Bot Last: All", "^:Bots Can't Take Last Kill", ::bot_last_toggle, self.bot_last_toggle );
            self add_toggle( "Bot Last: Allies", "^:Bots On Allies Can't Take Last Kill", ::bot_last_allies_toggle, self.bot_last_allies_toggle );
            self add_toggle( "Bot Last: Axis", "^:Bots On Axis Can't Take Last Kill", ::bot_last_axis_toggle, self.bot_last_axis_toggle );
            self add_toggle( "Freeze Bots", "^:Freeze Bots", ::freeze_bots, self.freeze_bots );
            break;
        case "^:Bot Functions":
            self add_menu( menu );
			self add_option( "Fill Lobby", "^:Fills The Lobby With Bots", ::bot_fill, "autoassign" );
            self add_option( "Fill Current Team", "^:Fills Your Current Team With Bots", ::bot_fill, self.team );
			self add_option( "Fill Enemy Team", "^:Fills The Enemy Team With Bots", ::bot_fill, getOtherTeam( self.team ) );
			self add_option( "Spawn Enemy Bot x1", "^:Add 1 Enemy Bot", ::spawn_bot, getOtherTeam( self.team ) );
			self add_option( "Spawn Enemy Bot x6", "^:Add 6 Enemy Bots", ::multi_bots, 6, getOtherTeam( self.team ) );
			self add_option( "Spawn Friendly Bot x1", "^:Add 1 Friendly Bot", ::spawn_bot, self.team );
			self add_option( "Spawn Friendly Bot x6", "^:Add 6 Friendly Bots", ::multi_bots, 6, self.team );
			self add_option( "Remove Bots", "^:Remove Bots", ::remove_bots, "" );
			self add_option( "Teleport Bots to Crosshair", "^:Teleport All Bots to Crosshair", ::crosshair_bots, "" );
			self add_option( "Bot Difficulty", "^:Set Bot Difficulty", ::new_menu, "^:Bot Difficulty" );
            break;
        case "^:Misc Options":
            self add_menu( menu );
            self add_option( "Misc Toggles", "^:Misc Related Toggles", ::new_menu, "^:Misc Toggles" );
            self add_option( "Misc Functions", "^:Misc Related Functions", ::new_menu, "^:Misc Functions" );
            break;
        case "^:Misc Toggles":
            self add_menu( menu );
			self add_toggle( "Wasted Mode", "^:Vision Constantly Changing And Moving", ::drunk_mode_toggle, self.drunk_mode_toggle );
			self add_toggle( "Fireworks", "^:Constant Explosions in Sky", ::fireworks_toggle, self.fireworks_toggle );
			self add_toggle( "Kill Aura", "^:Kills Nearby Players", ::kill_aura_toggle, self.kill_aura_toggle );
			self add_toggle( "Matrix Mode", "^:Slows Time When Attacking", ::matrix_mode_toggle, self.matrix_mode_toggle );
			self add_toggle( "Human Centipede", "^:Spawns Clones Constantly", ::centipede_toggle, self.centipede_toggle );
            break;
        case "^:Misc Functions":
            self add_menu( menu );
			self add_option( "Scripted Weapons", "^:Custom Weapons", ::new_menu, "^:Scripted Weapons" );
			self add_option( "Scripted Killstreaks", "^:Custom Killstreaks", ::new_menu, "^:Scripted Killstreaks" );
			self add_option( "Spawnables", "^:Spawnable Structures", ::new_menu, "^:Spawnables" );
			self add_option( "Model Rain", "^:Rains Down Selected Model", ::new_menu, "^:Model Rain" );
			self add_option( "Custom Minimap", "^:Change The Minimap", ::new_menu, "^:Minimap" );
			//self add_option( "Model Spawner", "Spawns Selected Model at Crosshair", ::new_menu, "^:Model Spawner" );
			self add_option( "Tornado", "^:Tosses Nearby Players and Entities Around", ::tornado_verify, "" );
			self add_option( "Visit Space", "^:Take a Trip to Space", ::space, "" );
			self add_option( "Spawn Dead Clone", "^:Spawn Dead Clone of Self", ::spawn_dead_clone, "" );
			self add_option( "Earthquake", "^:Start a Short Earthquake", ::earthquake_mode, "" );
			self add_option( "Predator Missile", "^:Start a Predator Missile", ::use_pred_missile, "" );
			self add_option( "Print Functions", "^:Print Related Functions", ::new_menu, "^:Print Functions" );
            break;
        case "^:Save / Load Position":
            self add_menu( menu );
			self add_option( "Save Position", "^:Save Current Position", ::save_pos, "" );
			self add_option( "Load Position", "^:Load Current Position", ::load_pos, "" );
            break;
        case "^:Print Functions":
            self add_menu( menu );
			self add_toggle( "Print FPS", "^:Constantly Prints FPS", ::fps_toggle, self.fps_toggle );
			self add_toggle( "Print Ping", "^:Constantly Prints Ping", ::ping_toggle, self.ping_toggle );
			self add_toggle( "Print Viewmodel Position", "^:Constantly Prints Viewmodel Position", ::view_pos_toggle, self.view_pos_toggle );
			self add_option( "Print Controls", "^:Shows Menu Controls", ::print_controls, "" );
			self add_option( "Print Position", "^:Shows Current Position", ::pos_print, "" );
			self add_option( "Print GUID", "^:Shows Your GUID", ::print_guid, "" );
            break;
        case "^:Weapon Modifiers":
            self add_menu( menu );
			self add_toggle( "Infinite Ammo", "^:Unlimited Ammo", ::infinite_ammo_toggle, self.infinite_ammo_toggle );
			self add_toggle( "Infinite Equipment", "^:Unlimited Equipment ^1(Needs Improving)", ::infinite_equipment_toggle, self.infinite_equipment_toggle );
			self add_toggle( "Rapid Fire", "^:Rapid Fire With [{+reload}] + [{+attack}] ^7(^1Disable Infinite Ammo^7)", ::rapid_fire_toggle, self.rapid_fire_toggle );
			self add_toggle( "No Spread", "^:No Hipfire Spread", ::no_spread_toggle, self.no_spread_toggle );
			self add_toggle( "No Recoil", "^:No Weapon Recoil ^1(Bugged, Doesn't Turn Off)", ::no_recoil_toggle, self.no_recoil_toggle );
			self add_toggle( "Laser", "^:Weapon Laser", ::laser_toggle, self.laser_toggle );
			self add_toggle( "Bullets Ricochet", "^:Bullets Bounce Off of Walls", ::bullet_ricochet_toggle, self.bullet_ricochet_toggle );
			self add_toggle( "Earthquake Rounds", "^:Earthquake When Firing", ::quake_rounds_toggle, self.quake_rounds_toggle );
			self add_toggle( "Shotgun Rounds", "^:Weapon Fires SPAS-12 Rounds", ::shotgun_rounds_toggle, self.shotgun_rounds_toggle );
			self add_toggle( "Explosive Rounds", "^:Weapon Fires Explosive Rounds", ::explosive_rounds_toggle, self.explosive_rounds_toggle );
			self add_toggle( "Variable Zoom", "^:Press [{+activate}] While ADS to Cycle Zoom (Best w/ Scope)", ::variable_zoom_toggle, self.variable_zoom_toggle );
			self add_toggle( "Tracking Knives", "^:Throwing Knives Track Enemies ^7(^1Buggy^7)", ::tracking_knife_toggle, self.tracking_knife_toggle );
			self add_option( "Custom Projectile", "^:Choose Weapon Projectile", ::new_menu, "^:Custom Projectile" );
			self add_option( "Give Ammo", "^:Give Current Weapon Ammo", ::give_ammo, "" );
			self add_option( "Remove Current Weapon", "^:Take Current Weapon", ::take_weapon, "" );
			self add_option( "Remove All Weapons", "^:Take All Weapons", ::take_all_weapons, "" );
			self add_option( "Reset Current Weapon", "^:Reset Weapon to Base", ::reset_weapon, "" );
            break;
		case "^:Change Map":
            self add_menu( menu );
			self add_option( "Modern Warfare Remastered", "^:Modern Warfare Remastered Maps ^3(^1Server Only!^3)", ::new_menu, "^:Modern Warfare Remastered" );
			self add_option( "Modern Warfare 2", "^:Modern Warfare 2 Maps ^3(^1Server Only!^3)", ::new_menu, "^:Modern Warfare 2" );
			self add_option( "Modern Warfare 2: CR", "^:Modern Warfare 2:CR Maps ^3(^1Server Only!^3)", ::new_menu, "^:Modern Warfare 2: CR" );
            self add_option( "Modern Warfare 3", "^:Modern Warfare 3 Maps ^3(^1Server Only!^3)", ::new_menu, "^:Modern Warfare 3" );
			self add_option( "Advanced Warfare", "^:Advanced Warfare ^3(^1Server Only!^3)", ::new_menu, "^:Advanced Warfare" );
			self add_option( "Ported", "^:Ported Maps ^3(^1Server Only!^3)", ::new_menu, "^:Ported" );
			break;
		case "^:Modern Warfare Remastered":
            self add_menu( menu );
			self add_option( "Ambush", "^:Changes Map to Ambush", ::change_map, "convoy" );
			self add_option( "Backlot", "^:Changes Map to Backlot", ::change_map, "backlot" );
			self add_option( "Bloc", "^:Changes Map to Bloc", ::change_map, "bloc" );
			self add_option( "Bog", "^:Changes Map to Bog", ::change_map, "bog" );
			self add_option( "Beach Bog", "^:Changes Map to Beach Bog", ::change_map, "bog_summer" );
			self add_option( "Broadcast", "^:Changes Map to Broadcast", ::change_map, "broadcast" );
			self add_option( "Chinatown", "^:Changes Map to Chinatown", ::change_map, "carentan" );
			self add_option( "Countdown", "^:Changes Map to Countdown", ::change_map, "countdown" );
			self add_option( "Crash", "^:Changes Map to Crash", ::change_map, "crash" );
			self add_option( "Winter Crash", "^:Changes Map to Winter Crash", ::change_map, "crash_snow" );
			self add_option( "Creek", "^:Changes Map to Creek", ::change_map, "creek" );
			self add_option( "Crossfire", "^:Changes Map to Crossfire", ::change_map, "crossfire" );
			self add_option( "District", "^:Changes Map to District", ::change_map, "citystreets" );
			self add_option( "Downpour", "^:Changes Map to Downpour", ::change_map, "farm" );
			self add_option( "Daybreak", "^:Changes Map to Daybreak", ::change_map, "farm_spring" );
			self add_option( "Killhouse", "^:Changes Map to Killhouse", ::change_map, "killhouse" );
			self add_option( "Overgrown", "^:Changes Map to Overgrown", ::change_map, "overgrown" );
			self add_option( "Pipeline", "^:Changes Map to Pipeline", ::change_map, "pipeline" );
			self add_option( "Shipment", "^:Changes Map to Shipment", ::change_map, "shipment" );
			self add_option( "Showdown", "^:Changes Map to Showdown", ::change_map, "showdown" );
			self add_option( "Strike", "^:Changes Map to Strike", ::change_map, "strike" );
			self add_option( "Vacant", "^:Changes Map to Vacant", ::change_map, "vacant" );
			self add_option( "Wet Work", "^:Changes Map to Wet Work", ::change_map, "cargoship" );
			break;
		case "^:Modern Warfare 2":
            self add_menu( menu );
			self add_option( "Afghan", "^:Changes Map to Afghan", ::change_map, "afghan" );
			self add_option( "Bailout", "^:Changes Map to Bailout", ::change_map, "complex" );
			self add_option( "Carnival", "^:Changes Map to Carnival", ::change_map, "abandon" );
			self add_option( "Derail", "^:Changes Map to Derail", ::change_map, "derail" );
			self add_option( "Estate", "^:Changes Map to Estate", ::change_map, "estate" );
			self add_option( "Favela", "^:Changes Map to Favela", ::change_map, "favela" );
			self add_option( "Fuel", "^:Changes Map to Fuel", ::change_map, "fuel2" );
			self add_option( "Highrise", "^:Changes Map to Highrise", ::change_map, "highrise" );
			self add_option( "Invasion", "^:Changes Map to Invasion", ::change_map, "invasion" );
			self add_option( "Karachi", "^:Changes Map to Karachi", ::change_map, "checkpoint" );
			self add_option( "Quarry", "^:Changes Map to Quarry", ::change_map, "quarry" );
			self add_option( "Rundown", "^:Changes Map to Rundown", ::change_map, "rundown" );
			self add_option( "Rust", "^:Changes Map to Rust", ::change_map, "rust" );
			self add_option( "Salvage", "^:Changes Map to Salvage", ::change_map, "compact" );
			self add_option( "Scrapyard", "^:Changes Map to Scrapyard", ::change_map, "boneyard" );
			self add_option( "Skidrow", "^:Changes Map to Skidrow", ::change_map, "nightshift" );
			self add_option( "Storm", "^:Changes Map to Storm", ::change_map, "storm" );
			self add_option( "Sub Base", "^:Changes Map to Sub Base", ::change_map, "subbase" );
			self add_option( "Terminal", "^:Changes Map to Terminal", ::change_map, "terminal" );
			self add_option( "Trailer Park", "^:Changes Map to Trailer Park", ::change_map, "trailerpark" );
			self add_option( "Underpass", "^:Changes Map to Underpass", ::change_map, "underpass" );
			self add_option( "Wasteland", "^:Changes Map to Wasteland", ::change_map, "brecourt" );
			break;
		case "^:Modern Warfare 2: CR":
            self add_menu( menu );
			self add_option( "Airport", "^:Changes Map to Airport", ::change_map_cr, "airport" );
			self add_option( "Blizzard", "^:Changes Map to Blizzard", ::change_map_cr, "cliffhanger" );
			self add_option( "Contingency", "^:Changes Map to Contingency", ::change_map_cr, "contingency" );
			self add_option( "DC Burning", "^:Changes Map to DC Burning", ::change_map_cr, "dcburning" );
			self add_option( "Dumpsite", "^:Changes Map to Dumpsite", ::change_map_cr, "boneyard" );
			self add_option( "Gulag", "^:Changes Map to Gulag", ::change_map_cr, "gulag" );
			self add_option( "Oilrig", "^:Changes Map to Oilrig", ::change_map_cr, "oilrig" );
			self add_option( "Safehouse", "^:Changes Map to Safehouse", ::change_map_cr, "estate" );
			self add_option( "Whiskey Hotel", "^:Changes Map to Whiskey Hotel", ::change_map_cr, "dc_whitehouse" );
			break;
        case "^:Modern Warfare 3":
            self add_menu(menu);
			self add_option( "Bootleg", "^:Changes Map to Bootleg", ::change_map, "mp_bootleg" );
			self add_option( "Dome", "^:Changes Map to Dome", ::change_map, "mp_dome" );
			self add_option( "Fallen", "^:Changes Map to Fallen", ::change_map, "mp_lambeth" );
			self add_option( "Hardhat", "^:Changes Map to Hardhat", ::change_map, "mp_hardhat" );
			self add_option( "Lockdown", "^:Changes Map to Lockdown", ::change_map, "mp_alpha" );
			self add_option( "Mission", "^:Changes Map to Mission", ::change_map, "mp_bravo" );
			self add_option( "Resistance", "^:Changes Map to Resistance", ::change_map, "mp_paris" );
			self add_option( "Underground", "^:Changes Map to Underground", ::change_map, "mp_underground" );
			self add_option( "Erosion", "^:Changes Map to Erosion", ::change_map, "mp_courtyard_ss" );
			break;
		case "^:Advanced Warfare":
            self add_menu(menu);
			self add_option( "Big Ben 2", "^:Changes Map to Big Ben 2", ::change_map, "mp_bigben2" );
			self add_option( "Climate 3", "^:Changes Map to Black Box", ::change_map, "mp_blackbox" );
			self add_option( "Climate 3", "^:Changes Map to Climate 3", ::change_map, "mp_climate_3" );
			self add_option( "Clowntown 3", "^:Changes Map to Clowntown 3", ::change_map, "mp_clowntown3" );
			self add_option( "Comeback", "^:Changes Map to Comeback", ::change_map, "mp_comeback" );
			self add_option( "Dam", "^:Changes Map to Dam", ::change_map, "mp_dam" );
			self add_option( "Detroit", "^:Changes Map to Detroit", ::change_map, "mp_detroit" );
			self add_option( "Fracture", "^:Changes Map to Fracture", ::change_map, "mp_fracture" );
			self add_option( "Greenband", "^:Changes Map to Greenband", ::change_map, "mp_greenband" );
			self add_option( "Highrise 2", "^:Changes Map to Highrise 2", ::change_map, "mp_highrise2" );
			self add_option( "Instinct", "^:Changes Map to Instinct", ::change_map, "mp_instinct" );
			self add_option( "Kremlin", "^:Changes Map to Kremlin", ::change_map, "mp_kremlin" );
			self add_option( "Lab 2", "^:Changes Map to Lab 2", ::change_map, "mp_lab2" );
			self add_option( "Lair", "^:Changes Map to Lair", ::change_map, "mp_lair" );
			self add_option( "Laser 2", "^:Changes Map to Laser 2", ::change_map, "mp_laser2" );
			self add_option( "Levity", "^:Changes Map to Levity", ::change_map, "mp_levity" );
			self add_option( "Liberty", "^:Changes Map to Liberty", ::change_map, "mp_liberty" );
			self add_option( "Lost", "^:Changes Map to Lost", ::change_map, "mp_lost" );
			self add_option( "Perplex 1", "^:Changes Map to Perplex 1", ::change_map, "mp_perplex_1" );
			self add_option( "Prison", "^:Changes Map to Prison", ::change_map, "mp_prison" );
			self add_option( "Recovery", "^:Changes Map to Recovery", ::change_map, "mp_recovery" );
			self add_option( "Refraction", "^:Changes Map to Refraction", ::change_map, "mp_refraction" );
			self add_option( "Sector 17", "^:Changes Map to Sector 17", ::change_map, "mp_sector17" );
			self add_option( "Seoul 2", "^:Changes Map to Seoul 2", ::change_map, "mp_seoul2" );
			self add_option( "Solar", "^:Changes Map to Solar", ::change_map, "mp_solar" );
			self add_option( "Spark", "^:Changes Map to Spark", ::change_map, "mp_spark" );
			self add_option( "Terrace", "^:Changes Map to Terrace", ::change_map, "mp_terrace" );
			self add_option( "Torqued", "^:Changes Map to Torqued", ::change_map, "mp_torqued" );
			self add_option( "Urban", "^:Changes Map to Urban", ::change_map, "mp_urban" );
			self add_option( "Venus", "^:Changes Map to Venus", ::change_map, "mp_venus" );
			break;
		case "^:Ported":
            self add_menu(menu);
			self add_option( "Haus", "^:Changes Map to Haus", ::change_map, "mp_haus" );
			self add_option( "Shipment: Long", "^:Changes Map to Shipment: Long", ::change_map, "mp_shipmentlong" );
			self add_option( "Stalingrad", "^:Changes Map to Stalingrad", ::change_map, "mp_stalingrad" );
			self add_option( "Summit", "^:Changes Map to Summit", ::change_map, "mp_mountain" );
			self add_option( "WaW Castle", "^:Changes Map to WaW Castle", ::change_map, "mp_waw_castle" );
			self add_option( "Pool Day", "^:Changes Map to Pool Day", ::change_map, "mp_poolday" );
			self add_option( "Pool Party", "^:Changes Map to Pool Party", ::change_map, "mp_poolparty" );
			break;
		case "^:Time Limit":
            self add_menu( menu );
			self add_option( "10 Seconds", "^:Set Time Limit to 10 Seconds", ::set_time_limit, 0.1 );
			self add_option( "1 Minute", "^:Set Time Limit to 1 Minute", ::set_time_limit, 1 );
			self add_option( "5 Minutes", "^:Set Time Limit to 5 Minutes", ::set_time_limit, 5 );
			self add_option( "10 Minutes", "^:Set Time Limit to 10 Minutes", ::set_time_limit, 10 );
			self add_option( "20 Minutes", "^:Set Time Limit to 20 Minutes", ::set_time_limit, 20 );
			self add_option( "30 Minutes", "^:Set Time Limit to 30 Minutes", ::set_time_limit, 30 );
			self add_option( "1 Hour", "^:Set Time Limit to 1 Hour", ::set_time_limit, 60 );
			self add_option( "2 Hours", "^:Set Time Limit to 2 Hours", ::set_time_limit, 120 );
			self add_option( "166,666,667 Hours", "^:Set Time Limit to 166,666,667 Hours", ::set_time_limit, "9999999999" );
			break;
		case "^:Score Max":
            self add_menu( menu );
			self add_option( "5 Max Score", "^:Sets Team Max Score to 5", ::set_team_max, 5 );
			self add_option( "10 Max Score", "^:Sets Team Max Score to 10", ::set_team_max, 10 );
			self add_option( "20 Max Score", "^:Sets Team Max Score to 20", ::set_team_max, 20 );
			self add_option( "30 Max Score", "^:Sets Team Max Score to 30", ::set_team_max, 30 );
			self add_option( "40 Max Score", "^:Sets Team Max Score to 40", ::set_team_max, 40 );
			self add_option( "50 Max Score", "^:Sets Team Max Score to 50", ::set_team_max, 50 );
			self add_option( "75 Max Score", "^:Sets Team Max Score to 75", ::set_team_max, 75 );
			self add_option( "100 Max Score", "^:Sets Team Max Score to 100", ::set_team_max, 100 );
			self add_option( "200 Max Score", "^:Sets Team Max Score to 200", ::set_team_max, 200 );
			self add_option( "500 Max Score", "^:Sets Team Max Score to 500", ::set_team_max, 500 );
			self add_option( "1000 Max Score", "^:Sets Team Max Score to 1000", ::set_team_max, 1000 );
            self add_option( "99999999 Max Score", "^:Sets Team Max Score to 99999999", ::set_team_max, "99999999" );
			break;
		case "^:Visions":
			self add_menu( menu );
			self add_option( "Default", undefined, ::vision_changer, "default" );
			self add_option( "Map Visions", "^:Visions For Maps", ::new_menu, "^:Map Visions" );
			self add_option( "Other Visions", "^:Other Visions", ::new_menu, "^:Other Visions" );
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
		case "^:Sun Color":
			self add_menu( menu );
			self add_toggle( "Disco", "^:Rapidly Changing Sun/Fog Color", ::disco_sun_toggle, self.disco_sun_toggle );
			self add_option( "Default", "^:Default Sun/Fog Color", ::sun_color, "1.1 1.05 0.85", "^7Default" );
			self add_option( "Red", "^:Red Sun/Fog Color", ::sun_color, "2 0 0", "^1Red" );
			self add_option( "Green", "^:Green Sun/Fog Color", ::sun_color, "0 2 0", "^2Green" );
			self add_option( "Blue", "^:Blue Sun/Fog Color", ::sun_color, "0 0 2", "^4Blue" );
			self add_option( "Yellow", "^:Yellow Sun/Fog Color", ::sun_color, "2 2 0", "^3Yellow" );
			self add_option( "Cyan", "^:Cyan Sun/Fog Color", ::sun_color, "0 2 2", "^5Cyan" );
			self add_option( "Pink", "^:Pink Sun/Fog Color", ::sun_color, "2 1 2", "^6Pink" );
			self add_option( "White", "^:White Sun/Fog Color", ::sun_color, "2 2 2", "^7White" );
			self add_option( "Black", "^:Black Sun/Fog Color", ::sun_color, "0 0 0", "^0Black" );
			break;
		case "^:Spawnables":
			self add_menu( menu );
			self add_option( "Destroy Spawnable", "^:Destroy Selected Spawnable", ::new_menu, "^:Destroy Spawnable" );
			self add_category( "^1spawnables a lil buggy rn" );
			self add_option( "Artillery Cannon", "^:Spawn Controllable Artillery Cannon", ::artillery_verify, "" );
			self add_option( "Skybase", "^:Spawn Controllable Sky Base", ::build_skybase2, "" );
			self add_option( "Bunker", "^:Spawn Bunker", ::spawn_bunker, "" );
			self add_option( "Trampoline", "^:Spawn Trampoline", ::trampoline, "" );
			self add_option( "Ferris Wheel", "^:Spawn Ferris Wheel Ride", ::ferris_verify, "" );
			self add_option( "Roller Coaster", "^:Spawn Roller Coaster Ride ^1(use again to delete)", ::coaster_verify, "" );
			self add_option( "The Centrox", "^:Spawn Centrox Ride", ::centrox_verify, "" );
			self add_option( "The Twister", "^:Spawn Twister Ride", ::twister_verify, "" );
			break;
		case "^:Destroy Spawnable":
			self add_menu( menu );
			self add_option( "Destroy Centrox", "^:Destroy Spawned Centrox", ::centrox_destroy, "" );
			self add_option( "Destroy Ferris Wheel", "^:Destroy Spawned Ferris Wheel", ::ferris_destroy, "" );
			break;
		case "^:Scripted Weapons":
            self add_menu( menu );
			self add_option( "Mustang and Sally", "^:Akimbo M1911's Firing M79 Grenades", ::mustang_sally, "" );
			self add_option( "Nova Gas", "^:Damaging Smoke Grenade", ::nova_gas, "" );
			self add_option( "Care Package Gun", "^:Spawn Care Package When Firing", ::care_package_gun, "" );
			self add_option( "Grappling Gun", "^:Move Towards Bullet Location", ::grappling_gun, "" );
			self add_option( "Mounted Turret", "^:Spawn Turret on Self", ::mounted_turret, "" );
			self add_option( "Teleport Gun", "^:Teleport to Bullet Location", ::teleport_gun, "" );
			self add_option( "Death Machine", "^:Rapidly Fires AC-130 25mm Rounds", ::death_machine, "" );
			self add_option( "Nuke AT4", "^:Fires a Nuke", ::nuke_at4, "" );
			self add_option( "Raygun", "^:Gives Raygun", ::raygun_give, "" );
			self add_option( "Rocket Grenade", "^:Throw an Exploding Rocket With [{+frag}]", ::rocket_nade, "" );
            break;
		case "^:Scripted Killstreaks":
			self add_menu( menu );
			self add_toggle( "Jetpack", "^:Give Jetpack | Hold [{+activate}] to Fly", ::jetpack_toggle, self.jetpack_toggle );
			self add_option( "Suicide Plane", "^:Crashes a Plane at Selected Location", ::suicide_plane, "" );
			self add_option( "Exploding Crawler", "^:Become a Zombie Crawler And Explode With [{+activate}]", ::exploding_crawler, "" );
			self add_option( "Mega Airdrop 1", "^:Custom Airdrop 1", ::mega_airdrop, "" );
			self add_option( "Mega Airdrop 2", "^:Custom Airdrop 2", ::mega_airdrop_remade, "" );
			self add_option( "Defense System", "^:Fires Rockets at Nearby Enemies", ::defense_system, "" );
			self add_option( "Rocket Barrage", "^:Fires a Rocket at All Living Enemies", ::rocket_barrage, "" );
			self add_option( "Super AC-130", "^:Circling AC-130", ::super_ac130, "" );
			self add_option( "Strafing Run", "^:Strafing Run With Two Passes", ::strafe_run_init, "" );
			self add_option( "Sonic Boom", "^:Spawns a Bomb at Bullet Location", ::sonic_boom, "" );
			self add_option( "Plane Collision", "^:Two Planes Collide Above The Player", ::plane_collision, "" );
			self add_option( "Suicide Bomber", "^:Press [{+attack}] to Detonate a Bomb", ::suicide_bomb, "" );
			break;
		case "^:Custom Projectile":
			self add_menu( menu );
			self add_option( "Default", "^:Reset Weapon Projectile", ::weapon_projectile, "Default" );
			self add_option( "Predator Missile", "^:Fire Predator Missiles", ::weapon_projectile, "remotemissile_projectile_mp" );
			self add_option( "Stinger Missile", "^:Fire Stinger Missiles", ::weapon_projectile, "stinger_mp" );
			self add_option( "Javelin Missile", "^:Fire Javelin Missiles", ::weapon_projectile, "javelin_mp" );
			self add_option( "AT4 Missile", "^:Fire AT4 Missiles", ::weapon_projectile, "at4_mp" );
			self add_option( "RPG Missile", "^:Fire RPG Missiles", ::weapon_projectile, "h2_rpg_mp" );
			self add_option( "M79 Grenade", "^:Fire M79 Grenades", ::weapon_projectile, "h2_m79_mp" );
			self add_option( "Harrier FFAR", "^:Fire FFAR Missiles", ::weapon_projectile, "harrier_FFAR_mp" );
			self add_option( "AC-130 25mm", "^:Fire AC-130 25mm Rounds", ::weapon_projectile, "ac130_25mm_mp" );
			self add_option( "AC-130 40mm", "^:Fire AC-130 40mm Rounds", ::weapon_projectile, "ac130_40mm_mp" );
			self add_option( "AC-130 105mm", "^:Fire AC-130 105mm Rounds", ::weapon_projectile, "ac130_105mm_mp" );
			self add_option( "Intervention", "^:Fire Intervention Rounds", ::weapon_projectile, "h2_cheytac_mp" );
			break;
		case "^:Gametype":
			self add_menu( menu );
			self add_option( "Free-for-All", "^:Change Gametype to Free-for-All", ::change_gametype, "dm" );
			self add_option( "Domination", "^:Change Gametype to Domination", ::change_gametype, "dom" );
			self add_option( "Search and Destroy", "^:Change Gametype to Search and Destroy", ::change_gametype, "sd" );
			self add_option( "Team Deathmatch", "^:Change Gametype to Team Deathmatch", ::change_gametype, "war" );
			self add_option( "Kill Confirmed", "^:Change Gametype to Kill Confirmed", ::change_gametype, "conf" );
			self add_option( "Headquarters", "^:Change Gametype to Headquarters", ::change_gametype, "koth" );
			self add_option( "Sabotage", "^:Change Gametype to Sabotage", ::change_gametype, "sab" );
			self add_option( "Capture the Flag", "^:Change Gametype to Capture the Flag", ::change_gametype, "ctf" );
			self add_option( "Demolition", "^:Change Gametype to Demolition", ::change_gametype, "dd" );
			self add_option( "Hardpoint", "^:Change Gametype to Hardpoint", ::change_gametype, "hp" );
			self add_option( "Gun Game", "^:Change Gametype to Gun Game", ::change_gametype, "gun" );
			break;
		case "^:Killstreaks":
			self add_menu( menu );
			self add_option( "UAV", "^:Give UAV", ::give_killstreak, "radar_mp" );
			self add_option( "Counter UAV", "^:Give Counter UAV", ::give_killstreak, "counter_radar_mp" );
			self add_option( "Care Package", "^:Give Care Package", ::give_killstreak, "airdrop_marker_mp" );
			self add_option( "Sentry Gun", "^:Give Sentry Gun", ::give_killstreak, "sentry_mp" );
			self add_option( "Predator Missile", "^:Give Predator Missile", ::give_killstreak, "predator_mp" );
			self add_option( "Precision Airstrike", "^:Give Precision Airstrike", ::give_killstreak, "airstrike_mp" );
			self add_option( "Harrier Strike", "^:Give Harrier Strike", ::give_killstreak, "harrier_airstrike_mp" );
			self add_option( "Attack Helicopter", "^:Give Attack Helicopter", ::give_killstreak, "helicopter_mp" );
			self add_option( "Advanced UAV", "^:Give Advanced UAV", ::give_killstreak, "advanced_uav_mp" );
            self add_option( "Emergency Airdrop", "^:Give Emergency Airdrop", ::give_killstreak, "airdrop_mega_marker_mp" );
			self add_option( "AH6 Overwatch", "^:Give AH6 Overwatch", ::give_killstreak, "ah6_mp" );
            self add_option( "Pavelow", "^:Give Pavelow", ::give_killstreak, "pavelow_mp" );
            self add_option( "Reaper", "^:Give Reaper", ::give_killstreak, "reaper_mp" );
			self add_option( "Stealth Bomber", "^:Give Stealth Bomber", ::give_killstreak, "stealth_airstrike_mp" );
			self add_option( "Chopper Gunner", "^:Give Chopper Gunner", ::give_killstreak, "chopper_gunner_mp" );
			self add_option( "AC-130", "^:Give AC-130", ::give_killstreak, "ac130_mp" );
			self add_option( "EMP", "^:Give EMP", ::give_killstreak, "emp_mp" );
			self add_option( "Nuke", "^:Give Nuke", ::give_killstreak, "nuke_mp" );
			break;
		case "^:Equipment":
			self add_menu( menu );
			self add_option( "Flash Grenade", "^:Set Equipment to Flash Grenade", ::give_equipment, "h1_flashgrenade_mp" );
			self add_option( "Stun Grenade", "^:Set Equipment to Stun Grenade", ::give_equipment, "h1_concussiongrenade_mp" );
			self add_option( "Smoke Grenade", "^:Set Equipment to Smoke Grenade", ::give_equipment, "h1_smokegrenade_mp" );
			self add_option( "Frag Grenade", "^:Set Equipment to Frag Grenade", ::give_equipment, "h1_fraggrenade_mp" );
			self add_option( "Frag Grenade (Short)", "^:Set Equipment to Frag Grenade (Shorter Cook Time)", ::give_equipment, "h1_fraggrenadeshort_mp" );
			self add_option( "Semtex", "^:Set Equipment to Semtex", ::give_equipment, "h2_semtex_mp" );
			self add_option( "Throwing Knife", "^:Set Equipment to Throwing Knife", ::give_equipment, "iw9_throwknife_mp" );
			self add_option( "Tactical Insertion", "^:Set Equipment to Tactical Insertion", ::give_equipment, "flare_mp" );
			self add_option( "Claymore", "^:Set Equipment to Claymore", ::give_equipment, "h1_claymore_mp" );
			self add_option( "C4", "^:Set Equipment to C4", ::give_equipment, "h1_c4_mp" );
			break;
		case "^:Lethal":
            self add_menu( menu );
			self add_option( "Flash Grenade", "^:Set Lethal to Flash Grenade", ::give_lethal, "h1_flashgrenade_mp" );
			self add_option( "Stun Grenade", "^:Set Lethal to Stun Grenade", ::give_lethal, "h1_concussiongrenade_mp" );
			self add_option( "Smoke Grenade", "^:Set Lethal to Smoke Grenade", ::give_lethal, "h1_smokegrenade_mp" );
			self add_option( "Frag Grenade", "^:Set Lethal to Frag Grenade", ::give_lethal, "h1_fraggrenade_mp" );
			self add_option( "Frag Grenade (Short)", "^:Set Lethal to Frag Grenade (Shorter Cook Time)", ::give_lethal, "h1_fraggrenadeshort_mp" );
			self add_option( "Semtex", "^:Set Lethal to Semtex", ::give_lethal, "h2_semtex_mp" );
			self add_option( "Throwing Knife", "^:Set Lethal to Throwing Knife", ::give_lethal, "iw9_throwknife_mp" );
			self add_option( "Tactical Insertion", "^:Set Lethal to Tactial Insertion", ::give_lethal, "flare_mp" );
			self add_option( "Claymore", "^:Set Lethal to Claymore", ::give_lethal, "h1_claymore_mp" );
			self add_option( "C4", "^:Set Lethal to C4", ::give_lethal, "h1_c4_mp" );
			break;
        case "^:Restart Map":
            self add_menu( menu );
			self add_option( "Confirm Restart", "^:Restart Current Game", ::restart_map, "" );
            break;
		case "^:End Game":
            self add_menu( menu );
			self add_option( "Confirm End Game", "^:End Current Game", ::end_game, "" );
            break;
        case "^:Knockback Menu":
            self add_menu( menu );
			self add_option( "0", "^:Set Knockback to 0", ::knockback_set, 0 );
			self add_option( "1", "^:Set Knockback to 1", ::knockback_set, 1 );
			self add_option( "100", "^:Set Knockback to 100", ::knockback_set, 100 );
			self add_option( "500", "^:Set Knockback to 500", ::knockback_set, 500 );
			self add_option( "1000 (Default)", "^:Set Knockback to Default", ::knockback_set, 1000 );
			self add_option( "10000", "^:Set Knockback to 10000", ::knockback_set, 10000 );
			self add_option( "50000", "^:Set Knockback to 10000", ::knockback_set, 50000 );
			self add_option( "999999", "^:Set Knockback to 999999", ::knockback_set, 999999 );
			self add_option( "99999999", "^:Set Knockback to 99999999", ::knockback_set, "9999999" );
            self add_option( "-500", "^:Set Knockback to -500", ::knockback_set, -500 );
			self add_option( "-10000", "^:Set Knockback to -10000", ::knockback_set, -10000 );
			self add_option( "-50000", "^:Set Knockback to -10000", ::knockback_set, -50000 );
			self add_option( "-999999", "^:Set Knockback to -999999", ::knockback_set, -999999 );
			self add_option( "-99999999", "^:Set Knockback to -99999999", ::knockback_set, "-9999999" );
            break;
		case "^:Gravity Menu":
            self add_menu( menu );
			self add_option( "1000", "^:Set Gravity to 1000", ::gravity_set, 1000 );
			self add_option( "800 (Default)", "^:Set Gravity to Default", ::gravity_set, 800 );
			self add_option( "600", "^:Set Gravity to 600", ::gravity_set, 600 );
			self add_option( "400", "^:Set Gravity to 400", ::gravity_set, 400 );
			self add_option( "200", "^:Set Gravity to 200", ::gravity_set, 200 );
			self add_option( "100", "^:Set Gravity to 100", ::gravity_set, 100 );
			self add_option( "75", "^:Set Gravity to 100", ::gravity_set, 75 );
			self add_option( "50", "^:Set Gravity to 50", ::gravity_set, 50 );
			self add_option( "25", "^:Set Gravity to 25", ::gravity_set, 25 );
			self add_option( "0", "^:Set Gravity to 0", ::gravity_set, 0 );
            break;
		case "^:Timescale Menu":
            self add_menu( menu );
			self add_option( "0.1", "^:Set Timescale to 0.1", ::timescale_set, 0.1 );
			self add_option( "0.25", "^:Set Timescale to 0.25", ::timescale_set, 0.25 );
			self add_option( "0.5", "^:Set Timescale to 0.5", ::timescale_set, 0.5 );
			self add_option( "0.75", "^:Set Timescale to 0.75", ::timescale_set, 0.75 );
			self add_option( "1 (Default)", "^:Set Timescale to Default", ::timescale_set, 1 );
			self add_option( "2", "^:Set Timescale to 2", ::timescale_set, 2 );
			self add_option( "3", "^:Set Timescale to 3", ::timescale_set, 3 );
			self add_option( "4", "^:Set Timescale to 4", ::timescale_set, 4 );
			self add_option( "8", "^:Set Timescale to 8", ::timescale_set, 8 );
			self add_option( "20", "^:Set Timescale to 20", ::timescale_set, 20 );
            break;
		case "^:Move Speed Menu":
            self add_menu( menu );
			self add_option( "1", "^:Set Movement Speed to 1", ::speed_set, 1 );
			self add_option( "90", "^:Set Movement Speed to 90", ::speed_set, 90 );
			self add_option( "190 (Default)", "^:Set Movement Speed to Default", ::speed_set, 190 );
			self add_option( "400", "^:Set Movement Speed to 400", ::speed_set, 400 );
			self add_option( "600", "^:Set Movement Speed to 600", ::speed_set, 600 );
			self add_option( "800", "^:Set Movement Speed to 800", ::speed_set, 800 );
			self add_option( "1000", "^:Set Movement Speed to 1000", ::speed_set, 1000 );
            break;
		case "^:Jump Height Menu":
            self add_menu( menu );
			self add_option( "20", "^:Set Jump Height to 20", ::jumpheight_set, 20 );
			self add_option( "41 (Default)", "^:Set Jump Height to Default", ::jumpheight_set, 41 );
			self add_option( "80", "^:Set Jump Height to 80", ::jumpheight_set, 80 );
			self add_option( "160", "^:Set Jump Height to 160", ::jumpheight_set, 160 );
			self add_option( "500", "^:Set Jump Height to 500", ::jumpheight_set, 500 );
			self add_option( "1000", "^:Set Jump Height to 1000", ::jumpheight_set, 1000 );
            break;
		case "^:Bot Difficulty":
            self add_menu( menu );
			self add_option( "Recruit", "^:Set Bot Difficulty to Recruit", ::bot_difficulty, "recruit" );
			self add_option( "Regular", "^:Set Bot Difficulty to Regular", ::bot_difficulty, "regular" );
			self add_option( "Hardened", "^:Set Bot Difficulty to Hardened", ::bot_difficulty, "hardened" );
			self add_option( "Veteran", "^:Set Bot Difficulty to Veteran", ::bot_difficulty, "veteran" );
            break;
        case "^:Weapon Editor":
            self add_menu( menu );
            self add_option( "Weapon", "^:Choose Weapon To Edit (Defaults To Current Gun)", ::new_menu, "^:Weapons" );
            self add_option( "Camo", "^:Choose Weapon Camo", ::new_menu, "^:Camos" );
            self add_category( "^1Attachment Order Matters!!" );
            self add_array( "Attachment 1", "^:Choose Weapon Attachment 1", ::set_attachment, level.attach_array, 0 );
            self add_array( "Attachment 2", "^:Choose Weapon Attachment 2", ::set_attachment, level.attach_array, 1 );
            self add_array( "Attachment 3", "^:Choose Weapon Attachment 3", ::set_attachment, level.attach_array, 2 );
            self add_array( "Attachment 4", "^:Choose Weapon Attachment 4", ::set_attachment, level.attach_array, 3 );
            self add_option( "Give Weapon Build", "^:Gives Weapon With Selected Options", ::build_weapon );
            break;
        case "^:Weapons":
            self add_menu( menu );
			self add_option( "MWR Weapons", "^:Modern Warfare Remastered Weapons", ::new_menu, "^:MWR Weapons" );
			self add_option( "MW2 Weapons", "^:Modern Warfare 2 Weapons", ::new_menu, "^:MW2 Weapons" );
			self add_option( "MW3 Weapons", "^:Modern Warfare 3 Weapons", ::new_menu, "^:MW3 Weapons" );
			self add_option( "Misc Weapons", "^:Miscellaneous Weapons", ::new_menu, "^:Misc Weapons" );
            break;
        case "^:MWR Weapons":
            self add_menu( menu );
			self add_option( "Rifles", "^:Modern Warfare Remastered Rifles", ::new_menu, "^:MWR Rifles" );
			self add_option( "SMGs", "^:Modern Warfare Remastered SMGs", ::new_menu, "^:MWR SMGs" );
			self add_option( "Pistols", "^:Modern Warfare Remastered Pistols", ::new_menu, "^:MWR Pistols" );
			self add_option( "Snipers", "^:Modern Warfare Remastered Snipers", ::new_menu, "^:MWR Snipers" );
			self add_option( "Battle Rifles", "^:Modern Warfare Remastered BRs", ::new_menu, "^:MWR Battle Rifles" );
			self add_option( "Shotguns", "^:Modern Warfare Remastered Shotguns", ::new_menu, "^:MWR Shotguns" );
			self add_option( "LMGs", "^:Modern Warfare Remastered LMGs", ::new_menu, "^:MWR LMGs" );
            break;
        case "^:MWR Rifles":
            self add_menu( menu );
			self add_option( "MWR MP44", "^:Give MP44", ::set_weapon, "h1_mp44_mp" );
			self add_option( "MWR Galil", "^:Give Galil", ::set_weapon, "h1_galil_mp" );
			self add_option( "MWR G36C", "^:Give G36C", ::set_weapon, "h1_g36c_mp" );
			self add_option( "MWR M4", "^:Give M4", ::set_weapon, "h1_m4_mp" );
			self add_option( "MWR M16", "^:Give M16", ::set_weapon, "h1_m16_mp" );
            break;
		case "^:MWR SMGs":
            self add_menu( menu );
			self add_option( "MWR AK74u", "^:Give AK74u", ::set_weapon, "h1_ak74u_mp" );
			self add_option( "MWR P90", "^:Give P90", ::set_weapon, "h1_p90_mp" );
			self add_option( "MWR Skorpion", "^:Give Skorpion", ::set_weapon, "h1_skorpion_mp" );
			self add_option( "MWR Mini-Uzi", "^:Give Mini-Uzi", ::set_weapon, "h1_mac10_mp" );
			break;
		case "^:MWR Pistols":
            self add_menu( menu );
			self add_option( "MWR M1911", "^:Give M1911", ::set_weapon, "h1_colt45_mp" );
			self add_option( "MWR .44 Magnum", "^:Give .44 Magnum", ::set_weapon, "h1_coltanaconda_mp" );
			self add_option( "MWR Deagle", "^:Give Desert Eagle", ::set_weapon, "h1_deserteagle_mp" );
			self add_option( "MWR Commanders Deagle", "^:Give Commanders Desert Eagle", ::set_weapon, "h1_deserteagle55_mp" );
			self add_option( "MWR PP2000", "^:Give PP2000", ::set_weapon, "h1_pp2000_mp" );
			self add_option( "MWR Beretta", "^:Give Beretta", ::set_weapon, "h1_beretta_mp" );
			self add_option( "MWR USP", "^:Give USP", ::set_weapon, "h1_usp_mp" );
            break;
		case "^:MWR Snipers":
            self add_menu( menu );
			self add_option( "MWR M40A3 (No Scope)", "^:Give M40A3 (No Scope)", ::set_weapon, "h1_m40a3_mp" );
			self add_option( "MWR Dragunov (No Scope)", "^:Give Dragunov (No Scope)", ::set_weapon, "h1_dragunov_mp" );
			self add_option( "MWR R700 (No Scope)", "^:Give R700 (No Scope)", ::set_weapon, "h1_remington700_mp" );
			self add_option( "MWR Dragunov (Scoped)", "^:Give VSS", ::set_weapon, "h1_vssvintorez_mp" );
			self add_option( "MWR Barrett (No Scope)", "^:Give Barrett", ::set_weapon, "h1_barrett_mp" );
            break;
		case "^:MWR Battle Rifles":
            self add_menu( menu );
			self add_option( "MWR M21 (No Scope)", "^:Give M21 (No Scope)", ::set_weapon, "h1_m21_mp" );
			self add_option( "MWR FAL (XM-LAR)", "^:Give XM-LAR", ::set_weapon, "h1_fal_mp" );
			self add_option( "MWR M14", "^:Give M14", ::set_weapon, "h1_m14_mp" );
			self add_option( "MWR G3", "^:Give G3", ::set_weapon, "h1_g3_mp" );
			break;
		case "^:MWR Shotguns":
            self add_menu( menu );
			self add_option( "MWR M1014", "^:Give M1014", ::set_weapon, "h1_m1014_mp" );
			self add_option( "MWR Striker", "^:Give Striker", ::set_weapon, "h1_striker_mp" );
			self add_option( "MWR Winchester 1200", "^:Give W1200", ::set_weapon, "h1_winchester1200_mp" );
            break;
		case "^:MWR LMGs":
            self add_menu( menu );
			self add_option( "MWR M60E4", "^:Give M60E4", ::set_weapon, "h1_m60e4_mp" );
			self add_option( "MWR M240", "^:Give M240", ::set_weapon, "h1_m240_mp" );
			self add_option( "MWR RPD", "^:Give RPD", ::set_weapon, "h1_rpd_mp" );
			self add_option( "MWR SAW", "^:Give SAW", ::set_weapon, "h1_saw_mp" );
			break;
		case "^:MW2 Weapons":
            self add_menu( menu );
			self add_option( "Rifles", "^:Modern Warfare 2 Rifles", ::new_menu, "^:MW2 ARs" );
			self add_option( "SMGs", "^:Modern Warfare 2 SMGs", ::new_menu, "^:MW2 SMGs" );
			self add_option( "Snipers", "^:Modern Warfare 2 Snipers", ::new_menu, "^:MW2 Snipers" );
			self add_option( "LMGs", "^:Modern Warfare 2 LMGs", ::new_menu, "^:MW2 LMGs" );
			self add_option( "Pistols", "^:Modern Warfare 2 Pistols", ::new_menu, "^:MW2 Pistols" );;
			self add_option( "Shotguns", "^:Modern Warfare 2 Shotguns", ::new_menu, "^:MW2 Shotguns" );
			self add_option( "Launchers", "^:Modern Warfare 2 Launchers", ::new_menu, "^:MW2 Launchers" );
			self add_option( "Melee", "^:Modern Warfare 2 Melee", ::new_menu, "^:MW2 Melee" );
            break;
        case "^:MW2 ARs":
            self add_menu( menu );
			self add_option( "M4", "^:Give M4", ::set_weapon, "h2_m4_mp" );
			self add_option( "FAMAS", "^:Give FAMAS", ::set_weapon, "h2_famas_mp" );
			self add_option( "SCAR", "^:Give SCAR", ::set_weapon, "h2_scar_mp" );
			self add_option( "TAR-21", "^:Give TAR-21", ::set_weapon, "h2_tavor_mp" );
			self add_option( "FAL", "^:Give FAL", ::set_weapon, "h2_fal_mp" );
			self add_option( "M16", "^:Give M16", ::set_weapon, "h2_m16_mp" );
			self add_option( "ACR", "^:Give ACR", ::set_weapon, "h2_masada_mp" );
			self add_option( "F2000", "^:Give F2000", ::set_weapon, "h2_fn2000_mp" );
			self add_option( "AK47", "^:Give AK47", ::set_weapon, "h2_ak47_mp" );
            break;
		case "^:MW2 SMGs":
            self add_menu( menu );
			self add_option( "MP5k", "^:Give MP5k", ::set_weapon, "h2_mp5k_mp" );
			self add_option( "UMP45", "^:Give UMP45", ::set_weapon, "h2_ump45_mp" );
			self add_option( "Vector", "^:Give Vector", ::set_weapon, "h2_kriss_mp" );
			self add_option( "P90", "^:Give P90", ::set_weapon, "h2_p90_mp" );
			self add_option( "Uzi", "^:Give Uzi", ::set_weapon, "h2_uzi_mp" );
			self add_option( "AK74u", "^:Give AK74u", ::set_weapon, "h2_ak74u_mp" );
            break;
		case "^:MW2 Snipers":
            self add_menu( menu );
			self add_option( "Intervention", "^:Give Intervention", ::set_weapon, "h2_cheytac_mp" );
			self add_option( "Barrett", "^:Give Barrett", ::set_weapon, "h2_barrett_mp" );
			self add_option( "WA2000", "^:Give WA2000", ::set_weapon, "h2_wa2000_mp" );
			self add_option( "M21", "^:Give M21", ::set_weapon, "h2_m21_mp" );
			self add_option( "M40A3", "^:Give M40A3", ::set_weapon, "h2_m40a3_mp" );
            break;
		case "^:MW2 LMGs":
            self add_menu( menu );
			self add_option( "L86", "^:Give L86", ::set_weapon, "h2_sa80_mp" );
			self add_option( "RPD", "^:Give RPD", ::set_weapon, "h2_rpd_mp" );
			self add_option( "MG4", "^:Give MG4", ::set_weapon, "h2_mg4_mp" );
			self add_option( "AUG", "^:Give AUG", ::set_weapon, "h2_aug_mp" );
			self add_option( "M240", "^:Give M240", ::set_weapon, "h2_m240_mp" );
            break;
		case "^:MW2 Pistols":
            self add_menu( menu );
			self add_option( "USP", "^:Give USP", ::set_weapon, "h2_usp_mp" );
			self add_option( ".44 Magnum", "^:Give .44 Magnum", ::set_weapon, "h2_coltanaconda_mp" );
			self add_option( "M9", "^:Give M9", ::set_weapon, "h2_m9_mp" );
			self add_option( "M1911", "^:Give M1911", ::set_weapon, "h2_colt45_mp" );
			self add_option( "Deagle", "^:Give Desert Eagle", ::set_weapon, "h2_deserteagle_mp" );
			self add_option( "PP2000", "^:Give PP2000", ::set_weapon, "h2_pp2000_mp" );
			self add_option( "Glock 18", "^:Give Glock 18", ::set_weapon, "h2_glock_mp" );
			self add_option( "Raffica", "^:Give Raffica", ::set_weapon, "h2_beretta393_mp" );
			self add_option( "TMP", "^:Give TMP", ::set_weapon, "h2_tmp_mp" );
            break;
		case "^:MW2 Shotguns":
            self add_menu( menu );
			self add_option( "SPAS-12", "^:Give SPAS-12", ::set_weapon, "h2_spas12_mp" );
			self add_option( "AA-12", "^:Give AA-12", ::set_weapon, "h2_aa12_mp" );
			self add_option( "Striker", "^:Give Striker", ::set_weapon, "h2_striker_mp" );
			self add_option( "Ranger", "^:Give Ranger", ::set_weapon, "h2_ranger_mp" );
			self add_option( "W1200", "^:Give W1200", ::set_weapon, "h2_winchester1200_mp" );
			self add_option( "M1014", "^:Give M1014", ::set_weapon, "h2_m1014_mp" );
			self add_option( "Model 1887", "^:Give Model 1887", ::set_weapon, "h2_model1887_mp" );
            break;
		case "^:MW2 Launchers":
            self add_menu( menu );
			self add_option( "AT4", "^:Give AT4", ::set_weapon, "at4_mp" );
			self add_option( "Thumper", "^:Give Thumper", ::set_weapon, "h2_m79_mp" );
			self add_option( "Stinger", "^:Give Stinger", ::set_weapon, "stinger_mp" );
			self add_option( "Javelin", "^:Give Javelin", ::set_weapon, "javelin_mp" );
			self add_option( "RPG", "^:Give RPG", ::set_weapon, "h2_rpg_mp" );
            break;
		case "^:MW2 Melee":
            self add_menu( menu );
			self add_option( "Hatchet", "^:Give Hatchet", ::set_weapon, "h2_hatchet_mp" );
			self add_option( "Sickle", "^:Give Sickle", ::set_weapon, "h2_sickle_mp" );
			self add_option( "Shovel", "^:Give Shovel", ::set_weapon, "h2_shovel_mp" );
			self add_option( "Ice Pick", "^:Give Ice Pick", ::set_weapon, "h2_icepick_mp" );
			self add_option( "Karambit", "^:Give Karambit", ::set_weapon, "h2_karambit_mp" );
            break;
        case "^:MW3 Weapons":
            self add_menu( menu );
			self add_option("Rifles", "^:Modern Warfare 3 Rifles", ::new_menu, "^:MW3 ARs" );
			self add_option("SMGs", "^:Modern Warfare 3 SMGs", ::new_menu, "^:MW3 SMGs" );
			self add_option("Snipers", "^:Modern Warfare 3 Snipers", ::new_menu, "^:MW3 Snipers" );
			self add_option("LMGs", "^:Modern Warfare 3 LMGs", ::new_menu, "^:MW3 LMGs" );
			self add_option("Pistols", "^:Modern Warfare 3 Pistols", ::new_menu, "^:MW3 Pistols" );;
			self add_option("Shotguns", "^:Modern Warfare 3 Shotguns", ::new_menu, "^:MW3 Shotguns" );
			self add_option("Launchers", "^:Modern Warfare 3 Launchers", ::new_menu, "^:MW3 Launchers" );
            break;
        case "^:MW3 ARs":
            self add_menu( menu );
			self add_option("G36C", "^:Give G36C", ::set_weapon, "h2_g36c_mp" );
			self add_option("CM901", "^:Give CM901", ::set_weapon, "h2_cm901_mp" );
            break;
		case "^:MW3 SMGs":
            self add_menu( menu );
			self add_option("PP90M1", "^:Give PP90M1", ::set_weapon, "h2_bizon_mp" );
			self add_option("MP7", "^:Give MP7", ::set_weapon, "h2_mp7_mp" );
            break;
		case "^:MW3 Snipers":
            self add_menu( menu );
			self add_option("MSR", "^:Give MSR", ::set_weapon, "h2_msr_mp" );
			self add_option("AS50", "^:Give AS50", ::set_weapon, "h2_as50_mp" );
			self add_option("D25S", "^:Give D25S", ::set_weapon, "h2_d25s_mp" );
            break;
		case "^:MW3 LMGs":
            self add_menu( menu );
			self add_option("PKM", "^:Give PKM", ::set_weapon, "h2_pkm_mp" );
            break;
		case "^:MW3 Pistols":
            self add_menu( menu );
			self add_option("FMG", "^:Give FMG9", ::set_weapon, "h2_fmg9_mp" );
			self add_option("MP412", "^:Give MP412", ::set_weapon, "h2_mp412_mp" );
            break;
		case "^:MW3 Shotguns":
            self add_menu( menu );
			self add_option("KSG", "^:Give KSG", ::set_weapon, "h2_ksg_mp" );
            break;
		case "^:MW3 Launchers":
            self add_menu( menu );
			self add_option("M320", "^:Give M320", ::set_weapon, "h2_m320_mp" );
            break;
        case "^:Misc Weapons":
            self add_menu( menu );
			self add_option( "Default Weapon", "^:Give Default Weapon", ::set_weapon, "defaultweapon_mp" );
			self add_option( "AC130 25mm", "^:Give AC-130 25mm", ::set_weapon, "ac130_25mm_mp" );
			self add_option( "AC130 40mm", "^:Give AC-130 40mm", ::set_weapon, "ac130_40mm_mp" );
			self add_option( "AC130 105mm", "^:Give AC-130 105mm", ::set_weapon, "ac130_105mm_mp" );
			self add_option( "Infected", "^:Give Infected", ::set_weapon, "h2_infect_mp" );
			self add_option( "One Man Army Bag", "^:Give One Man Army", ::set_weapon, "onemanarmy_mp" );
			self add_option( "Remote Missile Projectile (Stinger Knife)", "^:Give Remote Missile Projectile", ::set_weapon, "remotemissile_projectile_mp" );
			self add_option( "Harrier FFAR (Stinger Knife)", "^:Give Harrier FFAR", ::set_weapon, "harrier_FFAR_mp" );
            self add_option( "MWR Uzi (No Model)", "^:Give Uzi (No Model)", ::set_weapon, "h1_uzi_mp" );
			self add_option( "MWR AK-47 (No Model)", "^:Give AK-47 (No Model)", ::set_weapon, "h1_ak47_mp" );
			self add_option( "MWR MP5 (No Barrel)", "^:Give MP5 (No Barrel)", ::set_weapon, "h1_mp5_mp" );
			self add_option( "Bomb Explosion", "^:Give Bomb Explosion", ::set_weapon, "bomb_site_mp" );
			self add_option( "Vehicle Explosion", "^:Give Vehicle Explosion", ::set_weapon, "destructible_car" );
			self add_option( "Destructible Toy (Weird Claymore)", "^:Give Destructible Toy", ::set_weapon, "destructible_toy" );
			self add_option( "Stealth Bomb (Weird Claymore)", "^:Give Stealth Bomb", ::set_weapon, "stealth_bomb_mp" );
			self add_option( "ADS Zoom 5 FOV", "^:Give Camera 5 FOV", ::set_weapon, "camera_5fov" );
			self add_option( "ADS Zoom 10 FOV", "^:Give Camera 10 FOV", ::set_weapon, "camera_10fov" );
			self add_option( "ADS Zoom 20 FOV", "^:Give Camera 20 FOV", ::set_weapon, "camera_20fov" );
			self add_option( "ADS Zoom 30 FOV", "^:Give Camera 30 FOV", ::set_weapon, "camera_30fov" );
			self add_option( "ADS Zoom 45 FOV", "^:Give Camera 45 FOV", ::set_weapon, "camera_45fov" );
            break;
        case "^:Camos":
            self add_menu( menu );
            self add_option( "None", undefined, ::set_camo, "" );
			self add_option( "Classic", "^:Classic Camos", ::new_menu, "^:Classic Camos" );
			self add_option( "Colors", "^:Color Camos",  ::new_menu, "^:Color Camos" );
			self add_option( "Polyatomic", "^:Polyatomic Camos",  ::new_menu, "^:Polyatomic Camos" );
			self add_option( "Elemental", "^:Elemental Camos",  ::new_menu, "^:Elemental Camos" );
			self add_option( "Special", "^:Special Camos",  ::new_menu, "^:Special Camos" );
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
			self add_option( "Give God Mode", "^:Give God Mode", ::give_god_mode, player );
			self add_option( "Remove God Mode", "^:Remove God Mode", ::remove_god_mode, player );
            self add_option( "Give Menu Access", "^:Give Menu Access", ::menu_access, player );
            self add_option( "Give Admin Access", "^:Give Admin Access", ::admin_access, player );
			self add_option( "Remove Menu Access", "^:Give Menu Access", ::remove_access, player );
			self add_option( "Give Current Weapon", "^:Give Selected Player Your Current Weapon", ::give_current_weapon, player );
            self add_option( "Give Killstreak", "^:Give Selected Player a Killstreak", ::new_menu, "^:Give Killstreak" );
            self add_option( "Give All Perks", "^:Give All Perks", ::give_player_perks, player );
            self add_option( "Remove All Perks", "^:Remove All Perks", ::remove_player_perks, player );
            self add_option( "Remove Weapons", "^:Remove Selected Players Weapons", ::remove_player_weapons, player );
            self add_option( "Freeze", "^:Freeze Selected Player", ::freeze_player, player );
            self add_option( "Unfreeze", "^:Unfreeze Selected Player", ::unfreeze_player, player );
            self add_option( "Teleport to Player", "^:Teleport to Selected Player", ::teleport_to_player, player );
			self add_option( "Teleport to Self", "^:Teleport Selected Player to Self", ::teleport_player_self, player );
            self add_option( "Teleport to Crosshair", "^:Teleport Selected Player to Crosshair", ::teleport_player_crosshair, player );
            self add_option( "Send to Space", "^:Send Selected Player to Space", ::space_player, player );
            self add_option( "Warn", "^:Warn Selected Player", ::warn_player, player );
			self add_option( "Kill", "^:Kill Selected Player", ::kill_player, player );
            self add_option( "Kick", "^:Kick Selected Player", ::kick_player, player getEntityNumber() );
			self add_option( "Warn (IW4MAdmin)", "^:Warn Selected Player ^1(IW4MAdmin)", ::warn_iw4madmin, player );
			self add_option( "Warn Clear (IW4MAdmin)", "^:Warn Selected Player ^1(IW4MAdmin)", ::warnclear_iw4madmin, player );
			self add_option( "Temp Ban (IW4MAdmin)", "^:Temporarily Ban Selected Player ^1(IW4MAdmin)", ::tempban_iw4madmin, player );
			self add_option( "Ban (IW4MAdmin)", "^:Ban Selected Player ^1(IW4MAdmin)", ::ban_iw4madmin, player );
			self add_option( "Print GUID", "^:Print Selected Players GUID", ::print_player_guid, player );
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
        case "^:Give Killstreak":
			self add_menu( menu );
			self add_option( "UAV", "^:Give UAV", ::give_player_killstreak, player, "radar_mp" );
			self add_option( "Counter UAV", "^:Give Counter UAV", ::give_player_killstreak, player, "counter_radar_mp" );
			self add_option( "Care Package", "^:Give Care Package", ::give_player_killstreak, player, "airdrop_marker_mp" );
			self add_option( "Sentry Gun", "^:Give Sentry Gun", ::give_player_killstreak, player, "sentry_mp" );
			self add_option( "Predator Missile", "^:Give Predator Missile", ::give_player_killstreak, player, "predator_mp" );
			self add_option( "Precision Airstrike", "^:Give Precision Airstrike", ::give_player_killstreak, player, "airstrike_mp" );
			self add_option( "Harrier Strike", "^:Give Harrier Strike", ::give_player_killstreak, player, "harrier_airstrike_mp" );
			self add_option( "Attack Helicopter", "^:Give Attack Helicopter", ::give_player_killstreak, player, "helicopter_mp" );
            self add_option( "Advanced UAV", "^:Give Advanced UAV", ::give_player_killstreak, player, "advanced_uav_mp" );
			self add_option( "Emergency Airdrop", "^:Give Emergency Airdrop", ::give_player_killstreak, player, "airdrop_mega_marker_mp" );
			self add_option( "AH6 Overwatch", "^:Give AH6 Overwatch", ::give_player_killstreak, player, "ah6_mp" );
            self add_option( "Pavelow", "^:Give Pavelow", ::give_player_killstreak, player, "pavelow_mp" );
            self add_option( "Reaper", "^:Give Reaper", ::give_player_killstreak, player, "reaper_mp" );
			self add_option( "Stealth Bomber", "^:Give Stealth Bomber", ::give_player_killstreak, player, "stealth_airstrike_mp" );
			self add_option( "Chopper Gunner", "^:Give Chopper Gunner", ::give_player_killstreak, player, "chopper_gunner_mp" );
            self add_option( "AC-130", "^:Give AC-130", ::give_player_killstreak, player, "ac130_mp" );
			self add_option( "EMP", "^:Give EMP", ::give_player_killstreak, player, "emp_mp" );
			self add_option( "Nuke", "^:Give Nuke", ::give_player_killstreak, player, "nuke_mp" );
            break;
    }
}