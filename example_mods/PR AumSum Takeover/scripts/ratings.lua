function onCreate()
	--this makes the rating object
	
	makeAnimatedLuaSprite("ratings","ratings",992.1,435.2);
	addLuaSprite("ratings",true);
	setScrollFactor('ratings',0,0);
	setObjectCamera('ratings','hud');
	scaleObject('ratings',0.8,0.8);
	
	--animations, this adds animations to the rating object so it can actually change ratings
	
	addAnimationByPrefix('ratings','PLUS','PLUS',14,false);
	addAnimationByPrefix('ratings','S','S',14,false);
	addAnimationByPrefix('ratings','A','A',14,false);
	addAnimationByPrefix('ratings','B','B',14,false);
	addAnimationByPrefix('ratings','C','C',14,false);
	addAnimationByPrefix('ratings','D','D',14,false);
	addAnimationByPrefix('ratings','E','E',14,false);
	addAnimationByPrefix('ratings','F','F',14,false);
	addAnimationByPrefix('ratings','?','?',14,false);
	
	--plays the ? animation when there's no rating
	objectPlayAnimation('ratings','?',true)
	
end

--changes the rating, and it bops to the beat too
function onUpdate()
	--S+ rating code
    if rating >= 1 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				objectPlayAnimation('ratings','PLUS',true)
		end
	end
	--S rating code
	
    elseif rating >= 0.98 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				objectPlayAnimation('ratings','S',true)
		end
	end
	--A rating code
	
    elseif rating >= 0.90 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				objectPlayAnimation('ratings','A',true)
		end
	end
	--B rating code
	
    elseif rating >= 0.80 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				objectPlayAnimation('ratings','B',true)
		end
	end
	--C rating code
	
    elseif rating >= 0.70 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				objectPlayAnimation('ratings','C',true)
		end
	end
	--D rating code
	
    elseif rating >= 0.50 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				objectPlayAnimation('ratings','D',true)
		end
	end
	--E rating code
	
    elseif rating >= 0.21 then
		function onBeatHit()
			if curBeat % 2 == 0 then
				objectPlayAnimation('ratings','E',true)
		end
	end
	--F rating code
	
    elseif rating <= 0.20 and ratings.animation ~= '?' then
		function onBeatHit()
			if curBeat % 2 == 0 then
				objectPlayAnimation('ratings','F',true)
		end
	end
end
end