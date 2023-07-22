-- For now.
GAMESTATE:SetCurrentPlayMode('PlayMode_Regular')

-- This will be workable on double as well, so make sure we have the
-- right step type.
local type = GAMESTATE:GetCurrentStyle():GetStepsType()