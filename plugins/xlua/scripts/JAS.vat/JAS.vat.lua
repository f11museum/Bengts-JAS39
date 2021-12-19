

sim_heartbeat = find_dataref("JAS/system/vat/heartbeat") 
sim_heartbeat = 100

vat_kvitt = {}    -- new array

for i=1, 5 do
	vat_kvitt[i] = {}
	for j=1, 7 do
		vat_kvitt[i][j] = 0
	end
end

vat_larm = {}    -- new array

for i=1, 5 do
	vat_larm[i] = {}
	for j=1, 7 do
		vat_larm[i][j] = 0
	end
end

sim_heartbeat = 101
-- JAS/system/vat/power	int	y	unit	Om systemet har ström
sim_power = find_dataref("JAS/system/vat/power")
-- JAS/system/vat/normsty	int	y	unit	Description
-- JAS/system/vat/luftsys	int	y	unit	Description
-- JAS/system/vat/hhp1		int	y	unit	Description
-- JAS/system/vat/hgen		int	y	unit	Description
-- JAS/system/vat/motor	int	y	unit	Description
-- JAS/system/vat/dragkr	int	y	unit	Description
-- JAS/system/vat/oljetr	int	y	unit	Description
-- 
-- JAS/system/vat/abumod	int	y	unit	Description
-- JAS/system/vat/primdat	int	y	unit	Description
-- JAS/system/vat/hydr1	int	y	unit	Description
-- JAS/system/vat/resgen	int	y	unit	Description
-- JAS/system/vat/mobrand	int	y	unit	Description
-- JAS/system/vat/apu		int	y	unit	Description
-- JAS/system/vat/apubrnd	int	y	unit	Description
-- 
-- JAS/system/vat/styrsak	int	y	unit	Description
-- JAS/system/vat/uppdrag	int	y	unit	Description
-- JAS/system/vat/hydr2	int	y	unit	Description
-- JAS/system/vat/likstrm	int	y	unit	Description
-- JAS/system/vat/landst	int	y	unit	Description
-- JAS/system/vat/bromsar	int	y	unit	Description
-- 
-- JAS/system/vat/felinfo	int	y	unit	Description
-- JAS/system/vat/dator	int	y	unit	Description
-- JAS/system/vat/brasys	int	y	unit	Description
-- JAS/system/vat/bramgd	int	y	unit	Description
sim_bramgd = find_dataref("JAS/system/vat/bramgd")
dr_bramgd_lamp = XLuaFindDataRef("JAS/system/vat/lamp/bramgd")
--dr_elv_trim = XLuaFindDataRef("sim/flightmodel/controls/elv_trim")
-- JAS/system/vat/oxykab	int	y	unit	Description
-- JAS/system/vat/huvstol	int	y	unit	Description


sim_vat_larm1 = find_dataref("JAS/system/vat/larm1")
sim_vat_larm2 = find_dataref("JAS/system/vat/larm2")
dr_vat_larm1_lamp = XLuaFindDataRef("JAS/system/vat/lamp/larm1")
dr_vat_larm2_lamp = XLuaFindDataRef("JAS/system/vat/lamp/larm2")

sim_jas_master = find_dataref("JAS/button/master")
sim_jas_lamps_master = find_dataref("JAS/lamps/master")
sim_jas_lamps_master1 = find_dataref("JAS/lamps/master1")
sim_jas_lamps_master2 = find_dataref("JAS/lamps/master2")
dr_FRP = find_dataref("sim/operation/misc/frame_rate_period")


function flight_start() 
	sim_heartbeat = 200
    
    sim_heartbeat = 299
end

function aircraft_unload()
	--XLuaSetNumber(dr_override_surfaces, 0) 
	--logMsg("EXIT LUA")
end

function do_on_exit()
	--XLuaSetNumber(dr_override_surfaces, 0) 
	--logMsg("EXIT LUA")
end

sim_FRP = 0.25
function update_dataref()
	sim_FRP = (sim_FRP*19+ dr_FRP)/20
	if sim_FRP == 0 then 
		sim_FRP = 0.25 
	end
end

blink1s = 0
blink05s = 0
blinktimer = 0
function blink1sFunc()
	sim_heartbeat = 400
	blinktimer = blinktimer + sim_FRP
	t2 = math.floor(blinktimer)
	if (t2 % 2 == 0) then
		blink1s = 1
	else 
		blink1s = 0
	end
	sim_heartbeat = 402
    t2 = math.floor(blinktimer*2)
	if (t2 % 2 == 0) then
		blink05s = 1
	else 
		blink05s = 0
	end
	sim_heartbeat = 499
end

clocktimer = 0
function lampMasterWarning()
    if ( sim_jas_lamps_master == 1) then

        if (blink05s == 1) then
			sim_jas_lamps_master1 = 1
			sim_jas_lamps_master2 = 0
        else
            sim_jas_lamps_master1 = 0
			sim_jas_lamps_master2 = 1
        end
        
    else
		sim_jas_lamps_master1 = 0
		sim_jas_lamps_master2 = 0
    end
end

function updateLarm(col, row, signal, lamp, sticky)
	if (signal >= 1) then
		vat_larm[col][row] = 1
		if (sticky == 1 and vat_kvitt[col][row] == 0) then
			vat_kvitt[col][row] = 1
		end
		if (sticky == 0) then
			vat_kvitt[col][row] = 2
		end
	else
		vat_larm[col][row] = 0
		if (vat_kvitt[col][row] >= 2) then
			vat_kvitt[col][row] = 0
		end
	end
	
	if (vat_kvitt[col][row] == 1 or vat_kvitt[col][row] == 2) then
		XLuaSetNumber(lamp, blink05s)
	elseif (vat_kvitt[col][row] == 3 and vat_larm[col][row] == 1 ) then
		XLuaSetNumber(lamp, 1)
	else
		XLuaSetNumber(lamp, 0)
	end
end

function checkLarm()
	
	updateLarm(4, 5, sim_bramgd, dr_bramgd_lamp, 1)
	updateLarm(5, 1, sim_vat_larm1, dr_vat_larm1_lamp, 0)
	sim_vat_larm1 = 0
end

function kvittera()
	if (sim_jas_master == 1) then
		for i=1, 5 do
			for j=1, 7 do
				if (vat_kvitt[i][j] == 1) then
					vat_kvitt[i][j] = 3
				end
			end
		end
	end
	aktiv = 0
	for i=1, 5 do
		for j=1, 7 do
			if (vat_kvitt[i][j] == 1) then
				aktiv+=1
			end
		end
	end
	if (aktiv >0) then
		-- blinka master varning
		sim_jas_lamps_master = 1
	end
end


heartbeat = 0
function before_physics() 
	sim_heartbeat = 300
	update_dataref()
	blink1sFunc()
	checkLarm()
	kvittera()
    
	
	sim_heartbeat = heartbeat
    heartbeat = heartbeat + 1
end

function after_physics() 	
	
end
sim_heartbeat = 199