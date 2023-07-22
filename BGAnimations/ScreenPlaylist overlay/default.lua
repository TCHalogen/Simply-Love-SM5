local af = Def.ActorFrame {}

-- Configs for repeated values.
local boxW = _screen.w/2 - _screen.w/16
local boxH = _screen.h * 0.75
local boxColor = {0,0,0,0.4}
local boxBorderWidth = 2
local boxBorderColor = {0.5,0.5,0.5,1}

-- Left side box and border.
af[#af+1] = Def.Quad {
    InitCommand=function(self)
        self:xy(_screen.cx / 2, _screen.cy);
        self:zoomto(boxW, boxH):diffuse(boxColor)
    end
}
af[#af+1] = Border(boxW, boxH, 2)..{
    InitCommand=function(self)
        self:xy(_screen.cx / 2, _screen.cy)
        self:diffuse(boxBorderColor)
    end
}

-- Right side box and border.
af[#af+1] = Def.Quad {
    InitCommand=function(self)
        self:xy(_screen.cx + (_screen.cx / 2), _screen.cy)
        self:zoomto(boxW, boxH):diffuse(boxColor)
    end
}
af[#af+1] = Border(boxW, boxH, 2)..{
    InitCommand=function(self)
        self:xy(_screen.cx + (_screen.cx / 2), _screen.cy)
        self:diffuse(boxBorderColor)
    end
}

return af