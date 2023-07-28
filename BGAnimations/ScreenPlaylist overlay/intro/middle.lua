local Styles = LoadActor("../Styles.lua")

local middle = Def.ActorFrame {
  Name="MiddleFrame",
  InitCommand=function(self)
    self:xy(_screen.cx, _screen.cy)
    self:zoomto(Styles.boundW, Styles.boundH)
  end,

  Def.Quad {
    Name="MiddleBox",
    InitCommand=function(self)
      self:diffuse(Styles.boundColor)
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

return middle