--[[
triggered?                                                                                                                                                                                         --]] function EFFECT:Init(data) if not IsValid(data:GetEntity()) then return end if not IsValid(data:GetEntity():GetOwner()) then return end self.Ent = data:GetEntity() self.Att = data:GetAttachment() self.For = data:GetNormal() self.Position = self:GetTracerShootPos(data:GetOrigin(),self.Ent,self.Att) local emitter = ParticleEmitter(self.Position) if emitter != nil then local particle = emitter:Add("sprites/flamelet"..math.random(1,5),self.Position) particle:SetVelocity(VectorRand():GetNormalized()*math.random(4,8)) particle:SetAirResistance(0) particle:SetGravity(Vector(0,0,20)) particle:SetDieTime(0.6) particle:SetStartAlpha(255) particle:SetEndAlpha(0) particle:SetStartSize(math.Rand(2,2.5)) particle:SetEndSize(0) particle:SetRoll(math.Rand(-1,1)) particle:SetRollDelta(math.Rand(-1,1)) particle:SetColor(255,255,255) particle:SetCollide(false) particle:SetBounce(0) emitter:Finish() end end  function EFFECT:Think() return false end   function EFFECT:Render() end--[[
--]]