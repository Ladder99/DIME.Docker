-- sliding_window.lua
-- A module that implements a sliding window algorithm for processing time-series data
-- Usage:
--   local window = require('sliding_window')
--   local myWindow = window.create(5)  -- Create a window of size 5
--   myWindow:add(10)                  -- Add values
--   myWindow:add(20)
--   local avg = myWindow:average()    -- Calculate average of values in window
--   local sum = myWindow:sum()        -- Calculate sum of values in window
--   local min = myWindow:min()        -- Find minimum value in window
--   local max = myWindow:max()        -- Find maximum value in window

local middleclass = require('middleclass')

-- Define the SlidingWindow class
local SlidingWindow = middleclass('SlidingWindow')

-- Constructor for the SlidingWindow class
function SlidingWindow:initialize(size)
    self.size = size or 10  -- Default window size is 10
    self.values = {}        -- Array to store values
    self.currentIndex = 1   -- Current position in the window
    self.isFull = false     -- Flag to indicate if window is full
end

-- Create function (factory method)
local function create(size)
    return SlidingWindow:new(size)
end

-- Add a new value to the window
function SlidingWindow:add(value)
    -- Store the value at the current index
    self.values[self.currentIndex] = value
    
    -- Update the current index (circle back to 1 when we reach the end)
    self.currentIndex = self.currentIndex % self.size + 1
    
    -- Check if the window is full
    if not self.isFull and #self.values >= self.size then
        self.isFull = true
    end
    
    return value
end

-- Get the current values in the window as an array
function SlidingWindow:getValues()
    local result = {}
    local count = self.isFull and self.size or (self.currentIndex - 1)
    
    for i = 1, count do
        table.insert(result, self.values[i])
    end
    
    return result
end

-- Calculate the average of values in the window
function SlidingWindow:average()
    local values = self:getValues()
    if #values == 0 then return 0 end
    
    local sum = 0
    for _, v in ipairs(values) do
        sum = sum + v
    end
    
    return sum / #values
end

-- Calculate the sum of values in the window
function SlidingWindow:sum()
    local values = self:getValues()
    local sum = 0
    
    for _, v in ipairs(values) do
        sum = sum + v
    end
    
    return sum
end

-- Find the minimum value in the window
function SlidingWindow:min()
    local values = self:getValues()
    if #values == 0 then return nil end
    
    local minVal = values[1]
    for i = 2, #values do
        if values[i] < minVal then
            minVal = values[i]
        end
    end
    
    return minVal
end

-- Find the maximum value in the window
function SlidingWindow:max()
    local values = self:getValues()
    if #values == 0 then return nil end
    
    local maxVal = values[1]
    for i = 2, #values do
        if values[i] > maxVal then
            maxVal = values[i]
        end
    end
    
    return maxVal
end

-- Count the number of elements currently in the window
function SlidingWindow:count()
    return self.isFull and self.size or (self.currentIndex - 1)
end

-- Check if the window is full
function SlidingWindow:full()
    return self.isFull
end

-- Clear all values from the window
function SlidingWindow:clear()
    self.values = {}
    self.currentIndex = 1
    self.isFull = false
end

-- Export the module
return {
    create = create
}
