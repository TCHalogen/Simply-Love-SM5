TestURL = function()
  -- For now, we're just going to mirror GrooveStats' helper structure, but
  -- this will likely deviate once actual functionality gets put into place.
  local test = ThemePrefs.Get("EnableTest") -- not used at the moment, but for later
  local url_prefix = "http://127.0.0.1:5000/"
  return url_prefix
end

-- ----------
-- See: RequestResponseActor, SL-Helpers-GrooveStats.lua
-- This isn't quite the same, but the functionality is derived from
-- it.
-- ----------
RequestResponseTestActor=function(x, y)
  local url_prefix = TestURL()

  return Def.ActorFrame{
    InitCommand=function(self)
      self.request_time = -1
      self.timeout = -1
      self.request_handler = nil
      self.leaving_screen = false
      self:xy(x, y)
    end,
    CancelCommand=function(self)
      self.leaving_screen = true
      if self.request_handler then
        self.request_handler:Cancel()
        self.request_handler = nil
      end
    end,
    OffCommand=function(self)
      self.leaving_screen = true
      if self.request_handler then
        self.request_handler:Cancel()
        self.request_handler = nil
      end
    end,
    SubmissionRequestCommand=function(self, params)
      Trace("testing again")
      local url_prefix = TestURL()
      self:stoptweening()
      if not params then
        Warn("No params specified for SubmissionRequestCommand.")
      end

      Trace("testing again")
      if self.request_handler then
        self.request_handler:Cancel()
        self.request_handler = nil
      end
      self:GetChild("Spinner"):visible(true);

      Trace("testing again")
      local timeout = params.timeout or 30
      local endpoint = params.endpoint or ""
      local headers = params.headers
      local body = params.body

      -- add dynamism later
      local method = "GET"

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
    end
  }
end