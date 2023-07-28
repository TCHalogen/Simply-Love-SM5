local Styles = LoadActor("../Styles.lua")
local right = Def.ActorFrame {
  Name="RightFrame",
  InitCommand=function(self)
    self:xy(_screen.cx + (_screen.cx / 1.5), _screen.cy)
    self:zoomto(Styles.boundW, Styles.boundH)
  end,

  Def.Quad {
    Name="RightBox",
    InitCommand=function(self)
      self:diffuse(Styles.boundColor)
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

return right