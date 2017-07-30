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
	}
}