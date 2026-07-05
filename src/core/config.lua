-- Configuration Management System

local config = {}
config.config_path = "config/settings.lua"
config.defaults = {
    -- Graphics
    theme = "dark",
    render_distance = 16,
    smooth_lighting = true,
    custom_textures = true,
    
    -- Performance
    performance_mode = "balanced",
    fps_cap = 60,
    memory_optimization = true,
    chunk_preload = true,
    
    -- Mods
    auto_install_mods = true,
    auto_update_mods = false,
    enable_mod_development = true,
    
    -- Gameplay
    auto_respawn = false,
    show_fps = true,
    show_coordinates = true,
    show_notifications = true,
}
config.settings = {}

function config:load()
    -- Try to load existing config
    local success, loaded_config = pcall(function()
        local f = io.open(self.config_path, "r")
        if f then
            local content = f:read("*all")
            f:close()
            return load(content)()
        end
        return nil
    end)
    
    if success and loaded_config then
        self.settings = loaded_config
        print("[Config] ✓ Configuration loaded from file")
    else
        self.settings = self.defaults
        print("[Config] ✓ Using default configuration")
        self:save()
    end
end

function config:save()
    -- Ensure config directory exists
    local f = io.open(self.config_path, "w")
    if f then
        f:write("return {\n")
        for key, value in pairs(self.settings) do
            if type(value) == "string" then
                f:write("    " .. key .. " = \"" .. value .. "\",\n")
            else
                f:write("    " .. key .. " = " .. tostring(value) .. ",\n")
            end
        end
        f:write("}\n")
        f:close()
        print("[Config] ✓ Configuration saved")
    end
end

function config:get(key)
    return self.settings[key] or self.defaults[key]
end

function config:set(key, value)
    self.settings[key] = value
    self:save()
end

return config
