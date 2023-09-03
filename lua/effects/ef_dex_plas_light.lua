
--blablabla creditz to gaymod devs blablabla triggered?
function EFFECT:Init(data)
	local vOffset = data:GetOrigin()
	local ent = data:GetEntity()
	local dlight = DynamicLight(ent:EntIndex())
	if (dlight) then
		local c = self:GetColor()
		dlight.Pos = vOffset
		dlight.r = 255
		dlight.g = 255
		dlight.b = 255
		dlight.Brightness = 2
		dlight.Size = 512
		dlight.DieTime = CurTime() + 0.05
		dlight.Decay = 512 * 1
	end
end

function EFFECT:Think( )
	return false
end

function EFFECT:Render()
end
