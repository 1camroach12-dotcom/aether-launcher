-- Mod Details Screen

local screen = {}
screen.current_mod = nil

function screen:on_open()
    print("\n[Mod Details] Screen opened")
end

function screen:render()
    print("\n" .. string.rep("=", 50))
    print("          AETHER LAUNCHER - MOD DETAILS")
    print(string.rep("=", 50))
    if self.current_mod then
        print("\nName: " .. self.current_mod.name)
        print("Version: " .. self.current_mod.version)
        print("Author: " .. self.current_mod.author)
        print("Rating: " .. self.current_mod.rating .. " ★")
        print("Downloads: " .. self.current_mod.downloads)
        print("\nDescription:")
        print(self.current_mod.description)
        print("\n[I] Install  [U] Uninstall  [B] Back")
    else
        print("\nNo mod selected")
        print("\n[B] Back to Mods Browser")
    end
    print(string.rep("=", 50))
end

function screen:handle_input(input)
    if input == "i" or input == "I" then
        print("[Mod Details] Installing mod...")
    elseif input == "u" or input == "U" then
        print("[Mod Details] Uninstalling mod...")
    elseif input == "b" or input == "B" then
        print("[Mod Details] Returning to Mods Browser...")
    end
end

function screen:set_mod(mod)
    self.current_mod = mod
end

function screen:on_close()
    print("[Mod Details] Screen closed")
end

return screen
