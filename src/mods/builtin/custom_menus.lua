-- Custom Menus Mod
-- Beautiful, modern UI menus for Minecraft

local mod = {
    name = "Custom Menus",
    version = "2.1.0",
    author = "Aether Team",
    description = "Beautiful custom UI menus",
}

function mod:init()
    print("[" .. self.name .. "] Initializing...")
    self.enabled = true
    self.menu_screens = {}
    self.current_screen = nil
end

function mod:on_load()
    print("[" .. self.name .. "] ✓ Loaded!")
    print("[" .. self.name .. "] Installing custom menu screens...")
end

function mod:register_menu(name, render_func, input_func)
    self.menu_screens[name] = {
        render = render_func,
        handle_input = input_func,
    }
    print("[" .. self.name .. "] Registered menu: " .. name)
end

function mod:open_menu(name)
    if self.menu_screens[name] then
        self.current_screen = self.menu_screens[name]
        print("[" .. self.name .. "] Opened: " .. name)
    end
end

function mod:on_render()
    if self.current_screen and self.current_screen.render then
        self.current_screen:render()
    end
end

function mod:on_unload()
    print("[" .. self.name .. "] Unloading...")
end

return mod
