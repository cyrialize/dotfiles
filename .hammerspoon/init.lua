wallpaperDir = "/Users/jonny/Pictures/wallpapers"
imageExt = {"jpg", "jpeg"}

function change_wallpaper()
  local count = 1
  local wallpapers = {}

  for file in hs.fs.dir(wallpaperDir) do
    local wallpaper = wallpaperDir .. "/" .. file
    local validImage = false
    for i = 1, #imageExt do
      if string.find(wallpaper, imageExt[i]) then
        wallpapers[count] = wallpaper
        count = count + 1
      end
    end
  end

  screens = hs.screen.allScreens()
  local chosenWallpaper = wallpapers[math.random(#wallpapers)]
  for i = 1, #screens do
    screens[i]:desktopImageURL("file://" .. chosenWallpaper)
  end

end

hs.hotkey.bind({"cmd", "alt", "ctrl"}, "W", change_wallpaper)
