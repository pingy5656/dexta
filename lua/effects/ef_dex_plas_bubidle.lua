--[[
triggered?                                                                                                                                                                                         --]]function EFFECT:Init(data) if not IsValid(data:GetEntity()) then return end if not IsValid(data:GetEntity():GetOwner()) then return end self.Ent = data:GetEntity() self.Att = data:GetAttachment() self.For = data:GetNormal() self.Position = self:GetTracerShootPos(data:GetOrigin(),self.Ent,self.Att) local emitter = ParticleEmitter(self.Position) if emitter != nil then local particle = emitter:Add("effects/bubble",self.Position) particle:SetVelocity(VectorRand():GetNormalized()*math.random(10,15)) particle:SetAirResistance(10) particle:SetGravity(Vector(0,0,0)) particle:SetDieTime(0.5) particle:SetStartAlpha(255) particle:SetEndAlpha(255) particle:SetStartSize(1) particle:SetEndSize(0) particle:SetRoll(0) particle:SetRollDelta(0) particle:SetColor(255,255,255) particle:SetCollide(true) particle:SetBounce(0.1) emitter:Finish() end end  function EFFECT:Think() return false end   function EFFECT:Render() end--[[
--]]