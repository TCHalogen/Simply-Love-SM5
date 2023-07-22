-- Contains styling/design parameters for UI elements.
local af = Def.ActorFrame {}

-- TODO: leverage Styles.lua to abstract design from logic/drawing
local boxW = _screen.w/3 - _screen.w/16
local boxH = _screen.h * 0.75
local boxColor = {0,0,0,0.3}
local boxBorderWidth = 2
local boxBorderColor = {0.5,0.5,0.5,1}

-- Left side box.
af[#af+1] = Def.ActorFrame {
    InitCommand=function(self) 
        self:xy(_screen.cx / 3, _screen.cy)
        self:zoomto(boxW, boxH)
    end,

    Def.Quad {
        InitCommand=function(self)
            self:xy(0, 0)
            self:diffuse(0.5, 0.5, 0.5, 0.25)
        end
    },

    Def.Quad {
        InitCommand=function(self)
            self:xy(0, 0)
            self:zoomto(1, 0.2)
            self:valign(0)
            self:diffuse(0, 0.5, 1, 1)
        end
    },

    Def.Quad {
        InitCommand=function(self)
            self:xy(0, 0)
            self:zoomto(1, 0.2)
            self:valign(1)
            self:diffuse(0.5, 0, 1, 1)
        end
    }
}

-- Is this how this has to be done?
-- I guess it makes sense since it is outlining a bounding box, but still...
af[#af+1] = Border(boxW, boxH, 2)..{
    InitCommand=function(self)
        self:xy(_screen.cx / 3, _screen.cy)
        self:diffuse(boxBorderColor)
    end
}


-- af[#af+1] = Def.Quad {   
--     InitCommand=function(self)
--         self:xy(_screen.cx / 3, _screen.cy);
--         self:zoomto(boxW, boxH):diffuse(boxColor)
--     end
-- }
-- af[#af+1] = Border(boxW, boxH, 2)..{
--     InitCommand=function(self)
--         self:xy(_screen.cx / 3, _screen.cy)
--         self:diffuse(boxBorderColor)
--     end
-- }

-- Middle box/border.
-- af[#af+1] = Def.Quad {
--     InitCommand=function(self)
--         self:xy(_screen.cx, _screen.cy)
--         self:zoomto(boxW, boxH):diffuse(boxColor)
--     end
-- }
-- af[#af+1] = Border(boxW, boxH, 2)..{
--     InitCommand=function(self)
--         self:xy(_screen.cx, _screen.cy)
--         self:diffuse(boxBorderColor)
--     end
-- }

-- Right box/border.
-- af[#af+1] = Def.Quad {
--     InitCommand=function(self)
--         self:xy(_screen.cx + _screen.cx/1.5, _screen.cy)
--         self:zoomto(boxW, boxH):diffuse(boxColor)
--     end
-- }
-- af[#af+1] = Border(boxW, boxH, 2)..{
--     InitCommand=function(self)
--         self:xy(_screen.cx + _screen.cx/1.5, _screen.cy)
--         self:diffuse(boxBorderColor)
--     end
-- }
return af