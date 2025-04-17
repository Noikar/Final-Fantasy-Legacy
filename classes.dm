mob/PC
    dknight
        name = "Cecil"
        class="Dark Knight"
        MaxHP=100
        HP=100
        MaxMP=0
        MP=0
        str=5
        agi=3
        vit=2
        wis=2
        wil=1
        icon='mob/pc/dknight.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/DarkWave,,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
        //The higher the number the more likely a status effect will hit you. The Lower the lesser chance of it hitting you.
    dragoon
        name = "Kain"
        class="Dragoon"
        MaxHP=90
        HP=90
        MaxMP=0
        MP=0
        str=4
        agi=3
        vit=2
        wis=2
        wil=2
        icon='mob/pc/dragoon.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/Jump,,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=10,"piercing"=20,"fire"=30,"ice"=20,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=20,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    ycaller
        name = "Rydia"
        class="Young Caller"
        MaxHP=60
        HP=60
        MaxMP=5
        MP=5
        str=2
        agi=2
        vit=1
        wis=4
        wil=3
        icon='mob/pc/ycaller.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White__,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/Summon,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=25,"holy"=35,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    sage
        name = "Tellah"
        class="Sage"
        MaxHP=70
        HP=70
        MaxMP=5
        MP=5
        str=2
        agi=2
        vit=2
        wis=4
        wil=2
        icon='mob/pc/sage.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White,new/obj/Ability/ASkills/Black,new/obj/Ability/Skills/Remember,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=25,"holy"=35,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    bard
        name = "Edward"
        class="Bard"
        MaxHP=80
        HP=80
        MaxMP=0
        MP=0
        str=1
        agi=1
        vit=1
        wis=1
        wil=1
        icon='mob/pc/bard.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Sing,new/obj/Ability/Skills/Medicine,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    wmage
        name = "Rosa"
        class="White Mage"
        MaxHP=75
        HP=75
        MaxMP=5
        MP=5
        str=3
        agi=2
        vit=2
        wis=1
        wil=5
        icon='mob/pc/wmage.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White,new/obj/Ability/Skills/Prayer,new/obj/Ability/Skills/Aim,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=25,"holy"=35,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    monk
        name = "Yang"
        class="Monk"
        MaxHP=90
        HP=90
        MaxMP=0
        MP=0
        str=5
        agi=3
        vit=2
        wis=1
        wil=1
        icon='mob/pc/monk.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/BuildUp,new/obj/Ability/Skills/Kick,new/obj/Ability/Skills/Endure,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    wtwin
        name = "Porom"
        class="White Twin"
        MaxHP=70
        HP=70
        MaxMP=6
        MP=6
        str=2
        agi=2
        vit=1
        wis=3
        wil=5
        icon='mob/pc/wtwin.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White,new/obj/Ability/ASkills/Twin,new/obj/Ability/Skills/FakeTears,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=20,"holy"=40,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    btwin
        name = "Palom"
        class="Black Twin"
        MaxHP=60
        HP=60
        MaxMP=5
        MP=5
        str=2
        agi=2
        vit=1
        wis=5
        wil=3
        icon='mob/pc/btwin.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/Twin,new/obj/Ability/Skills/Strengthen,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=40,"holy"=20,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    paladin
        name = "Cecil"
        class="Paladin"
        MaxHP=100
        HP=100
        MaxMP=3
        MP=3
        str=4
        agi=2
        vit=3
        wis=1
        wil=2
        icon='mob/pc/paladin.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White_,new/obj/Ability/Skills/Cover,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=25,"holy"=35,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    engineer
        name = "Cid"
        class="Engineer"
        MaxHP=120
        HP=120
        MaxMP=0
        MP=0
        str=5
        agi=1
        vit=5
        wis=1
        wil=1
        icon='mob/pc/engineer.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/Peep,,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    ninja
        name = "Edge"
        class="Ninja"
        MaxHP=80
        HP=80
        MaxMP=3
        MP=3
        str=4
        agi=3
        vit=2
        wis=2
        wil=1
        icon='mob/pc/ninja.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Ninjutsu,new/obj/Ability/Basic/Dart,new/obj/Ability/Skills/Sneak,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=30,"ice"=25,"water"=25,"bolt"=30,"earth"=25,"wind"=25,"dark"=25,"holy"=25,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    mcaller
        name = "Rydia"
        class="Mature Caller"
        MaxHP=70
        HP=70
        MaxMP=5
        MP=5
        str=3
        agi=2
        vit=2
        wis=4
        wil=2
        icon='mob/pc/mcaller.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/Summon,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    lunarian
        name = "FuSoYa"
        class="Lunarian"
        MaxHP=65
        HP=65
        MaxMP=5
        MP=5
        str=2
        agi=2
        vit=2
        wis=2
        wil=4
        icon='mob/pc/lunarian.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/White,new/obj/Ability/ASkills/Black,new/obj/Ability/Skills/SpiritWave,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    bknight
        name = "Golbez"
        class="Black Knight"
        MaxHP=90
        HP=90
        MaxMP=5
        MP=5
        str=4
        agi=1
        vit=3
        wis=4
        wil=1
        icon='mob/spc/bknight.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/Summon_,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)



/*	hero
        name = ""
        class="Hero"
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=25,"healing"=300)
    mknight
        name = "Albert"
        class="Magic Knight"
        icon='mob/spc/lknight.dmi'
        MaxHP=75
        HP=75
        MaxMP=4
        MP=4
        str=4
        agi=3
        vit=2
        wis=2
        wil=2
        icon='mob/spc/lknight.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/ASkills/MgcSword,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    lknight
        name = "Kluya"
        class = "Lunar Knight"
        MaxHP = 120
        HP = 120
        MaxMP = 3
        MP = 3
        str = 4
        agi = 4
        vit = 3
        wis = 1
        wil = 1
        icon = 'mob/spc/lknight.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Support,new/obj/Ability/Skills/SpiritWave,new/obj/Ability/Skills/Remember,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=25,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=35,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    dragoon2
        name = "Kain"
        class="Dragoon"
        icon='mob/spc/dragoon2.dmi'
    king
        name = "Giott"
        class="King"
        icon='mob/spc/king.dmi'
        Resist = list("slashing"=15,"piercing"=10,"fire"=35,"ice"=35,"water"=25,"bolt"=35,"earth"=60,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
    hknight
        name = "Holy Knight"
        class="Holy Knight"
        MaxHP=100
        HP=100
        MaxMP=5
        MP=5
        str=5
        agi=3
        vit=2
        wis=2
        wil=2
        icon='mob/spc/mknight.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Holy_Sword,new/obj/Ability/ASkills/White_,new/obj/Ability/Skills/Cover,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=20,"piercing"=10,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=30,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    bahamut
        name = "Bahamut"
        class="Bahamut"
        icon='mob/spc/bahamut.dmi'
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
    fiend
        name = "Rubicant"
        class="Fiend"
        MaxHP=85
        HP=85
        MaxMP=4
        MP=4
        str=3
        agi=2
        vit=3
        wis=4
        wil=1
        icon='mob/spc/fiend.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Black,new/obj/Ability/Skills/Scorch,null,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=255,"ice"=-25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    dancer
        name = "Anna"
        class="Dancer"
        icon='mob/spc/dancer.dmi'
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
    wmage2
        name = "Sylph"
        class="White Mage"
        icon='mob/spc/wmage2.dmi'
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
    mbtwin
        name = "Palom"
        class="Mature BTwin"
        icon='mob/spc/mbtwin.dmi'
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
    mwtwin
        name = "Porom"
        class="Mature WTwin"
        icon='mob/spc/mwtwin.dmi'
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
    sage2
        name = "Tellah"
        class="Sage"
        icon='mob/spc/sage2.dmi'
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=30,"holy"=30,"healing"=300)
    swordmaster
        name = "Crimson"
        class="Swordmaster"
        HP=90
        MaxHP=90
        MaxMP=2
        MP=2
        str=7
        agi=3
        vit=4
        wis=2
        wil=1
        icon='mob/spc/swordmaster.dmi'
        action=list(new/obj/Ability/Basic/Attack,new/obj/Ability/Skills/DarkWave,new/obj/Ability/ASkills/Holy_Sword,new/obj/Ability/ASkills/MgcSword,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=35,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)
    cardmage
        name = "Ryoshin"
        class="Card Mage"
        MaxHP=70
        HP=70
        MaxMP=5
        MP=5
        str=4
        agi=2
        vit=3
        wis=1
        wil=2
        icon='mob/spc/cardmage.dmi'
        action = list(new/obj/Ability/Basic/Attack,new/obj/Ability/ASkills/Card,,,new/obj/Ability/Basic/Item)
        Resist = list("slashing"=15,"piercing"=15,"fire"=25,"ice"=25,"water"=25,"bolt"=25,"earth"=25,"wind"=25,"dark"=35,"holy"=35,"healing"=300)
        StatResist = list("Poison"=43,"Darkness"=35,"Slow"=50,"Mute"=30,"Confuse"=47,"Curse"=30,"Sleep"=32,"Hold"=28,"Stone"=15,"Death"=10,"Berserk"=60,"Protect"=90,"Shell"=90,"Reflect"=90,"Float"=90,"Haste"=90,"Blink"=90,"Regen"=90,"Strengthen"=90,"Cry"=90,"Countdown"=80)*/