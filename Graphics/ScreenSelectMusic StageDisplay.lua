local curScreen = Var "LoadingScreen";
local curStage = GAMESTATE:GetCurrentStage();
local curStageIndex = GAMESTATE:GetCurrentStageIndex();
local t = Def.ActorFrame {};

t[#t+1] = Def.ActorFrame {
		Def.Quad{
			-- InitCommand=cmd(diffuse,color("#000000");zoomto,100,30;);
			-- OnCommand=cmd(diffusealpha,0.4;fadeleft,0.2;faderight,0.2;);
      InitCommand=function(self)
        self:diffuse(0,0,0,0)
        self:zoomto(100,30)
      end,
      OnCommand=function(self)
        self:diffusealpha(0.4)
        self:fadeleft(0.2)
        self:faderight(0.2)
      end,
		};
  -- InitCommand=function(self)
  --   self:diffuse(0,0,0,0)
  --   self:zoomto(100,30)
  -- end,
  -- OnCommand=function(self)
  --   self:diffusealpha(0.4)
  --   self:fadeleft(0.2)
  --   self:faderight(0.2)
  -- end,
	LoadFont(ThemePrefs.Get("ThemeFont") .. " Normal") .. {
		-- InitCommand=cmd(y,-1;shadowlength,1;zoom,1;strokecolor,color("#000000"));
    InitCommand=function(self)
      self:y(-1)
      self:shadowlength(1)
      self:zoom(1)
      self:strokecolor(0,0,0,0)
    end,
		BeginCommand=function(self)
			local top = SCREENMAN:GetTopScreen()
			if top then
				if not string.find(top:GetName(),"ScreenEvaluation") then
					curStageIndex = curStageIndex + 1
				end
			end
			self:playcommand("Set")
		end;
		SetCommand=function(self)
			if GAMESTATE:GetCurrentCourse() then
				self:settext( curStageIndex+1 .. " / " .. GAMESTATE:GetCurrentCourse():GetEstimatedNumStages() );
			elseif GAMESTATE:IsEventMode() then
				self:settextf("Stage %s", curStageIndex);
			else
				self:settextf("%s Stage", ToEnumShortString(curStage));
				self:zoom(1);
			end;
			-- StepMania is being stupid so we have to do this here;
			self:diffuse(StageToColor(curStage));
			self:diffusetopedge(ColorLightTone(StageToColor(curStage)));
		end;
	};
};
return t