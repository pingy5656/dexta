--[[
triggered?                                                                                                                                                                                         --]]SWEP.PrintName = "Teleportation" SWEP.Author = "Dexter Barnes" SWEP.Contact = "Addon page" SWEP.Purpose = "It's not my fault if you figure out how to get your autist self stuck." SWEP.Instructions = "Left click to teleport somewhere. You can't teleport on ceilings, walls, or larger than 45 degree slopes." SWEP.Category = "Dexter's Plasmids" SWEP.Primary.Ammo = "None" SWEP.Primary.ClipSize = -1 SWEP.Primary.DefaultClip = -1 SWEP.Primary.Automatic = true SWEP.Secondary.Ammo = "None" SWEP.Secondary.Automatic = true SWEP.Secondary.ClipSize = -1 SWEP.Secondary.DefaultClip = -1 SWEP.UseHands = false SWEP.Base = "weapon_base" SWEP.Spawnable = true SWEP.ViewModelFOV = 56 SWEP.ViewModelFlip = false SWEP.HoldType = "magic" SWEP.ViewModel = "models/weapons/c_bugbait.mdl" SWEP.WorldModel = "models/weapons/c_bugbait.mdl" SWEP.Slot = 1 SWEP.SlotPos = 1 SWEP.SwayScale = 0 SWEP.BobScale = 0  function SWEP:Deploy() local vm = self.Owner:GetViewModel() vm:SendViewModelMatchingSequence(vm:LookupSequence("draw")) self:SetNextPrimaryFire(CurTime()+0.7) end  function SWEP:Initialize() self:SetHoldType(self.HoldType) end  function SWEP:Think() end  function SWEP:PreDrawViewModel(vm) render.SetBlend(0) end  function SWEP:PostDrawViewModel(vm) render.SetBlend(1) if ( !self.Arms ) then self.Arms = ClientsideModel("models/weapons/c_arms_citizen.mdl",RENDERGROUP_BOTH) self.Arms:SetNoDraw( true ) end self.Arms:SetModel(self.Owner:GetHands():GetModel()) self.Arms:SetPos(vm:GetPos()) self.Arms:SetAngles(vm:GetAngles()) self.Arms:SetParent(vm) self.Arms:AddEffects(EF_BONEMERGE) self.Arms:DrawModel() end  function SWEP:PrimaryAttack() local vm = self.Owner:GetViewModel() vm:SendViewModelMatchingSequence(vm:LookupSequence("squeeze")) local tr = util.TraceLine({ start = self.Owner:EyePos(), endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward()*1500, filter = self.Owner }) if tr.Hit then local hn = tr.HitNormal if (math.abs(hn.x) < 0.5) and (math.abs(hn.y) < 0.5) and (hn.z > 0) then if SERVER then self.Owner:CreateRagdoll() self.Owner:ScreenFade(SCREENFADE.IN,Color(200,255,255,255),0.5,0.1) end self:EmitSound("ambient/levels/citadel/portal_beam_shoot5.wav",100,math.random(97,103)) if SERVER then timer.Simple(0.05,function() if IsValid(self) and IsValid(self.Owner) and self.Owner:Alive() then self.Owner:SetPos(tr.HitPos) end end) end end end self:SetNextPrimaryFire(CurTime()+0.7) end  function SWEP:SecondaryAttack() end  function SWEP:Reload() end  function SWEP:DrawHUD() end  function SWEP:Holster(wep) return true end  function SWEP:DrawWorldModel() return false end  SWEP.OldEyeAng = Angle(0,0,0) SWEP.NewEyeAng = Angle(0,0,0) SWEP.WepBob = Vector(0,0,0) SWEP.HeightBob = 0  function DexLerpAng(sp,st,fi) fi.p = math.NormalizeAngle(fi.p-st.p) fi.y = math.NormalizeAngle(fi.y-st.y) fi.r = math.NormalizeAngle(fi.r-st.r) return st + fi*sp end  function SWEP:GetViewModelPosition(pos,ang) if self.Owner:OnGround() then self.WepBob = LerpVector(0.3,self.WepBob,Vector(math.sin(CurTime()*6)*math.Clamp((self.Owner:GetVelocity():Length()/600),-5,5),math.sin(CurTime()*12)*math.Clamp((self.Owner:GetVelocity():Length()/300),-5,5),math.sin(CurTime()*3)*math.Clamp((self.Owner:GetVelocity():Length()/600),-5,5))) else self.WepBob = LerpVector(0.2,self.WepBob,Vector(0,0,0)) end self.HeightBob = Lerp(0.1,self.HeightBob,math.Clamp(self.Owner:GetVelocity().z/30,-2,2)) pos = pos + Vector(0,0,self.HeightBob) pos = pos + ang:Up()*self.WepBob.x ang:RotateAroundAxis(ang:Right(),self.WepBob.y) ang:RotateAroundAxis(ang:Up(),self.WepBob.z) self.NewEyeAng = DexLerpAng(0.4,self.NewEyeAng,self.Owner:EyeAngles() - self.OldEyeAng) pos = pos + ang:Right()*self.NewEyeAng.y*0.05 pos = pos + ang:Up()*self.NewEyeAng.p*0.05 ang:RotateAroundAxis( ang:Up(),self.NewEyeAng.y*0.25) ang:RotateAroundAxis( ang:Right(),self.NewEyeAng.p*-0.25) self.OldEyeAng = self.Owner:EyeAngles() pos = pos + ang:Up()*math.sin(CurTime())/5 pos = pos + ang:Right()*math.sin(CurTime()/2)/5 ang:RotateAroundAxis(ang:Up(),math.sin(CurTime())/2.5) return pos, ang end --[[
--]]