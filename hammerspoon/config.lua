local function expandHome(path)
  return path and path:gsub("^~", os.getenv("HOME")) .. "/" or path
end
obsidianVault = expandHome("~/Documents/Google Sync'd/Notes/Notes")
obsidianDailyNotePath = expandHome("~/Documents/Google Sync'd/Notes/Notes/4-Archive/Journaling/")

return {
    obsidianVault = obsidianVault,
    obsidianDailyNotePath = obsidianDailyNotePath,
}