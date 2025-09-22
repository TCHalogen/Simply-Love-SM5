ExternalResponseProcessor = function(res, externalInfo)

  -- We'll probably need to refactor this a bit more, since this 
  -- is intended to be a generic thing, but for now, this is okay
  local status = externalInfo:GetChild("ExternalServerStatus")
  if (res.error or res.statusCode ~= 200) then
    local error = res.error and ToEnumShortString(res.error) or nil

    if error == "Timeout" then
      status:settext("Unable to connect to external server.")
    end
    return;
  end

  status:settext("✔ Connected to external server.")
end