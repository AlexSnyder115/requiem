// 
//		Clientfuncs -- used to communicate between server and client
//

void SetUpdate(entity client, float type, float val1, float val2, float val3)
{
	if (type != 2)
	{
		msg_entity = client;
		WriteByte(MSG_ONE, SVC_CGAMEPACKET);
		WriteByte(MSG_ONE, EVENT_UPDATE);
		WriteByte(MSG_ONE, type); // UT_HUD, UT_ROUNDS_CHANGE
		WriteByte(MSG_ONE, val1); 
		WriteByte(MSG_ONE, val2);
		WriteByte(MSG_ONE, val3); // misc flags/vars for later if needed
	}
	else
	{
		WriteByte(MSG_ALL, SVC_CGAMEPACKET);
		WriteByte(MSG_ALL, EVENT_UPDATE);
		WriteByte(MSG_ALL, type); // UT_HUD, UT_ROUNDS_CHANGE
		WriteByte(MSG_ALL, val1); 
		WriteByte(MSG_ALL, val2);
		WriteByte(MSG_ALL, val3); // misc flags/vars for later if needed
	}
}

void(entity to, float type, float cost, float weapon) useprint = {
    msg_entity = to;
	WriteByte(MSG_ONE, SVC_CGAMEPACKET);
	WriteByte(MSG_ONE, EVENT_USEPRINT);
	WriteByte(MSG_ONE, type);
	WriteShort(MSG_ONE, cost);
	WriteByte(MSG_ONE, weapon);
}

void NotifyNewRound(float to) {
	WriteByte(MSG_ALL, SVC_CGAMEPACKET);
	WriteByte(MSG_ALL, EVENT_NEWROUND);
	WriteByte(MSG_ALL, to);
}

void SetRound(entity client, float to) {
    msg_entity = client;
	WriteByte(MSG_ONE, SVC_CGAMEPACKET);
	WriteByte(MSG_ONE, EVENT_SETROUND);
	WriteByte(MSG_ONE, to);
}

void SetPerk(entity client, float to) 
{
    msg_entity = client;
	WriteByte(MSG_ONE, SVC_CGAMEPACKET);
	WriteByte(MSG_ONE, EVENT_PERK);
	WriteLong(MSG_ONE, to);
}

void(float to) SwitchWeapon =
{
	WriteByte(MSG_MULTICAST, SVC_CGAMEPACKET);
	WriteByte(MSG_MULTICAST, EVENT_WEAPONCHANGE);
	WriteByte(MSG_MULTICAST, to);
	msg_entity = self;
	multicast('0 0 0', MULTICAST_ONE);
}

void(string to, float skin) UpdateVmodel =
{
	
	WriteByte(MSG_MULTICAST, SVC_CGAMEPACKET);
	WriteByte(MSG_MULTICAST, EVENT_UPDATEVMODEL);
	WriteString(MSG_MULTICAST, to);
	WriteByte(MSG_MULTICAST, skin);
	msg_entity = self;
	multicast('0 0 0', MULTICAST_ONE);
}

void(string to, float skin) UpdateV2model =
{
	WriteByte(MSG_MULTICAST, SVC_CGAMEPACKET);
	WriteByte(MSG_MULTICAST, EVENT_UPDATEV2MODEL);
	WriteString(MSG_MULTICAST, to);
	WriteByte(MSG_MULTICAST, skin);
	msg_entity = self;
	multicast('0 0 0', MULTICAST_ONE);
}

void(float broadcast_time, float type) BroadcastMessage =
{
	WriteByte(MSG_ALL, SVC_CGAMEPACKET);
	WriteByte(MSG_ALL, EVENT_BROADCAST);
	WriteByte(MSG_ALL, broadcast_time);
	WriteByte(MSG_ALL, type);
}

void(float playernum, float points, string name) UpdatePlayerPoints =
{
	WriteByte(MSG_ALL, SVC_CGAMEPACKET);
	WriteByte(MSG_ALL, EVENT_POINTUPDATE);
	WriteByte(MSG_ALL, playernum);
	WriteLong(MSG_ALL, points);
	WriteString(MSG_ALL, name);
}

void(float newtime, float newtype, entity change) PromptLevelChange =
{
	WriteByte(MSG_MULTICAST, SVC_CGAMEPACKET);
	WriteByte(MSG_MULTICAST, EVENT_BLACKOUT);
	WriteByte(MSG_MULTICAST, newtime);
	WriteByte(MSG_MULTICAST, newtype);
	msg_entity = change;
	multicast('0 0 0', MULTICAST_ONE);
}

// *****************************************
// Unrelated to engine, but custom functions
// *****************************************

float() crandom =
{
	return 2*(random() - 0.5);
}

void WeaponSwitch(entity player) {
	float wep, cmag, cmag2, cammo;

	wep = other.weapon;
	other.weapon = other.secondaryweapon;
	other.secondaryweapon = wep;

	cmag = other.currentmag;
	other.currentmag = other.secondarymag;
	other.secondarymag = cmag;

	cmag2 = other.currentmag2;
	other.currentmag2 = other.secondarymag2;
	other.secondarymag2 = cmag2;

	cammo = other.currentammo;
	other.currentammo = other.secondaryammo;
	other.secondaryammo = cammo;

	entity tempe = self;
	self = player;
	SwitchWeapon(other.weapon);
	self = tempe;
}

void() give0 =
{
	addmoney(self, 0, 0);
}

void(entity who) divinium =
{
	local float a, wow;
	a = random();
	if (a < 0.3)
		wow = 2;
	else
		wow = 1;

	who.div += wow;
	if (wow == 1)
		centerprint(who, "Earned 1 Liquid Divinium! Spend it in Monty's Factory!");
	else
		centerprint(who, "Double Divinium! Spend it in Monty's Factory!");

}

void(entity person, float expamt , float doublepoint) addmoney =
{
	local float b;
	b = random();
	if (person.classname != "player")
		return;

	if (expamt > 0 && doublepoint == TRUE && x2_finished> time)
		person.points = person.points + expamt*2;
	else
		person.points = person.points + expamt;

	person.pointdif = expamt;
	person.nextthink = time + 0.4;
	person.think = give0;
	if (expamt < 0 && b < 0.1)
		divinium(person);
		
	UpdatePlayerPoints(person.playernum, person.points, person.netname);
};

void(entity dude, float amount) givexp =
{
	dude.xp += amount;
}