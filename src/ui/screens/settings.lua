-- Settings Screen

local screen = {}

function screen:on_open()
    print("\n[Settings] Screen opened")
end

function screen:render()
    print("\n" .. string.rep("=", 50))
    print("          AETHER LAUNCHER - SETTINGS")
    print(string.rep("=", 50))
    print("\n1. Graphics Settings")
    print("2. Performance Options")
    print("3. Mod Settings")
    print("4. Controls")
    print("5. Audio")
    print("6. Back to Main Menu")
    print("\n" .. string.rep("=", 50))
end

function screen:handle_input(input)
    if input == "1" then
        print("[Settings] Opening Graphics Settings...")
    elseif input == "2" then
        print("[Settings] Opening Performance Options...")
    elseif input == "3" then
        print("[Settings] Opening Mod Settings...")
    elseif input == "4" then
        print("[Settings] Opening Controls...")
    elseif input == "5" then
        print("[Settings] Opening Audio Settings...")
    elseif input == "6" then
        print("[Settings] Returning to Main Menu...")
    end
end

function screen:on_close()
    print("[Settings] Screen closed")
end

return screen
