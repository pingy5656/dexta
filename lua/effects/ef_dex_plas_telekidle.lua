--[[
   .---.  .---.          
  ( .-._)/ .-. )         
 (_) \   | | |(_)        
 _  \ \  | | | |         
( `-'  ) \ `-' /         
 `----'   )---'          
         (_)             
   .---.  .--.   ,'|"\   
  ( .-._)/ /\ \  | |\ \  
 (_) \  / /__\ \ | | \ \ 
 _  \ \ |  __  | | |  \ \
( `-'  )| |  |)| /(|`-' /
 `----' |_|  (_)(__)`--'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      --]]function EFFECT:Init(data) if not IsValid(data:GetEntity()) then return end if not IsValid(data:GetEntity():GetOwner()) then return end self.Ent = data:GetEntity() self.Att = data:GetAttachment() self.For = data:GetNormal() self.Position = self:GetTracerShootPos(data:GetOrigin(),self.Ent,self.Att) local emitter = ParticleEmitter(self.Position) if emitter != nil then local particle = emitter:Add("effects/blueflare1",self.Position) particle:SetVelocity(VectorRand():GetNormalized()*math.Rand(1,3)) particle:SetAirResistance(50) particle:SetGravity(Vector(0,0,math.random(-15,15))) particle:SetDieTime(math.Rand(1,2)) particle:SetStartAlpha(255) particle:SetEndAlpha(0) particle:SetStartSize(math.Rand(3,4)) particle:SetEndSize(0) particle:SetRoll(math.Rand(-1,1)) particle:SetRollDelta(math.Rand(-1,1)) particle:SetColor(255,0,255) particle:SetCollide(true) particle:SetBounce(0.5) emitter:Finish() end end  function EFFECT:Think() return false end   function EFFECT:Render() end--[[
 --]]