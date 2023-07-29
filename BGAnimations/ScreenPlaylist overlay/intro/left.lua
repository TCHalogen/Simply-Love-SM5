local Styles = ...

local left = Def.ActorFrame {
  Name="LeftFrame",
  InitCommand=function(self) 
    self:xy(_screen.cx / 3, _screen.cy)
    self:zoomto(Styles.boundW, Styles.boundH)
  end,

  Def.Quad {
    Name="LeftBox",
    InitCommand=function(self)
      self:xy(0,0)
      self:diffuse(Styles.boundColor)
    end
  },

  Def.ActorFrame {
    Name="LeftHeaderFrame",
    InitCommand=function(self)
      self:y(-0.35)
      self:zoomto(1, 0.15)
      self:valign(1)
    end,

    Def.Quad {
      Name="LeftHeaderBox",
      InitCommand=function(self)
        self:diffuse(1, 1, 1, 0.1)
      end
    },

    Def.BitmapText {
      Font="Common Bold",
      Name="LeftText",
      Text=THEME:GetString("ScreenPlaylist", "CreateHeader"),
      InitCommand=function(self)
        self:xy(0, 0)
        self:zoomto(0.6, 0.4)
      end
    },
  },

  Def.ActorFrame {
    Name="LeftDescriptionFrame",
    InitCommand=function(self)
      self:y(0.15)
      self:zoomto(1, 0.35)
      self:valign(0)
    end,

    Def.Quad {
      Name="LeftDescription",
      InitCommand=function(self)
        self:diffuse(1, 1, 1, 0.1)
      end
    },

    Def.BitmapText {
      Font="Common Normal",
      Name="LeftDescriptionText",
      Text=THEME:GetString("ScreenPlaylist", "CreateDescription"),
      InitCommand=function(self)
        self:horizalign(left)
        self:xy(-0.47, -0.4)
        self:valign(0)
        self:zoomto(0.9, 0.55)
      end
    }
  },

  Def.ActorFrame {
    Name="LeftCenterFrame",
    InitCommand=function(self)
      self:y(0.15)
      self:valign(1)
      self:zoomto(1, 0.5)
    end,

    Def.Sprite {
      Name="LeftImage",
      Texture=THEME:GetPathB("ScreenPlaylist", "overlay/assets/plus.png"),
      InitCommand=function(self)
        self:xy(0,0)
        self:zoomto(0.65, 0.65)
      end
    },
  },
}

return left