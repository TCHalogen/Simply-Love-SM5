local Styles = ...

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

  Def.ActorFrame {
    Name="MiddleHeaderFrame",
    InitCommand=function(self)
      self:y(-0.35)
      self:zoomto(1, 0.15)
      self:valign(1)
    end,

    Def.Quad {
      Name="MiddleHeaderBox",
      InitCommand=function(self)
        self:diffuse(1, 1, 1, 0.1)
      end
    },

    Def.BitmapText {
      Font="Common Bold",
      Name="MiddleText",
      Text=THEME:GetString("ScreenPlaylist", "ViewHeader"),
      InitCommand=function(self)
        self:xy(0, 0)
        self:zoomto(0.6, 0.4)
      end
    },
  },

  Def.ActorFrame {
    Name="MiddleCenterFrame",
    InitCommand=function(self)
      self:y(0.15)
      self:valign(1)
      self:zoomto(1, 0.5)
    end,

    Def.Sprite {
      Name="MiddleImage",
      Texture=THEME:GetPathB("ScreenPlaylist", "overlay/assets/view.png"),
      InitCommand=function(self)
        self:xy(0,0)
        self:zoomto(0.65, 0.65)
      end
    },
  },

  Def.ActorFrame {
    Name="MiddleDescriptionFrame",
    InitCommand=function(self)
      self:y(0.15)
      self:zoomto(1, 0.35)
      self:valign(0)
    end,

    Def.Quad {
      Name="MiddleDescription",
      InitCommand=function(self)
        self:diffuse(1, 1, 1, 0.1)
      end
    },

    Def.BitmapText {
      Font="Common Normal",
      Name="MiddleDescriptionText",
      Text=THEME:GetString("ScreenPlaylist", "ViewDescription"),
      InitCommand=function(self)
        self:horizalign(left)
        self:xy(-0.47, -0.4)
        self:valign(0)
        self:zoomto(0.9, 0.55)
      end
    }
  }
}

return middle