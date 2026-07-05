-- FPS Counter Mod
-- Display FPS and performance statistics

local mod = {
    name = "FPS Counter",
    version = "1.1.0",
    author = "Aether Team",
    description = "Display FPS and performance stats",
}

function mod:init()
    print("[" .. self.name .. "] Initializing...")
    self.enabled = true
    self.fps = 0
    self.frame_count = 0
    self.last_time = os.time()
    self.show_details = false
    self.position = {x = 10, y = 10}
end

function mod:on_load()
    print("[" .. self.name .. "] ✓ Loaded!")
    print("[" .. self.name .. "] Press F3 to show detailed stats")
end

function mod:on_tick()
    self.frame_count = self.frame_count + 1
    
    local current_time = os.time()
    if current_time > self.last_time then
        self.fps = self.frame_count
        self.frame_count = 0
        self.last_time = current_time
    end
end

function mod:on_render()
    -- Draw FPS counter on screen
    print("FPS: " .. self.fps)
end

function mod:on_unload()
    print("[" .. self.name .. "] Unloading...")
end

return mod
