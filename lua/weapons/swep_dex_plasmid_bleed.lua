SWEP.PrintName = "Bleed"
SWEP.Author = "Dexter Barnes"
SWEP.Contact = "Addon page"
SWEP.Purpose = "The FitnessGram™ Pacer Test is a multistage aerobic capacity test that progressively gets more difficult as it continues."
SWEP.Instructions = "Left click to drain the red oxygen goop from your foes."
SWEP.Category = "Dexter's Plasmids"
SWEP.Primary.Ammo = "None"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Secondary.Ammo = "None"
SWEP.Secondary.Automatic = false
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.UseHands = false
SWEP.Base = "weapon_base"
SWEP.Spawnable = true
SWEP.ViewModelFOV = 56
SWEP.ViewModelFlip = false
SWEP.HoldType = "magic"
SWEP.ViewModel = "models/weapons/c_bugbait.mdl"
SWEP.WorldModel = "models/weapons/c_bugbait.mdl"
SWEP.Slot = 1
SWEP.SlotPos = 1
SWEP.SwayScale = 0
SWEP.BobScale = 0

function SWEP:Deploy()
    local vm = self.Owner:GetViewModel()
    vm:SendViewModelMatchingSequence(vm:LookupSequence("throw"))
    self:SetNextPrimaryFire(CurTime() + 0.7)
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
end

function SWEP:Think()
end

function SWEP:PreDrawViewModel(vm)
    render.SetBlend(0)
end

function SWEP:PostDrawViewModel(vm)
    render.SetBlend(1)
    if (not self.Arms) then
        self.Arms = ClientsideModel("models/weapons/c_arms_citizen.mdl", RENDERGROUP_BOTH)
        self.Arms:SetNoDraw(true)
    end
    self.Arms:SetModel(self.Owner:GetHands():GetModel())
    self.Arms:SetPos(vm:GetPos())
    self.Arms:SetAngles(vm:GetAngles())
    self.Arms:SetParent(vm)
    self.Arms:AddEffects(EF_BONEMERGE)
    self.Arms:DrawModel()
end

function SWEP:PrimaryAttack()
      if SERVER then
          if not self.Owner:DeductManaForWeapon(self:GetClass()) then
              return
          end
      end
  
      local tr = util.TraceLine({
          start = self.Owner:EyePos(),
          endpos = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 1000,
          filter = self.Owner
      })
  
      if tr.Hit and (tr.Entity:IsPlayer() or tr.Entity:IsNPC()) then
          local vm = self.Owner:GetViewModel()
          vm:SendViewModelMatchingSequence(vm:LookupSequence("throw"))
          
          if IsFirstTimePredicted() then
              local tr2 = util.TraceLine({
                  start = tr.HitPos,
                  endpos = tr.HitPos - Vector(0, 0, 200),
                  filter = tr.Entity
              })
              
              util.Decal("blood", tr2.HitPos - tr2.HitNormal, tr2.HitPos + tr2.HitNormal)
          end
          
          if SERVER then
              tr.Entity:TakeDamage(1, self.Owner, self)
              local fx = EffectData()
              fx:SetOrigin(tr.HitPos)
              util.Effect("bloodimpact", fx)
          end
          
          self:EmitSound("ambient/levels/canals/drip" .. math.random(1, 4) .. ".wav", 90, math.random(97, 103))
      end
  
      self:SetNextPrimaryFire(CurTime() + 0.1)
end
  


function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:DrawHUD()
end

function SWEP:Holster(wep)
    return true
end

function SWEP:DrawWorldModel()
    return false
end

SWEP.OldEyeAng = Angle(0, 0, 0)
SWEP.NewEyeAng = Angle(0, 0, 0)
SWEP.WepBob = Vector(0, 0, 0)
SWEP.HeightBob = 0

function DexLerpAng(sp, st, fi)
    fi.p = math.NormalizeAngle(fi.p - st.p)
    fi.y = math.NormalizeAngle(fi.y - st.y)
    fi.r = math.NormalizeAngle(fi.r - st.r)
    return st + fi * sp
end

function SWEP:GetViewModelPosition(pos, ang)
    -- ... (rest of the function remains unchanged)
end
