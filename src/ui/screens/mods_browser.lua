-- Mods Browser Screen

local screen = {}
screen.current_page = 1
screen.mods_per_page = 5

function screen:on_open()
    print("\n[Mods Browser] Screen opened")
end

function screen:render()
    print("\n" .. string.rep("=", 50))
    print("          AETHER LAUNCHER - MODS BROWSER")
    print(string.rep("=", 50))
    print("\n[1] Performance Enhancer - 4.8 ★ (5000 downloads)")
    print("[2] Better Lighting - 4.6 ★ (3200 downloads)")
    print("[3] Custom Menus - 4.9 ★ (8000 downloads)")
    print("[4] FPS Counter - 4.7 ★ (6000 downloads)")
    print("[5] Chat Enhancement - 4.5 ★ (2500 downloads)")
    print("\n[N] Next Page  [P] Previous  [B] Back")
    print(string.rep("=", 50))
end

function screen:handle_input(input)
    if input == "1" or input == "2" or input == "3" or input == "4" or input == "5" then
        print("[Mods Browser] Opening mod details for selection " .. input .. "...")
    elseif input == "n" or input == "N" then
        self.current_page = self.current_page + 1
        print("[Mods Browser] Moving to page " .. self.current_page)
    elseif input == "p" or input == "P" then
        if self.current_page > 1 then
            self.current_page = self.current_page - 1
            print("[Mods Browser] Moving to page " .. self.current_page)
        end
    elseif input == "b" or input == "B" then
        print("[Mods Browser] Returning to Main Menu...")
    end
end

function screen:on_close()
    print("[Mods Browser] Screen closed")
end

return screen
