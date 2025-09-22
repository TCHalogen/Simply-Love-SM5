---------------------------------------------------------------------
-- This file is used for the purpose of loading modules.
-- Creating a loader.lua file allows us to leverage the LoadActor()
-- function in conjunction with pathing to recursively load modules
-- as we desire.
---------------------------------------------------------------------
local t = {}

-----------------------------------------------------------------------
-- External Server Modules
-----------------------------------------------------------------------
local external_module_enabled = true

if external_module_enabled then
  t["ScreenTitleMenu"] = LoadActor("./external_server/server_connect.lua")
  t["ScreenTitleJoin"] = LoadActor("./external_server/server_connect.lua")
  t["ScreenEvaluationStage"] = LoadActor("./external_server/score_submit.lua")
end

return t;

