local af = Def.ActorFrame {
  Def.Quad {
    InitCommand=function(self)
      self:diffuse(color("#000000dd"))
      self:zoomto(_screen.wm row.h*0.5):valign(0):xy(_screen.cx, 0)
    end
  },

  Def.BitmapText {
		Name="HeaderText",
		Font="Common Header",
		Text=text,
		InitCommand=function(self) self:diffuse(1,1,1,0):zoom(WideScale(0.5,0.6)):horizalign(left):xy(10, 15) end,
		OffCommand=function(self) self:accelerate(0.33):diffusealpha(0) end,
  }
}

return af