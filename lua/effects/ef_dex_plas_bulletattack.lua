--[[
triggered?                                                                                                                                                                                         --]]function EFFECT:Init(data) if not IsValid(data:GetEntity()) then return end if not IsValid(data:GetEntity():GetOwner()) then return end self.Ent = data:GetEntity() self.Att = data:GetAttachment() self.For = data:GetNormal() self.Position = self:GetTracerShootPos(data:GetOrigin(),self.Ent,self.Att) local emitter = ParticleEmitter(self.Position) if emitter != nil then local particle = emitter:Add("effects/muzzleflash"..math.random(1,4),self.Position) particle:SetVelocity(Vector(0,0,0)) particle:SetAirResistance(0) particle:SetGravity(Vector(0,0,0)) particle:SetDieTime(0.1) particle:SetStartAlpha(255) particle:SetEndAlpha(0) particle:SetStartSize(math.Rand(10,15)) particle:SetEndSize(0) particle:SetRoll(math.Rand(-2,2)) particle:SetRollDelta(math.Rand(-2,2)) particle:SetColor(255,255,255) particle:SetCollide(false) particle:SetBounce(0) emitter:Finish() end end  function EFFECT:Think() return false end   function EFFECT:Render() end--[[
--]]