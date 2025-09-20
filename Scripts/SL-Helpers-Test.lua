-- For now, we're just going to mirror GrooveStats' helper structure, but
-- this will likely deviate once actual functionality gets put into place.
TestURL = function()
  local url_prefix = "http://127.0.0.1:5000/"
  return url_prefix
end

RequestResponseTestActor = function(x, y)
  local url_prefix = TestURL()
  return Def.ActorFrame{
    InitCommand = function(self)
      self.request_time = -1
      self.timeout = -1
      self.request_handler = nil
      self.leaving_screen = false
      self:xy(x, y)
    end,
    CancelCommand = function (self)
      self.leaving_screen = true
      if self.request_handler then
        self.request_handler:Cancel()
        self.request_handler = nil
      end
    end,
    OffCommand = function (self)
      self.leaving_screen = true
      if self.request_handler then
        self.request_handler:Cancel()
        self.request_handler = nil
      end
    end,
    SubmissionRequestCommand = function(self, params)
      local url_prefix = TestURL()
      self:stoptweening()
      if not params then
        Warn("No params specified for MakeTestRequestCommand.")
      end

      if self.request_handler then
        self.request_handler:Cancel()
        self.request_handler = nil
      end
      self:GetChild("Spinner"):visible(true);

      -- proof of concept won't have an endpoint, so let's protect
      -- against nil
      local endpoint = params.endpoint or ""
      local headers = params.headers or "" -- for now
      local body = params.body

      -- add dynamism later
      local method = "POST"

      self.request_handler = NETWORK:HttpRequest{
        url=url_prefix, -- PoC captures at 5000 for now
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

            -- handle connection errors later

            --

            if self.leaving_screen then
              return
            end

            -- hmmm, what's this? might need to look at other calls to see what this does
            if params.callback then
              if not res.error or ToEnumShortString(res.error) ~= "Cancelled" then
                params.callback(res, params.args)
              end
            end

          end
        end
      }
    end,
    -- Borrowing this from the GrooveStats request call code, for now.
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
					self:diffuse(DarkUI() and name ~= "Leaderboard" and Color.Black or Color.White)
				end,
				UpdateSpinnerCommand=function(self, params)
					-- Only display the countdown after we've waiting for some amount of time.
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
    }
  }

end