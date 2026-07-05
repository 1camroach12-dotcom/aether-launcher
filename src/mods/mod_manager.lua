-- Mod Manager - Handles mod discovery, loading, installation, and lifecycle

local mod_manager = {}
mod_manager.mods = {}
mod_manager.mod_directory = "mods/"
mod_manager.auto_install_list = {
    "performance-enhancer",
    "better-lighting",
    "custom-menus",
    "fps-counter",
}
mod_manager.launcher = nil

function mod_manager:initialize(launcher)
    self.launcher = launcher
    print("[Mod Manager] ✓ Initialized")
end

function mod_manager:discover_mods()
    print("[Mod Manager] Discovering mods in " .. self.mod_directory .. "...")
    
    local discovered = 0
    
    -- Scan for mod directories
    local mod_dirs = {
        "performance-enhancer",
        "better-lighting",
        "custom-menus",
        "fps-counter",
        "chat-enhancement",
        "zoom-mod",
    }
    
    for _, mod_name in ipairs(mod_dirs) do
        local mod_path = self.mod_directory .. mod_name .. "/mod.lua"
        if self:file_exists(mod_path) then
            print("[Mod Manager] Found: " .. mod_name)
            discovered = discovered + 1
        end
    end
    
    print("[Mod Manager] ✓ Discovered " .. discovered .. " mods")
end

function mod_manager:auto_install_mods()
    print("[Mod Manager] Auto-installing default mods...")
    
    for _, mod_name in ipairs(self.auto_install_list) do
        if not self:is_installed(mod_name) then
            print("[Mod Manager] Installing: " .. mod_name)
            self:install_mod(mod_name)
        else
            print("[Mod Manager] Already installed: " .. mod_name)
            self:load_mod(mod_name)
        end
    end
end

function mod_manager:install_mod(mod_name)
    print("[Mod Manager] Installing " .. mod_name .. "...")
    
    -- In production, this would download from a registry
    -- For now, we'll just copy from templates
    
    local mod_dir = self.mod_directory .. mod_name .. "/"
    os.execute("mkdir -p \"" .. mod_dir .. "\"")
    
    -- Create mod.lua for the mod
    self:create_mod_file(mod_name)
    
    print("[Mod Manager] ✓ Installed: " .. mod_name)
end

function mod_manager:create_mod_file(mod_name)
    local mod_templates = {
        ["performance-enhancer"] = require("src.mods.builtin.performance_enhancer"),
        ["better-lighting"] = require("src.mods.builtin.better_lighting"),
        ["custom-menus"] = require("src.mods.builtin.custom_menus"),
        ["fps-counter"] = require("src.mods.builtin.fps_counter"),
        ["chat-enhancement"] = require("src.mods.builtin.chat_enhancement"),
        ["zoom-mod"] = require("src.mods.builtin.zoom_mod"),
    }
    
    if mod_templates[mod_name] then
        self:load_mod(mod_name)
    end
end

function mod_manager:load_mod(mod_name)
    if self.mods[mod_name] then
        return self.mods[mod_name]
    end
    
    print("[Mod Manager] Loading mod: " .. mod_name)
    
    local mod_path = self.mod_directory .. mod_name .. "/mod.lua"
    local success, mod = pcall(require, mod_path)
    
    if not success then
        -- Try to load from builtin templates
        local builtin_path = "src.mods.builtin." .. mod_name:gsub("-", "_")
        success, mod = pcall(require, builtin_path)
    end
    
    if success and mod then
        self.mods[mod_name] = mod
        
        -- Call mod initialization hooks
        if mod.init then mod:init() end
        if mod.on_load then mod:on_load() end
        
        -- Subscribe mod to game events
        if self.launcher and self.launcher.minecraft then
            if mod.on_tick then
                self.launcher.minecraft:subscribe_event("on_tick", function()
                    mod:on_tick()
                end)
            end
        end
        
        print("[Mod Manager] ✓ Loaded: " .. mod_name)
        return mod
    else
        print("[Mod Manager] ✗ Failed to load mod: " .. mod_name)
        return nil
    end
end

function mod_manager:unload_mod(mod_name)
    if self.mods[mod_name] then
        local mod = self.mods[mod_name]
        if mod.on_unload then
            mod:on_unload()
        end
        self.mods[mod_name] = nil
        print("[Mod Manager] Unloaded: " .. mod_name)
    end
end

function mod_manager:unload_all_mods()
    print("[Mod Manager] Unloading all mods...")
    for mod_name, _ in pairs(self.mods) do
        self:unload_mod(mod_name)
    end
    print("[Mod Manager] ✓ All mods unloaded")
end

function mod_manager:update_mods()
    for mod_name, mod in pairs(self.mods) do
        if mod.on_tick then
            pcall(function() mod:on_tick() end)
        end
    end
end

function mod_manager:get_mod(mod_name)
    return self.mods[mod_name]
end

function mod_manager:list_mods()
    local mod_list = {}
    for name, mod in pairs(self.mods) do
        table.insert(mod_list, {
            name = name,
            version = mod.version or "1.0.0",
            author = mod.author or "Unknown",
            enabled = true,
        })
    end
    return mod_list
end

function mod_manager:is_installed(mod_name)
    return self:file_exists(self.mod_directory .. mod_name .. "/mod.lua")
end

function mod_manager:file_exists(path)
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    end
    return false
end

return mod_manager
