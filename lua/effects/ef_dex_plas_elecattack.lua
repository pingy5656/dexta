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
 `----' |_|  (_)(__)`--'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      --]]EFFECT.Mat = Material("trails/electric")  function EFFECT:Init( data ) self.texcoord = math.Rand(0,20)/3 self.Position = data:GetStart() self.WeaponEnt = data:GetEntity() self.HandPos = data:GetOrigin() self.StartPos = self.Position self.Entity:SetCollisionBounds( self.StartPos - self.HandPos, Vector( 110, 110, 110 ) ) self.Entity:SetRenderBoundsWS( self.StartPos, self.HandPos, Vector()*8 ) self.Alpha = 195 self.FlashA = 255  end  function EFFECT:Think( ) self.FlashA = self.FlashA - 650 * FrameTime() if (self.FlashA < 0) then self.FlashA = 0 end self.Alpha = self.Alpha - 4150 * FrameTime() if (self.Alpha < 0) then return false end return true end  function EFFECT:Render() self.Length = (self.StartPos - self.HandPos):Length() local texcoord = self.texcoord render.SetMaterial(self.Mat) render.DrawBeam(self.StartPos,self.HandPos,15,texcoord,texcoord + self.Length / 300,Color(255,255,255,255)) end--[[
 --]]