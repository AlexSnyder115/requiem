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
	//Quick tut, if you want to add quotes to your map, copy paste this kino code, change "kdt" to the name of your map, and change sound names (if wanted)
	if (world.charchoose == 0)
	{
		if (buyqr == 1 && self.fire_delay < time) //Quick Revive
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/buyrevive.wav"), 1, ATTN_NORM);
			buyqr = 0;
		}
		if (buyjug == 1 && self.fire_delay < time) //Juggernog
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/buyjug.wav"), 1, ATTN_NORM);
			buyjug = 0;
		}
		if (buyspeed == 1 && self.fire_delay < time) //Speed Cola
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/buyspeed.wav"), 1, ATTN_NORM);
			buyspeed = 0;
		}
		if (buydt == 1 && self.fire_delay < time) //Double Tap
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/buydt.wav"), 1, ATTN_NORM);
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
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/spwn", sd, ".wav"), 1, ATTN_NORM);
			spwnn = 1;
		}
		if (hasknifed == 1) //Melee Kill
		{
			local float snd1, shouldplay; //shouldplay is here because sometimes a quote shouldn't play
			local string sd1;
			snd1 = random();
			shouldplay = random();
			if (snd1 < (1/5))
				sd1 = "0";
			else if (snd1 < (2/5))
				sd1 = "1";
			else if (snd1 < (3/5))
				sd1 = "2";
			else if (snd1 < (4/5))
				sd1 = "3";
			else
				sd1 = "4";
			if (shouldplay < 0.4)
				sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/killclose", sd1, ".wav"), 1, ATTN_NORM);
			hasknifed = 0;
		}
		if (self.rock1 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/rock1.wav"), 1, ATTN_NORM);
			self.rock1 = 0;
		}
		if (self.rock2 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/rock2.wav"), 1, ATTN_NORM);
			self.rock2 = 0;
		}
		if (self.activatedsong == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/rock3.wav"), 1, ATTN_NORM);
			self.activatedsong = 0;
			self.accomplished = time + 3;
			self.amready = 1;
		}
		if (self.accomplished < time && self.nomore == 0 && self.amready == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/song.wav"), 1, ATTN_NORM);
			self.nomore = 1;
		}
		if (self.hasray == 1) //Got Ray Gun
		{
			local float rsnd;
			local string ray;
			rsnd = random();
			if (rsnd < (1/5))
				ray = "0";
			else if (rsnd < (2/5))
				ray = "1";
			else if (rsnd < (3/5))
				ray = "2";
			else if (rsnd < (4/5))
				ray = "3";
			else
				ray = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/ray", ray, ".wav"), 1, ATTN_NORM);
			self.hasray = 0;
		}
		if (self.raykill == 1) //Killed with Ray Gun
		{
			local float rsndk;
			local string rayk;
			rsndk = random();
			if (rsndk < (1/5))
				rayk = "0";
			else if (rsndk < (2/5))
				rayk = "1";
			else if (rsndk < (3/5))
				rayk = "2";
			else if (rsndk < (4/5))
				rayk = "3";
			else
				rayk = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/rayk", rayk, ".wav"), 1, ATTN_NORM);
			self.raykill = 0;
		}
		if (self.ampap == 1) //IS PaPing
		{
			local float p;
			local string pp;
			p = random();
			if (p < (1/5))
				pp = "0";
			else if (p < (2/5))
				pp = "1";
			else if (p < (3/5))
				pp = "2";
			else if (p < (4/5))
				pp = "3";
			else
				pp = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/wait", pp, ".wav"), 1, ATTN_NORM);
			self.ampap = 0;
		}
		if (self.haspap == 1) //HAS PaP
		{
			local float ppp;
			local string pppp;
			ppp = random();
			if (ppp < (1/6))
				pppp = "0";
			else if (ppp < (2/6))
				pppp = "1";
			else if (ppp < (3/6))
				pppp = "2";
			else if (ppp < (4/6))
				pppp = "3";
			else if (ppp < (5/6))
				pppp = "4";
			else
				pppp = "5";
			sound (self, CHAN_ITEM, strcat("sounds/player/kdt/", playername, "/has", pppp, ".wav"), 1, ATTN_NORM);
			self.haspap = 0;
		}
	}
	if (world.charchoose == 1)
	{
		if (buyqr == 1 && self.fire_delay < time) //Quick Revive
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/buyrevive.wav"), 1, ATTN_NORM);
			buyqr = 0;
		}
		if (buyjug == 1 && self.fire_delay < time) //Juggernog
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/buyjug.wav"), 1, ATTN_NORM);
			buyjug = 0;
		}
		if (buyspeed == 1 && self.fire_delay < time) //Speed Cola
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/buyspeed.wav"), 1, ATTN_NORM);
			buyspeed = 0;
		}
		if (buydt == 1 && self.fire_delay < time) //Double Tap
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/buydt.wav"), 1, ATTN_NORM);
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
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/spwn", sd, ".wav"), 1, ATTN_NORM);
			spwnn = 1;
		}
		if (hasknifed == 1) //Melee Kill
		{
			local float snd1, shouldplay; //shouldplay is here because sometimes a quote shouldn't play
			local string sd1;
			snd1 = random();
			shouldplay = random();
			if (snd1 < (1/5))
				sd1 = "0";
			else if (snd1 < (2/5))
				sd1 = "1";
			else if (snd1 < (3/5))
				sd1 = "2";
			else if (snd1 < (4/5))
				sd1 = "3";
			else
				sd1 = "4";
			if (shouldplay < 0.4)
				sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/killclose", sd1, ".wav"), 1, ATTN_NORM);
			hasknifed = 0;
		}
		if (self.rock1 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/rock1.wav"), 1, ATTN_NORM);
			self.rock1 = 0;
		}
		if (self.rock2 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/rock2.wav"), 1, ATTN_NORM);
			self.rock2 = 0;
		}
		if (self.activatedsong == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/rock3.wav"), 1, ATTN_NORM);
			self.activatedsong = 0;
			self.accomplished = time + 3;
			self.amready = 1;
		}
		if (self.accomplished < time && self.nomore == 0 && self.amready == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/song.wav"), 1, ATTN_NORM);
			self.nomore = 1;
		}
		if (self.hasray == 1) //Got Ray Gun
		{
			local float rsnd;
			local string ray;
			rsnd = random();
			if (rsnd < (1/5))
				ray = "0";
			else if (rsnd < (2/5))
				ray = "1";
			else if (rsnd < (3/5))
				ray = "2";
			else if (rsnd < (4/5))
				ray = "3";
			else
				ray = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/ray", ray, ".wav"), 1, ATTN_NORM);
			self.hasray = 0;
		}
		if (self.raykill == 1) //Killed with Ray Gun
		{
			local float rsndk;
			local string rayk;
			rsndk = random();
			if (rsndk < (1/5))
				rayk = "0";
			else if (rsndk < (2/5))
				rayk = "1";
			else if (rsndk < (3/5))
				rayk = "2";
			else if (rsndk < (4/5))
				rayk = "3";
			else
				rayk = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/rayk", rayk, ".wav"), 1, ATTN_NORM);
			self.raykill = 0;
		}
		if (self.ampap == 1) //IS PaPing
		{
			local float p;
			local string pp;
			p = random();
			if (p < (1/5))
				pp = "0";
			else if (p < (2/5))
				pp = "1";
			else if (p < (3/5))
				pp = "2";
			else if (p < (4/5))
				pp = "3";
			else
				pp = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/wait", pp, ".wav"), 1, ATTN_NORM);
			self.ampap = 0;
		}
		if (self.haspap == 1) //HAS PaP
		{
			local float ppp;
			local string pppp;
			ppp = random();
			if (ppp < (1/6))
				pppp = "0";
			else if (ppp < (2/6))
				pppp = "1";
			else if (ppp < (3/6))
				pppp = "2";
			else if (ppp < (4/6))
				pppp = "3";
			else if (ppp < (5/6))
				pppp = "4";
			else
				pppp = "5";
			sound (self, CHAN_ITEM, strcat("sounds/player/five/", playername, "/has", pppp, ".wav"), 1, ATTN_NORM);
			self.haspap = 0;
		}
	}
	if (world.charchoose == 2)
	{
		if (buyqr == 1 && self.fire_delay < time) //Quick Revive
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/buyrevive.wav"), 1, ATTN_NORM);
			buyqr = 0;
		}
		if (buyjug == 1 && self.fire_delay < time) //Juggernog
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/buyjug.wav"), 1, ATTN_NORM);
			buyjug = 0;
		}
		if (buyspeed == 1 && self.fire_delay < time) //Speed Cola
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/buyspeed.wav"), 1, ATTN_NORM);
			buyspeed = 0;
		}
		if (buydt == 1 && self.fire_delay < time) //Double Tap
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/buydt.wav"), 1, ATTN_NORM);
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
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/spwn", sd, ".wav"), 1, ATTN_NORM);
			spwnn = 1;
		}
		if (hasknifed == 1) //Melee Kill
		{
			local float snd1, shouldplay; //shouldplay is here because sometimes a quote shouldn't play
			local string sd1;
			snd1 = random();
			shouldplay = random();
			if (snd1 < (1/5))
				sd1 = "0";
			else if (snd1 < (2/5))
				sd1 = "1";
			else if (snd1 < (3/5))
				sd1 = "2";
			else if (snd1 < (4/5))
				sd1 = "3";
			else
				sd1 = "4";
			if (shouldplay < 0.4)
				sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/killclose", sd1, ".wav"), 1, ATTN_NORM);
			hasknifed = 0;
		}
		if (self.rock1 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/rock1.wav"), 1, ATTN_NORM);
			self.rock1 = 0;
		}
		if (self.rock2 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/rock2.wav"), 1, ATTN_NORM);
			self.rock2 = 0;
		}
		if (self.activatedsong == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/rock3.wav"), 1, ATTN_NORM);
			self.activatedsong = 0;
			self.accomplished = time + 3;
			self.amready = 1;
		}
		if (self.accomplished < time && self.nomore == 0 && self.amready == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/song.wav"), 1, ATTN_NORM);
			self.nomore = 1;
		}
		if (self.hasray == 1) //Got Ray Gun
		{
			local float rsnd;
			local string ray;
			rsnd = random();
			if (rsnd < (1/5))
				ray = "0";
			else if (rsnd < (2/5))
				ray = "1";
			else if (rsnd < (3/5))
				ray = "2";
			else if (rsnd < (4/5))
				ray = "3";
			else
				ray = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/ray", ray, ".wav"), 1, ATTN_NORM);
			self.hasray = 0;
		}
		if (self.raykill == 1) //Killed with Ray Gun
		{
			local float rsndk;
			local string rayk;
			rsndk = random();
			if (rsndk < (1/5))
				rayk = "0";
			else if (rsndk < (2/5))
				rayk = "1";
			else if (rsndk < (3/5))
				rayk = "2";
			else if (rsndk < (4/5))
				rayk = "3";
			else
				rayk = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/rayk", rayk, ".wav"), 1, ATTN_NORM);
			self.raykill = 0;
		}
		if (self.ampap == 1) //IS PaPing
		{
			local float p;
			local string pp;
			p = random();
			if (p < (1/5))
				pp = "0";
			else if (p < (2/5))
				pp = "1";
			else if (p < (3/5))
				pp = "2";
			else if (p < (4/5))
				pp = "3";
			else
				pp = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/wait", pp, ".wav"), 1, ATTN_NORM);
			self.ampap = 0;
		}
		if (self.haspap == 1) //HAS PaP
		{
			local float ppp;
			local string pppp;
			ppp = random();
			if (ppp < (1/6))
				pppp = "0";
			else if (ppp < (2/6))
				pppp = "1";
			else if (ppp < (3/6))
				pppp = "2";
			else if (ppp < (4/6))
				pppp = "3";
			else if (ppp < (5/6))
				pppp = "4";
			else
				pppp = "5";
			sound (self, CHAN_ITEM, strcat("sounds/player/victis/", playername, "/has", pppp, ".wav"), 1, ATTN_NORM);
			self.haspap = 0;
		}
	}
	if (world.charchoose == 3)
	{
		if (buyqr == 1 && self.fire_delay < time) //Quick Revive
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/buyrevive.wav"), 1, ATTN_NORM);
			buyqr = 0;
		}
		if (buyjug == 1 && self.fire_delay < time) //Juggernog
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/buyjug.wav"), 1, ATTN_NORM);
			buyjug = 0;
		}
		if (buyspeed == 1 && self.fire_delay < time) //Speed Cola
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/buyspeed.wav"), 1, ATTN_NORM);
			buyspeed = 0;
		}
		if (buydt == 1 && self.fire_delay < time) //Double Tap
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/buydt.wav"), 1, ATTN_NORM);
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
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/spwn", sd, ".wav"), 1, ATTN_NORM);
			spwnn = 1;
		}
		if (hasknifed == 1) //Melee Kill
		{
			local float snd1, shouldplay; //shouldplay is here because sometimes a quote shouldn't play
			local string sd1;
			snd1 = random();
			shouldplay = random();
			if (snd1 < (1/5))
				sd1 = "0";
			else if (snd1 < (2/5))
				sd1 = "1";
			else if (snd1 < (3/5))
				sd1 = "2";
			else if (snd1 < (4/5))
				sd1 = "3";
			else
				sd1 = "4";
			if (shouldplay < 0.4)
				sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/killclose", sd1, ".wav"), 1, ATTN_NORM);
			hasknifed = 0;
		}
		if (self.rock1 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/rock1.wav"), 1, ATTN_NORM);
			self.rock1 = 0;
		}
		if (self.rock2 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/rock2.wav"), 1, ATTN_NORM);
			self.rock2 = 0;
		}
		if (self.activatedsong == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/rock3.wav"), 1, ATTN_NORM);
			self.activatedsong = 0;
			self.accomplished = time + 3;
			self.amready = 1;
		}
		if (self.accomplished < time && self.nomore == 0 && self.amready == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/song.wav"), 1, ATTN_NORM);
			self.nomore = 1;
		}
		if (self.hasray == 1) //Got Ray Gun
		{
			local float rsnd;
			local string ray;
			rsnd = random();
			if (rsnd < (1/5))
				ray = "0";
			else if (rsnd < (2/5))
				ray = "1";
			else if (rsnd < (3/5))
				ray = "2";
			else if (rsnd < (4/5))
				ray = "3";
			else
				ray = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/ray", ray, ".wav"), 1, ATTN_NORM);
			self.hasray = 0;
		}
		if (self.raykill == 1) //Killed with Ray Gun
		{
			local float rsndk;
			local string rayk;
			rsndk = random();
			if (rsndk < (1/5))
				rayk = "0";
			else if (rsndk < (2/5))
				rayk = "1";
			else if (rsndk < (3/5))
				rayk = "2";
			else if (rsndk < (4/5))
				rayk = "3";
			else
				rayk = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/rayk", rayk, ".wav"), 1, ATTN_NORM);
			self.raykill = 0;
		}
		if (self.ampap == 1) //IS PaPing
		{
			local float p;
			local string pp;
			p = random();
			if (p < (1/5))
				pp = "0";
			else if (p < (2/5))
				pp = "1";
			else if (p < (3/5))
				pp = "2";
			else if (p < (4/5))
				pp = "3";
			else
				pp = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/wait", pp, ".wav"), 1, ATTN_NORM);
			self.ampap = 0;
		}
		if (self.haspap == 1) //HAS PaP
		{
			local float ppp;
			local string pppp;
			ppp = random();
			if (ppp < (1/6))
				pppp = "0";
			else if (ppp < (2/6))
				pppp = "1";
			else if (ppp < (3/6))
				pppp = "2";
			else if (ppp < (4/6))
				pppp = "3";
			else if (ppp < (5/6))
				pppp = "4";
			else
				pppp = "5";
			sound (self, CHAN_ITEM, strcat("sounds/player/motd/", playername, "/has", pppp, ".wav"), 1, ATTN_NORM);
			self.haspap = 0;
		}
	}
	if (world.charchoose == 4)
	{
		if (buyqr == 1 && self.fire_delay < time) //Quick Revive
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/buyrevive.wav"), 1, ATTN_NORM);
			buyqr = 0;
		}
		if (buyjug == 1 && self.fire_delay < time) //Juggernog
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/buyjug.wav"), 1, ATTN_NORM);
			buyjug = 0;
		}
		if (buyspeed == 1 && self.fire_delay < time) //Speed Cola
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/buyspeed.wav"), 1, ATTN_NORM);
			buyspeed = 0;
		}
		if (buydt == 1 && self.fire_delay < time) //Double Tap
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/buydt.wav"), 1, ATTN_NORM);
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
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/spwn", sd, ".wav"), 1, ATTN_NORM);
			spwnn = 1;
		}
		if (hasknifed == 1) //Melee Kill
		{
			local float snd1, shouldplay; //shouldplay is here because sometimes a quote shouldn't play
			local string sd1;
			snd1 = random();
			shouldplay = random();
			if (snd1 < (1/5))
				sd1 = "0";
			else if (snd1 < (2/5))
				sd1 = "1";
			else if (snd1 < (3/5))
				sd1 = "2";
			else if (snd1 < (4/5))
				sd1 = "3";
			else
				sd1 = "4";
			if (shouldplay < 0.4)
				sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/killclose", sd1, ".wav"), 1, ATTN_NORM);
			hasknifed = 0;
		}
		if (self.rock1 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/rock1.wav"), 1, ATTN_NORM);
			self.rock1 = 0;
		}
		if (self.rock2 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/rock2.wav"), 1, ATTN_NORM);
			self.rock2 = 0;
		}
		if (self.activatedsong == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/rock3.wav"), 1, ATTN_NORM);
			self.activatedsong = 0;
			self.accomplished = time + 3;
			self.amready = 1;
		}
		if (self.accomplished < time && self.nomore == 0 && self.amready == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/song.wav"), 1, ATTN_NORM);
			self.nomore = 1;
		}
		if (self.hasray == 1) //Got Ray Gun
		{
			local float rsnd;
			local string ray;
			rsnd = random();
			if (rsnd < (1/5))
				ray = "0";
			else if (rsnd < (2/5))
				ray = "1";
			else if (rsnd < (3/5))
				ray = "2";
			else if (rsnd < (4/5))
				ray = "3";
			else
				ray = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/ray", ray, ".wav"), 1, ATTN_NORM);
			self.hasray = 0;
		}
		if (self.raykill == 1) //Killed with Ray Gun
		{
			local float rsndk;
			local string rayk;
			rsndk = random();
			if (rsndk < (1/5))
				rayk = "0";
			else if (rsndk < (2/5))
				rayk = "1";
			else if (rsndk < (3/5))
				rayk = "2";
			else if (rsndk < (4/5))
				rayk = "3";
			else
				rayk = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/rayk", rayk, ".wav"), 1, ATTN_NORM);
			self.raykill = 0;
		}
		if (self.ampap == 1) //IS PaPing
		{
			local float p;
			local string pp;
			p = random();
			if (p < (1/5))
				pp = "0";
			else if (p < (2/5))
				pp = "1";
			else if (p < (3/5))
				pp = "2";
			else if (p < (4/5))
				pp = "3";
			else
				pp = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/wait", pp, ".wav"), 1, ATTN_NORM);
			self.ampap = 0;
		}
		if (self.haspap == 1) //HAS PaP
		{
			local float ppp;
			local string pppp;
			ppp = random();
			if (ppp < (1/6))
				pppp = "0";
			else if (ppp < (2/6))
				pppp = "1";
			else if (ppp < (3/6))
				pppp = "2";
			else if (ppp < (4/6))
				pppp = "3";
			else if (ppp < (5/6))
				pppp = "4";
			else
				pppp = "5";
			sound (self, CHAN_ITEM, strcat("sounds/player/soe/", playername, "/has", pppp, ".wav"), 1, ATTN_NORM);
			self.haspap = 0;
		}
	}
	if (world.charchoose == 5)
	{
		if (buyqr == 1 && self.fire_delay < time) //Quick Revive
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/buyrevive.wav"), 1, ATTN_NORM);
			buyqr = 0;
		}
		if (buyjug == 1 && self.fire_delay < time) //Juggernog
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/buyjug.wav"), 1, ATTN_NORM);
			buyjug = 0;
		}
		if (buyspeed == 1 && self.fire_delay < time) //Speed Cola
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/buyspeed.wav"), 1, ATTN_NORM);
			buyspeed = 0;
		}
		if (buydt == 1 && self.fire_delay < time) //Double Tap
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/buydt.wav"), 1, ATTN_NORM);
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
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/spwn", sd, ".wav"), 1, ATTN_NORM);
			spwnn = 1;
		}
		if (hasknifed == 1) //Melee Kill
		{
			local float snd1, shouldplay; //shouldplay is here because sometimes a quote shouldn't play
			local string sd1;
			snd1 = random();
			shouldplay = random();
			if (snd1 < (1/5))
				sd1 = "0";
			else if (snd1 < (2/5))
				sd1 = "1";
			else if (snd1 < (3/5))
				sd1 = "2";
			else if (snd1 < (4/5))
				sd1 = "3";
			else
				sd1 = "4";
			if (shouldplay < 0.4)
				sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/killclose", sd1, ".wav"), 1, ATTN_NORM);
			hasknifed = 0;
		}
		if (self.rock1 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/rock1.wav"), 1, ATTN_NORM);
			self.rock1 = 0;
		}
		if (self.rock2 == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/rock2.wav"), 1, ATTN_NORM);
			self.rock2 = 0;
		}
		if (self.activatedsong == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/rock3.wav"), 1, ATTN_NORM);
			self.activatedsong = 0;
			self.accomplished = time + 3;
			self.amready = 1;
		}
		if (self.accomplished < time && self.nomore == 0 && self.amready == 1)
		{
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/song.wav"), 1, ATTN_NORM);
			self.nomore = 1;
		}
		if (self.hasray == 1) //Got Ray Gun
		{
			local float rsnd;
			local string ray;
			rsnd = random();
			if (rsnd < (1/5))
				ray = "0";
			else if (rsnd < (2/5))
				ray = "1";
			else if (rsnd < (3/5))
				ray = "2";
			else if (rsnd < (4/5))
				ray = "3";
			else
				ray = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/ray", ray, ".wav"), 1, ATTN_NORM);
			self.hasray = 0;
		}
		if (self.raykill == 1) //Killed with Ray Gun
		{
			local float rsndk;
			local string rayk;
			rsndk = random();
			if (rsndk < (1/5))
				rayk = "0";
			else if (rsndk < (2/5))
				rayk = "1";
			else if (rsndk < (3/5))
				rayk = "2";
			else if (rsndk < (4/5))
				rayk = "3";
			else
				rayk = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/rayk", rayk, ".wav"), 1, ATTN_NORM);
			self.raykill = 0;
		}
		if (self.ampap == 1) //IS PaPing
		{
			local float p;
			local string pp;
			p = random();
			if (p < (1/5))
				pp = "0";
			else if (p < (2/5))
				pp = "1";
			else if (p < (3/5))
				pp = "2";
			else if (p < (4/5))
				pp = "3";
			else
				pp = "4";
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/wait", pp, ".wav"), 1, ATTN_NORM);
			self.ampap = 0;
		}
		if (self.haspap == 1) //HAS PaP
		{
			local float ppp;
			local string pppp;
			ppp = random();
			if (ppp < (1/6))
				pppp = "0";
			else if (ppp < (2/6))
				pppp = "1";
			else if (ppp < (3/6))
				pppp = "2";
			else if (ppp < (4/6))
				pppp = "3";
			else if (ppp < (5/6))
				pppp = "4";
			else
				pppp = "5";
			sound (self, CHAN_ITEM, strcat("sounds/player/cotd/", playername, "/has", pppp, ".wav"), 1, ATTN_NORM);
			self.haspap = 0;
		}
	}
}