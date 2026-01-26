---@meta


-- Node timers: persistent per-node timer reference
---@class NodeTimerRef
NodeTimerRef = {}

---Set a timer's state.
---Will trigger the node's `on_timer` after (timeout - elapsed) seconds.
---@param timeout number  -- seconds, supports fractional values
---@param elapsed number  -- seconds, supports fractional values
function NodeTimerRef:set(timeout, elapsed) end

---Start a timer (equivalent to `set(timeout, 0)`).
---@param timeout number  -- seconds, supports fractional values
function NodeTimerRef:start(timeout) end

---Stop the timer.
function NodeTimerRef:stop() end

---Get current timeout in seconds. If timeout == 0, timer is inactive.
---@return number timeout
function NodeTimerRef:get_timeout() end

---Get current elapsed time in seconds.
---@return number elapsed
function NodeTimerRef:get_elapsed() end

---Whether the timer is currently started.
---@return boolean started
function NodeTimerRef:is_started() end

