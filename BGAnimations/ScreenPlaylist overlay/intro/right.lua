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

  Def.ActorFrame {
    Name="RightHeaderFrame",
    InitCommand=function(self)
      self:y(-0.35)
      self:zoomto(1, 0.15)
      self:valign(1)
    end,

    Def.Quad {
      Name="RightHeaderBox",
      InitCommand=function(self)
        self:diffuse(1, 1, 1, 0.1)
      end
    },

    Def.BitmapText {
      Font="Common Bold",
      Name="RightText",
      Text="Edit",
      InitCommand=function(self)
        self:xy(0, 0)
        self:zoomto(0.25, 0.4)
      end
    }
  },

  Def.ActorFrame {
    Name="RightCenterFrame",
    InitCommand=function(self)
      self:y(0.15)
      self:valign(1)
      self:zoomto(1, 0.5)
    end,

    Def.Sprite {
      Name="RightImage",
      Texture=THEME:GetPathB("ScreenPlaylist", "overlay/assets/edit.png"),
      InitCommand=function(self)
        self:xy(0,0)
        self:zoomto(0.65, 0.65)
      end
    }
  },

  Def.ActorFrame {
    Name="RightDescriptionFrame",
    InitCommand=function(self)
      self:y(0.15)
      self:zoomto(1, 0.35)
      self:valign(0)
    end,

    Def.Quad {
      Name="RightDescription",
      InitCommand=function(self)
        self:diffuse(1, 1, 1, 0.1)
      end
    },

    Def.BitmapText {
      Font="Common Normal",
      Name="RightDescriptionText",
      Text="Edit existing playlists.\n\nChange/modify a playlist on your local\n profile or machine.",
      InitCommand=function(self)
        self:horizalign(left)
        self:xy(-0.47, -0.4)
        self:valign(0)
        self:zoomto(0.9, 0.55)
      end
    }
  }
}

return right