// put custom server-only globals and fields here

#pragma target FTE

#define true 1
#define false 0

const float FL_JUMPRELEASED = 4096;

//prone4points
.float moneyclaimed;

.float teleport_time;
.float flamecool;
.float iscooling;
.float hasbowie;
.string boxwepname;
.float rock1;
.float rock2;
.float activatedsong;
.float gamemode;
.float ptsleft;
.float accomplished;
.float nomore;
.float amready;
.float nomoremusic;
.float ampap;
.float haspap;


//BO3 update 
.float lev;
.float xp;
.float div;


float gunnumber;
float perkdropcount;

float num;
float usingfizz;

.float hasray;
.float raykill;

.string song;

float teddycount;

string soundstyle;

float jugfall; 
float spdfall;
float papfall;
float dtfall;
float kills;

float fizzskin;
float fizztime;


//whoswho perk check
float whoq;
float whoflop;
float whojug;
float whorun;
float whospd;
float whodt;
float whocry;
float whocan;
float whoamm;
float whomul;
float whoded;

//what am i buying? doing just 4 core perks because kino
float buyqr;
float buyjug;
float buyspeed;
float buydt;

float spwnn;
.string eesong;
.float hudstyle;
.float rousounds;
.float charchoose;

float hasknifed;

.float spawntime; //Used to time how long we've been spawned in
.float pointdif;
float framecount;
float deathmatch;
float hasprone;
float coop;
.float boxwep;
.vector oldvelocity;
.float lastsound_time;
.float isspec;
float hassale;
float boxmoved;
.float bkm;
.float bka;
.float bk;
.float perkcount;
string mappath;
.float playernum;
.float thirdweapon;
.float hasclamps;
.float hasdolly;
.float hasgrate;
.float equipment;
.float thirdammo;
.float thirdmag;
.float gumuses;
.float tp_delay;
.float alstate;
float oilet;
.float toilet;
float player_count;
.string fog;		// used for hacking in changing fog from world.fog for legacy maps

float linked;
float cantp;

//money
.float points;
.float cost;
.float cost2;
void(entity person, float expamt , float doublepoint) addmoney;

//doors
.float state;
float STATE_TOP		= 0;
float STATE_BOTTOM	= 1;
float STATE_UP		= 2;
float STATE_DOWN		= 3;
.float /*worldtype,*/ delay, wait, lip, /*light_lev,*/ speed, style/*, skill*/;

entity activator;
.float requirespower;

//player funcs
.float zoom;
.float sprinting;
.float weaponskin;
.float stamina;
void() W_SprintStop;
.float into_sprint;
.float damagetimer;

//Weaponsystem defines
void SwitchWeapon(float to);
void GetUp();
void Weapon_Logic();
.float downed;
.float regen_delay;
.float flametime;
.float removetime;
.float fire_delay;
.float fire_delay2;
.float reload_delay;
.float reload_delay2;
.float health_delay;
.float progress_bar;
.float progress_bar_time;
.float progress_bar_percent;
.float weaponbk;
.float currentmag;
.float currentmag2;
.float currentmagbk;
.float currentmagbk2;
.float currentammobk;
.float secondaryammo;
.float dmweapon;
.float dmammo;
.float dmmag;
.float dm2weapon;
.float dm2ammo;
.float dm2mag;
.float burst;
.float shots;
.float btime;
.float semi;
.float semi2;
.float semiuse;
.float semiswitch;
.float semireload;
.float secondarymag;
.float secondarymag2;
.float secondaryweapon;

.float secondaryweaponbk;
.float secondarymagbk;
.float secondarymag2bk;
.float secondaryammobk;

.float NeedLoad;
.string weapon2model;
.float weapon2frame;
.float reloadinterupted;
.float hitcount;
.float playernumber;
.float weaponnum;	// 0 for weapon one, 1 for second weapon...we invert value for easy comparison, a third gun would need to be hardwired

//Reviving
.float invoke_revive;
.float reviving;
.float revived;
.float beingrevived;
.float downedloop;

#define S_LEFT 0
#define S_RIGHT 1
#define S_BOTH 2

//Knife 
.float semiknife;
.float knife_delay;
.float bowie;

//Grenades
.float grenades;
.float pri_grenade_state;
.float bk_nade;
.float grenade_delay;
.float secondary_grenades;
.float primary_grenades;
.float throw_delay;

//weapon frames
void Set_W_Frame (float startframe, float endframe, float duration, float funccalledin, float animtype, void(optional float t) endanimfunc, string set_model, float dontstartnew, float side);
.float weapon_animduration;
.float weapon2_animduration;
.float weapon_anim_type;
.float weapon2_anim_type;
.float anim_weapon_time;
.float anim_weapon2_time;
.float weaponframe_end;
.float weapon2frame_end;
.float callfuncat;
.float callfuncat2;
.float new_anim_stop;
.float new_anim2_stop;
.float anim_reversed;
.float anim2_reversed;
.void() animend;
.void(optional float t) animend2;

//Null functions
void() SUB_Null = {};
void() SUB_Null2 = {};

vector	VEC_HULL_MIN = '-16 -16 -32';
vector	VEC_HULL_MAX = '16 16 40';
vector	VEC_HULL2_MIN = '-32 -32 -24';
vector	VEC_HULL2_MAX = '32 32 64';
vector  VEC_VIEW_OFS  = '0 0 40';
vector	trace_plane_normal;


// AI definitions
//Used for global one-zombie-at-a-time type ai
void Do_Zombie_AI();
.string aistatus;
.float currentHitBoxSetup;
entity lastzombie;
//Other AI definitions
.vector box1, box2, box3;//used for windows and zombies
.vector idlebox;
.vector hop_spot;//used for windows (zombies hop to these)
.vector goalorigin;
.vector		bbmins, bbmaxs;		// Used for zombie hitboxes
//float(entity zombie, float which, entity limb) updateLimb		= #33;
.entity head;
.entity larm;
.entity rarm;
float crawler_num;
//==== Reference Vars ====
const float WWINDOW = 1; 
const float WBOX1 = 2;
const float WBOX2 = 4;
const float WBOX3 = 8;
const float WIDLEBOX = 16;
//========================

//we're using usedent for who is currently hopping the window
//Used for windows to keep track of what zombies are at windows
.entity box1owner, box2owner, box3owner;

.entity usedent;
//.float used;//used for the window boxes//not anymore
.float outside;//used for knowing if a zomibe has hopped window yet
.float chase_enemy_time;
.float chase_time;
.float enemy_timeout;
//.float pathing;
.float calc_time; //used as a delay thing (so zombie ai doesn't run 100% of the time
.string target2;
.string target3;
.string target4;
.string target5;
.string target6;
.string target7;
.string target8;
.string wayTarget;
.entity active_door;//Set in waypoint mode
.string targetname;//the name of an entitys
entity lastspawn;//last spawn point used by spawning code
.entity goaldummy; //Used to store the origin of the zombies target
.float goalway; //Used to store the origin of the zombies target
.float walktype;//decides animations and moving speeds for zombies
.void() th_walk;
//.void() th_run;
.void() th_die;
.void() th_melee;
.void() th_idle;
.void() th_windowhop;
.void() th_diewunder;

.void() th_fall;
.void() th_falling;
.void() th_land;

.void() th_jump;
.void() th_grabledge;
.float tries;
.float hop_step;//KEEPS TRACK OF WHERE WE ARE ON THE HOPPING PART

float INACTIVE = 1;

float tracemove(vector start, vector min, vector max, vector end, float nomonsters, entity forent);

.float way_path[40];
.float way_cur;

.float sound_time;
.float s_time;
float sounds_playing;

.float fall;
//.vector lastOrg;//Zombie's last origin, for checking stuckness
//.float OrgStuckCount;
.float crawling;

.float washit;
.float hitamount;

.float laststep;
void(entity who) makeCrawler;
.float state;//used to delay making a crawler, ex) when zombie is rising from ground or climbing over barrier, turn zombie into a crawler afterwards

void() spawnAllZombEnts;
void() set_z_health;
float() spawn_a_zombieA;
float() spawn_a_dogA;
float gotdog;
float z_health;
.float bleedingtime;
.float time_to_die;


float crandom();


// Door
.string killtarget;
.void() think1;
.vector finaldest;
.vector pos1, pos2/*, mangle*/;
.float sequence;
.entity active_door;

//Perk and Power system
float isPowerOn;
float perk_power;
.float isBuying; // naievil -- used for checking if a perk is being consumed, limits glitching
.float perks;
.float perk_delay;
.float revivesoda;

.float boxstatus;
.entity boxweapon;
.float visited; 		// 2 is we HAVE visited, 1 is we have the ability to visit
.float spins;
.float papState;

//powerups
.float x2_icon;
.float insta_icon;
.float dm_icon;
float instakill_finished;
float insta_blink;
.float sale_icon;
float firesale_finished;
float sale_blink;
float x2_finished;
float x2_blink;
float dm_finished;
float dm_blink;
float total_windows_down;
float total_powerup_points;
float powerup_activate;

//rounds
float roundinit;
float roundtype;
float Current_Zombies;
float Total_Zombies;
float Remaining_Zombies;
float Delay_Time;
float spawn_time;
float round_changetime;
float game_over;
float blink_return;
float delay_at_round;
float spawn_delay;
float maxreward;
float totalreward;
float totalpowerups;
float sounds_playing;

float rounds;
float rounds_change;

//Waypoints
void () Waypoint_Logic;
entity current_way;
float waypoint_mode;
entity active_way;

#define MAX_WAY_TARGETS		10
.string waynum;
.string targets[MAX_WAY_TARGETS];


//pathfinds
#define MAX_WAYPOINTS 256 //max waypoints
void LoadWaypointData();
typedef struct
{
	vector org;
	float id;
	float g, f;
	float next, prev;
	float step;
	float target_id [MAX_WAY_TARGETS]; // Targets array number
	string targetdoor; //special tag is required for the closed waypoints
	float dist [MAX_WAY_TARGETS]; // Distance to the next waypoints
	float set;
} waypoint_ai;

#define SET_NONE	0
#define SET_OPEN	1
#define SET_CLOSED	2

waypoint_ai waypoints[MAX_WAYPOINTS];

#define UT_HUD 				1
#define UT_ROUNDS_CHANGE 	2
#define UT_HM				3
#define UT_ZOOM2			4
#define UT_CROSSHAIR		5

//Misc patch definitions
.string teddyremovetarget;