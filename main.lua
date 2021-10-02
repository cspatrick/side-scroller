display.setStatusBar(display.HiddenStatusBar)
local bgm = audio.loadSound( "ms.wav")
audio.play (bgm)
local physics = require("physics")
physics.start()
local score = 0
local scoreTxt = display.newText("Score: 0",240,10,native.systemFont,22)
local bgn1 = display.newImage("h.png", 855, 180)
local bgn2 = display.newImage("h.png", 1710, 180)
local floor = display.newImage("floor.png", 855, 310)
physics.addBody(floor,"static",{friction = .5, bounce = 0})
local floor2 = display.newImage("floor.png", 1710, 310)
physics.addBody(floor2,"static",{friction = .5, bounce = 0})
local floor3 = display.newImage("floor.png", -1000, 310)
physics.addBody(floor3,"static",{friction = .5, bounce = 0})
local options = 
{
	width = 25, 
	height = 25, 
	numFrames= 4,
}
local imageSheet = graphics.newImageSheet("meso.png", options)
local sequenceData= 
{
	{
		name = "spin",
		start=1,
	    count=4,
	    time=600,
	}
}
local meso = display.newSprite(imageSheet, sequenceData)
meso.x = 185
meso.y = 10
meso:play()
local options = 
{
	width = 67, 
	height = 81, 
	numFrames= 7,
}
local imageSheet = graphics.newImageSheet("sprite.png", options)
local sequenceData= 
{
	{
		name = "running",
		start=1,
	    count=6,
	    time=600,
	},
	{
	    name="jumping",
	    start=7,
	    count=1,
	    loopCount = 1
	}
}
local sprite = display.newSprite(imageSheet, sequenceData)
sprite.x = 120
sprite.y = 245
sprite:play()
sprite.myName = "char"
physics.addBody(sprite, {density = 3, friction = .4, bounce = 0})
sprite.isFixedRotation = true
sprite.angularVelocity = 0
local options = 
{
	width = 75, 
	height = 58, 
	numFrames= 7,
}
local imageSheet = graphics.newImageSheet("slime.png", options)
local sequenceData = 
{
	{
		name = "run",
		start=1,
	    count=6,
	    time=600,
	},
	{
	    name="jump",
	    start=7,
	    count=1,
	    loopCount = 1
	}
}
local slime = display.newSprite(imageSheet, sequenceData)
slime.x = 450
slime.y = 255
slime:play()
slime.myName = "slime"
physics.addBody(slime, "static", {friction = 1, bounce = 0})
local options = 
{
	width = 75, 
	height = 58, 
	numFrames= 7,
}
local imageSheet = graphics.newImageSheet("slime.png", options)
local sequenceData = 
{
	{
		name = "run",
		start=1,
	    count=6,
	    time=600,
	},
	{
	    name="jump",
	    start=7,
	    count=1,
	    loopCount = 1
	}
}
local slime2 = display.newSprite(imageSheet, sequenceData)
slime2.x = 900
slime2.y = 255
slime2:play()
slime2.myName = "slime2"
physics.addBody(slime2, "static", {friction = 1, bounce = 0})
local notCrashing = false
local function update ()
	bgn1.x = bgn1.x - (5)
	if(bgn1.x < -854) then
		bgn1.x = 1710
	end
	bgn2.x = bgn2.x - (5)
	if(bgn2.x < -854) then
		bgn2.x = 1710
	end
	floor.x = floor.x - (5)
	if(floor.x < -854) then
		floor.x = 1710
	end
	floor2.x = floor2.x - (5)
	if(floor2.x < -854) then
		floor2.x = 1710
	end
	if (sprite.sequence == "jumping" and sprite.y > 243) then
		sprite:setSequence("running")
    	sprite:play() 
    if(sprite.x < 120 or sprite.rotation ~= 0) then
		transition.to(sprite, {time=500,x = 120, rotation=0})
	end
	if (notCrashing == true and sprite.x > 119 and slime.x < 120 and sprite.x < 121 and sprite.y < 245) then
       	score = score + 1
       	scoreTxt.text = "Score: "..score
       	notCrashing = false
	end
	if (notCrashing == true and sprite.x > 119 and slime2.x < 120 and sprite.x < 121 and sprite.y < 245) then
       	score = score + 1
       	scoreTxt.text = "Score: "..score
       	notCrashing = false
    end
    if (sprite.x < 120 or sprite.y > 245) then
    	score = 0
       	scoreTxt.text = "Score: "..score
	end
end
	slime.x = slime.x - 6
	if(slime.x < -150) then
		slime.x = math.random(600, 900)
	end
	slime2.x = slime2.x - 6
	if(slime2.x < -150) then
		slime2.x = math.random(900, 1200)
	end
end
timer.performWithDelay(1, update, -1)
local function jump()
	if (sprite.y > 240)then
		sprite:applyLinearImpulse( 0, -180, sprite.x, sprite.y)
		sprite:setSequence( "jumping" )
		notCrashing = true
	else
		sprite:applyLinearImpulse( 0, 101, sprite.x, sprite.y)
		sprite:setSequence( "jumping" )
		notCrashing = true
	end
end
Runtime:addEventListener("tap", jump)
