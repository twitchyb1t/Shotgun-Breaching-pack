#twitchyb1t's Door Breaching Pack

This addon allows you to break down doors, they will respawn after a period of time defined by you.

## Customization
To add another breaching weapon to the pack, duplicate the file and give it a different name, this works with any desired weapon (FA:S 2, CW2, CS:S, HL2 and pretty much any other pack). Once you have duplicated this file, name it "custom-shotgun", the file should contain the following.
```

function DeployConvars()
	CreateConVar("knacken_blast",1)
	CreateConVar("knacken_weapon","fas2_ks23") replace "knacken_blast" with any memorable word you chose. in this example we will use "custom-shotgun" and replace "fas2_ks23 with the desired weapon"
	CreateConVar("knacken_reset",60)
end

function DoorKnacken(door,dmgInfo)
	if ( door:GetClass() == "prop_door_rotating" ) then
		if ( dmgInfo:GetInflictor():GetActiveWeapon():GetClass() == GetConVarString("knacken_weapon") ) then -- replace "knacken_weapon" with "custom-weapon"
			if ( GetConVarNumber("knacken_blast") == 1 ) then
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
				if ( GetConVarNumber("knacken_reset") == 0 ) then
					return
				else
					timer.Simple(GetConVarNumber("knacken_reset"),function()
					door:SetNoDraw(false)
					door:SetSolid(SOLID_VPHYSICS)
					dFall:Remove()
					end)
				end
			end
			
			if ( GetConVarNumber("knacken_blast") == 0 ) then
				door:Fire("unlock","",0)
				door:Fire("open","",0)
			end
			
		end
	end
	
	if ( door:GetClass() == "func_door" ) then
		print("Walrus")
		if ( dmgInfo:GetInflictor():GetActiveWeapon():GetClass() == GetConVarString("knacken_weapon") ) then -- replace "knacken_weapon" with "custom-weapon"
			door:Fire("unlock","",0)
			door:Fire("open","",0)
		end
	end
	
	if ( door:GetClass() == "func_door_rotating" ) then
		if ( dmgInfo:GetInflictor():GetActiveWeapon():GetClass() == GetConVarString("knacken_weapon") ) then -- replace "knacken_weapon" with "custom-weapon"
			door:Fire("unlock","",0)
			door:Fire("open","",0)
		end
	end
	
end

hook.Add("EntityTakeDamage","SchlossKnackensShotgun",DoorKnacken)
hook.Add("Initialize","DeployConvars",DeployConvars)
```
