---
layout: post
title: "Game Design Analysis: World of Goo"
category: Game Design Course
tags: [Game Design, Analysis]
time: 16:00:10
---

<a name="top">Top</a>

1. [Introduction](#introduction)
1. [Analysis](#analysis)
    1. [Actions and confirmation](#actions)
    1. [Varying the mechanics](#mechanics)
    1. [Consequences of the rules](#rules)
    1. [Mods](#mods)
1. [Conclusion](#conclusion)
1. [References](#references)

[Original essay here](/files/download/world_of_goo_analysis.doc).

<h1><a name="introduction">Introduction</a></h1>
This is the second essay for the course Game Design and this thime I will be analysing the game [World of Goo][wog] a bit.

<div class="center">
  <img src="/media/images/wog/goo1.pn" />
  <em>The first level</em>
</div>  

The game is very simple. You begin with a structure and a few Goo balls, the charming balls bobbing around there, which you can drag and drop to build on the structure. Your goal is to reach the pipe and it will suck in the surviving Goo balls and you need to collect a certain amount of balls, in this case at least 4. All you ever use is your mouse and one button to pick up and place the balls.

<div class="center">
  <img src="/media/images/wog/step-1.png" />
  <img src="/media/images/wog/step-2.png" />
  <img src="/media/images/wog/step-4.png" />
  <em>A step by step of the core mechanics</em>
</div>  

The beginning levels are very easy but it will get increasingly harder and you have to plan your building so you don't use up too many Goo balls.

But as it's a physics game you will also have to think about gravity so your tower won't topple over and crash, which will happen to you a lot in the later levels.

<div class="center">
  <img src="/media/images/wog/bridge.png" />
  <em>Oh noes my bridge is collapsing!</em>
</div>  

That's about the whole game concept right there; build structures to reach the pipe but use so few balls, or building blocks, as you can. You might think that it's a shallow game with doing the same thing over and over – but you couldn't be more wrong, there are a lot of different Goo balls to play around with; sticky balls, dangling balls, exploding balls, shooting balls, removable balls and more which will force you to change your build process in different directions. The level design is simply fantastic and it challenges your constructions and it makes the game very varied.

<div class="center">
  <img src="/media/images/wog/balloons.png" />
  <img src="/media/images/wog/sticky.png" />
  <em>The levels are both fun and diverse</em>
</div>  

The game which inspired World of Goo, namely Tower of Goo was an experimental one week, one person game with the aim of simply building a high tower and you can still do that in World of Goo in a sandbox mode and you can compete online on who makes the highest tower.

<div class="center">
  <img src="/media/images/wog/levels.png" />
  <em>The level chooser screen, be proud of those flags!</em>
</div>  

If you like challenges there's more to do: for every level there's this extra hard ending criteria – a challenge – for you to get gray hairs from. There's time challenges, constraints on number of moves and a minimum of balls collected and some of them are extremely though. If you're successful you'll get a nice little flag on the level chooser screen.

The game is quite large with 5 different chapters and there's around 10 levels each. Every chapter has it's own theme and they vary quite a lot; there's focus on explosions, balloons and there's even Goo balls you can shoot! This gives the game fairly long but it manages to stay fresh all the way through.

<div class="center">
  <img src="/media/images/wog/chapters.pn" /><br />
  <em>The 5 chapters + sandbox (Tower of Goo) is the World of Goo</em>
</div>  

[Back to top](#top)

<h1><a name="analysis">Analysis</a></h1>

1. [Actions and confirmation](#actions)
1. [Varying the mechanics](#mechanics)
1. [Consequences of the rules](#rules)
1. [Mods](#mods)

<h2><a name="actions">Actions and confirmation</a></h2>

One of the things World of Goo does really well is to communicate to the player. When a first time player loads the first level it's almost always clear what to do, you have this helpful sign showing your first move (drop a goo ball here) and you have this curious looking pipe just above you and not much else to distract you. After each level you get a score screen on how you did and both the level and world screen are helpfully showing your progress and what to do next. But to me the most impressive thing is how your actions are handled.

When you hover your cursor over moving Goo balls or removable joints you'll get a clear marker around the selected ball and it'll stop and give you a cute look just to show you 'Hey! It's me you wanna pick up!'. Likewise when you have a ball selected and you're moving it around for a good spot you'll get a small notion of where it's going to connect and always you have a nice big clear marker on where your cursor is.

<div class="center">
  <img src="/media/images/wog/select.png" width="130" height="100" />
  <img src="/media/images/wog/build.png" width="130" height="100" />
  <img src="/media/images/wog/shooting.png" width="130" height="100" />
  <img src="/media/images/wog/block.png" width="130" height="100" /><br />
  <em>Selecting, building, shooting and moving</em>
</div>

Visual confirmation in all honor but what really makes actions clear is the sounds. For every Goo ball hovered over and every joint constructed there's a short confirmation of your action and for every dead Goo and every block crashed there's an unique sound to let you know that something bad happened here in your little world. Every Goo that go down the pipe will emit a happy little laugh and you just love the hear that extra peculiar laugh which will tell you if you did complete the extra level challenge. 

I didn't find any sound or visual effect for when your action fails, for example there were no error sound when trying to click in an empty space and the mouse pointer never acknowledged my clicks if they weren't valid. But you can say that they aren't necessary, because for every valid action and for every click you can make, where something actually happens, there's always a confirmation sound and that is enough to let you know that something was successful and unsuccessful.

Although simple the visual and auditive feedback works absolutely wonderful and I never had to wonder if my actions were registered, it felt like they always were and if things didn't work as I wanted to I realized pretty quick that I was doing something wrong.

[Back to top](#top)

<h2><a name="mechanics">Varying the mechanics</a></h2>

The concept of the whole game is really quite simple, create structures with drag n' drop Goo balls, add in some simple physics and you're done. It's amazing how captivating something simple as this can be and I believe it has a lot to do with the small incremental changes the game makes all the time.

One thing the game does is introduce new Goo balls all the time; balls you can remove multiple times force you to climb and restructure, balloon Goos create interesting aerial acrobatics and a sticky Goo makes the structure mobile. 

<div class="center">
  <img src="/media/images/wog/liftoff.png" />
  <img src="/media/images/wog/climb.pn" /><br />
  <em>Lifting off and climbing is possible thanks to different Goo balls</em>
</div>  

Even Goo's with minor changes like industrial Goo which you can't control or dangling Goo which will only dangle down gives a lot of depth to the game thanks to the great level design.

<div class="center">
<img src="/media/images/wog/industry.png" width="130" height="100" />
<img src="/media/images/wog/water.png" width="130" height="100" />
<img src="/media/images/wog/bone.png" width="130" height="100" />
<img src="/media/images/wog/cutter.png" width="130" height="100" />     <br />
  <em>There are lot's and lot's of levels which change the way you play</em>
</div>  

It's not just build straight up; it's build around, use balloons to topple the tower from island to island and it's surprising how hard it is to build a tower in water or in a tumbler, you really have to stop and think or else it won't work. The game is constantly varying it's mechanics and you have to change with it, you have to evolve to keep up.

Perhaps the most radical experiment is the fourth chapter. We get new Goo's that shoot! This is different from our regular balls that we can move around freely and they usually build or attach when we release them but these launch themselves when we drag n drop them. It's the only way we can move them around and with one type we get to shoot and build.

<div class="center">
  <img src="/media/images/wog/shoot-build.png" />
  <img src="/media/images/wog/world-gravity.pn" /><br />
  <em>Shooting Goo?</em>
</div>  

Still staying true to the basic mechanics, select ball, drag n drop for effect with some physics and this could easily have been a game of it's own.

Going the other way around World of Goo also experiments with the drag n' drop of Goo. They introduce block Goo which is immobile and it doesn't walk around your structure like the other Goo and the only way you can move, the only way you can interact with them is to move them around and use them to block and for support or just to create a very unstable tower.

<div class="center">
  <img src="/media/images/wog/blocking.png" />
  <img src="/media/images/wog/tower-of-blocks.png" />
  <em>Block Goo; immobile and blocky but yet they manage to add something to the game</em><br />
</div>  

All in all World of Goo uses their simple core concept to it's limit with a ton of variation and experimentation and it makes the game feel novel all the way through those 50+ levels.

[Back to top](#top)

<h2><a name="rules">Consequences of the rules</a></h2>

World of Goo is a physics based game; when building structures you need to compensate against gravity so your tower won't collapse and you need to make sure your structure has enough joints so it can withstand tension and compression. Physics games are hard to create, you can't rely on a perfect representation as it's too hard to simulate perfectly and there are many edge cases you'll have to handle.

You can for example make it easier through this level if you force your structure into the wall and this “break” it. In real life a structure like this would completely break but in the game that doesn't happen, the joints simply turn inwards and now you have a nice and short structure to move around.

<div class="center">
  <img src="/media/images/wog/small.png" />
  <img src="/media/images/wog/small2.png" /><br />
  <em>Small structures are easier to move around</em>
</div>  

This happens because in the rules you can only break a structure if you either drop it into the ocean or on spikes, and loose them forever, or if you connect with a special construction destroying cogs. Here we exceed the tension and the compression and instead of breaking we get our joints twisted.

You even have to abuse the rules because the extra hard level goals can't be beat otherwise. I'm sure the creators chose to incorporate the bugs into the game and they even call them features in a way to create bigger challenges in the extra level requirements.

<div class="center"> 
  <img src="/media/images/wog/throw.png" width="180" height="120" />
  <img src="/media/images/wog/hang2.png" width="180" height="120" />
  <img src="/media/images/wog/hang.png" width="180" height="120" />    <br />
  <em>Some core game rules abuse</em>
</div>  

**The left picture:**   
In World of Goo in some levels there are sleeping goo balls which you can't get control of if you don't get your construction close enough. But you can pick up and move around the balls and even throw them and if you do you can actually make the sleeping balls bounce around too. If you throw at the right angle you can bounce the sleeping balls close enough your structure and they'll wake up.

**The middle picture:**   
Your ultimate goal is the pipe and it will start sucking in your goo balls if you get your construction close. But if you have the green goo balls which you can remove from the structure you can get a small structure hanging from the pipe's suction! Then you proceed to move the rest of the goo balls freely onto the structure and you will get a lot more balls collected. It's so good you can actually get every goo ball, except one, if you do this trick. Incidentally the creators noticed this bug, or feature, when testing and so they set the extra level goal to precisely one less than your total balls.

**The right picture:**   
In a level there's a huge head which hangs from a small hook. When you've exploded the head you can get the hook to attach to the wall by throwing goo balls at your dangling structure. It will then connect to the wall because it doesn't make any distinction to exploding heads or walls, it just sticks to it.

[Back to top](#top)

<h2><a name="mods">Mods</a></h2>

The game is more or less a closed system but if you're interested it isn't too hard to create new levels, alter the online scoreboard (which has happened a lot) or even add new Goo balls. The site goofans.com is a dedicated site which collects fan-made levels and mods.

<div class="center">
  <img src="/media/images/wog/color.png" />
  <img src="/media/images/wog/jingleballs2.pn" /><br />
  <em>Colorful balloons and a new Christmas level</em>
</div>  

There's even a tool, [GooTool][gootools], which is a tool which let's you manage your installed mods, manage your profile stats, general options like screen resolution and even add in your own language.

These changes, these mods, are mainly geared towards resources and not the actual game rules. It is possible to change them but then you more or less have to rewrite and mod the game on assembly level. This could be said about every computer game but it's really hard and time consuming to do, but it sure is possible.

[Back to top](#top)

<h1><a name="conclusion">Conclusion</a></h1>

I think World of Goo is an excellent game and there are so many things it does right. The game is good about telling you what to do and when you've done something good by using both visuals and sound effects. The game basic foundation of the game is really quite simple but they manage to create a lot of diversity and this fresh feel throughout the whole game by introducing small, and big, variations to the core mechanics.

The simple rules will create a few bugs and surprising side effects but they turn it around and they even call them features when they force you to use them if you want to complete the extra hard level requirements. 

There are a few mods and new levels out there if you hunger for more and with a little effort you can create your own, even if most of the game rules are quite inaccessible. 

[Back to top](#top)

<h1><a name="references">References</a></h1>

Salen & Zimmerman, 2004. Rules of Play. The MIT Press.

<http://2dboy.com/>   
<http://www.worldofgoo.com/>

<http://goofans.com/>   
<http://goofans.com/gootool/about>   
Accessed may 1st

[gootools]: http://goofans.com/gootool/about
[wog]: http://www.worldofgoo.com/

