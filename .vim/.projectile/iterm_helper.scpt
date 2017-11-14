on openMainTab(currentTab)
  tell currentTab
    tell current session
      terminate
    end tell
  end tell
end openMainTab

tell application "iTerm"
  tell current window
   set currentTab to current tab
    openMainTab(currentTab)
  end tell
end tell
