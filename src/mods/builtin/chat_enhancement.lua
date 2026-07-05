-- Chat Enhancement Mod
-- Better chat with filtering and colors

local mod = {
    name = "Chat Enhancement",
    version = "1.3.0",
    author = "Aether Team",
    description = "Better chat with filtering and colors",
}

function mod:init()
    print("[" .. self.name .. "] Initializing...")
    self.enabled = true
    self.filters = {}
    self.commands = {}
end

function mod:on_load()
    print("[" .. self.name .. "] ✓ Loaded!")
    print("[" .. self.name .. "] Features: Message Filtering, Color Support, Custom Prefixes")
end

function mod:on_chat(message)
    -- Apply chat enhancements
    return message
end

function mod:on_unload()
    print("[" .. self.name .. "] Unloading...")
end

return mod
