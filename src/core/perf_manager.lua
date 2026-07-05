-- Performance Manager - Monitors and optimizes launcher performance

local perf_manager = {}
perf_manager.metrics = {}
perf_manager.start_time = os.time()

function perf_manager:initialize()
    print("[Performance Manager] Initializing...")
    self.metrics = {
        fps = 0,
        memory_usage = 0,
        frame_time = 0,
        mod_load_time = 0,
    }
    print("[Performance Manager] ✓ Initialized")
end

function perf_manager:start_timer(label)
    return {
        label = label,
        start = os.time(),
    }
end

function perf_manager:end_timer(timer)
    local elapsed = os.time() - timer.start
    print("[Performance] " .. timer.label .. ": " .. elapsed .. "ms")
    return elapsed
end

function perf_manager:get_uptime()
    return os.time() - self.start_time
end

function perf_manager:get_metrics()
    return self.metrics
end

function perf_manager:update_fps(fps)
    self.metrics.fps = fps
end

function perf_manager:update_memory(usage)
    self.metrics.memory_usage = usage
end

function perf_manager:log_performance()
    print("[Performance Metrics]")
    print("  FPS: " .. self.metrics.fps)
    print("  Memory: " .. self.metrics.memory_usage .. "MB")
    print("  Frame Time: " .. self.metrics.frame_time .. "ms")
    print("  Uptime: " .. self:get_uptime() .. "s")
end

return perf_manager
