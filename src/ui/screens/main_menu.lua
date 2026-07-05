-- Main Menu Screen

local screen = {}

function screen:on_open()
    print("\n[Main Menu] Screen opened")
end

function screen:render()
    print("\n" .. string.rep("=", 50))
    print("          AETHER LAUNCHER - MAIN MENU")
    print(string.rep("=", 50))
    print("\n1. Play Minecraft")
    print("2. Mods Browser")
    print("3. Settings")
    print("4. About")
    print("5. Exit")
    print("\n" .. string.rep("=", 50))
end

function screen:handle_input(input)
    if input == "1" then
        print("[Main Menu] Starting Minecraft...")
    elseif input == "2" then
        print("[Main Menu] Opening Mods Browser...")
    elseif input == "3" then
        print("[Main Menu] Opening Settings...")
    elseif input == "4" then
        print("[Main Menu] Showing About...")
    elseif input == "5" then
        print("[Main Menu] Exiting...")
    end
end

function screen:on_close()
    print("[Main Menu] Screen closed")
end

return screen
