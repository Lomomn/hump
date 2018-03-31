local GameObject = Class{}
local Vector = require('lib.hump.vector')
GameObject.scene = nil
GameObject.screenWidth, GameObject.screenHeight = love.graphics.getDimensions()

function GameObject.init(self, pos, width, height)
    if GameObject.scene == nil then error('GameObject.scene wasn\'t set! Please set it before instantiating any GameObjects') end
    if GameObject.camera == nil then error('GameObject.camera wasn\'t set! Please set it before instantiating any GameObjects') end

    self.pos = pos or Vector(0,0)
    self.vel = Vector(0,0)
    self.width = width or error('No width provided')
    self.height = height or error('No height provided')
    self.rotation = 0
    self.rotationPoint = Vector(self.width/2, self.height)
    
    self.alive = true
    self:createBounds()
end


function GameObject.createBounds(self)
    self.bounds = GameObject.scene:rectangle(self.pos.x, self.pos.y, self.width, self.height)
    self.bounds.parent = self
end


function GameObject.update(self, dt)
    self.pos = self.pos+self.vel*dt
    self.bounds:setRotation(math.rad(self.rotation))
    self.bounds:moveTo(self.pos:unpack())
end


function GameObject.draw(self)
    if self.alive then
        love.graphics.setColor(0,255,0)
    else
        love.graphics.setColor(255,0,0)
    end
    if debugMode then
        self.bounds:draw('fill')
    end
    love.graphics.setColor(255,255,255)
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