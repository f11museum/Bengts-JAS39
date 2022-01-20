

sim_heartbeat = find_dataref("JAS/heartbeat/vat") 
sim_heartbeat = 100

-- local sound_master = load_WAV_file(SYSTEM_DIRECTORY .. "Resources/sounds/alert/gear_warn_2.wav")  -- sound file I want to play


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
-- JAS/vat/power	int	y	unit	Om systemet har ström
sim_power = find_dataref("JAS/vat/power")

-- Alla larmsignaler och lampor i VAT:

-- JAS/vat/larm/normsty	int	y	unit	Description
-- JAS/vat/larm/luftsys	int	y	unit	Description
-- JAS/vat/larm/hhp1		int	y	unit	Description
-- JAS/vat/larm/hgen		int	y	unit	Description
sim_hgen = find_dataref("JAS/vat/larm/hgen")
-- JAS/vat/larm/motor	int	y	unit	Description
sim_motor = find_dataref("JAS/vat/larm/motor")
-- JAS/vat/larm/dragkr	int	y	unit	Description
sim_dragkr = find_dataref("JAS/vat/larm/dragkr")
-- JAS/vat/larm/oljetr	int	y	unit	Description
sim_oljetr = find_dataref("JAS/vat/larm/oljetr")
-- 
-- JAS/vat/larm/abumod	int	y	unit	Description
-- JAS/vat/larm/primdat	int	y	unit	Description
-- JAS/vat/larm/hydr1	int	y	unit	Description
sim_hydr1 = find_dataref("JAS/vat/larm/hydr1")
-- JAS/vat/larm/resgen	int	y	unit	Description
sim_resgen = find_dataref("JAS/vat/larm/resgen")
-- JAS/vat/larm/mobrand	int	y	unit	Description
sim_mobrand = find_dataref("JAS/vat/larm/mobrand")
-- JAS/vat/larm/apu		int	y	unit	Description
sim_apu = find_dataref("JAS/vat/larm/apu")
-- JAS/vat/larm/apubrnd	int	y	unit	Description
-- 
-- JAS/vat/larm/styrsak	int	y	unit	Description
sim_styrsak = find_dataref("JAS/vat/larm/styrsak")
-- JAS/vat/larm/uppdrag	int	y	unit	Description
-- JAS/vat/larm/hydr2	int	y	unit	Description
-- JAS/vat/larm/likstrm	int	y	unit	Description
sim_likstrm = find_dataref("JAS/vat/larm/likstrm")
-- JAS/vat/larm/landst	int	y	unit	Description
sim_landst = find_dataref("JAS/vat/larm/landst")
-- JAS/vat/larm/bromsar	int	y	unit	Description
sim_bromsar = find_dataref("JAS/vat/larm/bromsar")
-- 
-- JAS/vat/larm/felinfo	int	y	unit	Description
-- JAS/vat/larm/dator	int	y	unit	Description
-- JAS/vat/larm/brasys	int	y	unit	Description
sim_brasys = find_dataref("JAS/vat/larm/brasys")
-- JAS/vat/larm/bramgd	int	y	unit	Description
sim_bramgd = find_dataref("JAS/vat/larm/bramgd")
-- JAS/vat/larm/oxykab	int	y	unit	Description
-- JAS/vat/larm/huvstol	int	y	unit	Description

-- ####### Lampor i VAT
-- ####### 
-- JAS/vat/larm/normsty	int	y	unit	Description
-- JAS/vat/larm/luftsys	int	y	unit	Description
-- JAS/vat/larm/hhp1		int	y	unit	Description
-- JAS/vat/larm/hgen		int	y	unit	Description
dr_hgen_lamp = XLuaFindDataRef("JAS/io/vat/lamp/hgen")
-- JAS/vat/larm/motor	int	y	unit	Description
dr_motor_lamp = XLuaFindDataRef("JAS/io/vat/lamp/motor")
-- JAS/vat/larm/dragkr	int	y	unit	Description
dr_dragkr_lamp = XLuaFindDataRef("JAS/io/vat/lamp/dragkr")
-- JAS/vat/larm/oljetr	int	y	unit	Description
dr_oljetr_lamp = XLuaFindDataRef("JAS/io/vat/lamp/oljetr")
-- 
-- JAS/vat/larm/abumod	int	y	unit	Description
-- JAS/vat/larm/primdat	int	y	unit	Description
-- JAS/vat/larm/hydr1	int	y	unit	Description
dr_hydr1_lamp = XLuaFindDataRef("JAS/io/vat/lamp/hydr1")
-- JAS/vat/larm/resgen	int	y	unit	Description
dr_resgen_lamp = XLuaFindDataRef("JAS/io/vat/lamp/resgen")
-- JAS/vat/larm/mobrand	int	y	unit	Description
dr_mobrand_lamp = XLuaFindDataRef("JAS/io/vat/lamp/mobrand")
-- JAS/vat/larm/apu		int	y	unit	Description
dr_apu_lamp = XLuaFindDataRef("JAS/io/vat/lamp/apu")
-- JAS/vat/larm/apubrnd	int	y	unit	Description
-- 
-- JAS/vat/larm/styrsak	int	y	unit	Description
dr_styrsak_lamp = XLuaFindDataRef("JAS/io/vat/lamp/styrsak")
-- JAS/vat/larm/uppdrag	int	y	unit	Description
-- JAS/vat/larm/hydr2	int	y	unit	Description
-- JAS/vat/larm/likstrm	int	y	unit	Description
dr_likstrm_lamp = XLuaFindDataRef("JAS/io/vat/lamp/likstrm")
-- JAS/vat/larm/landst	int	y	unit	Description
dr_landst_lamp = XLuaFindDataRef("JAS/io/vat/lamp/landst")
-- JAS/vat/larm/bromsar	int	y	unit	Description
dr_bromsar_lamp = XLuaFindDataRef("JAS/io/vat/lamp/bromsar")
-- 
-- JAS/vat/larm/felinfo	int	y	unit	Description
-- JAS/vat/larm/dator	int	y	unit	Description
-- JAS/vat/larm/brasys	int	y	unit	Description
dr_brasys_lamp = XLuaFindDataRef("JAS/io/vat/lamp/brasys")
-- JAS/vat/larm/bramgd	int	y	unit	Description
dr_bramgd_lamp = XLuaFindDataRef("JAS/io/vat/lamp/bramgd")
-- JAS/vat/larm/oxykab	int	y	unit	Description
-- JAS/vat/larm/huvstol	int	y	unit	Description


-- Övriga larmsignaler
jas_sys_vat_larmmkv = find_dataref("JAS/vat/larm/larmmkv")
sim_vat_larm1 = find_dataref("JAS/vat/larm/larm1")
sim_vat_larm2 = find_dataref("JAS/vat/larm/larm2")


sim_jas_sys_test = find_dataref("JAS/io/vu22/knapp/syst")



dr_vat_larm1_lamp = XLuaFindDataRef("JAS/io/vat/lamp/larm1")
dr_vat_larm2_lamp = XLuaFindDataRef("JAS/io/vat/lamp/larm2")
dr_vat_larmmkv_lamp = XLuaFindDataRef("JAS/io/vat/lamp/streck1")

sim_jas_master = find_dataref("JAS/io/frontpanel/knapp/master")
sim_jas_lamps_master = find_dataref("JAS/system/larm/master")
sim_jas_lamps_master1 = find_dataref("JAS/io/frontpanel/lamp/master1")
sim_jas_lamps_master2 = find_dataref("JAS/io/frontpanel/lamp/master2")
dr_FRP = find_dataref("sim/operation/misc/frame_rate_period")

-- dataref från spelet för at kolla generella larm
sim_warn_eng_fire = find_dataref("sim/cockpit/warnings/annunciators/engine_fire")
sim_warn_fuel_press = find_dataref("sim/cockpit/warnings/annunciators/fuel_pressure")
sim_warn_hyd_press = find_dataref("sim/cockpit/warnings/annunciators/hydraulic_pressure")
sim_warn_low_volt = find_dataref("sim/cockpit/warnings/annunciators/low_voltage")
sim_warn_oil_press = find_dataref("sim/cockpit/warnings/annunciators/oil_pressure")
sim_apu_n1 = find_dataref("sim/cockpit2/electrical/APU_N1_percent")

sim_apu_amps = find_dataref("sim/cockpit2/electrical/APU_generator_amps")

sim_warn_generator_off = find_dataref("sim/cockpit/warnings/annunciators/generator_off")

sim_engine_n1 = find_dataref("sim/flightmodel2/engines/N1_percent")




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
		if (sticky == 0 and vat_kvitt[col][row] ~= 3) then
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
	sim_heartbeat = 500
	updateLarm(1, 4, sim_hgen, dr_hgen_lamp, 1)
	updateLarm(1, 5, sim_motor, dr_motor_lamp, 1)
	updateLarm(1, 6, sim_dragkr, dr_dragkr_lamp, 0)
	updateLarm(1, 7, sim_oljetr, dr_oljetr_lamp, 1)
	sim_heartbeat = 501
	updateLarm(2, 3, sim_hydr1, dr_hydr1_lamp, 1)
	updateLarm(2, 4, sim_resgen, dr_resgen_lamp, 1)
	updateLarm(2, 5, sim_mobrand, dr_mobrand_lamp, 1)
	updateLarm(2, 6, sim_apu, dr_apu_lamp, 1)
	sim_heartbeat = 502
	updateLarm(3, 1, sim_styrsak, dr_styrsak_lamp, 1)
	updateLarm(3, 4, sim_likstrm, dr_likstrm_lamp, 1)
	updateLarm(3, 5, sim_landst, dr_landst_lamp, 0)
	updateLarm(3, 6, sim_bromsar, dr_bromsar_lamp, 0)
	sim_heartbeat = 503
	updateLarm(4, 4, sim_brasys, dr_brasys_lamp, 1)
	updateLarm(4, 5, sim_bramgd, dr_bramgd_lamp, 1)
	sim_heartbeat = 504
	updateLarm(5, 1, sim_vat_larm1, dr_vat_larm1_lamp, 0)
	updateLarm(5, 2, sim_vat_larm2, dr_vat_larm2_lamp, 0)
	updateLarm(5, 3, jas_sys_vat_larmmkv, dr_vat_larmmkv_lamp, 0)
	sim_heartbeat = 505
	sim_vat_larm1 = 0
end

function kvittera()
	if (sim_jas_master == 1) then
		for i=1, 5 do
			for j=1, 7 do
				if (vat_kvitt[i][j] == 1 or vat_kvitt[i][j] == 2) then
					vat_kvitt[i][j] = 3
				end
			end
		end
	end
	aktiv = 0
	for i=1, 5 do
		for j=1, 7 do
			if (vat_kvitt[i][j] == 1 or vat_kvitt[i][j] == 2) then
				aktiv=aktiv + 1
			end
		end
	end
	if (aktiv >0) then
		-- blinka master varning
		sim_jas_lamps_master = 1
		
	else
		sim_jas_lamps_master = 0
	end
end

function kvitteraStart()
	sim_jas_master = 1
	 kvittera()
end

function larm()
	sim_hgen = sim_warn_generator_off[0]
	
	sim_mobrand = sim_warn_eng_fire
	sim_oljetr = sim_warn_oil_press
	sim_hydr1 = sim_warn_hyd_press
	sim_likstrm = sim_warn_low_volt
	
	
	if (sim_apu_amps<1) then
		sim_resgen = 1
	else 
		sim_resgen = 0
	end
	if (sim_apu_n1>90) then
		sim_apu = 0
	else 
		sim_apu = 1
	end
	
	if (sim_engine_n1[0]<16) then
		sim_motor = 1
	else 
		sim_motor = 0
	end
	
end

sys_test_counter = 0
function systest()
	if (sim_jas_sys_test == 1) then
		sys_test_counter = sys_test_counter +sim_FRP
		time1 = math.floor(sys_test_counter)
		if (time1 == 0) then
			
			XLuaSetNumber(dr_hgen_lamp, 1)
			XLuaSetNumber(dr_resgen_lamp, 0)
			XLuaSetNumber(dr_likstrm_lamp, 0)
			XLuaSetNumber(dr_brasys_lamp, 0)
		end
		if (time1 == 1) then
			XLuaSetNumber(dr_hgen_lamp, 0)
			XLuaSetNumber(dr_resgen_lamp, 1)
			XLuaSetNumber(dr_likstrm_lamp, 0)
			XLuaSetNumber(dr_brasys_lamp, 0)
		end
		if (time1 == 2) then
			XLuaSetNumber(dr_hgen_lamp, 0)
			XLuaSetNumber(dr_resgen_lamp, 0)
			XLuaSetNumber(dr_likstrm_lamp, 1)
			XLuaSetNumber(dr_brasys_lamp, 0)
			
		end
		if (time1 == 3) then
			XLuaSetNumber(dr_hgen_lamp, 0)
			XLuaSetNumber(dr_resgen_lamp, 0)
			XLuaSetNumber(dr_likstrm_lamp, 0)
			XLuaSetNumber(dr_brasys_lamp, 1)
		end
		if (time1 >= 4) then
			sys_test_counter = 0
		end
	end
end

heartbeat = 0
function before_physics() 
	sim_heartbeat = 300
	update_dataref()
	blink1sFunc()
	sim_heartbeat = 301
	larm()
	sim_heartbeat = 302
	checkLarm()
	sim_heartbeat = 303
	kvittera()
	sim_heartbeat = 304
	lampMasterWarning()
	sim_heartbeat = 305
	-- 
	
	systest()
	sim_heartbeat = heartbeat
    heartbeat = heartbeat + 1
end

function after_physics() 	
	
end

function flight_start() 
	sim_heartbeat = 200
    run_after_time(kvitteraStart, 2)
    sim_heartbeat = 299
end
sim_heartbeat = 199