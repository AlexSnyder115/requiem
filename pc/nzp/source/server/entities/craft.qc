void() touch_clamps =
{
	if (self.classname == "crafting_clamps" && self.fire_delay < time)
	{
		useprint (other, 17, 0, 0);
		if (other.button7)
		{
			other.hasclamps = TRUE;
			remove (self);
		}
	}
}

void() touch_dolly =
{
	if (self.classname == "crafting_dolly" && self.fire_delay < time)
	{
		useprint (other, 17, 0, 0);
		if (other.button7)
		{
			other.hasdolly = TRUE;
			remove (self);
		}
	}
}

void() touch_grate =
{
	if (self.classname == "crafting_grate" && self.fire_delay < time)
	{
		useprint (other, 17, 0, 0);
		if (other.button7)
		{
			other.hasgrate = TRUE;
			remove (self);
		}
	}
}

void() isCrafting =
{
	entity tempe = self;
	self = other;
	if (self.sprinting) {
		W_SprintStop();
	}
	self.knife_delay = self.reload_delay2 = self.fire_delay2 = self.fire_delay = self.reload_delay = 4.5 + time;		
	Set_W_Frame (0, 22, 0, 0, PERK, 0, "models/machines/v_craft.mdl", true, S_RIGHT);
	self = tempe;
	sound (other, CHAN_ITEM, "sounds/machines/perk_drink.wav", 1, ATTN_NORM);
}




void() touch_table =
{
	if (self.classname == "crafting_table" && other.fire_delay < time)
	{
		useprint (other, 15, 0, 0);
		if (other.button7)
		{
			if (other.hasclamps == TRUE && other.hasgrate == TRUE && other.hasdolly == TRUE)
			{
				isCrafting();
				entity tablemodel; 
				entity tableorigin; 
				tablemodel = spawn (); 
				tableorigin = find(world,classname,"crafting_table"); 
				setorigin(tablemodel,tableorigin.origin); 
				setmodel (tablemodel,"models/machines/craft.mdl");
				remove (self);
				
			}
			else
				useprint (other, 16, 0, 0);
		}
	}
}

void() crafting_table =
{
	self.solid = SOLID_TRIGGER;
	precache_model ("models/machines/craft.mdl");
	precache_model ("models/machines/v_craft.mdl");
	precache_sound ("sounds/machines/perk_drink.wav");
	setorigin (self, self.origin);
	setmodel (self, "models/machines/craft.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.classname = "crafting_table";
	self.touch = touch_table;
};

void() crafting_clamps =
{
	self.solid = SOLID_TRIGGER;
	precache_model ("models/machines/clamps.mdl");
	setorigin (self, self.origin);
	setmodel (self, "models/machines/clamps.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.classname = "crafting_clamps";
	self.touch = touch_clamps;
}

void() crafting_dolly =
{
	self.solid = SOLID_TRIGGER;
	precache_model ("models/machines/dolly.mdl");
	setorigin (self, self.origin);
	setmodel (self, "models/machines/dolly.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.classname = "crafting_dolly";
	self.touch = touch_dolly;
}

void() crafting_grate =
{
	self.solid = SOLID_TRIGGER;
	precache_model ("models/machines/grate.mdl");
	setorigin (self, self.origin);
	setmodel (self, "models/machines/grate.mdl");
	setsize (self, VEC_HULL2_MIN, VEC_HULL2_MAX);
	self.classname = "crafting_grate";
	self.touch = touch_grate;
}