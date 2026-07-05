-- Mod Registry - Central repository of available mods for download and management

local registry = {}
registry.registry_url = "https://github.com/1camroach12-dotcom/aether-mod-registry"
registry.cache_path = "cache/mods.json"
registry.mods = {}

function registry:load()
    print("[Registry] Loading mod registry...")
    
    -- In production, this would fetch from the registry repo
    -- For now, we'll use a local list
    
    self.mods = {
        ["performance-enhancer"] = {
            name = "Performance Enhancer",
            version = "1.2.0",
            author = "Aether Team",
            description = "Optimize FPS and reduce lag",
            downloads = 5000,
            rating = 4.8,
            url = "https://github.com/1camroach12-dotcom/aether-mods/performance-enhancer",
        },
        ["better-lighting"] = {
            name = "Better Lighting",
            version = "1.0.5",
            author = "Aether Team",
            description = "Enhanced lighting and shadows",
            downloads = 3200,
            rating = 4.6,
            url = "https://github.com/1camroach12-dotcom/aether-mods/better-lighting",
        },
        ["custom-menus"] = {
            name = "Custom Menus",
            version = "2.1.0",
            author = "Aether Team",
            description = "Beautiful custom UI menus",
            downloads = 8000,
            rating = 4.9,
            url = "https://github.com/1camroach12-dotcom/aether-mods/custom-menus",
        },
        ["fps-counter"] = {
            name = "FPS Counter",
            version = "1.1.0",
            author = "Aether Team",
            description = "Display FPS and performance stats",
            downloads = 6000,
            rating = 4.7,
            url = "https://github.com/1camroach12-dotcom/aether-mods/fps-counter",
        },
        ["chat-enhancement"] = {
            name = "Chat Enhancement",
            version = "1.3.0",
            author = "Aether Team",
            description = "Better chat with filtering and colors",
            downloads = 2500,
            rating = 4.5,
            url = "https://github.com/1camroach12-dotcom/aether-mods/chat-enhancement",
        },
        ["zoom-mod"] = {
            name = "Zoom Mod",
            version = "1.0.0",
            author = "Aether Team",
            description = "Scroll wheel zoom like Optifine",
            downloads = 4000,
            rating = 4.8,
            url = "https://github.com/1camroach12-dotcom/aether-mods/zoom-mod",
        },
    }
    
    print("[Registry] ✓ Registry loaded (" .. self:count() .. " mods available)")
end

function registry:search(query)
    local results = {}
    local query_lower = query:lower()
    
    for id, mod in pairs(self.mods) do
        if mod.name:lower():find(query_lower) or 
           mod.description:lower():find(query_lower) then
            table.insert(results, {id = id, data = mod})
        end
    end
    
    return results
end

function registry:get_mod(mod_id)
    return self.mods[mod_id]
end

function registry:get_popular(limit)
    limit = limit or 10
    local popular = {}
    
    for id, mod in pairs(self.mods) do
        table.insert(popular, {id = id, data = mod})
    end
    
    table.sort(popular, function(a, b)
        return a.data.downloads > b.data.downloads
    end)
    
    local result = {}
    for i = 1, math.min(limit, #popular) do
        table.insert(result, popular[i])
    end
    
    return result
end

function registry:get_top_rated(limit)
    limit = limit or 10
    local rated = {}
    
    for id, mod in pairs(self.mods) do
        table.insert(rated, {id = id, data = mod})
    end
    
    table.sort(rated, function(a, b)
        return a.data.rating > b.data.rating
    end)
    
    local result = {}
    for i = 1, math.min(limit, #rated) do
        table.insert(result, rated[i])
    end
    
    return result
end

function registry:count()
    local count = 0
    for _ in pairs(self.mods) do
        count = count + 1
    end
    return count
end

return registry
