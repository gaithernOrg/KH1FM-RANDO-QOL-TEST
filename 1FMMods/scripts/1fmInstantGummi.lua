local monstroOpen = false
local neverlandOpen = false

function _OnInit()

end

function _OnFrame()
	local selection = ReadInt(0x503CEC-0x3A0606)
	local realSelection = selection
	local realWorld = ReadByte(0x503C04-0x3A0606)
	local room = ReadShort(0x2534638-0x3A0606)
	
	if (realWorld == 17 or realWorld == 18) and not monstroOpen and room>0 then
		monstroOpen = true
		print("Monstro visited")
	end
	if (realWorld == 19 or realWorld == 20) and not neverlandOpen and room>0 then
		neverlandOpen = true
		print("Neverland visited")
	end
	if not monstroOpen and (selection == 10 or selection == 9) then
		selection = selection == 9 and 18 or 17
		--WriteInt(0x503CEC-0x3A0606, selection)
	end
	if not neverlandOpen and selection == 13 then
		selection = 19
	end
	if selection == 25 then
		selection = 15
		WriteInt(0x503CEC-0x3A0606, selection)
	end
	local curDest = ReadInt(0x5041F0-0x3A0606)
	if curDest < 40 then
		selection = selection > 20 and 0 or selection
		WriteInt(0x5041F0-0x3A0606, selection)
		WriteInt(0x503C00-0x3A0606, selection)
		WriteInt(0x2685EEC-0x3A0606, 0)
	else
		WriteInt(0x503C00-0x3A0606, realSelection)
	end
end