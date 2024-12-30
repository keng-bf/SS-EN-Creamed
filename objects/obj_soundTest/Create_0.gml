currentSelection = 0;
savedSelection = 0;
pauseStatus = false;
specialToggle = false;
musicPlaying = false;

defineMusic = function(argument0, argument1, argument2 = false) constructor
{
    static add = function()
    {
        array_push(obj_soundTest.musicArray, self);
        return self;
    };
    
    eventPath = argument0;
    eventInstance = undefined;
    
    if (!is_undefined(eventPath) && is_string(eventPath))
        eventInstance = fmod_createEventInstance(eventPath);
    
    songDescription = argument1;
    hasSpecial = argument2;
    return add();
};

musicArray = [];
new defineMusic("event:/music/Soundtest/intro", "Art Curse - PaperKitty");
new defineMusic("event:/music/Soundtest/title_exhibition", "Exhibition Night - Stewart Keller");
new defineMusic("event:/music/Soundtest/hub1", "Good Morning - Stewart Keller");
new defineMusic("event:/music/Soundtest/options", "Pick Your Poison - Stewart Keller");
new defineMusic("event:/music/Soundtest/pause", "Earth. - CableChords");
new defineMusic("event:/music/Soundtest/tutorial", "Family Friendly - PaperKitty");
new defineMusic("event:/music/Soundtest/harry", "Arkoudaphobia - Stewart Keller");
new defineMusic("event:/music/Soundtest/entrywayPZ", "Down To Noise - RodMod");
new defineMusic("event:/music/Soundtest/entrywayPZ_secret", "A Construction Secret - Various");
new defineMusic("event:/music/Soundtest/cottontownA", "Steamy Cotton Candy - RodMod", true);
new defineMusic("event:/music/Soundtest/cottontownB", "Around The Gateau's Gears - RodMod", true);
new defineMusic("event:/music/Soundtest/cottontown_secret", "A Steamy Secret - Various");
new defineMusic("event:/music/Soundtest/minesA", "Mineshaft Depths - RodMod", true);
new defineMusic("event:/music/Soundtest/minesB", "Cobalt Catastrophe - RodMod", true);
new defineMusic("event:/music/Soundtest/mines_secret", "A Dusty Secret - Various");
new defineMusic("event:/music/Soundtest/molassesA", "Lost Chocolate - CableChords, RodMod", true);
new defineMusic("event:/music/Soundtest/molassesB", "Found Chocolate - CableChords", true);
new defineMusic("event:/music/Soundtest/molasses_secret", "A Sticky Secret - Various");
new defineMusic("event:/music/Soundtest/glucosegetaway", "Sugar Rush - RodMod, CableChords, The8Bitdrummer");
new defineMusic("event:/music/Soundtest/sweetrelease", "Sweet Release of Death - RodMod");
new defineMusic("event:/music/Soundtest/credits", "Toodle-oo! - PaperKitty");
ini_open(global.SaveFileName);

if (ini_read_string("Game", "Judgment", "none") != "none")
    new defineMusic("event:/music/Soundtest/painterBrain", "Painter's Brain - Stewart Keller");

if (ini_read_string("Treasure", "mindpalace", "0") != "0")
{
    new defineMusic("event:/music/Soundtest/painterMixtape", "Painter's Mixtape - Stewart Keller", true);
    new defineMusic("event:/music/Soundtest/spiresamba", "Samba de Spire - PaperKitty");
    new defineMusic("event:/music/Soundtest/mountainA", "Aw, Fudge! (Bonus) - Pteracotta");
    new defineMusic("event:/music/Soundtest/mountainB", "Fudge It All! (Bonus) - RodMod");
    new defineMusic("event:/music/Soundtest/mountain_secret", "A Mountain Secret (Bonus) - Various");
    new defineMusic("event:/music/Soundtest/runthedog", "Run the Dog (Bonus) - PaperKitty", true);
    new defineMusic("event:/music/Soundtest/sugarcubehailstorm", "Sugarcube Hailstorm (Bonus) - PaperKitty");
    new defineMusic("event:/music/Soundtest/painterBoss", "Painter's Theme (Bonus) - CableChords");
    new defineMusic("event:/music/Soundtest/stinky", "What's that Smell? (Bonus) - PaperKitty");
}

ini_close();
