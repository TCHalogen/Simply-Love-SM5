-- There's an option in place for enabling the test harness; we can use
-- similar conditions for whether or not we want to keep it up.
-- if not IsServiceAllowed(SL.Test.AutoSubmit) or GAMESTATE:IsCourseMode() then return end

-- For now, we'll take these from the GrooveStats file.
-- If integration w/ GS becomes an option, we can deduplicate it later.
-- local GetJudgmentCounts = function(player)
-- 	local counts = GetExJudgmentCounts(player)
-- 	local translation = {
-- 		["W0"] = "fantasticPlus",
-- 		["W1"] = "fantastic",
-- 		["W2"] = "excellent",
-- 		["W3"] = "great",
-- 		["W4"] = "decent",
-- 		["W5"] = "wayOff",
-- 		["Miss"] = "miss",
-- 		["totalSteps"] = "totalSteps",
-- 		["Holds"] = "holdsHeld",
-- 		["totalHolds"] = "totalHolds",
-- 		["Mines"] = "minesHit",
-- 		["totalMines"] = "totalMines",
-- 		["Rolls"] = "rollsHeld",
-- 		["totalRolls"] = "totalRolls"
-- 	}

-- 	local judgmentCounts = {}

-- 	for key, value in pairs(counts) do
-- 		if translation[key] ~= nil then
-- 			judgmentCounts[translation[key]] = value
-- 		end
-- 	end

-- 	return judgmentCounts
-- end

-- local GetRescoredJudgmentCounts = function(player)
-- 	local pn = ToEnumShortString(player)

-- 	local translation = {
-- 		["W0"] = "fantasticPlus",
-- 		["W1"] = "fantastic",
-- 		["W2"] = "excellent",
-- 		["W3"] = "great",
-- 		["W4"] = "decent",
-- 		["W5"] = "wayOff",
-- 	}

-- 	local rescored = {
-- 		["fantasticPlus"] = 0,
-- 		["fantastic"] = 0,
-- 		["excellent"] = 0,
-- 		["great"] = 0,
-- 		["decent"] = 0,
-- 		["wayOff"] = 0
-- 	}
	
-- 	for i=1,GAMESTATE:GetCurrentStyle():ColumnsPerPlayer() do
-- 		for window, name in pairs(translation) do
-- 			rescored[name] = rescored[name] + SL[pn].Stages.Stats[SL.Global.Stages.PlayedThisGame + 1].column_judgments[i]["Early"][window]
-- 		end
-- 	end

-- 	return rescored
-- end

-- local af = Def.ActorFrame {
--   Name="AutoSubmitTest",
--   OnCommand=function(self)

--   end,
--   RequestResponseTestActor(17, 50)..{
--     OnCommand=function(self)
--       SM("RequestResponseTestActor from ScreenEvalCommon")
--     end
--   }
-- }

-- -- Anonymous callback function to handle the submission.
-- local AutoSubmitTestRequestProcessor = function(res, overlay)
--   SCREENMAN:SystemMessage("AutoSubmitTestRequestProcessor from ScreenEvalCommon")
  
-- end