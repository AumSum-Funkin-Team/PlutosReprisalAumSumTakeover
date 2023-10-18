--[[PROTOTYPE
Texts are TRASH, BAD, MEH, NICE! (also includes EPIC!! and SPOT-ON!!!)
Include timed combo streak, score to add, freestreak
NICE!! x15
34500 + 350
STREAK 145
]]

local tempcombo = 0
local realcombo = 0
local tempscore = 0
local realscore = 0

local modcombotxt = true

local temptimer = 0
local templimit = 0

local delay = 0
--local ratingdesignationold = {1, 15, 50, 100, 150, 1000}
--local ratingtagdesignation = {'SPOT ON!!!', 'EPIC!!', 'NICE!', 'Meh..', 'bad', 'NASTY!!!!'}
local ratingdesignation = {
    {
        ms = 0,
        tag = 'PERFECT!!!!!',
        outlinecolor = 'ffffff',
        fillcolor = 'ffbff4'
    },
    {
        ms = 5,
        tag = 'INCREDIBLE!!!!',
        outlinecolor = 'ffffff',
        fillcolor = 'd43bff'
    },
    {
        ms = 10,
        tag = 'MARVELOUS!!!',
        outlinecolor = 'fb91ff',
        fillcolor = '4700ab'
    },
    {
        ms = 15,
        tag = 'AMAZING!!',
        outlinecolor = 'a160fc',
        fillcolor = '1d09b5'
    },
    {
        ms = 20,
        tag = 'EPIC!',
        outlinecolor = 'c9f3ff',
        fillcolor = '1787ff'
    },
    {
        ms = 25,
        tag = 'CLEAN!',
        outlinecolor = 'd6f5ff',
        fillcolor = '2effd5'
    },
    {
        ms = 30,
        tag = 'GOOD',
        outlinecolor = '0f5238',
        fillcolor = '22e342'
    },
    {
        ms = 35,
        tag = 'ALRIGHT',
        outlinecolor = '064f15',
        fillcolor = '5cc71a'
    },
    {
        ms = 40,
        tag = 'MEH',
        outlinecolor = '8f7a11',
        fillcolor = 'afc738'
    },    
    {
        ms = 50,
        tag = 'SUBPAR',
        outlinecolor = '633219',
        fillcolor = 'e68825'
    },
    {
        ms = 60,
        tag = 'BAD',
        outlinecolor = '420d03',
        fillcolor = '9e2c03'
    },
    {
        ms = 70,
        tag = 'EW',
        outlinecolor = '1a0000',
        fillcolor = '7d0f00'
    },
    {
        ms = 80,
        tag = 'AWFUL',
        outlinecolor = '000000',
        fillcolor = '360808'
    },
    {
        ms = 90,
        tag = 'TERRIBLE',
        outlinecolor = '000000',
        fillcolor = '291616'
    },
    {
        ms = 100,
        tag = 'DISGUSTING',
        outlinecolor = '000000',
        fillcolor = '292121'
    },
    {
        ms = 150,
        tag = 'ATROCIOUS',
        outlinecolor = '1f1e1e',
        fillcolor = '595454'
    },
    {
        ms = 200,
        tag = 'unfortunate',
        outlinecolor = '000000',
        fillcolor = '1a1a1a'
    },
}


local colordesignation = {
    '61342b',
    '7d4531',
    'a6683c',
    'cc9556',
    'e0b979',
    'e8c990',
    'f0ccaa',
    'fae8dc',
    'fffbf2',
    'ffffff',
    '339933'
}

function onCreate()
    precacheSound('combobroken')

    setProperty('showRating', false)
    setProperty('showComboNum', false)
    setProperty('combo', 0)
    templimit = crochet*0.006
    temptimer = templimit

    local streakrealsize = 16
    local realsizeB = 1
    local streakflashfactor = 0
    local streakcanflash = false
    makeLuaText('streak', 'STREAK 0', 400, 440, 130)
    makeLuaText('streaknatty', 'STREAK 0', 400, 640, 130)
    setTextAlignment('streak', 'center')
    setTextBorder('streak', 1, 'ffffff')
    setTextColor('streak', 'ff0000')
    setProperty('streak.alpha', 0)
    addLuaText('streak')
    setObjectOrder('streak', 100)

    makeLuaText('rating', 'SPOT-ON!!!', 200, 540, 70)
    makeLuaText('ratingnatty', 'SPOT-ON!!!', 200, 640, 70)
    setTextBorder('rating', 1, '000000')
    setTextSize('rating', 24)
    setProperty('rating.alpha', 0)
    addLuaText('rating')
    setObjectOrder('rating', 100)

    if not botPlay then
        setProperty('streaknatty.y', getProperty('streaknatty.y') - 20)
        setProperty('ratingnatty.y', getProperty('ratingnatty.y') + 15)
    end

    function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
        temptimer = 0
        if not isSustainNote then
            if modcombotxt then
                streakrealsize = 20
            end
            realsizeB = 1.5
    
            realcombo = realcombo + 1
            tempcombo = tempcombo + 1
            delay = getSongPosition() - getPropertyFromGroup('notes', membersIndex, 'strumTime')
            for i, v in pairs(ratingdesignation) do
                if math.abs(delay) < v.ms then
                    setProperty('rating.text', ratingdesignation[i].tag)
                    setTextColor('rating', ratingdesignation[i].fillcolor)
                    setTextBorder('rating', 1, ratingdesignation[i].outlinecolor)
                    break
                end
            end
    
            if realcombo == 117 then
    
            end
        end
    end
    
    function noteMiss(membersIndex, noteData, noteType, isSustainNote)
        if realcombo > 10 then
            modcombotxt = false
            streakcanflash = true
            playSound('combobroken')
            setProperty('streak.text', 'COMBO BROKEN. . .')
            setProperty('streak.color', getColorFromHex('000000'))
            setTextBorder('streak', 1, 'ff0000')
        end
        realcombo = 0
        tempcombo = 0
        temptimer = templimit
    end
    
    function onUpdate(elapsed)
        temptimer = temptimer + elapsed

        streakrealsize = (streakrealsize*9+16)/10
        realsizeB = (realsizeB*9+1)/10
        streakflashfactor = streakflashfactor + 1
        if streakflashfactor % 6 == 0 then
            --New tick
            if getProperty('streak.visible') == true and streakcanflash then
                setProperty('streak.visible', false)
            else
                setProperty('streak.visible', true)
            end
        elseif streakflashfactor % 1 == 0 then
            if temptimer > templimit then
                if tempcombo > 0 then
                    tempcombo = tempcombo - 1
                end
            end
        end

        scaleObject('streak', (streakrealsize/16)^1.2, (1/(getProperty(streakrealsize)/16))^1.5)
        scaleObject('rating', (realsizeB/1)^1.2, (realsizeB/1)^1.2)
        setProperty('rating.x', getProperty('ratingnatty.x')-100*getProperty('rating.scale.x'))
        setProperty('rating.y', getProperty('ratingnatty.y')+12-24*getProperty('rating.scale.y'))
        setProperty('streak.x', getProperty('streaknatty.x')-200*getProperty('streak.scale.x'))
        setProperty('streak.y', getProperty('streaknatty.y'))
        if realcombo >= 10 then
            setProperty('streak.alpha', getProperty('streak.alpha')^0.95+0.001)
            setTextBorder('streak', 1, '000000')
            modcombotxt = true
            streakcanflash = false
        else
            setProperty('streak.alpha', getProperty('streak.alpha')*0.95)
        end
        if modcombotxt then
            if tempcombo > 0 then
                setProperty('streak.text', 'STREAK ' .. realcombo-tempcombo .. ' + ' .. tempcombo)
            else
                setProperty('streak.text', 'STREAK ' .. realcombo)
            end
            local newstring = tostring(realcombo)
            if string.len(newstring) == 1 then
                newstring = '0' .. newstring
            end
            if string.char(string.byte(newstring, string.len(newstring)-1))/2 == math.floor(string.char(string.byte(newstring, string.len(newstring)-1))/2) then
                setTextColor('streak', colordesignation[string.char(string.byte(newstring, string.len(newstring)))+1])
            else
                setTextColor('streak', colordesignation[10-string.char(string.byte(newstring, string.len(newstring)))])
            end
        end
        if temptimer < templimit then
            setProperty('rating.alpha', 1)
        else
            setProperty('rating.alpha', getProperty('rating.alpha')*0.95)
        end

        if hideHud then
            setProperty('rating.alpha', 0)
            setProperty('streak.alpha', 0)
        end
    end
end