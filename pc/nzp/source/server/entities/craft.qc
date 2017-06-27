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
	if (self.classname == "crafting_table" && self.fire_delay < time)
	{
		useprint (other, 15, 0, 0);
		if (other.button7)
		{
			addmoney (other, -2000, 0);
			isCrafting();
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