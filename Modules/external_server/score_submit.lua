local GetJudgmentCounts = function(player)
	local counts = GetExJudgmentCounts(player)
	local translation = {
		["W0"] = "fantasticPlus",
		["W1"] = "fantastic",
		["W2"] = "excellent",
		["W3"] = "great",
		["W4"] = "decent",
		["W5"] = "wayOff",
		["Miss"] = "miss",
		["totalSteps"] = "totalSteps",
		["Holds"] = "holdsHeld",
		["totalHolds"] = "totalHolds",
		["Mines"] = "minesHit",
		["totalMines"] = "totalMines",
		["Rolls"] = "rollsHeld",
		["totalRolls"] = "totalRolls"
	}

	local judgmentCounts = {}

	for key, value in pairs(counts) do
		if translation[key] ~= nil then
			judgmentCounts[translation[key]] = value
		end
	end

	return judgmentCounts
end

local GetRescoredJudgmentCounts = function(player)
	local pn = ToEnumShortString(player)

	local translation = {
		["W0"] = "fantasticPlus",
		["W1"] = "fantastic",
		["W2"] = "excellent",
		["W3"] = "great",
		["W4"] = "decent",
		["W5"] = "wayOff",
	}

	local rescored = {
		["fantasticPlus"] = 0,
		["fantastic"] = 0,
		["excellent"] = 0,
		["great"] = 0,
		["decent"] = 0,
		["wayOff"] = 0
	}
	
	for i=1,GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() do
		for window, name in pairs(translation) do
			rescored[name] = rescored[name] + SL[pn].Stages.Stats[SL.Global.Stages.PlayedThisGame + 1].column_judgments[i]["Early"][window]
		end
	end

	return rescored
end

return Def.ActorFrame {
  Name="ExternalServerAutoSubmit",
  ModuleCommand=function(self)
    -- SM("Does this get hit?")
    self:playcommand("ExternalServerConnection")
  end,
  ExternalRequestResponseActor(17, 50)..{
    ExternalServerConnectionCommand=function(self)
      -- SM("RequestResponseTestActor from ScreenEvalCommon")
      SM("Does THIS get hit?")
      local sendRequest = false
      local headers = {}
      local query = {}
      local body = {}

      headers["content-type"] = "application/json"
      
      local rate = tonumber(string.format("%.0f", SL.Global.ActiveModifiers.MusicRate * 100))

      -- For each player, do the following...
      for i=1,2 do
        local player = "PlayerNumber_P"..i
        local pn = ToEnumShortString(player)

        if GAMESTATE:IsHumanPlayer(player) and GAMESTATE:IsSideJoined(player) then
          
          -- While we're generally decoupling from GrooveStats, this is
          -- a reasonable mechanism for verifying because the logic
          -- is generally decoupled away from GS being enabled.
          local _, valid = ValidForGrooveStats(player)
          

          local stats = STATSMAN:GetCurStageStats():GetPlayerStageStats(player)
          local submitForPlayer = false

          -- Commenting out top line for testing...
          -- if valid and not stats:GetFailed() and SL[pn].IsPadPlayer then

          Trace("Valid score: "..tostring(valid))
          if valid and not stats:GetFailed() then
            local percentDP = stats:GetPercentDancePoints()
            local score = tonumber(("%.0f"):format(percentDP * 10000))
            
            local profileName = ""
            if PROFILEMAN:IsPersistentProfile(player) and PROFILEMAN:GetProfile(player) then
              profileName = PROFILEMAN:GetProfile(player):GetDisplayName()
            end

            ---------------------------------------------------------
            -- For integration with GrooveStats, uncomment APIKey lines.
            ---------------------------------------------------------
            -- if SL[pn].ApiKey ~= "" and SL[pn].Streams.Hash ~= "" then
            Trace("Associated chart hash: "..SL[pn].Streams.Hash)
            if SL[pn].Streams.Hash ~= "" then
              Trace("Inside if after checking associated chart hash...")
              query["chartHashP"..i] = SL[pn].Streams.Hash
              -- headers["x-api-key-player-"..i] = SL[pn].ApiKey
              local score_details = {
                rate = rate,
                score = score,
                judgmentCount = GetJudgmentCounts(player),
                usedCmod=(GAMESTATE:GetPlayerState(pn):GetPlayerOptions("ModsLevel_Preferred"):CMod() ~= nil),
                comment=CreateCommentString(player) -- ??
              }
              SM(score_details)
              body["player"..i] = score_details
              sendRequest = true
              submitForPlayer = true
            end
          end

          if not submitForPlayer then

          -- add this later...
          end
        end
      end


      if sendRequest then
        -- Add the UI text for showing the submission in progress.
        -- self:GetParent():etcstuffyadayada
        -- self:GetParent():etcstuffyadayada
        local details = {
          endpoint="/api/v1/score?"..NETWORK:EncodeQueryParameters(query),
          method="POST",
          headers=headers,
          body=JsonEncode(body),
          timeout=30,
          callback=ExternalResponseProcessor,
          args=SCREENMAN:GetTopScreen():GetChild("Overlay"):GetChild("ScreenEval Common")
        }
        self:playcommand("ExternalServerRequestSubmission", details)
      end
    end
  }
}