function onCreate()
	--creates the bar's object
	makeLuaSprite('songbar','songbar',-75,250)
	addLuaSprite('songbar','true')
	setScrollFactor('songbar',0,0);
	setObjectCamera('songbar','hud');
	
	--creates the song name text
	makeLuaText('songname',songName,300,getProperty('songbar.x') + 100,292)
	addLuaText('songname')
	setTextFont('songname','PLANET__.TTF')
	setTextSize('songname','40')
	setTextAlignment('songname','left')
	setObjectOrder('songbar',2)
	setObjectOrder('songname',3)
	
	--runs the timer for the bar and text to move off the screen
	runTimer('sair',3)
	
end

--makes the bar and text move off the screen
function onTimerCompleted(sair)
	doTweenX('saindo1','songbar',-526,0.8,'cubeIn')
	doTweenX('saindo2','songname',-526,1.1,'cubeIn')
end