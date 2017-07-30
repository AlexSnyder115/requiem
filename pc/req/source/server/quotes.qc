/* ~~~~~~~~~~~~~~
     QUOTE CODE
   ~~~~~~~~~~~~~~*/

void() QuoteCheck = 	//Constantly ran, if THIS, play THAT.
{
	string playername; //used to make adding quotes for each character easier
	if (self.playernumber < 0.125) //Player 1 (Dempsey)
		playername = "0";
	else if (self.playernumber < 0.25) //Player 2 (Nikolai)
		playername = "1";
	else if (self.playernumber < 0.375) //Player 3 (Takeo)
		playername = "2";
	else //Player 4 (Richtofen)
		playername = "3";
	//Quick tut, if you want to add quotes to your map, copy paste this kino code, change "kino_der_toten" to the name of your map, and change sound names (if wanted)
	if (mapname == "kino_der_toten")
	{
		if (buyqr == 1 && self.fire_delay < time) //Quick Revive
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/", mapname, "/", playername, "/buyrevive.wav"), 1, ATTN_NORM);
			buyqr = 0;
		}
		if (buyjug == 1 && self.fire_delay < time) //Juggernog
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/", mapname, "/", playername, "/buyjug.wav"), 1, ATTN_NORM);
			buyjug = 0;
		}
		if (buyspeed == 1 && self.fire_delay < time) //Speed Cola
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/", mapname, "/", playername, "/buyspeed.wav"), 1, ATTN_NORM);
			buyspeed = 0;
		}
		if (buydt == 1 && self.fire_delay < time) //Double Tap
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/", mapname, "/", playername, "/buydt.wav"), 1, ATTN_NORM);
			buydt = 0;
		}
		if (self.spawntime < time && spwnn == 0) //Spawning in
		{
			local float snd;
			local string sd;
			snd = random();
			if (snd < 0.125)
				sd = "0";
			else if (snd < 0.25)
				sd = "1";
			else if (snd < 0.375)
				sd = "2";
			else if (snd < 0.500)
				sd = "3";
			else 
				sd = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/", mapname, "/", playername, "/spwn", sd, ".wav"), 1, ATTN_NORM);
			spwnn = 1;
		}
		if (hasknifed == 1) //Melee Kill
		{
			local float snd1, shouldplay; //shouldplay is here because sometimes a quote doesn't play
			local string sd1;
			snd1 = random();
			shouldplay = random();
			if (snd1 < 0.125)
				sd1 = "0";
			if (snd1 < 0.250)
				sd1 = "1";
			if (snd1 < 0.375)
				sd1 = "2";
			if (snd1 < 0.500)
				sd1 = "3";
			else
				sd1 = "4";
			if (shouldplay < 0.600)
				sound (self, CHAN_ITEM, strcat("sounds/player/", mapname, "/", playername, "/killclose", sd1, ".wav"), 1, ATTN_NORM);
			hasknifed = 0;
		}
	}
}