-- Zoom Mod
-- Scroll wheel zoom like Optifine

local mod = {
    name = "Zoom Mod",
    version = "1.0.0",
    author = "Aether Team",
    description = "Scroll wheel zoom like Optifine",
}

function mod:init()
    print("[" .. self.name .. "] Initializing...")
    self.enabled = true
    self.zoom_level = 1.0
    self.max_zoom = 8.0
    self.min_zoom = 1.0
end

function mod:on_load()
    print("[" .. self.name .. "] ✓ Loaded!")
    print("[" .. self.name .. "] Use scroll wheel to zoom (hold C key)")
end

function mod:on_key_press(key)
    if key == "scroll_up" then
        self.zoom_level = math.min(self.zoom_level + 0.2, self.max_zoom)
    elseif key == "scroll_down" then
        self.zoom_level = math.max(self.zoom_level - 0.2, self.min_zoom)
    end
end

function mod:on_unload()
    print("[" .. self.name .. "] Unloading...")
end

return mod
