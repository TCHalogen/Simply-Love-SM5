-- Contains styling/design parameters for UI elements.
local Styles = LoadActor("./Styles.lua")
local af = Def.ActorFrame {}
local test = SCREENMAN:GetTopScreen()

SM(test)

-- Left side box.
af[#af+1] = Def.ActorFrame {
  LoadActor("./intro/left.lua", Styles),
  Border(Styles.boundW, Styles.boundH, 2)..{
    InitCommand=function(self)
      self:xy(_screen.cx / 3, _screen.cy)
      self:diffuse(Styles.boundBorderColor)
    end
  }
}

-- Middle box.
af[#af+1] = Def.ActorFrame {
  LoadActor("./intro/middle.lua", Styles),
  Border(Styles.boundW, Styles.boundH, 2)..{
    InitCommand=function(self)
      self:xy(_screen.cx, _screen.cy)
      self:diffuse(Styles.boundBorderColor)
    end
  }
}

-- Right box.
af[#af+1] = Def.ActorFrame {
  LoadActor("./intro/right.lua", Styles),
  Border(Styles.boundW, Styles.boundH, 2)..{
    InitCommand=function(self)
      self:xy(_screen.cx + (_screen.cx / 1.5), _screen.cy)
      self:diffuse(Styles.boundBorderColor)
    end
  }
}

return af
