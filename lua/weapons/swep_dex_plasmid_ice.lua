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
 `----' |_|  (_)(__)`--'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      --]]SWEP.PrintName = "Ice" SWEP.Author = "Dexter Barnes" SWEP.Contact = "Addon page" SWEP.Purpose = "Ice cold." SWEP.Instructions = "Left click to let it go." SWEP.Category = "Dexter's Plasmids" SWEP.Primary.Ammo = "None" SWEP.Primary.ClipSize = -1 SWEP.Primary.DefaultClip = -1 SWEP.Primary.Automatic = false SWEP.Secondary.Ammo = "None" SWEP.Secondary.Automatic = false SWEP.Secondary.ClipSize = -1 SWEP.Secondary.DefaultClip = -1 SWEP.UseHands = false SWEP.Base = "weapon_base" SWEP.Spawnable = true SWEP.ViewModelFOV = 56 SWEP.ViewModelFlip = false SWEP.HoldType = "magic" SWEP.ViewModel = "models/weapons/c_bugbait.mdl" SWEP.WorldModel = "models/weapons/c_bugbait.mdl" SWEP.Slot = 1 SWEP.SlotPos = 1 SWEP.SwayScale = 0 SWEP.BobScale = 0  function SWEP:Deploy() local vm = self.Owner:GetViewModel() vm:SendViewModelMatchingSequence(vm:LookupSequence("draw")) self:SetNextPrimaryFire(CurTime()+0.7) end  function SWEP:Initialize() self:SetHoldType(self.HoldType) end  function SWEP:Think() end  function SWEP:PreDrawViewModel(vm) render.SetBlend(0) end  function SWEP:PostDrawViewModel(vm) render.SetBlend(1) if ( !self.Arms ) then self.Arms = ClientsideModel("models/weapons/c_arms_citizen.mdl",RENDERGROUP_BOTH) self.Arms:SetNoDraw( true ) end self.Arms:SetModel(self.Owner:GetHands():GetModel()) self.Arms:SetPos(vm:GetPos()) self.Arms:SetAngles(vm:GetAngles()) self.Arms:SetParent(vm) self.Arms:AddEffects(EF_BONEMERGE) self.Arms:DrawModel() end  if CLIENT then language.Add("Undone_Poor Sucker","Undone Poor Sucker") end  function SWEP:PrimaryAttack() local vm = self.Owner:GetViewModel() vm:SendViewModelMatchingSequence(vm:LookupSequence("squeeze")) local tr = util.TraceLine({ start = self.Owner:EyePos(), endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward()*1000, filter = self.Owner }) if tr.Hit then self:EmitSound("physics/glass/glass_impact_bullet"..math.random(1,4)..".wav",100,math.random(97,103)) local target = tr.Entity if (target:IsNPC() or target:IsPlayer()) and !tr.HitWorld and SERVER then local ragdoll = ents.Create("prop_ragdoll") ragdoll:SetPos(target:GetPos()) ragdoll:SetAngles(target:GetAngles()) ragdoll:SetModel(target:GetModel()) ragdoll:SetMaterial("phoenix_storms/gear") ragdoll:SetColor(Color(210,255,255,190)) ragdoll:SetRenderMode("1") ragdoll:SetSkin(target:GetSkin()) ragdoll:Spawn() ragdoll:Activate() ragdoll:SetSequence(target:GetSequence()) ragdoll:SetCycle(target:GetCycle()) undo.Create("Poor Sucker") undo.AddEntity(ragdoll) undo.SetPlayer(self.Owner) undo.Finish() bones = ragdoll:GetPhysicsObjectCount() if !(bones<2) then for bone = 1,bones-1 do bone1 = ragdoll:GetPhysicsObjectNum(bone) if bone1 then weld, weld2 = target:GetBonePosition(target:TranslatePhysBoneToBone(bone)) bone1:SetPos(weld) bone1:SetAngles(weld2) bone1:SetMaterial("glassbottle") constraint.Weld(ragdoll,ragdoll,1,bone,0,true) local fx = EffectData() fx:SetOrigin(ragdoll:GetBonePosition(bone)) util.Effect("glassimpact",fx) end end end if target:IsNPC() then target:Remove() elseif target:IsPlayer() then target:Kill() timer.Simple(0.005,function() if IsValid(target) then local corpse = target:GetRagdollEntity() if IsValid(corpse) then corpse:Remove() end end end ) end end end self:SetNextPrimaryFire(CurTime()+0.7) end  function SWEP:SecondaryAttack() end  function SWEP:Reload() end  function SWEP:DrawHUD() end  function SWEP:Holster(wep) return true end  function SWEP:DrawWorldModel() return false end  SWEP.OldEyeAng = Angle(0,0,0) SWEP.NewEyeAng = Angle(0,0,0) SWEP.WepBob = Vector(0,0,0) SWEP.HeightBob = 0  function DexLerpAng(sp,st,fi) fi.p = math.NormalizeAngle(fi.p-st.p) fi.y = math.NormalizeAngle(fi.y-st.y) fi.r = math.NormalizeAngle(fi.r-st.r) return st + fi*sp end  function SWEP:GetViewModelPosition(pos,ang) if self.Owner:OnGround() then self.WepBob = LerpVector(0.3,self.WepBob,Vector(math.sin(CurTime()*6)*math.Clamp((self.Owner:GetVelocity():Length()/600),-5,5),math.sin(CurTime()*12)*math.Clamp((self.Owner:GetVelocity():Length()/300),-5,5),math.sin(CurTime()*3)*math.Clamp((self.Owner:GetVelocity():Length()/600),-5,5))) else self.WepBob = LerpVector(0.2,self.WepBob,Vector(0,0,0)) end self.HeightBob = Lerp(0.1,self.HeightBob,math.Clamp(self.Owner:GetVelocity().z/30,-2,2)) pos = pos + Vector(0,0,self.HeightBob) pos = pos + ang:Up()*self.WepBob.x ang:RotateAroundAxis(ang:Right(),self.WepBob.y) ang:RotateAroundAxis(ang:Up(),self.WepBob.z) self.NewEyeAng = DexLerpAng(0.4,self.NewEyeAng,self.Owner:EyeAngles() - self.OldEyeAng) pos = pos + ang:Right()*self.NewEyeAng.y*0.05 pos = pos + ang:Up()*self.NewEyeAng.p*0.05 ang:RotateAroundAxis( ang:Up(),self.NewEyeAng.y*0.25) ang:RotateAroundAxis( ang:Right(),self.NewEyeAng.p*-0.25) self.OldEyeAng = self.Owner:EyeAngles() pos = pos + ang:Up()*math.sin(CurTime())/5 pos = pos + ang:Right()*math.sin(CurTime()/2)/5 ang:RotateAroundAxis(ang:Up(),math.sin(CurTime())/2.5) return pos, ang end--[[
 --]]