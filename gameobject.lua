Class = require('lib.hump.class')
local GameObject = Class{}
local Vector = require('lib.hump.vector')
GameObject.scene = nil
if love then
    GameObject.screenWidth, GameObject.screenHeight = love.graphics.getDimensions()
end

function GameObject.init(self, pos, width, height)
    if GameObject.scene == nil then error('GameObject.scene wasn\'t set! Please set it before instantiating any GameObjects') end

    self.pos = pos or Vector(0,0)
    self.vel = Vector(0,0)
    self.speed = Vector(100,0)
    self.width = width or error('No width provided')
    self.height = height or error('No height provided')
    self.rotation = 0
    self.id = nil

    self.alive = true
    self:createBounds()
end


function GameObject.createBounds(self)
    self.bounds = GameObject.scene:rectangle(self.pos.x, self.pos.y, self.width, self.height)
    self.bounds.parent = self
end


function GameObject.update(self, dt)
    local x,y = (self.vel*dt):unpack()
    self.bounds:move(x,y)
    self.pos.x, self.pos.y = self.bounds:bbox()
end


function GameObject.draw(self)
    if self.alive then
        love.graphics.setColor(0,1,0)
    else
        love.graphics.setColor(1,0,0)
    end
    if debugMode then
        self.bounds:draw('line')
    end
    love.graphics.setColor(1,1,1)
end


function GameObject.kill(self)
    self.alive = false
    GameObject.scene:remove(self.bounds)
    self.bounds.parent = nil 
    self.bounds = nil -- Destroy bounds reference so it can be garbage collected
end


function GameObject.revive(self)
    self.alive = true
    self:createBounds()
end


function GameObject.resize(width, height)
    GameObject.screenWidth, GameObject.screenHeight = width, height
end

return GameObject