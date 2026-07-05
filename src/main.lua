-- Aether Launcher - Main Entry Point
-- Complete Minecraft Bedrock Client with Mods, UI, and Performance Optimization

local launcher = {}
launcher.version = "1.0.0"
launcher.running = true

-- Initialize all core systems
function launcher:init()
    print("\n" .. string.rep("=", 50))
    print("[Aether Launcher v" .. self.version .. "] INITIALIZING")
    print(string.rep("=", 50))
    
    -- Load core modules
    self.config = require("src.core.config")
    self.performance = require("src.performance.performance_manager")
    self.mod_manager = require("src.mods.mod_manager")
    self.ui = require("src.ui.ui_framework")
    self.minecraft = require("src.minecraft.bedrock_integration")
    self.registry = require("src.mods.mod_registry")
    
    -- Initialize each system in order
    print("\n[Aether] Loading configuration...")
    self.config:load()
    
    print("[Aether] Initializing performance manager...")
    self.performance:initialize()
    
    print("[Aether] Connecting to Minecraft Bedrock...")
    self.minecraft:connect()
    
    print("[Aether] Discovering mods...")
    self.mod_manager:initialize(self)
    self.mod_manager:discover_mods()
    
    print("[Aether] Setting up mod registry...")
    self.registry:load()
    
    print("[Aether] Initializing UI framework...")
    self.ui:initialize(self)
    
    print("[Aether] Auto-installing mods...")
    self.mod_manager:auto_install_mods()
    
    print("\n[Aether] ✓ Initialization complete!\n")
end

-- Main game loop
function launcher:run()
    self:init()
    
    print("[Aether] Starting main loop...\n")
    
    while self.running do
        -- Render UI
        self.ui:render()
        
        -- Handle input
        local input = self:get_input()
        if input then
            self.ui:handle_input(input)
        end
        
        -- Update mods
        self.mod_manager:update_mods()
        
        -- Monitor performance
        self.performance:monitor()
        
        -- Small delay to prevent CPU spinning
        if os.execute then
            os.execute("sleep 0.016") -- ~60 FPS
        end
    end
    
    self:shutdown()
end

function launcher:get_input()
    -- This would read from stdin or game input system
    -- Placeholder for actual input handling
    return nil
end

function launcher:shutdown()
    print("\n[Aether] Shutting down...")
    self.mod_manager:unload_all_mods()
    self.minecraft:disconnect()
    print("[Aether] Goodbye!\n")
end

-- Entry point
if require then
    return launcher
else
    local launcher_instance = launcher
    launcher_instance:run()
end
