function DeployConvars3()
	CreateConVar("knacken_blast3",1)
	CreateConVar("knacken_weapon3","fas2_rem870")
	CreateConVar("knacken_reset3",60)
end

function DoorKnacken(door,dmgInfo)
	if ( door:GetClass() == "prop_door_rotating" ) then
		if ( dmgInfo:GetInflictor():GetActiveWeapon():GetClass() == GetConVarString("knacken_weapon3") ) then
			if ( GetConVarNumber("knacken_blast3") == 1 ) then
				local dMdl = door:GetModel()
				local dFall = ents.Create("prop_physics")
				local forceDir = door:GetPos() - dmgInfo:GetAttacker():GetPos()
				dFall:SetModel(dMdl)
				dFall:SetSkin(door:GetSkin())
				dFall:SetPos(door:GetPos())
				dFall:SetAngles(door:GetAngles())
				dFall:Spawn()
				dFall:GetPhysicsObject():ApplyForceCenter(forceDir * 200 )
				door:Fire("unlock","",0)
				door:Fire("open","",0)
				door:SetNoDraw(true)
				door:SetSolid(SOLID_NONE)
				if ( GetConVarNumber("knacken_reset3") == 0 ) then
					return
				else
					timer.Simple(GetConVarNumber("knacken_reset3"),function()
					door:SetNoDraw(false)
					door:SetSolid(SOLID_VPHYSICS)
					dFall:Remove()
					end)
				end
			end
			
			if ( GetConVarNumber("knacken_blast3") == 0 ) then
				door:Fire("unlock","",0)
				door:Fire("open","",0)
			end
			
		end
	end
	
	if ( door:GetClass() == "func_door" ) then
		print("Walrus")
		if ( dmgInfo:GetInflictor():GetActiveWeapon():GetClass() == GetConVarString("knacken_weapon3") ) then
			door:Fire("unlock","",0)
			door:Fire("open","",0)
		end
	end
	
	if ( door:GetClass() == "func_door_rotating" ) then
		if ( dmgInfo:GetInflictor():GetActiveWeapon():GetClass() == GetConVarString("knacken_weapon3") ) then
			door:Fire("unlock","",0)
			door:Fire("open","",0)
		end
	end
	
end

hook.Add("EntityTakeDamage","SchlossKnackensShotgun3",DoorKnacken)
hook.Add("Initialize","DeployConvars3",DeployConvars3)