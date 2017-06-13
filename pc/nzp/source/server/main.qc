//
//	Main.qc - mostly functions that will be called from the engine and are expected to exist
//

//called when starting server/loading the map
void() main =
{
	localcmd("echo Server starting...\n");

}

//called for each frame that QC runs
void() StartFrame =
{
	deathmatch = cvar("deathmatch");
	coop = cvar("coop");
	framecount = framecount + 1;

	if (waypoint_mode) {
		return;
	}
	
	if (roundinit) {
		Round_Core();
		Do_Zombie_AI ();
	} else {
	
	entity SpawnedIn;
	SpawnedIn = find(world, classname, "player");
	
	if (SpawnedIn)
		InitRounds();
		
	}
	
}

//called when map loaded
void() worldspawn =
{
	precache_model ("models/player.mdl");
	
	precache_model ("models/ai/zfull.mdl");
	precache_model ("models/ai/zb#.mdl");
	precache_model ("models/ai/zal(.mdl");
	precache_model ("models/ai/zar(.mdl");
	precache_model ("models/ai/zh^.mdl");
	
	precache_model ("models/ai/zcfull.mdl");
	precache_model ("models/ai/zbc#.mdl");
	precache_model ("models/ai/zalc(.mdl");
	precache_model ("models/ai/zarc(.mdl");
	precache_model ("models/ai/zhc^.mdl");

	precache_model ("progs/Misc/maxammo!.mdl");
	precache_model ("progs/Misc/x2!.mdl");
	precache_model ("progs/Misc/instakill!.mdl");
	precache_model ("progs/Misc/nuke!.mdl");
	precache_model ("progs/Misc/carpenter!.mdl");
	
	precache_sound("sounds/player/footstep1.wav");
	precache_sound("sounds/player/footstep2.wav");
	precache_sound("sounds/player/footstep3.wav");
	precache_sound("sounds/player/footstep4.wav");
	precache_sound("sounds/player/footstep5.wav");
	precache_sound("sounds/player/jump.wav");
	precache_sound("sounds/player/land.wav");
	precache_sound("sounds/items/health.wav");
	precache_sound("sounds/items/respawn.wav");
	precache_sound("sounds/misc/shock.wav");

	precache_sound("sounds/weapons/colt/magin.wav");
	precache_sound("sounds/weapons/colt/magout.wav");
	precache_sound("sounds/weapons/colt/shoot.wav");
	precache_sound("sounds/weapons/colt/slide.wav");

	precache_sound("sounds/weapons/papfire.wav");
	
	precache_sound("sounds/weapons/grenade/prime.wav");
	precache_sound("sounds/weapons/grenade/throw.wav");
	precache_sound("sounds/weapons/grenade/explode.wav");
	
	precache_sound("sounds/weapons/knife/knife_hitbod.wav");
	precache_sound("sounds/weapons/knife/knife.wav");
	precache_sound("sounds/weapons/knife/knife_hit.wav");
	
	precache_sound("sounds/rounds/nzp/eround.wav");
	precache_sound("sounds/rounds/nzp/nround.wav");
	precache_sound("sounds/rounds/nzp/splash.wav");
	precache_sound("sounds/rounds/ds/eround.wav");
	precache_sound("sounds/rounds/ds/nround.wav");
	precache_sound("sounds/rounds/ds/splash.wav");
	precache_sound("sounds/music/end.wav");
	precache_sound("sounds/null.wav");

	precache_sound("sounds/misc/buy.wav");
	precache_sound("sounds/misc/wood_door.wav");
	precache_sound("sounds/misc/debris.wav");
	precache_sound("sounds/misc/ds/ching.wav");
	precache_sound("sounds/misc/nzp/ching.wav");

	
	precache_model ("models/weapons/m1911/v_colt.mdl");
	precache_model ("models/weapons/m1911/g_colt.mdl");
	precache_model ("progs/VModels/v_nade.mdl");
	precache_model ("progs/GModels/g_grenade.mdl");
	precache_model ("progs/GModels/g_betty.mdl");

	
	
	//sprites
	precache_model ("models/way/current_way.spr");
	precache_model ("models/way/current_way_door.spr");
	precache_model ("models/way/last_way.spr");
	precache_model ("models/way/last_way_door.spr");
	precache_model ("models/way/normal_way.spr");
	precache_model ("models/way/normal_way_door.spr");
	precache_model ("models/way/way_jump.spr");
	precache_model ("models/way/way_land.spr");
	precache_model ("progs/Sprites/sprkle.spr");


	
	//Walk
	
	precache_sound ("sounds/zombie/ds/w0.wav");
	precache_sound ("sounds/zombie/ds/w1.wav");
	precache_sound ("sounds/zombie/ds/w2.wav");
	precache_sound ("sounds/zombie/ds/w3.wav");
	precache_sound ("sounds/zombie/ds/w4.wav");
	precache_sound ("sounds/zombie/ds/w5.wav");
	precache_sound ("sounds/zombie/ds/w6.wav");
	precache_sound ("sounds/zombie/ds/w7.wav");
	precache_sound ("sounds/zombie/ds/w8.wav");
	precache_sound ("sounds/zombie/ds/w9.wav");
	//Run
	precache_sound ("sounds/zombie/ds/r0.wav");
	precache_sound ("sounds/zombie/ds/r1.wav");
	precache_sound ("sounds/zombie/ds/r2.wav");
	precache_sound ("sounds/zombie/ds/r3.wav");
	precache_sound ("sounds/zombie/ds/r4.wav");
	precache_sound ("sounds/zombie/ds/r5.wav");
	precache_sound ("sounds/zombie/ds/r6.wav");
	precache_sound ("sounds/zombie/ds/r7.wav");
	precache_sound ("sounds/zombie/ds/r8.wav");
	precache_sound ("sounds/zombie/ds/r9.wav");
	//Attack
	precache_sound ("sounds/zombie/ds/a0.wav");
	precache_sound ("sounds/zombie/ds/a1.wav");
	precache_sound ("sounds/zombie/ds/a2.wav");
	precache_sound ("sounds/zombie/ds/a3.wav");
	precache_sound ("sounds/zombie/ds/a4.wav");
	precache_sound ("sounds/zombie/ds/a5.wav");
	precache_sound ("sounds/zombie/ds/a6.wav");
	precache_sound ("sounds/zombie/ds/a7.wav");
	//Death
	precache_sound ("sounds/zombie/ds/d0.wav");
	precache_sound ("sounds/zombie/ds/d1.wav");
	precache_sound ("sounds/zombie/ds/d2.wav");
	precache_sound ("sounds/zombie/ds/d3.wav");
	precache_sound ("sounds/zombie/ds/d4.wav");
	precache_sound ("sounds/zombie/ds/d5.wav");
	precache_sound ("sounds/zombie/ds/d6.wav");
	precache_sound ("sounds/zombie/ds/d7.wav");
	//Taunt
	precache_sound ("sounds/zombie/ds/t0.wav");
	precache_sound ("sounds/zombie/ds/t1.wav");
	precache_sound ("sounds/zombie/ds/t2.wav");
	precache_sound ("sounds/zombie/ds/t3.wav");
	precache_sound ("sounds/zombie/ds/t4.wav");
	//Footsteps
	precache_sound ("sounds/zombie/ds/s0.wav");
	precache_sound ("sounds/zombie/ds/s1.wav");
	precache_sound ("sounds/zombie/ds/sc0.wav");
	precache_sound ("sounds/zombie/ds/sc1.wav");
	precache_sound ("sounds/zombie/nzp/w0.wav");
	precache_sound ("sounds/zombie/nzp/w1.wav");
	precache_sound ("sounds/zombie/nzp/w2.wav");
	precache_sound ("sounds/zombie/nzp/w3.wav");
	precache_sound ("sounds/zombie/nzp/w4.wav");
	precache_sound ("sounds/zombie/nzp/w5.wav");
	precache_sound ("sounds/zombie/nzp/w6.wav");
	precache_sound ("sounds/zombie/nzp/w7.wav");
	precache_sound ("sounds/zombie/nzp/w8.wav");
	precache_sound ("sounds/zombie/nzp/w9.wav");
	//Run
	precache_sound ("sounds/zombie/nzp/r0.wav");
	precache_sound ("sounds/zombie/nzp/r1.wav");
	precache_sound ("sounds/zombie/nzp/r2.wav");
	precache_sound ("sounds/zombie/nzp/r3.wav");
	precache_sound ("sounds/zombie/nzp/r4.wav");
	precache_sound ("sounds/zombie/nzp/r5.wav");
	precache_sound ("sounds/zombie/nzp/r6.wav");
	precache_sound ("sounds/zombie/nzp/r7.wav");
	precache_sound ("sounds/zombie/nzp/r8.wav");
	precache_sound ("sounds/zombie/nzp/r9.wav");
	//Attack
	precache_sound ("sounds/zombie/nzp/a0.wav");
	precache_sound ("sounds/zombie/nzp/a1.wav");
	precache_sound ("sounds/zombie/nzp/a2.wav");
	precache_sound ("sounds/zombie/nzp/a3.wav");
	precache_sound ("sounds/zombie/nzp/a4.wav");
	precache_sound ("sounds/zombie/nzp/a5.wav");
	precache_sound ("sounds/zombie/nzp/a6.wav");
	precache_sound ("sounds/zombie/nzp/a7.wav");
	//Death
	precache_sound ("sounds/zombie/nzp/d0.wav");
	precache_sound ("sounds/zombie/nzp/d1.wav");
	precache_sound ("sounds/zombie/nzp/d2.wav");
	precache_sound ("sounds/zombie/nzp/d3.wav");
	precache_sound ("sounds/zombie/nzp/d4.wav");
	precache_sound ("sounds/zombie/nzp/d5.wav");
	precache_sound ("sounds/zombie/nzp/d6.wav");
	precache_sound ("sounds/zombie/nzp/d7.wav");
	//Taunt
	precache_sound ("sounds/zombie/nzp/t0.wav");
	precache_sound ("sounds/zombie/nzp/t1.wav");
	precache_sound ("sounds/zombie/nzp/t2.wav");
	precache_sound ("sounds/zombie/nzp/t3.wav");
	precache_sound ("sounds/zombie/nzp/t4.wav");
	//Footsteps
	precache_sound ("sounds/zombie/nzp/s0.wav");
	precache_sound ("sounds/zombie/nzp/s1.wav");
	precache_sound ("sounds/zombie/nzp/sc0.wav");
	precache_sound ("sounds/zombie/nzp/sc1.wav");
	//Announce
	precache_sound ("sounds/pu/pickup.wav");
	precache_sound ("sounds/pu/maxammo.wav");
	precache_sound ("sounds/pu/double_points.wav");
	precache_sound ("sounds/pu/insta_kill.wav");
	precache_sound ("sounds/pu/nuke.wav");
	precache_sound ("sounds/pu/powerup.wav");
	precache_sound ("sounds/pu/drop.wav");


	clientstat(STAT_CURRENTMAG, EV_FLOAT, currentmag);
	clientstat(STAT_CURRENTMAG2, EV_FLOAT, currentmag2);
	clientstat(STAT_POINTS, EV_FLOAT, points);
	clientstat(STAT_WEAPON2FRAME, EV_FLOAT, weapon2frame);
	clientstat(STAT_WEAPON2MODEL, EV_STRING, weapon2model);
	clientstat(STAT_GRENADES, EV_FLOAT, primary_grenades);
	clientstat(STAT_SECGRENADES, EV_FLOAT, secondary_grenades);
	clientstat(STAT_PROGRESSBAR, EV_FLOAT, progress_bar_percent);
	clientstat(STAT_WEAPONDURATION, EV_FLOAT, weapon_animduration);
	clientstat(STAT_WEAPON2DURATION, EV_FLOAT, weapon2_animduration);
	clientstat(STAT_WEAPONZOOM, EV_FLOAT, zoom);
	clientstat(STAT_PLAYERNAME, EV_FLOAT, playernumber);
	clientstat(STAT_INSTA, EV_FLOAT, insta_icon);
	clientstat(STAT_X2, EV_FLOAT, x2_icon);
	mappath = strcat("maps/", mapname);
	mappath = strzone(mappath);

	LoadWaypointData();
}

void() SpectatorConnect =
{
	bprint(PRINT_HIGH, self.netname);
	bprint(PRINT_HIGH, " has joined the spectators.\n");
}

