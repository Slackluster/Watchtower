-------------------------
-- Watchtower: API.lua --
-------------------------

-- Import a flag or group to Watchtower
Watchtower:Import(importString)

-- Export a flag or group from Watchtower
-- table: table, either Watchtower_Flags[x] for a group or Watchtower_Flags[x].flags[y] for a flag
-- exportType: string, "group" or "flag"
Watchtower:Export(table, exportType)
