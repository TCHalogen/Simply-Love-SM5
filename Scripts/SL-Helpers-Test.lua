-- TestURL = function()
--   -- For now, we're just going to mirror GrooveStats' helper structure, but
--   -- this will likely deviate once actual functionality gets put into place.
--   local test = ThemePrefs.Get("EnableTest") -- not used at the moment, but for later
--   local url_prefix = "http://127.0.0.1:5000/"
--     Trace("Testing TestURL")
--   return url_prefix

-- end

-- ----------
-- See: RequestResponseActor, SL-Helpers-GrooveStats.lua
-- This isn't quite the same, but the functionality is derived from
-- it.
-- ----------
RequestResponseTestActor = function(x, y)
  -- Trace("Do we even hit the start of this function?")
  local url_prefix = "http://127.0.0.1:5000/"
 -- doesn't fire
  return Def.ActorFrame{
    SubmissionRequestCommand=function(self, params)
      self:stoptweening()
      if not params then
        Warn("No params specified for SubmissionRequestCommand.")
      end

      if self.request_handler then
        self.request_handler:Cancel()
        self.request_handler = nil
      end
      self:GetChild("Spinner"):visible(true);

      local timeout = params.timeout or 30
      local endpoint = params.endpoint or ""
      local headers = params.headers
      local body = params.body
      local method = params.method

      self.request_handler = NETWORK:HttpRequest{
        url=url_prefix..endpoint, -- PoC captures at 5000 for now
        method=method,
        body=body,
        headers=headers,
        connectTimeout=60,
        transferTimeout=60,
        onResponse=function(res)
          -- we've received a response, so allow us to receive others
          self.request_handler = nil

          if res.statusCode then
            local body = nil
            local code = res.statusCode

            -- Successful response
            if code == 200 then
              body = JsonDecode(res.body)
            end

            if self.leaving_screen then
              return
            end

            -- hmmm, what's this? might need to look at other calls to see what this does
            if params.callback then
              if not res.error or ToEnumShortString(res.error) ~= "Cancelled" then
                params.callback(res, params.args)
              end
            end

            self:GetChild("Spinner"):visible(false)
          end
        end
      }
    end,
		Def.ActorFrame{
			Name="Spinner",
			InitCommand=function(self)
				self:visible(false)
			end,
			Def.Sprite{
				Texture=THEME:GetPathG("", "LoadingSpinner 10x3.png"),
				Frames=Sprite.LinearFrames(30,1),
				InitCommand=function(self)
					self:zoom(0.15)
					self:diffuse(GetHexColor(SL.Global.ActiveColorIndex, true))
				end,
				VisualStyleSelectedMessageCommand=function(self)
					self:diffuse(GetHexColor(SL.Global.ActiveColorIndex, true))
				end
			},
			LoadFont(ThemePrefs.Get("ThemeFont") .. " Normal")..{
				InitCommand=function(self)
					self:zoom(0.9)
					-- Leaderboard should be white since it's on a black background.
					-- self:diffuse(DarkUI() and name ~= "Leaderboard" and Color.Black or Color.White)
				end,
				UpdateSpinnerCommand=function(self, params)
					-- Only display the countdown after we've waiting for some amount of time.
          SM(params)
					if params.timeout - params.remaining_time > 2 then
						self:visible(true)
					else
						self:visible(false)
					end
					if params.remaining_time > 1 then
						self:settext(math.floor(params.remaining_time))
					end
				end
			}
		},
  }
end
