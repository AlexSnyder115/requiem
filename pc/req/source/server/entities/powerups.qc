.float zombie_drop_id;
.float flashtime;
.float flash_step;

void() firesale =
{
	entity salebox;
	salebox = find(world, classname, "mystery_box_tp_spot");
	makevectors (salebox.v_angle);
	salebox.classname = "mystery_firesale";
	salebox.touch = mystery_touch;
	salebox.solid = SOLID_TRIGGER;
	setmodel (salebox, "models/machines/mystery.mdl");
}

void() maxammo =
{
	entity tempe, temp;
	
	tempe = find (world, classname, "player");
	while (tempe)
	{	
		if (!tempe.downed)
		{
			if (tempe.weapon)
			{
				if (tempe.perks & P_CANDO)
					tempe.currentammo = (getWeaponAmmo(tempe.weapon) + (getWeaponMag(tempe.weapon) * 2));
				else
					tempe.currentammo = getWeaponAmmo(tempe.weapon);
				if (!tempe.currentmag)
				{
					temp = self;
					self = tempe;
					W_Reload(S_BOTH);
					self = temp;
				}
			}
			if (tempe.secondaryweapon) {
				if (tempe.perks & P_CANDO)
					tempe.secondaryammo = (getWeaponAmmo(tempe.secondaryweapon) + (getWeaponMag(tempe.secondaryweapon) * 2));
				else
					tempe.secondaryammo = getWeaponAmmo(tempe.secondaryweapon);
			}
			
			tempe.primary_grenades = 4;
			
			if (tempe.grenades & 2)
        tempe.secondary_grenades = 2;
		}
		tempe = find (tempe, classname, "player");
	}
}


void() nuke =
{
	local entity oldself;
	local entity who;
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
	
	who = find(world,classname,"player");
	while(who)
	{
		who = find(who,classname,"player");
	}
}

void() carpenter =
{
	local entity oldself;
	local entity who;
	oldself = self;
	
	
	who = find(world,classname,"window");
	while(who != world)
	{
		if(who.health < 6 && who.health != -10)//-10 is for boardless windows
		{
			self = who;
			window_carpenter_1 ();
			who.health = 6;
			self = oldself;
		}
		
		who = find(who,classname,"window");
	}
	
	who = find(world,classname,"player");
	while(who)
	{
		addmoney(who,200,1);
		
		who = find(who,classname,"player");
	}
	total_windows_down = 0;
}

void() give_perk =
{
  local float t;
  
  t = random();
  	
  if (t < 0.166 && !(other.perks & P_REVIVE))
  {
  other.perks = other.perks | 8;
  }
  else if (t < 0.333 && !(other.perks & P_JUG))
  {
  other.perks = other.perks | 1;
  }
  else if (t < 0.5 && !(other.perks & P_DOUBLE))
  {
  other.perks = other.perks | 2;
  }
  else if (t < 0.6666 && !(other.perks & P_SPEED))
  {
  other.perks = other.perks | 4;
  }
  else if (t < 0.8333 && !(other.perks & P_FLOP))
  {
  other.perks = other.perks | 16;
  }
  else if (t < 1 && !(other.perks & P_STAMIN))
  {
  other.perks = other.perks | 32;
  }
  else if (t <= 1 && (other.perks & P_STAMIN) && (other.perks & P_REVIVE) && (other.perks & P_JUG) && (other.perks & P_DOUBLE) && (other.perks & P_SPEED) && (other.perks & P_FLOP))
    return;
  else
    give_perk();
}




void() powerup_flash =
{
	if(self.flash_step == 0)
	{
		self.flash_step = 1;
		self.flashtime = time + 3;
		self.nextthink = time + 0.6;
	}
	else if(self.flash_step == 1)
	{
		self.nextthink = time + 0.6;
		
		if(self.flashtime < time)
		{
			self.flash_step = 2;
			self.nextthink = time + 0.3;
			self.flashtime = time + 3;
		}

	}
	else if(self.flash_step == 2)
	{
		self.nextthink = time + 0.3;
		
		if(self.flashtime < time)
		{
			self.flash_step = 3;
			self.nextthink = time + 0.15;
			self.flashtime = time + 3;
		}
		
	}
	else if(self.flash_step == 3)
	{
		self.nextthink = time + 0.15;
		if(self.flashtime < time)
		{
			setmodel(self,"");
			setmodel(self.owner,"");
			remove(self.owner);
			remove(self);
			return;
		}
	}
	
	if(self.model == "")
	{
		if(self.zombie_drop_id == 1)
			setmodel(self,"progs/Misc/maxammo!.mdl");
		if(self.zombie_drop_id == 2)
			setmodel(self,"progs/Misc/x2!.mdl");
		if(self.zombie_drop_id == 3)
			setmodel(self,"progs/Misc/instakill!.mdl");
		if(self.zombie_drop_id == 4)
			setmodel(self,"progs/Misc/nuke!.mdl");
		if(self.zombie_drop_id == 5)
			setmodel(self,"progs/Misc/carpenter!.mdl");
		if(self.zombie_drop_id == 6)
			setmodel(self,"progs/Misc/firesale!.mdl");
		if(self.zombie_drop_id == 7)
			setmodel(self,"models/weapons/mg/g_mg.mdl");
	}
	else
	{
		setmodel(self,"");
	}
};

void() powerup_touch =
{
  local float t;
  local float exp;
  
  if (x2_finished > time)
	exp = 2;
  else
	exp = 1;
  
  t = random();
  
	if(other.classname == "player")
	{
		sound(self.owner,CHAN_VOICE,"sounds/pu/pickup.wav",1,ATTN_NONE);
		
		if(self.zombie_drop_id == 1)
		{
			sound(self,CHAN_VOICE,"sounds/pu/maxammo.wav",1,ATTN_NONE);
			maxammo();
		}
		else if(self.zombie_drop_id == 2)
		{
			sound(self,CHAN_VOICE,"sounds/pu/double_points.wav",1,ATTN_NONE);   

			x2_finished = time + 30;
			other.x2_icon = true;
		}
		else if(self.zombie_drop_id == 3)
		{
			sound(self,CHAN_VOICE,"sounds/pu/insta_kill.wav",1,ATTN_NONE);
			instakill_finished = time + 30;
			other.insta_icon = true;
		}
		else if(self.zombie_drop_id == 4)
		{
			sound(self,CHAN_VOICE,"sounds/pu/nuke.wav",1,ATTN_NONE);
			addmoney(other, 400*exp, 0);
			nuke();
		}
		else if(self.zombie_drop_id == 5)
		{
			addmoney(other, 200*exp, 0);
			carpenter();
		}
		else if(self.zombie_drop_id == 6)
		{
			if (boxmoved == 1)
			{
				firesale();
				firesale_finished = time + 30;
				other.sale_icon = true;
				hassale = true;
			}
		}
		else if(self.zombie_drop_id == 7)
		{
			other.dmweapon = other.weapon;
			other.dmammo = other.currentammo;
			other.dmmag = other.currentmag;
			other.dm2weapon = other.secondaryweapon;
			other.dm2ammo = other.secondaryammo;
			other.dm2mag = other.secondarymag;
			other.weapon = W_BARRACUDA;
			other.currentmag = 999;
			other.secondaryweapon = 0;
			other.weaponmodel = GetWeaponModel(W_BARRACUDA, 0);
			SwitchWeapon(other.weapon);
			Set_W_Frame (GetFrame(other.weapon, TAKE_OUT_START), GetFrame(other.weapon, TAKE_OUT_END), 0, 0, 0, SUB_Null, GetWeaponModel(other.weapon, 0), false, S_BOTH);
			dm_finished = time + 30;
			other.dm_icon = true;
		}
		stuffcmd(other, "bf\n");
		remove(self.owner);
		remove(self);
	}
};

void() sparkle_think =
{
	local float f;
	f = self.frame;
	local float r;
	while(f == self.frame)
	{
		r = random();
		r = ((r > 0.2) ? 1 : 0) + ((r > 0.4) ? 1 : 0) + ((r > 0.6) ? 1 : 0) + ((r > 0.8) ? 1 : 0);
		f = r;
	}
	self.frame = f;
	
	self.think = sparkle_think;
	self.nextthink = time + 0.1;
	
	if(self.calc_time <= time)
	{
		sound(self,CHAN_VOICE,"sounds/pu/powerup.wav",0.6,ATTN_NORM);
		self.calc_time = time + 2.998;
	}
	
};

float last_pu;
void(vector where, float type) Spawn_Powerup =
{
	entity new_powerup;
	float t;

	new_powerup = spawn();
	new_powerup.origin = where;
	setorigin(new_powerup, new_powerup.origin);
	new_powerup.solid = SOLID_TRIGGER;
	new_powerup.classname = "item_powerup";
	new_powerup.effects = EF_GREEN;

	
	setsize (new_powerup, VEC_HULL_MIN, VEC_HULL_MAX);
	new_powerup.movetype = MOVETYPE_NONE;
	//new_powerup.effects = EF_GREENLIGHT;
	//new_powerup.effects = new_powerup.effects | EF_BRIGHTLIGHT;
	
	//=================== Sparkle Effects =====================
	entity twlt_Sparkle;
	twlt_Sparkle = spawn();
	new_powerup.owner = twlt_Sparkle; //just a reference so power up can delete the sparkle later on
	
	setorigin(twlt_Sparkle,where);
	//setmodel(twlt_Sparkle,"progs/Sprites/sprkle.spr");
	
	twlt_Sparkle.think = sparkle_think;
	twlt_Sparkle.nextthink = time + 0.1;
	sound(twlt_Sparkle,CHAN_VOICE,"sounds/pu/powerup.wav",0.6,ATTN_NORM);
	
	sound(new_powerup,CHAN_AUTO,"sounds/pu/drop.wav",1,ATTN_NONE);
	//========================================================
	t = random();
	
	if (!type) {
		if (total_windows_down >= 5 && boxmoved == 1)
    	{
        	if (t < (1/7))
        	{
            	setmodel(new_powerup,"progs/Misc/maxammo!.mdl");
            	new_powerup.zombie_drop_id = 1;
        	}
        	else if (t < (2/7))
        	{
       			setmodel(new_powerup,"progs/Misc/x2!.mdl");
            	new_powerup.zombie_drop_id = 2;
        	}
        	else if (t < (3/7))
        	{
            	setmodel(new_powerup,"progs/Misc/instakill!.mdl");
            	new_powerup.zombie_drop_id = 3;
        	}
        	else if (t < (4/7))
        	{
            	setmodel(new_powerup,"progs/Misc/nuke!.mdl");
            	new_powerup.zombie_drop_id = 4;
        	}
        	else if (t < (5/7))
        	{
            	setmodel(new_powerup,"progs/Misc/carpenter!.mdl");
            	new_powerup.zombie_drop_id = 5;
        	}
        	else if (t < (6/7))
        	{
            	setmodel(new_powerup,"progs/Misc/firesale!.mdl");
            	new_powerup.zombie_drop_id = 6;
        	}
        	else
        	{
        		setmodel(new_powerup,"models/weapons/mg/g_mg.mdl");
        		new_powerup.zombie_drop_id = 7;
        	}
        if (total_windows_down >= 5)
        {
        	if (t < (1/6))
        	{
            	setmodel(new_powerup,"progs/Misc/maxammo!.mdl");
            	new_powerup.zombie_drop_id = 1;
        	}
        	else if (t < (2/6))
        	{
       			setmodel(new_powerup,"progs/Misc/x2!.mdl");
            	new_powerup.zombie_drop_id = 2;
        	}
        	else if (t < (3/6))
        	{
            	setmodel(new_powerup,"progs/Misc/instakill!.mdl");
            	new_powerup.zombie_drop_id = 3;
        	}
        	else if (t < (4/6))
        	{
            	setmodel(new_powerup,"progs/Misc/nuke!.mdl");
            	new_powerup.zombie_drop_id = 4;
        	}
        	else if (t < (5/6))
        	{
            	setmodel(new_powerup,"progs/Misc/carpenter!.mdl");
            	new_powerup.zombie_drop_id = 5;
        	}
        	else
        	{
        		setmodel(new_powerup,"models/weapons/mg/g_mg.mdl");
        		new_powerup.zombie_drop_id = 7;
        	}
        }
        /*else
     {
            setmodel(new_powerup,"progs/Misc/perkbottle!.mdl");
            new_powerup.zombie_drop_id = 7;
        }*/
    	}
    	else
    	{
        	if (t < (1/5))
        	{
            	setmodel(new_powerup,"progs/Misc/maxammo!.mdl");
            	new_powerup.zombie_drop_id = 1;
        	}
        	else if (t < (2/5))
        	{
            	setmodel(new_powerup,"progs/Misc/x2!.mdl");
            	new_powerup.zombie_drop_id = 2;
        	}
        	else if (t < (3/5))
        	{
            	setmodel(new_powerup,"progs/Misc/instakill!.mdl");
            	new_powerup.zombie_drop_id = 3;
        	}
        	else if (t < (4/5))
        	{
            	setmodel(new_powerup,"progs/Misc/nuke!.mdl");
            	new_powerup.zombie_drop_id = 4;
        	}
        	else
        	{
        		setmodel(new_powerup,"models/weapons/mg/g_mg.mdl");
        		new_powerup.zombie_drop_id = 7;
        	}
        /*
        else
     {
            setmodel(new_powerup,"progs/Misc/perkbottle!.mdl");
            new_powerup.zombie_drop_id = 7;
        }
        */
        }
	} else if (type == 1) {
		setmodel(new_powerup,"progs/Misc/maxammo!.mdl");
		new_powerup.zombie_drop_id = 1;
	}
	last_pu = new_powerup.zombie_drop_id;
	new_powerup.touch = powerup_touch;
	
	new_powerup.think = powerup_flash;
	new_powerup.nextthink = time + 21;
	totalpowerups = 1;
}