//
// damage.qc -- used for any sort of down, hit, etc that the player or entity experiences
//

void() EndGame_Restart =
{
	localcmd("restart");
}

// Fade to black function, creates another think for restart
void() EndGame_FadePrompt =
{
	PromptLevelChange(time + 6, 2, self);
	self.think = EndGame_Restart;
	self.nextthink = time + 5;
}


void() ReturnWeaponModel;

//Spawn the downed Who's Who player
void() respawnplayer =
{
	local entity who, plr;
	who = find(world,classname, "who");
	plr = find(world,classname, "player");
	SetPerk(plr, plr.perks);
	plr.perks = 0;
	plr.perkcount = 0;
	setorigin(plr, who.origin);
	if (whoq == 1)
	{
		plr.perks = plr.perks | 8;
		plr.perkcount++;
		whoq = 0;
	}
	if (whoflop == 1)
	{
		plr.perks = plr.perks | 16;
		plr.perkcount++;
		whoflop = 0;
	}
	if (whojug == 1)
	{
		plr.perks = plr.perks | 1;
		plr.perkcount++;
		whojug = 0;
	}
	if (whorun == 1)
	{
		plr.perks = plr.perks | 32;
		plr.perkcount++;
		whorun = 0;
	}
	if (whospd == 1)
	{
		plr.perks = plr.perks | 4;
		plr.perkcount++;
		whospd = 0;
	}
	if (whodt == 1)
	{
		plr.perks = plr.perks | 2;
		plr.perkcount++;
		whodt = 0;
	}
	if (whocry == 1)
	{
		plr.perks = plr.perks | 64;
		plr.perkcount++;
		whocry = 0;
	}
	if (whocan == 1)
	{
		plr.perks = plr.perks | 128;
		plr.perkcount++;
		whocan = 0;
	}
	if (whoamm == 1)
	{
		plr.perks = plr.perks | 256;
		plr.perkcount++;
		whoamm = 0;
	}
	if (whomul == 1)
	{
		plr.perks = plr.perks | 512;
		plr.perkcount++;
		whomul = 0;
	}
	if (whoded == 1)
	{
		plr.perks = plr.perks | 1024;
		plr.perkcount++;
		whoded = 0;
	}
	SetPerk(plr, plr.perks);
	plr.weapon = plr.weaponbk;
	plr.currentammo = plr.currentammobk;
	plr.currentmag = plr.currentmagbk;
	plr.currentmag2 = plr.currentmagbk2;
	plr.secondaryweapon = plr.secondaryweaponbk;
	plr.secondarymag = plr.secondarymagbk;
	plr.secondarymag2 = plr.secondarymag2bk;
	plr.secondaryammo = plr.secondaryammobk;
	plr.weaponmodel = GetWeaponModel(plr.weapon, 0);// Give weapon model
	plr.movetype = MOVETYPE_WALK;
	SwitchWeapon(plr.weapon);
	remove(who);
}

void() touch_who =
{
	useprint(other, 25, 0, 0);
	if (other.button7 && other.progress_bar_time < time)
	{
		other.movetype = MOVETYPE_NONE;
		Set_W_Frame (0, 21, 0, 0, SPRINT, ReturnWeaponModel, "models/v_morphine.mdl", false, S_BOTH);	
		if !(other.perks & P_REVIVE)
			other.progress_bar_time = 4;
		else
			other.progress_bar_time = 2;

		other.fire_delay = other.progress_bar_time + time;
					
		other.progress_bar = other.progress_bar_time + time;     
		other.progress_bar_percent = 1;
		self.think = respawnplayer;
		self.nextthink = other.progress_bar_time + time;
	}
}

void() SpawnWhoDown =
{
	precache_model("models/player.mdl");
	local entity ppoint, who;
	ppoint = find(world, classname, "player");
	who = spawn();
	who.classname = "who";
	setorigin(who, ppoint.origin);
	setmodel(who, "models/player.mdl");
	who.touch = touch_who;
	who.frame = 36;
	who.solid = SOLID_TRIGGER;
}

//Actual endgame function, all zombies die, music plays
void() EndGame =
{
	local entity oldself;
	local entity who;

	self.health = 0;
	//WriteByte (MSG_ALL, SVC_INTERMISSION);
	self.origin = '0 0 0';
	setorigin (self, self.origin);
	self.velocity = '0 0 0';
	sound (self, CHAN_AUTO, strcat("sounds/music/", soundstyle, "/end.wav"), 1, ATTN_NORM);

	oldself = self;
	
	who = find(world,classname,"ai_zombie");
	while(who != world)
	{
		if(who.health)
		{
			self = who;
			self.th_die();
			self = oldself;
		}
		
		who = find(who,classname,"ai_zombie");
	}
	self.think = EndGame_FadePrompt;
	if (soundstyle == "cod")
		self.nextthink = time + 28;
	else
		self.nextthink = time + 33;
}

// removes revive icon from downed player heads, used as a recursive think function
void() remove_revive =
{
	if (self.owner.beingrevived)
		setmodel (self, "progs/Sprites/revive_white.spr");
	else
		setmodel (self, "progs/Sprites/revive.spr");

	if (!self.owner.downed || self.owner.isspec)
		SUB_Remove ();
	else {
		self.think = remove_revive;
		self.nextthink = time + 0.1;
	}
}

// when dead and other players exist and are alive, throw user into spectate mode
void() startspectate =
{
	if (!self.downed)
		return;
		
	if (self.beingrevived)
	{
		self.think = startspectate;
		self.nextthink = time + 0.1;
		return;
	}
	
	self.downedloop = 0;
	self.beingrevived = false;
	self.model = "";
	setmodel(self, self.model);
	self.health = 100;
	self.weaponmodel = "";
	self.weapon2model = "";
	self.downed = 0;
	self.frame = 0;

	UpdateVmodel(self.weaponmodel, GetWepSkin(self.weapon));
	UpdateV2model(self.weapon2model, GetWepSkin(self.weapon));
	
	SpectatorSpawn();
}

// searches for players that are alive given which clients have which playernumbers
//      Returns 1 if there IS someone in the world that's not downed
float() PollPlayersAlive = 
{
	float i, gotalive;
	entity playerent;
	
	gotalive = 0;
	
	for (i = 1; i <= 4; i++)
	{
		playerent = findfloat(world, playernum, i);
		
		if (playerent) {
			if (!playerent.downed && !playerent.isspec) {
				gotalive = 1;
				break;
			}
		}
	}
	
	return gotalive;
}

// Endgamesetup -- think function for setting up the death of everyone
void() EndGameSetup =
{
	game_over = true;
	self.health = 10;
	self.think = EndGame;
	self.nextthink = time + 5;
	self.weapon = 0;
	self.currentammo = 0;
	self.currentmag = 0;
	self.weaponmodel = "";
	self.weapon2model = "";
	self.animend = SUB_Null;
	self.perks = 0;
	self.isspec = true;
	SetPerk(self, self.perks);
	SwitchWeapon(0);		
    return;
}

// rec_downed is used as a recursive loop where we consistently check to see if ALL players are downed
//    if they aren't dead, we keep looping until our OWN death (45 seconds, so 450 loops)
void() rec_downed = 
{
	self.downedloop++;
	if (self.downedloop == /*450*/ 40) {
		startspectate();
		return;
	}
	
	float gotalive = PollPlayersAlive();
	
	if (!gotalive) {
		EndGameSetup();
		return;
	}
	
	self.think = rec_downed;
	self.nextthink = time + 0.1;
}

void() GetDown =
{
	if (self.perks & P_WHO)
	{
		if (self.perks & P_REVIVE)
		{
			whoq = 1;
		}
		if (self.perks & P_FLOP)
		{
			whoflop = 1;
		}
		if (self.perks & P_JUG)
		{
			whojug = 1;
		}
		if (self.perks & P_STAMIN)
		{
			whorun = 1;
		}
		if (self.perks & P_SPEED)
		{
			whospd = 1;
		}
		if (self.perks & P_DOUBLE)
		{
			whodt = 1;
		}
		if (self.perks & P_CHERRY)
		{
			whocry = 1;
		}
		if (self.perks & P_CANDO)
		{
			whocan = 1;
		}
		if (self.perks & P_AMMO)
		{
			whoamm = 1;
		}
		if (self.perks & P_MULE)
		{
			whomul = 1;
		}
		if (self.perks & P_DEAD)
		{
			whoded = 1;
		}
		self.perks = 0;
		SetPerk(self, self.perks);
		self.perkcount = 0;
		self.weaponbk = self.weapon;
		self.currentammobk = self.currentammo;
		self.currentmagbk = self.currentmag;
		self.currentmagbk2 = self.currentmag2;
		self.secondaryweaponbk = self.secondaryweapon;
		self.secondarymagbk = self.secondarymag;
		self.secondarymag2bk = self.secondarymag2;
		self.secondaryammobk = self.secondaryammo;
		local entity spoint;
		spoint = find(world, classname, "info_player_start");
		self.weapon = W_COLT;
		self.currentmag = 8;
		self.currentammo = 32;
		self.secondaryweapon = 0;
		self.weaponmodel = GetWeaponModel(self.weapon, 0);// Give weapon model
		SwitchWeapon(self.weapon);
		SpawnWhoDown();
		setorigin(self, spoint.origin);
		self.downed = 0;
		return;
	}
	float startframe;
	float endframe;
	local string modelname;
	
	playdown();
	
	self.view_ofs = '0 0 -15';
	self.velocity = '-80 0 -80';           			// Stop any old movement
	self.zoom = 0;
	self.downed = true;
	self.movetype = MOVETYPE_NONE;
	
	float gotalive = PollPlayersAlive();	
	
	if ((!deathmatch && !coop && !(self.perks & P_REVIVE)) || !gotalive)
	{
		EndGameSetup();
		return;
	}
	else if (coop) {
	self.health = 19; 
	self.downed = true;
	} else {
		self.health = 19;
	}
	
	if (self.perks && P_REVIVE && !coop) {	
		if (!self.perks && P_WHO)
		{
			self.progress_bar = 10 + time;     
			self.progress_bar_time = 10;
			self.progress_bar_percent = 1;
		}
	}
	self.points = 10*rint((self.points*0.95)/10);
	addmoney(self, 0, true);						// used to call a broadcast
	BroadcastMessage(time + 3, 2);
	
	self.perks = 0;
	self.weaponbk = self.weapon;
	self.currentammobk = self.currentammo;
	self.currentmagbk = self.currentmag;
	self.currentmagbk2 = self.currentmag2;
	
	if (self.weapon == W_BIATCH || self.secondaryweapon == W_BIATCH || self.progress_bar_percent > 0) {
		self.weapon = W_BIATCH;
		self.currentammo = 12;
		self.currentmag = 6;
		self.currentmag2 = 6;
	} else {
		self.weapon = W_COLT;
		self.currentammo = 16;
		self.currentmag = 8;
	}
      
  	modelname = GetWeaponModel(self.weapon, 0);
	self.weaponmodel = modelname;
	SwitchWeapon(self.weapon);
	
	startframe = GetFrame(self.weapon,TAKE_OUT_START);
	endframe = GetFrame(self.weapon,TAKE_OUT_END);
	Set_W_Frame (startframe, endframe, 0, 0, 0, SUB_Null, modelname, false, S_BOTH);
	
	local entity revive;
	
	revive = spawn ();
	revive.owner = self;
	revive.movetype = MOVETYPE_NONE;
	revive.solid = SOLID_NOT;
	revive.think = remove_revive;
	revive.nextthink = time + 0.1;

	setmodel (revive, "progs/Sprites/revive.spr");
	revive.origin = self.origin + VEC_VIEW_OFS;
	setorigin (revive, revive.origin);
	
	SetPerk(self, 0);
	
	self.think = rec_downed;
	self.nextthink = time + 0.1;
}

void () GetUp =
{
	local string modelname;
	float startframe;
	float endframe;
	
	playgetup();				// animation
	
	self.view_ofs = VEC_VIEW_OFS;
	self.health = 100;
	self.downedloop = 0;		// used for death timing vs endgame
	self.downed = 0;
	self.classname = "player";
	if (self.weaponbk)
	{
		self.weapon = self.weaponbk;
		self.currentammo = self.currentammobk;
		self.currentmag = self.currentmagbk;
		self.currentmag2 = self.currentmagbk2;
	}	
	modelname = GetWeaponModel(self.weapon, 0);
	self.weaponmodel = modelname;
	SwitchWeapon(self.weapon);
	self.movetype = MOVETYPE_WALK;
  
  	startframe = GetFrame(self.weapon,TAKE_OUT_START);
	endframe = GetFrame(self.weapon,TAKE_OUT_END);
	Set_W_Frame (startframe, endframe, 0, 0, 0, SUB_Null, modelname, false, S_BOTH);
	
};

// poll checking whether to see if our revive invoke is active
void(entity ent) CheckRevive =
{
	if (self.invoke_revive) {
		GetUp();
		self.invoke_revive = 0;
	}
}

void(entity attacker, float d_style) DieHandler =
{
    float t;

    t = random();

    if (self.classname == "ai_zombie" || self.classname == "ai_dog") {
        self.th_die();
    }

    if (attacker.classname == "player") {
        if (d_style == S_NORMAL) {
            addmoney(attacker, 60, true);
            total_powerup_points = total_powerup_points + 60;
            givexp(attacker, 10);
        }
		else if (d_style == S_KNIFE){
			addmoney(attacker, 130, true);
			hasknifed = 1;
			total_powerup_points = total_powerup_points + 130;
			givexp(attacker, 20);
		}
    }
}

void(entity victim,entity attacker, float damage, float d_style) DamageHandler = {
	entity old_self;
	if (victim.classname == "ai_zombie" || victim.classname == "ai_dog") {

		if (attacker.classname == "player" && (victim.health - damage)> 0) {
			addmoney(attacker, 10, 1);
        }

		victim.health = victim.health - damage;

		if (d_style == S_EXPLOSIVE) {
			if (victim.health < z_health*0.5)
			{
				if (victim.crawling != TRUE && !(victim.health <= 0) && crawler_num < 5 && victim.classname != "ai_dog")
				{
					makeCrawler(victim);	
				}
				else
				{
					if (attacker.classname == "player" && (victim.health - damage)> 0)
					addmoney(attacker, 10, 1);
				}
			}
			else 
				victim.th_die();	
				
			if (victim.health <= 0) {
				addmoney(attacker, 60, 1);
				if (attacker.weapon == W_RAY)
            		attacker.raykill = 1;
			}
		}

		if (victim.health <= 0 || instakill_finished) {
			old_self = self;
			self = victim;
			DieHandler(attacker, d_style);
			self = old_self;
		}
	} else if (victim.classname == "player" && !victim.downed) {
		if (victim.flags & FL_GODMODE) {
			return;
		}
		
		if (victim.perks & P_JUG)
			damage = ceil(damage*0.5);
		
		victim.health = victim.health - damage;
		victim.health_delay = time + 2;

		if (victim.health <= 20)
		{
			old_self = self;
			self = victim;
			GetDown();
			self = old_self;
		}
	}
}

/*
============
CanDamage

Returns true if the inflictor can directly damage the target.  Used for
explosions and melee attacks.
============
*/
float(entity targ, entity inflictor) CanDamage =
{
	if (targ.flags == FL_GODMODE)
    return FALSE;
// bmodels need special checking because their origin is 0,0,0
	if (targ.movetype == MOVETYPE_PUSH)
	{
		traceline(inflictor.origin, 0.5 * (targ.absmin + targ.absmax), TRUE, self);
		if (trace_fraction == 1)
			return TRUE;
		if (trace_ent == targ)
			return TRUE;
		return FALSE;
	}
    
	traceline(inflictor.origin, targ.origin, TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '-15 15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;
	traceline(inflictor.origin, targ.origin + '15 -15 0', TRUE, self);
	if (trace_fraction == 1)
		return TRUE;

	return FALSE;
};

void(entity inflictor, entity attacker, float damage2, float mindamage, float radius) DamgageExplode =
{
	local	float 	final_damage;
	local	entity	ent;

	local float multi,r;
	ent = findradius(inflictor.origin, radius);
	
	while (ent)
	{
		if(ent.classname == "player")
		{
      if (ent.perks & P_FLOP)
        final_damage = 0;
      else
      {
        final_damage = radius - vlen(inflictor.origin - ent.origin);
        if(final_damage < 0)
          continue;
        
        if (final_damage > radius * 0.6)
          final_damage = 100;
          
          if (final_damage < other.health)
          {
            addmoney(self, 10, 0);
          }
          else if (final_damage > other.health)
          {
              addmoney(self, 60, 0);
              }
        else
        {
          final_damage /= radius;
          final_damage *= 60;
        }
        DamageHandler (attacker, attacker, final_damage, S_EXPLOSIVE);
    }
		}
		else if (ent.takedamage && ent.classname != "ai_zombie_head" && ent.classname != "ai_zombie_larm" && ent.classname != "ai_zombie_rarm")
		{			
			r = rounds;
			multi = 1.07;
			while(r > 0)
			{
				multi *= 1.05;
				r --;
			}
			
			if (mindamage == 75)
        final_damage = (200 * multi) + 185;
      else
        final_damage = (mindamage + damage2)/2;
			
			if (final_damage > 0)
			{
				/* ndaekill = true; */
				if (CanDamage (ent, inflictor))
					DamageHandler (ent, attacker, final_damage, S_EXPLOSIVE);
				/* kill = false; */
			}
		}
		ent = ent.chain;
	}
};