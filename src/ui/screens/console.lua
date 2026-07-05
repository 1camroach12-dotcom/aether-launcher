-- Console Screen

local screen = {}
screen.console_lines = {}
screen.max_lines = 20

function screen:on_open()
    print("\n[Console] Screen opened")
end

function screen:render()
    print("\n" .. string.rep("=", 50))
    print("          AETHER LAUNCHER - CONSOLE")
    print(string.rep("=", 50))
    
    -- Display console lines
    if #self.console_lines == 0 then
        print("\n[Console ready]")
    else
        for i, line in ipairs(self.console_lines) do
            if i > #self.console_lines - self.max_lines then
                print(line)
            end
        end
    end
    
    print("\n[C] Clear  [B] Back to Main Menu")
    print(string.rep("=", 50))
end

function screen:handle_input(input)
    if input == "c" or input == "C" then
        self.console_lines = {}
        print("[Console] Cleared")
    elseif input == "b" or input == "B" then
        print("[Console] Returning to Main Menu...")
    else
        table.insert(self.console_lines, "> " .. input)
    end
end

function screen:log(message)
    table.insert(self.console_lines, message)
    if #self.console_lines > self.max_lines * 2 then
        table.remove(self.console_lines, 1)
    end
end

function screen:on_close()
    print("[Console] Screen closed")
end

return screen
