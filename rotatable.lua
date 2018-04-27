local Rotatable = Class{}
local Vector = require('lib.hump.vector')

function Rotatable.init(self)
    -- self.rotation is not needed as the gameobjects already have a rotation var
    self.screenPos = self.pos:clone()
end

return Rotatable