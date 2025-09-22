LoadActor("./request_response.lua") -- handles request submission
LoadActor("./response_processor.lua") -- handles response from server

---------------------------------------------------------------------
-- TODO: See if it is possible to hijack the SL global space for service
-- TODO: tracking while also maintaining dynamism
---------------------------------------------------------------------
local base_endpoint = "api/v1"

return Def.ActorFrame{
  Name="ExternalServer",
  ModuleCommand=function(self)
    local screen = SCREENMAN:GetTopScreen()
    if (screen:GetName() == "ScreenTitleMenu" or screen:GetName() == "ScreenTitleJoin") then
      self:queuecommand("Reset")
      self:diffusealpha(0):sleep(0.2):linear(0.4):diffusealpha(1):visible(true)
      self:queuecommand("ExternalServerConnection")
    end
  end,
  InitCommand=function(self)
    self:zoom(0.8):x(10):y(35)
  end,
  LoadFont(ThemePrefs.Get("ThemeFont") .. " Normal")..{
    Name="ExternalServerStatus",
    InitCommand=function(self)
      self:horizalign(left)
    end,
  },

  ExternalRequestResponseActor(5, 30)..{
    ExternalServerConnectionCommand=function(self)
        local details = {
          endpoint=base_endpoint,
          method="GET",
          timeout=30,
          callback=ExternalResponseProcessor,
          args=self:GetParent()
        }
        self:playcommand("ExternalServerRequestSubmission", details)
    end
  }
}