-- UI Framework - Main UI system for Aether Launcher

local ui = {}
ui.screens = {}
ui.current_screen = nil
ui.launcher = nil
ui.theme = {}

function ui:initialize(launcher)
    self.launcher = launcher
    print("[UI] Initializing UI framework...")
    
    -- Load theme
    self:load_theme()
    
    -- Register screens
    self:register_screens()
    
    print("[UI] ✓ UI framework initialized")
end

function ui:load_theme()
    self.theme = {
        primary_color = {r = 0.1, g = 0.1, b = 0.15},
        secondary_color = {r = 0.2, g = 0.2, b = 0.25},
        accent_color = {r = 0.3, g = 0.6, b = 1.0},
        text_color = {r = 1.0, g = 1.0, b = 1.0},
        font_size = 16,
    }
end

function ui:register_screens()
    print("[UI] Registering screens...")
    
    -- Load screen modules
    local screens = {
        "main_menu",
        "settings",
        "mods_browser",
        "mod_details",
        "console",
    }
    
    for _, screen_name in ipairs(screens) do
        local success, screen = pcall(require, "src.ui.screens." .. screen_name)
        if success and screen then
            self.screens[screen_name] = screen
            print("[UI] ✓ Registered screen: " .. screen_name)
        end
    end
end

function ui:set_screen(screen_name)
    if self.screens[screen_name] then
        if self.current_screen and self.current_screen.on_close then
            self.current_screen:on_close()
        end
        
        self.current_screen = self.screens[screen_name]
        
        if self.current_screen.on_open then
            self.current_screen:on_open()
        end
        
        print("[UI] Screen changed to: " .. screen_name)
    else
        print("[UI] ✗ Screen not found: " .. screen_name)
    end
end

function ui:render()
    if self.current_screen and self.current_screen.render then
        self.current_screen:render()
    else
        -- Render default screen
        self:render_default()
    end
end

function ui:render_default()
    print("====================================")
    print("  AETHER LAUNCHER v1.0.0")
    print("====================================")
end

function ui:handle_input(input)
    if self.current_screen and self.current_screen.handle_input then
        self.current_screen:handle_input(input)
    end
end

function ui:draw_box(x, y, width, height, color)
    -- Draw a colored box at specified position
    print("[UI] Drawing box at " .. x .. "," .. y)
end

function ui:draw_text(x, y, text, color)
    -- Draw text at specified position
    print(text)
end

function ui:draw_button(x, y, width, height, text, on_click)
    -- Draw a clickable button
    print("[Button] " .. text)
end

return ui
