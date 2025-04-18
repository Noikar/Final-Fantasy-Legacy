proc/CreateEncounter(encounter_group_id)
	var/list/Monsters = new()
	var/mob/Monster1,var/mob/Monster2,var/mob/Monster3
	var/mob/Monster4,var/mob/Monster5,var/mob/Monster6
	var/mob/Monster7,var/mob/Monster8,var/mob/Monster9
	var/mob/Monster10,var/mob/Monster11,var/mob/Monster12
	var/mob/Monster13,var/mob/Monster14,var/mob/Monster15

	switch(encounter_group_id)
		if(1)		//near baron
			switch(rand(1,4))
				if(1){Monster1=new/mob/monster/Imp;Monster1.XLoc=-1}
				if(2){Monster1=new/mob/monster/floating/Eagle;Monster1.XLoc=-3;Monster1.YLoc=1}
				if(3){Monster1=new/mob/monster/floating/FloatEye;Monster1.XLoc=-3}
				if(4){Monster1=new/mob/monster/SwordRat;Monster1.XLoc=-3}
		if(2)		//baron/mist
			switch(rand(1,8))
				if(1){Monster1=new/mob/monster/Imp;Monster1.XLoc=-1}
				if(2){Monster1=new/mob/monster/floating/Eagle;Monster1.XLoc=-3;Monster1.YLoc=1}
				if(3){Monster1=new/mob/monster/floating/FloatEye;Monster1.XLoc=-3}
				if(4){Monster1=new/mob/monster/SwordRat;Monster1.XLoc=-3}
				if(5){Monster1=new/mob/monster/Imp;Monster1.XLoc=-1;Monster1.YLoc=1;Monster2=new/mob/monster/Imp;Monster2.XLoc=-3;Monster2.YLoc=-1}
				if(6){Monster1=new/mob/monster/floating/Eagle;Monster1.XLoc=-2;Monster1.YLoc=2;Monster2=new/mob/monster/floating/FloatEye;Monster2.XLoc=-4;Monster2.YLoc=-1}
				if(7){Monster1=new/mob/monster/floating/Eagle;Monster1.XLoc=-1;Monster1.YLoc=2;Monster2=new/mob/monster/floating/Eagle;Monster2.XLoc=-4}
				if(8){Monster1=new/mob/monster/Imp;Monster2=new/mob/monster/SwordRat;Monster2.XLoc=-4}
		if(3)		//mist cave
			switch(rand(1,7))
				if(1){Monster1=new/mob/monster/Imp;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/Imp;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/Imp;Monster3.XLoc=-3;Monster3.YLoc=-1;Monster4=new/mob/monster/Imp;Monster4.YLoc=-1}
				if(2){Monster1=new/mob/monster/Imp;Monster1.XLoc=-3;Monster1.YLoc=1;Monster2=new/mob/monster/SwordRat;Monster2.YLoc=1;Monster3=new/mob/monster/Imp;Monster3.XLoc=-4;Monster3.YLoc=-1;Monster4=new/mob/monster/SwordRat;Monster4.XLoc=-1;Monster4.YLoc=-1}
				if(3){Monster1=new/mob/monster/SwordRat;Monster1.XLoc=-4;Monster1.YLoc=1;Monster2=new/mob/monster/SwordRat;Monster2.YLoc=1;Monster3=new/mob/monster/SwordRat;Monster3.XLoc=-5;Monster3.YLoc=-2;Monster4=new/mob/monster/SwordRat;Monster4.XLoc=-1;Monster4.YLoc=-2}
				if(4){Monster1=new/mob/monster/Larva;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/Larva;Monster2.XLoc=-2;Monster3=new/mob/monster/Larva;Monster3.XLoc=1;Monster3.YLoc=1}
				if(5){Monster1=new/mob/monster/undead/Zombie;Monster1.XLoc=-3;Monster2=new/mob/monster/Larva}
				if(6){Monster1=new/mob/monster/Imp;Monster1.XLoc=1;Monster2=new/mob/monster/Imp;Monster2.YLoc=-2;Monster3=new/mob/monster/Imp;Monster3.YLoc=2;Monster4=new/mob/monster/SwordRat;Monster4.XLoc=-3}
				if(7){Monster1=new/mob/monster/floating/SandMoth;Monster1.XLoc=-3;Monster1.YLoc=1;Monster2=new/mob/monster/Larva;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/Larva;Monster3.XLoc=-1;Monster3.YLoc=-2}
		if(4)		//kaipo
			switch(rand(1,7))
				if(1){Monster1=new/mob/monster/SandWorm;Monster1.XLoc=-4;Monster1.YLoc=-1}
				if(2){Monster1=new/mob/monster/SandWorm;Monster1.XLoc=-5;Monster1.YLoc=-1;Monster2=new/mob/monster/SandMan;Monster2.XLoc=-1;Monster2.YLoc=-1}
				if(3){Monster1=new/mob/monster/SandMan;Monster1.XLoc=-6;Monster2=new/mob/monster/SandMan;Monster2.XLoc=-3;Monster2.YLoc=-2;Monster3=new/mob/monster/SandMan;Monster3.XLoc=-1;Monster4=new/mob/monster/SandMan;Monster4.XLoc=2;Monster4.YLoc=-2}
				if(4){Monster1=new/mob/monster/Sandpede;Monster1.XLoc=-4;Monster1.YLoc=-2;Monster2=new/mob/monster/SandMan;Monster2.XLoc=-1;Monster2.YLoc=1;Monster3=new/mob/monster/SandMan;Monster3.XLoc=-1;Monster3.YLoc=-3}
				if(5){Monster1=new/mob/monster/SandWorm;Monster1.XLoc=-5;Monster1.YLoc=-1;Monster2=new/mob/monster/Sandpede;Monster2.YLoc=-1}
				if(6){Monster1=new/mob/monster/floating/SandMoth;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/floating/SandMoth;Monster2.XLoc=-1;Monster2.YLoc=2;Monster3=new/mob/monster/Larva;Monster3.XLoc=-4;Monster3.YLoc=-2;Monster4=new/mob/monster/Larva;Monster4.XLoc=-1;Monster4.YLoc=-2}
				if(7){Monster1=new/mob/monster/Imp;Monster1.XLoc=1;Monster1.YLoc=2;Monster2=new/mob/monster/Imp;Monster2.XLoc=1;Monster2.YLoc=-2;Monster3=new/mob/monster/SwordRat;Monster3.XLoc=-2;Monster3.YLoc=-2;Monster4=new/mob/monster/SwordRat;Monster4.XLoc=-2;Monster4.YLoc=2;Monster5=new/mob/monster/SwordRat;Monster5.XLoc=-5}
		if(5)		//underground passage
			switch(rand(1,6))
				if(1){Monster1=new/mob/monster/aquatic/CaveToad;Monster1.XLoc=-4;Monster1.YLoc=1;Monster2=new/mob/monster/aquatic/CaveToad;Monster2.XLoc=0;Monster2.YLoc=0;Monster3=new/mob/monster/aquatic/CaveToad;Monster3.XLoc=-2;Monster3.YLoc=-2}
				if(2){Monster1=new/mob/monster/aquatic/WaterBug;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/aquatic/EvilShell;Monster2.XLoc=-3;Monster2.YLoc=2;Monster3=new/mob/monster/aquatic/EvilShell;Monster3.XLoc=-1;Monster3.YLoc=0;Monster4=new/mob/monster/aquatic/EvilShell;Monster4.XLoc=-3;Monster4.YLoc=-2}
				if(3){Monster1=new/mob/monster/aquatic/Pike;Monster1.XLoc=0;Monster1.YLoc=-2;Monster2=new/mob/monster/aquatic/Pike;Monster2.XLoc=-1;Monster2.YLoc=0;Monster3=new/mob/monster/aquatic/Pike;Monster3.XLoc=-2;Monster3.YLoc=2}
				if(4){Monster1=new/mob/monster/aquatic/Pike;Monster1.XLoc=-4;Monster1.YLoc=2;Monster2=new/mob/monster/aquatic/Pike;Monster2.XLoc=-3;Monster2.YLoc=-1;Monster3=new/mob/monster/aquatic/EvilShell;Monster3.XLoc=-1;Monster3.YLoc=1;Monster4=new/mob/monster/aquatic/EvilShell;Monster4.XLoc=0;Monster4.YLoc=-2}
				if(5){Monster1=new/mob/monster/aquatic/Pike;Monster1.XLoc=2;Monster1.YLoc=1;Monster2=new/mob/monster/aquatic/Pike;Monster2.XLoc=1;Monster2.YLoc=-2;Monster3=new/mob/monster/aquatic/EvilShell;Monster3.XLoc=-2;Monster3.YLoc=1;Monster4=new/mob/monster/aquatic/EvilShell;Monster4.XLoc=-3;Monster4.YLoc=-2;Monster5=new/mob/monster/aquatic/WaterBug;Monster5.XLoc=-5;Monster5.YLoc=1;Monster6=new/mob/monster/aquatic/WaterBug;Monster6.XLoc=-6;Monster6.YLoc=-2}
				if(6){Monster1=new/mob/monster/aquatic/Waterhag;Monster1.XLoc=-1;Monster1.YLoc=-2;Monster2=new/mob/monster/aquatic/Waterhag;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/aquatic/Waterhag;Monster3.XLoc=-4;Monster3.YLoc=1;Monster4=new/mob/monster/aquatic/Waterhag;Monster4.XLoc=-1;Monster4.YLoc=1}
		if(6)	//waterfall
			switch(rand(1,6))
				if(1){Monster1=new/mob/monster/aquatic/Gator;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/aquatic/Pike;Monster2.XLoc=0;Monster2.YLoc=1;Monster3=new/mob/monster/aquatic/Pike;Monster3.XLoc=-1;Monster3.YLoc=-2}
				if(2){Monster1=new/mob/monster/aquatic/Gator;Monster1.XLoc=-4;Monster1.YLoc=2;Monster2=new/mob/monster/aquatic/Gator;Monster2.XLoc=-2;Monster2.YLoc=-1}
				if(3){Monster1=new/mob/monster/aquatic/Gator;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/aquatic/WaterBug;Monster2.XLoc=-1;Monster2.YLoc=1;Monster3=new/mob/monster/aquatic/WaterBug;Monster3.XLoc=0;Monster3.YLoc=-2}
				if(4){Monster1=new/mob/monster/aquatic/Pike;Monster1.XLoc=2;Monster1.YLoc=1;Monster2=new/mob/monster/aquatic/Pike;Monster2.XLoc=1;Monster2.YLoc=-2;Monster3=new/mob/monster/aquatic/EvilShell;Monster3.XLoc=-2;Monster3.YLoc=1;Monster4=new/mob/monster/aquatic/EvilShell;Monster4.XLoc=-3;Monster4.YLoc=-2;Monster5=new/mob/monster/aquatic/WaterBug;Monster5.XLoc=-5;Monster5.YLoc=1;Monster6=new/mob/monster/aquatic/WaterBug;Monster6.XLoc=-6;Monster6.YLoc=-2}
				if(5){Monster1=new/mob/monster/aquatic/MadToad;Monster1.XLoc=-4;Monster1.YLoc=1;Monster2=new/mob/monster/aquatic/MadToad;Monster2.XLoc=0;Monster2.YLoc=0;Monster3=new/mob/monster/aquatic/MadToad;Monster3.XLoc=-2;Monster3.YLoc=-2}
				if(6){Monster1=new/mob/monster/aquatic/Waterhag;Monster1.XLoc=-1;Monster1.YLoc=-2;Monster2=new/mob/monster/aquatic/Waterhag;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/aquatic/Waterhag;Monster3.XLoc=-4;Monster3.YLoc=1;Monster4=new/mob/monster/aquatic/Waterhag;Monster4.XLoc=-1;Monster4.YLoc=1}
		if(7)		//damcyan
			switch(rand(1,6))
				if(1){Monster1=new/mob/monster/Imp;Monster1.XLoc=-3;Monster1.YLoc=1;Monster2=new/mob/monster/SwordRat;Monster2.YLoc=1;Monster3=new/mob/monster/Imp;Monster3.XLoc=-4;Monster3.YLoc=-1;Monster4=new/mob/monster/SwordRat;Monster4.XLoc=-1;Monster4.YLoc=-1}
				if(2){Monster1=new/mob/monster/SandMan;Monster1.XLoc=-6;Monster2=new/mob/monster/SandMan;Monster2.XLoc=-3;Monster2.YLoc=-2;Monster3=new/mob/monster/SandMan;Monster3.XLoc=-1;Monster4=new/mob/monster/SandMan;Monster4.XLoc=2;Monster4.YLoc=-2}
				if(3){Monster1=new/mob/monster/Imp;Monster1.XLoc=1;Monster1.YLoc=1;Monster2=new/mob/monster/Imp;Monster2.XLoc=0;Monster2.YLoc=-2;Monster3=new/mob/monster/Imp;Monster3.XLoc=-1;Monster3.YLoc=1;Monster4=new/mob/monster/Imp;Monster4.XLoc=-2;Monster4.YLoc=-2;Monster5=new/mob/monster/Imp;Monster5.XLoc=-3;Monster5.YLoc=1;Monster6=new/mob/monster/Imp;Monster6.XLoc=-4;Monster6.YLoc=-2;Monster7=new/mob/monster/Imp;Monster7.XLoc=-5;Monster7.YLoc=1;Monster8=new/mob/monster/Imp;Monster8.XLoc=-6;Monster8.YLoc=-2}
				if(4){Monster1=new/mob/monster/SandWorm;Monster1.XLoc=-4;Monster1.YLoc=-1}
				if(5){Monster1=new/mob/monster/SandWorm;Monster1.XLoc=-5;Monster1.YLoc=-1;Monster2=new/mob/monster/SandWorm;Monster2.YLoc=-1}
				if(6){Monster1=new/mob/monster/SandWorm;Monster1.XLoc=-5;Monster1.YLoc=-1;Monster2=new/mob/monster/Sandpede;Monster2.YLoc=-1}
		if(8)		//damcyan's dungeon
			switch(rand(1,5))
				if(1 to 2){Monster1=new/mob/monster/undead/Zombie;Monster1.XLoc=0;Monster1.YLoc=1;Monster2=new/mob/monster/undead/Zombie;Monster2.XLoc=-2;Monster2.YLoc=-2}
				if(3 to 4){Monster1=new/mob/monster/undead/Zombie;Monster1.XLoc=1;Monster1.YLoc=0;Monster2=new/mob/monster/undead/Zombie;Monster2.XLoc=-2;Monster2.YLoc=-2;Monster3=new/mob/monster/undead/Zombie;Monster3.XLoc=-5;Monster3.YLoc=0}
				if(5){Monster1=new/mob/monster/undead/Zombie;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/undead/Zombie;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/undead/Zombie;Monster3.XLoc=-2;Monster3.YLoc=1;Monster4=new/mob/monster/undead/Zombie;Monster4.XLoc=-1;Monster4.YLoc=-2;Monster5=new/mob/monster/undead/Zombie;Monster5.XLoc=1;Monster5.YLoc=1}
		if(9)		//antilion
			switch(rand(1,7))
				if(1){Monster1=new/mob/monster/Turtle;Monster1.XLoc=-4;Monster1.YLoc=1;Monster2=new/mob/monster/Imp;Monster2.XLoc=0;Monster2.YLoc=1;Monster3=new/mob/monster/Imp;Monster3.XLoc=-1;Monster3.YLoc=-2}
				if(2){Monster1=new/mob/monster/Basilisk;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/Imp;Monster2.XLoc=0;Monster2.YLoc=2;Monster3=new/mob/monster/Imp;Monster3.XLoc=-1;Monster3.YLoc=0;Monster4=new/mob/monster/Imp;Monster4.XLoc=0;Monster4.YLoc=-2}
				if(3){Monster1=new/mob/monster/Weeper;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/Turtle;Monster2.XLoc=-1;Monster2.YLoc=2;Monster3=new/mob/monster/Basilisk;Monster3.XLoc=0;Monster3.YLoc=-1}
				if(4){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/Imp;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/Imp;Monster3.XLoc=-3;Monster3.YLoc=-2;Monster4=new/mob/monster/Imp;Monster4.YLoc=-2}
				if(5){Monster1=new/mob/monster/Turtle;Monster1.XLoc=-1;Monster1.YLoc=-1;Monster2=new/mob/monster/Turtle;Monster2.XLoc=-4;Monster2.YLoc=2}
				if(6){Monster1=new/mob/monster/Turtle;Monster1.XLoc=-1;Monster1.YLoc=2;Monster2=new/mob/monster/Basilisk;Monster2.XLoc=-5;Monster2.YLoc=-1}
				if(7){Monster1=new/mob/monster/Weeper;Monster1.XLoc=0;Monster1.YLoc=1;Monster2=new/mob/monster/Weeper;Monster2.XLoc=-4;Monster2.YLoc=-1}
		if(10)	//mount hobs
			switch(rand(1,7))
				if(1){Monster1=new/mob/monster/floating/Gargoyle;Monster1.XLoc=-4;Monster1.YLoc=3;Monster2=new/mob/monster/floating/Cocktrice;Monster2.XLoc=1;Monster2.YLoc=2;Monster3=new/mob/monster/floating/Cocktrice;Monster3.XLoc=-3}
				if(2){Monster1=new/mob/monster/floating/Cocktrice;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/floating/Cocktrice;Monster2.XLoc=-2;Monster3=new/mob/monster/floating/Cocktrice;Monster3.XLoc=1;Monster3.YLoc=2}
				if(3){Monster1=new/mob/monster/undead/Spirit;Monster1.XLoc=-1;Monster1.YLoc=0;Monster2=new/mob/monster/undead/Spirit;Monster2.XLoc=-4;Monster2.YLoc=0}
				if(4){Monster1=new/mob/monster/undead/Skeleton;Monster1.XLoc=-3;Monster1.YLoc=2;Monster2=new/mob/monster/undead/Skeleton;Monster2.XLoc=-4;Monster2.YLoc=-1;Monster3=new/mob/monster/undead/Spirit;Monster3.XLoc=1;Monster3.YLoc=2;Monster4=new/mob/monster/undead/Spirit;Monster4.YLoc=-1}
				if(5){Monster1=new/mob/monster/undead/Skeleton;Monster1.XLoc=-4;Monster1.YLoc=-1;Monster2=new/mob/monster/undead/Skeleton;Monster2.XLoc=-3;Monster2.YLoc=2;Monster3=new/mob/monster/undead/Skeleton;Monster3.XLoc=1;Monster3.YLoc=-1;Monster4=new/mob/monster/undead/Skeleton;Monster4.YLoc=2}
				if(6){Monster1=new/mob/monster/Bomb;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/Bomb;Monster2.XLoc=-1;Monster2.YLoc=-2;Monster3=new/mob/monster/Bomb;Monster3.XLoc=1;Monster3.YLoc=0}
				if(7){Monster1=new/mob/monster/Bomb;Monster1.XLoc=-1;Monster1.YLoc=1;Monster2=new/mob/monster/Bomb;Monster2.XLoc=-1;Monster2.YLoc=-2;Monster3=new/mob/monster/GrayBomb;Monster3.XLoc=-4;Monster3.YLoc=1;Monster4=new/mob/monster/GrayBomb;Monster4.XLoc=-4;Monster4.YLoc=-2}
		if(11)	//fabul area
			switch(rand(1,7))
				if(1){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/ImpCap;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/ImpCap;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/Imp;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/Imp;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(2){Monster1=new/mob/monster/Needler;Monster1.XLoc=0;Monster1.YLoc=3;Monster2=new/mob/monster/ImpCap;Monster2.XLoc=0;Monster2.YLoc=0;Monster3=new/mob/monster/Needler;Monster3.XLoc=0;Monster3.YLoc=-3;Monster4=new/mob/monster/ImpCap;Monster4.XLoc=-4;Monster4.YLoc=3;Monster5=new/mob/monster/Needler;Monster5.XLoc=-4;Monster5.YLoc=0;Monster6=new/mob/monster/ImpCap;Monster6.XLoc=-4;Monster6.YLoc=-3}
				if(3){Monster1=new/mob/monster/SwordRat;Monster1.XLoc=-1;Monster1.YLoc=3;Monster2=new/mob/monster/SwordRat;Monster2.XLoc=0;Monster2.YLoc=0;Monster3=new/mob/monster/SwordRat;Monster3.XLoc=1;Monster3.YLoc=-3;Monster4=new/mob/monster/Needler;Monster4.XLoc=-5;Monster4.YLoc=3;Monster5=new/mob/monster/Needler;Monster5.XLoc=-4;Monster5.YLoc=0;Monster6=new/mob/monster/Needler;Monster6.XLoc=-3;Monster6.YLoc=-3}
				if(4){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/ImpCap;Monster3.XLoc=-3;Monster3.YLoc=-2;Monster4=new/mob/monster/ImpCap;Monster4.YLoc=-2}
				if(5){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.YLoc=-2;Monster3=new/mob/monster/ImpCap;Monster3.YLoc=2;Monster4=new/mob/monster/Needler;Monster4.XLoc=-3}
				if(6){Monster1=new/mob/monster/floating/Cocktrice;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/floating/Cocktrice;Monster2.XLoc=-2;Monster3=new/mob/monster/floating/Cocktrice;Monster3.XLoc=1;Monster3.YLoc=2}
				if(7){Monster1=new/mob/monster/floating/Gargoyle;Monster1.XLoc=-4;Monster1.YLoc=3;Monster2=new/mob/monster/floating/Cocktrice;Monster2.XLoc=1;Monster2.YLoc=2;Monster3=new/mob/monster/floating/Cocktrice;Monster3.XLoc=-3}
		if(12)	//fabul area + PinkPuff
			switch(rand(1,8))
				if(1){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/ImpCap;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/ImpCap;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/Imp;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/Imp;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(2){Monster1=new/mob/monster/Needler;Monster1.XLoc=0;Monster1.YLoc=3;Monster2=new/mob/monster/ImpCap;Monster2.XLoc=0;Monster2.YLoc=0;Monster3=new/mob/monster/Needler;Monster3.XLoc=0;Monster3.YLoc=-3;Monster4=new/mob/monster/ImpCap;Monster4.XLoc=-4;Monster4.YLoc=3;Monster5=new/mob/monster/Needler;Monster5.XLoc=-4;Monster5.YLoc=0;Monster6=new/mob/monster/ImpCap;Monster6.XLoc=-4;Monster6.YLoc=-3}
				if(3){Monster1=new/mob/monster/SwordRat;Monster1.XLoc=-1;Monster1.YLoc=3;Monster2=new/mob/monster/SwordRat;Monster2.XLoc=0;Monster2.YLoc=0;Monster3=new/mob/monster/SwordRat;Monster3.XLoc=1;Monster3.YLoc=-3;Monster4=new/mob/monster/Needler;Monster4.XLoc=-5;Monster4.YLoc=3;Monster5=new/mob/monster/Needler;Monster5.XLoc=-4;Monster5.YLoc=0;Monster6=new/mob/monster/Needler;Monster6.XLoc=-3;Monster6.YLoc=-3}
				if(4){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/ImpCap;Monster3.XLoc=-3;Monster3.YLoc=-1;Monster4=new/mob/monster/ImpCap;Monster4.YLoc=-1}
				if(5){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.YLoc=-2;Monster3=new/mob/monster/ImpCap;Monster3.YLoc=2;Monster4=new/mob/monster/Needler;Monster4.XLoc=-3}
				if(6){Monster1=new/mob/monster/floating/Cocktrice;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/floating/Cocktrice;Monster2.XLoc=-2;Monster3=new/mob/monster/floating/Cocktrice;Monster3.XLoc=1;Monster3.YLoc=2}
				if(7){Monster1=new/mob/monster/floating/Gargoyle;Monster1.XLoc=-4;Monster1.YLoc=3;Monster2=new/mob/monster/floating/Cocktrice;Monster2.XLoc=1;Monster2.YLoc=2;Monster3=new/mob/monster/floating/Cocktrice;Monster3.XLoc=-3}
		if(13)	//mysidia area
			switch(rand(1,5))
				if(1){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/ImpCap;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/ImpCap;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/Imp;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/Imp;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(2){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/ImpCap;Monster3.XLoc=-3;Monster3.YLoc=-1;Monster4=new/mob/monster/ImpCap;Monster4.YLoc=-1}
				if(3){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.YLoc=-2;Monster3=new/mob/monster/ImpCap;Monster3.YLoc=2;Monster4=new/mob/monster/Needler;Monster4.XLoc=-3}
				if(4){Monster1=new/mob/monster/floating/Raven;Monster1.XLoc=-1}
				if(5){Monster1=new/mob/monster/TinyMage;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/TinyMage;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/Imp;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/Imp;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/SwordRat;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/SwordRat;Monster6.XLoc=1;Monster6.YLoc=-2}
		if(14)	//ordeals area
			switch(rand(1,5))
				if(1){Monster1=new/mob/monster/undead/RedBone;Monster1.XLoc=-6;Monster2=new/mob/monster/undead/Skeleton;Monster2.XLoc=-3; Monster2.YLoc=2;Monster3=new/mob/monster/undead/Skeleton;Monster3.XLoc=-3; Monster3.YLoc=-2;Monster4=new/mob/monster/undead/Skeleton;Monster4.XLoc=0}
				if(2){Monster1=new/mob/monster/undead/RedBone;Monster1.XLoc=-6;Monster2=new/mob/monster/undead/RedBone;Monster2.XLoc=-3; Monster2.YLoc=-1;Monster3=new/mob/monster/undead/Soul;Monster3.XLoc=-1; Monster3.YLoc=-2;Monster4=new/mob/monster/undead/Soul;Monster4.XLoc=-1; Monster4.YLoc=2;Monster5=new/mob/monster/undead/Spirit;Monster5.XLoc=2; Monster5.YLoc=-2; Monster6=new/mob/monster/undead/Spirit;Monster6.XLoc=2; Monster6.YLoc=2}
				if(3){Monster1=new/mob/monster/undead/Revenant;Monster1.XLoc=-6;Monster2=new/mob/monster/undead/Ghoul;Monster2.XLoc=-3; Monster2.YLoc=-1;Monster3=new/mob/monster/undead/Ghoul;Monster3.XLoc=0;Monster4=new/mob/monster/undead/Ghoul;Monster4.XLoc=3; Monster4.YLoc=-1}
				if(4){Monster1=new/mob/monster/undead/Lilith;Monster1.XLoc=-2}
				if(5){Monster1=new/mob/monster/undead/Zombie;Monster1.XLoc=-7; Monster1.YLoc=1; Monster2=new/mob/monster/undead/Zombie;Monster2.XLoc=-4; Monster2.YLoc=2; Monster3=new/mob/monster/undead/Zombie;Monster3.XLoc=-4; Monster3.YLoc=-1; Monster4=new/mob/monster/undead/Ghoul;Monster4.XLoc=-1; Monster4.YLoc=2; Monster5=new/mob/monster/undead/Ghoul;Monster5.XLoc=-1; Monster5.YLoc=-1; Monster6=new/mob/monster/undead/Revenant;Monster6.XLoc=2; Monster6.YLoc=3;Monster7=new/mob/monster/undead/Revenant;Monster7.XLoc=2; Monster7.YLoc=-2}
		if(15)	//toroia area + Behemoth
			switch(rand(1,11))
				if(1){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/StingRat;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/plant/Treant;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/StingRat;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/StingRat;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(2){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/plant/Cannibal;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/Panther;Monster3.XLoc=-3;Monster3.YLoc=-1;Monster4=new/mob/monster/StingRat;Monster4.YLoc=-1}
				if(3){Monster1=new/mob/monster/plant/Treant;Monster1.XLoc=1;Monster2=new/mob/monster/Panther;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.YLoc=2;Monster4=new/mob/monster/StingRat;Monster4.XLoc=-3}
				if(4){Monster1=new/mob/monster/plant/Cannibal;Monster1.XLoc=-1}
				if(5){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/StingRat;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/plant/Treant;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/StingRat;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/StingRat;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(6){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/plant/Cannibal;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/Panther;Monster3.XLoc=-3;Monster3.YLoc=-1;Monster4=new/mob/monster/StingRat;Monster4.YLoc=-1}
				if(7){Monster1=new/mob/monster/plant/Treant;Monster1.XLoc=1;Monster2=new/mob/monster/Panther;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.YLoc=2;Monster4=new/mob/monster/StingRat;Monster4.XLoc=-3}
				if(8){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.YLoc=-2;Monster3=new/mob/monster/ImpCap;Monster3.YLoc=2;Monster4=new/mob/monster/Needler;Monster4.XLoc=-3}
				if(9){Monster1=new/mob/monster/Sandpede;Monster1.XLoc=-4;Monster1.YLoc=-2;Monster2=new/mob/monster/SandMan;Monster2.XLoc=-1;Monster2.YLoc=1;Monster3=new/mob/monster/SandMan;Monster3.XLoc=-1;Monster3.YLoc=-3}
				if(10){Monster1=new/mob/monster/Sandpede;Monster1.XLoc=-4;Monster1.YLoc=-2;Monster2=new/mob/monster/SandMan;Monster2.XLoc=-1;Monster2.YLoc=1;Monster3=new/mob/monster/SandMan;Monster3.XLoc=-1;Monster3.YLoc=-3}
		if(16)	//toroia area
			switch(rand(1,10))
				if(1){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/StingRat;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/plant/Treant;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/StingRat;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/StingRat;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(2){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/plant/Cannibal;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/Panther;Monster3.XLoc=-3;Monster3.YLoc=-1;Monster4=new/mob/monster/StingRat;Monster4.YLoc=-1}
				if(3){Monster1=new/mob/monster/plant/Treant;Monster1.XLoc=1;Monster2=new/mob/monster/Panther;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.YLoc=2;Monster4=new/mob/monster/StingRat;Monster4.XLoc=-3}
				if(4){Monster1=new/mob/monster/plant/Cannibal;Monster1.XLoc=-1}
				if(5){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/StingRat;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/plant/Treant;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/StingRat;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/StingRat;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(6){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-2;Monster1.YLoc=1;Monster2=new/mob/monster/plant/Cannibal;Monster2.XLoc=1;Monster2.YLoc=1;Monster3=new/mob/monster/Panther;Monster3.XLoc=-3;Monster3.YLoc=-1;Monster4=new/mob/monster/StingRat;Monster4.YLoc=-1}
				if(7){Monster1=new/mob/monster/plant/Treant;Monster1.XLoc=1;Monster2=new/mob/monster/Panther;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.YLoc=2;Monster4=new/mob/monster/StingRat;Monster4.XLoc=-3}
				if(8){Monster1=new/mob/monster/ImpCap;Monster1.XLoc=1;Monster2=new/mob/monster/ImpCap;Monster2.YLoc=-2;Monster3=new/mob/monster/ImpCap;Monster3.YLoc=2;Monster4=new/mob/monster/Needler;Monster4.XLoc=-3}
				if(9){Monster1=new/mob/monster/Sandpede;Monster1.XLoc=-4;Monster1.YLoc=-2;Monster2=new/mob/monster/SandMan;Monster2.XLoc=-1;Monster2.YLoc=1;Monster3=new/mob/monster/SandMan;Monster3.XLoc=-1;Monster3.YLoc=-3}
				if(10){Monster1=new/mob/monster/Sandpede;Monster1.XLoc=-4;Monster1.YLoc=-2;Monster2=new/mob/monster/SandMan;Monster2.XLoc=-1;Monster2.YLoc=1;Monster3=new/mob/monster/SandMan;Monster3.XLoc=-1;Monster3.YLoc=-3}
		if(17) //magnes area
			switch(rand(1,10))
				if(1){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/StingRat;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/plant/Treant;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/StingRat;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/StingRat;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(2){Monster1=new/mob/monster/plant/Treant;Monster1.XLoc=1;Monster2=new/mob/monster/Panther;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.YLoc=2;Monster4=new/mob/monster/StingRat;Monster4.XLoc=-3}
				if(3){Monster1=new/mob/monster/StingRat;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/StingRat;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.XLoc=-2;Monster3.YLoc=2;Monster4=new/mob/monster/plant/Treant;Monster4.XLoc=-2;Monster4.YLoc=-1;Monster5=new/mob/monster/StingRat;Monster5.XLoc=1;Monster5.YLoc=1;Monster6=new/mob/monster/StingRat;Monster6.XLoc=1;Monster6.YLoc=-2}
				if(4){Monster1=new/mob/monster/plant/Treant;Monster1.XLoc=1;Monster2=new/mob/monster/Panther;Monster2.YLoc=-2;Monster3=new/mob/monster/plant/Treant;Monster3.YLoc=2;Monster4=new/mob/monster/StingRat;Monster4.XLoc=-3}
				if(5){Monster1=new/mob/monster/floating/Cave_Bat;Monster1.XLoc=2;Monster1.YLoc=0;Monster2=new/mob/monster/floating/Cave_Bat;Monster2.XLoc=-1;Monster2.YLoc=-1;Monster3=new/mob/monster/floating/Cave_Bat;Monster3.XLoc=-4;Monster3.YLoc=-2;Monster4=new/mob/monster/VampGirl;Monster4.XLoc=-5;Monster4.YLoc=3}
				if(6){Monster1=new/mob/monster/floating/Cave_Bat;Monster1.XLoc=2;Monster1.YLoc=0;Monster2=new/mob/monster/floating/Cave_Bat;Monster2.XLoc=-1;Monster2.YLoc=-1;Monster3=new/mob/monster/floating/Cave_Bat;Monster3.XLoc=-4;Monster3.YLoc=-2}
				if(7){Monster1=new/mob/monster/Ogre;Monster1.XLoc=2;Monster1.YLoc=-1;Monster2=new/mob/monster/Ogre;Monster2.XLoc=-1;Monster2.YLoc=-2;Monster3=new/mob/monster/CaveNaga;Monster3.XLoc=-4.5;Monster3.YLoc=-1}
				if(8){Monster1=new/mob/monster/Mage;Monster1.XLoc=-4;Monster1.YLoc=0;Monster2=new/mob/monster/Ogre;Monster2.XLoc=-1;Monster2.YLoc=-2;Monster3=new/mob/monster/Ogre;Monster3.XLoc=2;Monster3.YLoc=-1}
				if(9){Monster1=new/mob/monster/Mage;Monster1.XLoc=1;Monster1.YLoc=0;Monster2=new/mob/monster/Mage;Monster2.XLoc=-3;Monster2.YLoc=-1}
				if(10){Monster1=new/mob/monster/Ogre;Monster1.XLoc=2;Monster1.YLoc=0;Monster2=new/mob/monster/Ogre;Monster2.XLoc=-1;Monster2.YLoc=2;Monster3=new/mob/monster/Ogre;Monster3.XLoc=-1;Monster3.YLoc=-2;Monster4=new/mob/monster/Ogre;Monster4.XLoc=-4;Monster4.YLoc=0}
		if(18)	//eblan and agart Area
			switch(rand(1,5))
				if(1){Monster1=new/mob/monster/HugeCell;Monster1.XLoc=-3;Monster1.YLoc=2;Monster2=new/mob/monster/HugeCell;Monster2.XLoc=-2;Monster2.YLoc=0;Monster3=new/mob/monster/HugeCell;Monster3.XLoc=-1;Monster3.YLoc=-2}
				if(2){Monster1=new/mob/monster/HugeCell;Monster1.XLoc=-1;Monster1.YLoc=2;Monster2=new/mob/monster/HugeCell;Monster2.XLoc=-3;Monster2.YLoc=0;Monster3=new/mob/monster/HugeCell;Monster3.XLoc=1;Monster3.YLoc=0;Monster4=new/mob/monster/HugeCell;Monster4.XLoc=-1;Monster4.YLoc=-2}
				if(3){Monster1=new/mob/monster/floating/Roc;Monster1.XLoc=-2;Monster1.YLoc=2;Monster2=new/mob/monster/floating/RocBaby;Monster2.XLoc=-5;Monster2.YLoc=-2;Monster3=new/mob/monster/floating/RocBaby;Monster3.XLoc=-2;Monster3.YLoc=-2}
				if(4){Monster1=new/mob/monster/BlackLiz;Monster1.XLoc=-5;Monster1.YLoc=2;Monster2=new/mob/monster/BlackLiz;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/flame/FlameDog;Monster3.XLoc=0;Monster3.YLoc=1;Monster4=new/mob/monster/flame/FlameDog;Monster4.XLoc=1;Monster4.YLoc=-3}
				if(5){Monster1=new/mob/monster/BlackLiz;Monster1.XLoc=-5;Monster1.YLoc=2;Monster2=new/mob/monster/BlackLiz;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/Ironback;Monster3.XLoc=0;Monster3.YLoc=2;Monster4=new/mob/monster/Ironback;Monster4.XLoc=1;Monster4.YLoc=-2}
		if(19)	//Tower of Zot Area
			switch(rand(1,8))
				if(1){Monster1=new/mob/monster/Centaur;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/aquatic/IceBeast;Monster2.XLoc=-1;Monster2.YLoc=1;Monster3=new/mob/monster/aquatic/IceBeast;Monster3.XLoc=0;Monster3.YLoc=-3}
/*				if(2){Monster1=new/mob/monster/EpeeGirl;Monster1.XLoc=-4;Monster1.YLoc=1;Monster2=new/mob/monster/EpeeGirl;Monster2.XLoc=0;Monster2.YLoc=2;Monster3=new/mob/monster/SwordMan;Monster3.XLoc=-4;Monster3.YLoc=-3;Monster4=new/mob/monster/SwordMan;Monster4.XLoc=0;Monster4.YLoc=-2}*/
				if(2){Monster1=new/mob/monster/Marion;Monster1.XLoc=-6;Monster1.YLoc=0;Monster2=new/mob/monster/Puppet;Monster2.XLoc=-1;Monster2.YLoc=3;Monster3=new/mob/monster/Puppet;Monster3.XLoc=0;Monster3.YLoc=0;Monster4=new/mob/monster/Puppet;Monster4.XLoc=1;Monster4.YLoc=-3}
/*				if(4){Monster1=new/mob/monster/SwordMan;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/SwordMan;Monster2.XLoc=-1;Monster2.YLoc=1}*/
				if(3){Monster1=new/mob/monster/Marion;Monster1.XLoc=-6;Monster1.YLoc=-1;Monster2=new/mob/monster/Puppet;Monster2.XLoc=-3;Monster2.YLoc=1;Monster3=new/mob/monster/Puppet;Monster3.XLoc=-3;Monster3.YLoc=-2}
				if(4){Monster1=new/mob/monster/Centaur;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/Centaur;Monster2.XLoc=-2;Monster2.YLoc=0;Monster3=new/mob/monster/Centaur;Monster3.XLoc=1;Monster3.YLoc=-1}
				if(5){Monster1=new/mob/monster/Centaur;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/Gremlin;Monster2.XLoc=-2;Monster2.YLoc=2;Monster3=new/mob/monster/Gremlin;Monster3.XLoc=-1;Monster3.YLoc=-2}
				if(6){Monster1=new/mob/monster/Carapace;Monster1.XLoc=-5;Monster1.YLoc=2;Monster2=new/mob/monster/aquatic/IceLiz;Monster2.XLoc=0;Monster2.YLoc=4;Monster3=new/mob/monster/Carapace;Monster3.XLoc=-4;Monster3.YLoc=-1;Monster4=new/mob/monster/aquatic/IceLiz;Monster4.XLoc=1;Monster4.YLoc=0}
/*				if(9){Monster1=new/mob/monster/SwordMan;Monster1.XLoc=-6;Monster1.YLoc=0;Monster2=new/mob/monster/aquatic/IceLiz;Monster2.XLoc=-2;Monster2.YLoc=3;Monster3=new/mob/monster/aquatic/IceLiz;Monster3.XLoc=-2;Monster3.YLoc=-2}*/
				if(7){Monster1=new/mob/monster/Centaur;Monster1.XLoc=-5;Monster1.YLoc=2;Monster2=new/mob/monster/Centaur;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/aquatic/IceBeast;Monster3.XLoc=-1;Monster3.YLoc=2;Monster4=new/mob/monster/aquatic/IceBeast;Monster4.XLoc=0;Monster4.YLoc=-2}
				if(8){Monster1=new/mob/monster/Gremlin;Monster1.XLoc=-6;Monster1.YLoc=0;Monster2=new/mob/monster/Gremlin;Monster2.XLoc=-4;Monster2.YLoc=-1;Monster3=new/mob/monster/aquatic/IceLiz;Monster3.XLoc=0;Monster3.YLoc=2;Monster4=new/mob/monster/aquatic/IceLiz;Monster4.XLoc=-1;Monster4.YLoc=-2}
		if(20)	//Eblan Cave
			switch(rand(1,11))
				if(1){Monster1=new/mob/monster/Staleman;Monster1.XLoc=-6;Monster1.YLoc=0;Monster2=new/mob/monster/undead/Skull;Monster2.XLoc=-2;Monster2.YLoc=2;Monster3=new/mob/monster/undead/Skull;Monster3.XLoc=-2;Monster3.YLoc=-2}
				if(2){Monster1=new/mob/monster/floating/GiantBat;Monster1.XLoc=-5;Monster1.YLoc=1;Monster2=new/mob/monster/floating/GiantBat;Monster2.XLoc=-2;Monster2.YLoc=4;Monster3=new/mob/monster/floating/GiantBat;Monster3.XLoc=-1;Monster3.YLoc=-1}
				if(3){Monster1=new/mob/monster/undead/Skull;Monster1.XLoc=-4;Monster1.YLoc=0;Monster2=new/mob/monster/undead/Skull;Monster2.XLoc=-1;Monster2.YLoc=2;Monster3=new/mob/monster/undead/Skull;Monster3.XLoc=-1;Monster3.YLoc=-2}
				if(4){Monster1=new/mob/monster/BlackLiz;Monster1.XLoc=-5;Monster1.YLoc=2;Monster2=new/mob/monster/BlackLiz;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/Ironback;Monster3.XLoc=0;Monster3.YLoc=2;Monster4=new/mob/monster/Ironback;Monster4.XLoc=1;Monster4.YLoc=-2}
				if(5){Monster1=new/mob/monster/floating/Cave_Bat;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/floating/Cave_Bat;Monster2.XLoc=-3;Monster2.YLoc=-1;Monster3=new/mob/monster/floating/Cave_Bat;Monster3.XLoc=-1;Monster3.YLoc=-2;Monster4=new/mob/monster/floating/GiantBat;Monster4.XLoc=-4;Monster4.YLoc=4;Monster5=new/mob/monster/floating/GiantBat;Monster5.XLoc=-2;Monster5.YLoc=3;Monster6=new/mob/monster/floating/GiantBat;Monster6.XLoc=0;Monster6.YLoc=2}
				if(6){Monster1=new/mob/monster/undead/Skull;Monster1.XLoc=-6;Monster1.YLoc=1;Monster2=new/mob/monster/undead/Skull;Monster2.XLoc=-3;Monster2.YLoc=-1;Monster3=new/mob/monster/undead/Skull;Monster3.XLoc=0;Monster3.YLoc=1;Monster4=new/mob/monster/undead/Skull;Monster4.XLoc=3;Monster4.YLoc=-1}
				if(7){Monster1=new/mob/monster/Ironback;Monster1.XLoc=-5;Monster1.YLoc=3;Monster2=new/mob/monster/Ironback;Monster2.XLoc=-3;Monster2.YLoc=-1}
				if(8){Monster1=new/mob/monster/floating/GiantBat;Monster1.XLoc=-4;Monster1.YLoc=-1;Monster2=new/mob/monster/floating/GiantBat;Monster2.XLoc=-5;Monster2.YLoc=3;Monster3=new/mob/monster/floating/GiantBat;Monster3.XLoc=-1;Monster3.YLoc=4;Monster4=new/mob/monster/floating/GiantBat;Monster4.XLoc=-1;Monster4.YLoc=0}
				if(9){Monster1=new/mob/monster/Egg1;Monster1.XLoc=-2;Monster1.YLoc=1}
				if(10){Monster1=new/mob/monster/Ironback;Monster1.XLoc=1;Monster1.YLoc=3;Monster2=new/mob/monster/Armadilo;Monster2.XLoc=0;Monster2.YLoc=-1;Monster3=new/mob/monster/BlackLiz;Monster3.XLoc=-5;Monster3.YLoc=0}
				if(11){Monster1=new/mob/monster/undead/Skull;Monster1.XLoc=-5;Monster1.YLoc=-2;Monster2=new/mob/monster/undead/Skull;Monster2.XLoc=-5;Monster2.YLoc=2;Monster3=new/mob/monster/undead/RedBone;Monster3.XLoc=-2;Monster3.YLoc=-3;Monster4=new/mob/monster/undead/RedBone;Monster4.XLoc=-2;Monster4.YLoc=3;Monster5=new/mob/monster/undead/RedBone;Monster5.XLoc=1;Monster5.YLoc=0}
		if(21)	//Underworld - regular area
			switch(rand(1,6))
				if(1){Monster1=new/mob/monster/Tortoise;Monster1.XLoc=-3;Monster1.YLoc=-1;Monster2=new/mob/monster/Tortoise;Monster2.XLoc=-5;Monster2.YLoc=2;Monster3=new/mob/monster/Armadilo;Monster3.XLoc=2;Monster3.YLoc=0}
				if(2){Monster1=new/mob/monster/DarkImp;Monster1.XLoc=0;Monster1.YLoc=0;Monster2=new/mob/monster/DarkImp;Monster2.XLoc=-1;Monster2.YLoc=2;Monster3=new/mob/monster/DarkImp;Monster3.XLoc=1;Monster3.YLoc=-2;Monster4=new/mob/monster/Armadilo;Monster4.XLoc=-5;Monster4.YLoc=2;Monster5=new/mob/monster/BlackLiz;Monster5.XLoc=-5;Monster5.YLoc=-2}
				if(3){Monster1=new/mob/monster/Armadilo;Monster1.XLoc=-2;Monster1.YLoc=-1;Monster2=new/mob/monster/Armadilo;Monster2.XLoc=-5;Monster2.YLoc=2}
				if(4){Monster1=new/mob/monster/Tortoise;Monster1.XLoc=-4;Monster1.YLoc=-1;Monster2=new/mob/monster/DarkImp;Monster2.XLoc=-1;Monster2.YLoc=2;Monster3=new/mob/monster/DarkImp;Monster3.XLoc=1;Monster1.YLoc=-2}
				if(5){Monster1=new/mob/monster/BlackLiz;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/BlackLiz;Monster2.XLoc=0;Monster2.YLoc=-1;Monster3=new/mob/monster/BlackLiz;Monster3.XLoc=2;Monster3.YLoc=2}
				if(6){Monster1=new/mob/monster/DarkImp;Monster1.XLoc=0;Monster1.YLoc=0;Monster2=new/mob/monster/DarkImp;Monster2.XLoc=-3;Monster2.YLoc=-1;Monster3=new/mob/monster/DarkImp;Monster3.XLoc=-4;Monster3.YLoc=2;Monster4=new/mob/monster/DarkImp;Monster4.XLoc=-1;Monster4.YLoc=3}
		if(22)	//Bab-il - Lugae's Half
			switch(rand(1,6))
				if(1){Monster1=new/mob/monster/flame/FlameDog;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/flame/FlameDog;Monster2.XLoc=0;Monster2.YLoc=2;Monster3=new/mob/monster/flame/FlameDog;Monster3.XLoc=0;Monster3.YLoc=-2}
				if(2){Monster1=new/mob/monster/Marion;Monster1.XLoc=-6;Monster1.YLoc=0;Monster2=new/mob/monster/Puppet;Monster2.XLoc=-1;Monster2.YLoc=3;Monster3=new/mob/monster/Puppet;Monster3.XLoc=0;Monster3.YLoc=0;Monster4=new/mob/monster/Puppet;Monster4.XLoc=1;Monster4.YLoc=-3}
				if(3){Monster1=new/mob/monster/flame/FlameDog;Monster1.XLoc=-4;Monster1.YLoc=1;Monster2=new/mob/monster/flame/FlameDog;Monster2.XLoc=-1;Monster2.YLoc=-2}
				if(4){Monster1=new/mob/monster/BlackLiz;Monster1.XLoc=-5;Monster1.YLoc=0;Monster2=new/mob/monster/BlackLiz;Monster2.XLoc=0;Monster2.YLoc=-1;Monster3=new/mob/monster/BlackLiz;Monster3.XLoc=2;Monster3.YLoc=2}
				if(5){Monster1=new/mob/monster/Alert;Monster1.XLoc=-5;Monster1.YLoc=3}
				if(6){Monster1=new/mob/monster/Alert;Monster1.XLoc=-5;Monster1.YLoc=3;Monster2=new/mob/monster/Stoneman;Monster2.XLoc=-1;Monster2.YLoc=-1}
		if(23)  //The Sealed Cave (Underground)
			switch(rand(1,5))
				if(1){Monster1=new/mob/monster/HugeNaga;Monster1.XLoc=-4;Monster1.YLoc=1;Monster2=new/mob/monster/HugeNaga;Monster2.XLoc=0;Monster2.YLoc=-1}
		//		if(2){Monster1=new/mob/monster/Marid;Monster1.XLoc=-4;Monster2=new/mob/monster/Marid;Monster2.XLoc=-1}
				if(2){Monster1=new/mob/monster/ChimeraHead;Monster1.XLoc=-4;Monster2=new/mob/monster/Marid;Monster2.XLoc=0}
				if(3){Monster1=new/mob/monster/floating/EvilHead;Monster1.XLoc=-5;Monster2=new/mob/monster/floating/EvilHead;Monster2.XLoc=-4;Monster2.YLoc=-2;Monster3=new/mob/monster/floating/EvilHead;Monster3.XLoc=-2;Monster4=new/mob/monster/floating/EvilHead;Monster4.XLoc=0;Monster4.YLoc=-2;Monster5=new/mob/monster/VampLady;Monster5.XLoc=-2;Monster5.YLoc=3}
				if(4){Monster1=new/mob/monster/floating/EvilHead;Monster1.XLoc=-6;Monster2=new/mob/monster/floating/EvilHead;Monster2.XLoc=-4;Monster2.YLoc=2;Monster3=new/mob/monster/floating/EvilHead;Monster3.XLoc=0;Monster3.YLoc=2;Monster4=new/mob/monster/floating/EvilHead;Monster4.XLoc=2}
				if(5){Monster1=new/mob/monster/Marid;Monster1.XLoc=-4;Monster2=new/mob/monster/HugeNaga;Monster2.XLoc=1;Monster2.YLoc=-1}
		//		if(7){Monster1=new/mob/monster/floating/EvilHead;Monster1.XLoc=-4;Monster2=new/mob/monster/floating/EvilHead;Monster2.XLoc=-1;Monster3=new/mob/monster/floating/EvilHead;Monster3;XLoc=-3;Monster4=new/mob/monster/VampLady;Monster4.XLoc=-2;Monster4.YLoc=4;Monster5=new/mob/monster/VampLady;Monster5.XLoc=1;Monster5.YLoc=4}
		if(24) //Cave of Summoned Monsters
			switch(rand(1,4))
				if(1){Monster1=new/mob/monster/floating/Red_Eye;Monster1.XLoc=-2;Monster1.YLoc=0;Monster2=new/mob/monster/floating/Red_Eye;Monster2.XLoc=2;Monster2.YLoc=-2;Monster3=new/mob/monster/floating/Red_Eye;Monster3.XLoc=1;Monster3.YLoc=2}
				if(2){Monster1=new/mob/monster/Arachne;Monster1.XLoc=1}
				if(3){Monster1=new/mob/monster/Fiend;Monster1.XLoc=-3;Monster1.YLoc=1;Monster2=new/mob/monster/Fiend;Monster2.XLoc=-3;Monster2.YLoc=-3;Monster3=new/mob/monster/Satanite;Monster3.XLoc=1;Monster3.YLoc=2;Monster4=new/mob/monster/Satanite;Monster4.XLoc=1;Monster4.YLoc=-2}
				if(4){Monster1=new/mob/monster/floating/Red_Eye;Monster1.XLoc=1;Monster1.YLoc=2;Monster2=new/mob/monster/Arachne;Monster2.XLoc=-3;Monster2.YLoc=-1;Monster3=new/mob/monster/Arachne;Monster3.XLoc=2;Monster3.YLoc=-2}
		if(25)//Sylph Cave
			switch(rand(1,5))
				if(1){Monster1=new/mob/monster/Malboro;Monster1.XLoc=-4;Monster2=new/mob/monster/Malboro;Monster2.XLoc=0}
				if(2){Monster1=new/mob/monster/ToadLady;Monster1.XLoc=0;Monster1.YLoc=0}
				if(3){Monster1=new/mob/monster/undead/Ghost;Monster1.XLoc=0;Monster1.YLoc=2;Monster2=new/mob/monster/undead/Ghost;Monster2.XLoc=2;Monster2.YLoc=0;Monster3=new/mob/monster/undead/Ghost;Monster3.XLoc=0;Monster3.YLoc=-3} // Corrected Line
				if(4){Monster1=new/mob/monster/undead/Ghost;Monster1.XLoc=-2;Monster1.YLoc=2;Monster2=new/mob/monster/undead/Ghost;Monster2.XLoc=-2;Monster2.YLoc=-1;Monster3=new/mob/monster/Malboro;Monster3.XLoc=0}
				if(5){Monster1=new/mob/monster/undead/Ghost;Monster1.XLoc=-2;Monster1.YLoc=2;Monster2=new/mob/monster/undead/Ghost;Monster2.XLoc=-2;Monster3=new/mob/monster/Malboro;Monster3.XLoc=2}

	if(Monster1) Monsters+=Monster1;if(Monster2) Monsters+=Monster2;if(Monster3) Monsters+=Monster3
	if(Monster4) Monsters+=Monster4;if(Monster5) Monsters+=Monster5;if(Monster6) Monsters+=Monster6
	if(Monster7) Monsters+=Monster7;if(Monster8) Monsters+=Monster8;if(Monster9) Monsters+=Monster9
	if(Monster10) Monsters+=Monster10;if(Monster11) Monsters+=Monster11;if(Monster12) Monsters+=Monster12
	if(Monster13) Monsters+=Monster13;if(Monster14) Monsters+=Monster14;if(Monster15) Monsters+=Monster15

	return Monsters
