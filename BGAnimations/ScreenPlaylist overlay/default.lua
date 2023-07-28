-- Contains styling/design parameters for UI elements.
local af = Def.ActorFrame {}

-- TODO: leverage Styles.lua to abstract design from logic/drawing
local boundW = _screen.w/3 - _screen.w/16
local boundH = _screen.h * 0.75
local boundColor = {0, 0, 0, 0.5}
local boundBorderWidth = 2
local boundBorderColor = {0.5,0.5,0.5,1}

local innerW
local innerH
local innerColor

-- Left side box.
af[#af+1] = Def.ActorFrame {
  Name="LeftFrame",
  InitCommand=function(self) 
    self:xy(_screen.cx / 3, _screen.cy)
    self:zoomto(boundW, boundH)
    -- self:diffuse(boundColor)
  end,

  Def.Quad {
    Name="LeftBox",
    InitCommand=function(self)
      self:xy(0,0) -- WHY
      self:diffuse(boundColor)
    end
  },

  Def.Quad {
    Name="LeftDescription",
    InitCommand=function(self)
      self:y(0.15)
      self:zoomto(1, 0.35)
      self:valign(0)
      self:diffuse(0, 0.5, 1, 1)
    end
  },

  Def.Quad {
    Name="LeftHeader",
    InitCommand=function(self)
      self:y(-0.35)
      self:zoomto(1, 0.15)
      self:valign(1)
      self:diffuse(0.5, 0, 1, 1)
    end
  }
}

-- Is this how this has to be done?
-- I guess it makes sense since it is outlining a bounding box, but still...
af[#af+1] = Border(boundW, boundH, 2)..{
  InitCommand=function(self)
    self:xy(_screen.cx / 3, _screen.cy)
    self:diffuse(boundBorderColor)
  end
}

-- Middle box.
af[#af+1] = Def.ActorFrame {
  Name="MiddleFrame",
  InitCommand=function(self)
    self:xy(_screen.cx, _screen.cy)
    self:zoomto(boundW, boundH)
  end,

  Def.Quad {
    Name="MiddleBox",
    InitCommand=function(self)
      self:diffuse(boundColor)
    end
  },

  Def.Quad {
    Name="MiddleDescription",
    InitCommand=function(self)
      self:y(0.15)
      self:zoomto(1, 0.35)
      self:valign(0)
      self:diffuse(0, 0.5, 1, 1)
    end
  },

  Def.Quad {
    Name="MiddleHeader",
    InitCommand=function(self)
      self:y(-0.35)
      self:zoomto(1, 0.15)
      self:valign(1)
      self:diffuse(0.5, 0, 1, 1)
    end
  },
}

af[#af+1] = Border(boundW, boundH, 2)..{
  InitCommand=function(self)
    self:xy(_screen.cx, _screen.cy)
    self:diffuse(boundBorderColor)
  end
}

-- Right box.
af[#af+1] = Def.ActorFrame {
  Name="RightFrame",
  InitCommand=function(self)
    self:xy(_screen.cx + (_screen.cx / 1.5), _screen.cy)
    self:zoomto(boundW, boundH)
  end,

  Def.Quad {
    Name="RightBox",
    InitCommand=function(self)
      self:diffuse(boundColor)
    end
  },

  Def.Quad {
    Name="RightDescription",
    InitCommand=function(self)
      self:y(0.15)
      self:zoomto(1, 0.35)
      self:valign(0)
      self:diffuse(0, 0.5, 1, 1)
    end
  },

  Def.Quad {
    Name="RightHeader",
    InitCommand=function(self)
      self:y(-0.35)
      self:zoomto(1, 0.15)
      self:valign(1)
      self:diffuse(0.5, 0, 1, 1)
    end
  }
}

af[#af+1] = Border(boundW, boundH, 2)..{
  InitCommand=function(self)
    self:xy(_screen.cx + (_screen.cx / 1.5), _screen.cy)
    self:diffuse(boundBorderColor)
  end
}

return af