-- Aether Launcher - Main Entry Point
-- Version 1.0.0
-- A feature-rich Minecraft launcher with mod management

package.path = package.path .. ";./src/?.lua"

local launcher = {}
launcher.version = "1.0.0"
launcher.name = "AETHER LAUNCHER"
launcher.running = true
launcher.current_instance = nil

-- Load core modules
local mod_manager = require("src.core.mod_manager")
local mod_registry = require("src.mods.mod_registry")
local ui_framework = require("src.ui.ui_framework")
local perf_manager = require("src.core.perf_manager")

function launcher:initialize()
    print("\n" .. string.rep("=", 50))
    print("  " .. self.name .. " v" .. self.version)
    print("  A Modern Minecraft Launcher")
    print(string.rep("=", 50) .. "\n")
    
    -- Initialize core systems
    print("[Launcher] Initializing core systems...")
    perf_manager:initialize()
    
    print("[Launcher] Loading mod registry...")
    mod_registry:load()
    
    print("[Launcher] Initializing mod manager...")
    mod_manager:initialize()
    
    print("[Launcher] Initializing UI framework...")
    ui_framework:initialize(self)
    
    print("[Launcher] ✓ All systems initialized\n")
end

function launcher:run()
    print("[Launcher] Starting main loop...")
    
    -- Set initial screen
    ui_framework:set_screen("main_menu")
    
    -- Main loop
    while self.running do
        -- Render current screen
        ui_framework:render()
        
        -- Get user input
        print("\n> ", "")
        local input = io.read()
        
        if input then
            if input:lower() == "exit" or input:lower() == "quit" then
                self:shutdown()
            else
                ui_framework:handle_input(input)
            end
        end
    end
end

function launcher:shutdown()
    print("\n[Launcher] Shutting down...")
    print("[Launcher] Cleaning up resources...")
    perf_manager:log_performance()
    print("[Launcher] ✓ Shutdown complete")
    print("[Launcher] Thank you for using " .. self.name .. "!\n")
    self.running = false
end

-- Main execution
if arg[0]:match("launcher%.lua$") or arg[1] then
    launcher:initialize()
    launcher:run()
else
    return launcher
end
