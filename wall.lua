local GameObject = require('lib.hump.gameobject')
local Rotatable = require('lib.hump.rotatable')
local Wall = Class{__includes = {GameObject, Rotatable}}

local Vector = require('lib.hump.vector')
local blockGraphic = love.graphics.newImage('assets/block.png')


function Wall.init(self, pos, width, height)
    GameObject.init(self, pos, width, height)
    Rotatable.init(self)
end

function Wall.draw(self)
    for i=0, 12 do
        love.graphics.setColor((1/12)*i,(1/12)*i,(1/12)*i)
        love.graphics.draw(blockGraphic, 
            self.screenPos.x, self.screenPos.y-i, 
            self.rotation)
    end
    GameObject.draw(self)
end

function Wall.update(self, dt) 
    GameObject.update(self, dt)
end

return Wall