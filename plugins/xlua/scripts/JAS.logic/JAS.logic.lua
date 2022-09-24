-------------------------------------------------------
---- Hjälp system för JAS
---- F11 Museum 2021 Bengt
-------------------------------------------------------


-- Datareffar
XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 100)
XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 101)
dr_status = XLuaFindDataRef("JAS/system/logic/heartbeat") 

sim_heartbeat = find_dataref("JAS/system/logic/heartbeat") 

XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 102)

dr_override_flightcontrol = XLuaFindDataRef("sim/operation/override/override_flightcontrol") 
dr_override_surfaces = XLuaFindDataRef("sim/operation/override/override_control_surfaces") 
dr_FRP = XLuaFindDataRef("sim/operation/misc/frame_rate_period")

-- input från användaren
dr_yoke_roll_ratio = XLuaFindDataRef("sim/joystick/yoke_roll_ratio") 
dr_yoke_heading_ratio = XLuaFindDataRef("sim/joystick/yoke_heading_ratio") 
dr_yoke_pitch_ratio = XLuaFindDataRef("sim/joystick/yoke_pitch_ratio") 
dr_elv_trim = XLuaFindDataRef("sim/flightmodel/controls/elv_trim") 


XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 103)

dr_acf_pitch = XLuaFindDataRef("sim/flightmodel/position/theta") 
dr_acf_roll = XLuaFindDataRef("sim/flightmodel/position/phi") 
dr_acf_hdg = XLuaFindDataRef("sim/flightmodel/position/psi") 
dr_acf_truehdg = find_dataref("sim/flightmodel/position/true_psi") 
dr_acf_rollrate = XLuaFindDataRef("sim/flightmodel/position/P") 
dr_acf_pitchrate = XLuaFindDataRef("sim/flightmodel/position/Q") 
dr_acf_yawrate = XLuaFindDataRef("sim/flightmodel/position/R") 
dr_acf_rollrate_acc = XLuaFindDataRef("sim/flightmodel/position/P_dot") 
dr_acf_pitchrate_acc = XLuaFindDataRef("sim/flightmodel/position/Q_dot") 
dr_acf_yawrate_acc = XLuaFindDataRef("sim/flightmodel/position/R_dot") 
dr_acf_vx = XLuaFindDataRef("sim/flightmodel/position/local_vx") 
dr_acf_vy = XLuaFindDataRef("sim/flightmodel/position/local_vy") 
dr_acf_vz = XLuaFindDataRef("sim/flightmodel/position/local_vz") 
dr_lat = find_dataref("sim/flightmodel/position/latitude") 
dr_lon = find_dataref("sim/flightmodel/position/longitude") 
dr_alt = find_dataref("sim/flightmodel/position/elevation") 

XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 104)
dr_alpha = XLuaFindDataRef("sim/flightmodel/position/alpha") 
dr_g_nrml = XLuaFindDataRef("sim/flightmodel/forces/g_nrml") 


dr_N1 = XLuaFindDataRef("sim/flightmodel/engine/ENGN_N1_[0]")
dr_braking_ratio = XLuaFindDataRef("sim/cockpit2/controls/parking_brake_ratio")
dr_braking_ratio_right = XLuaFindDataRef("sim/cockpit2/controls/right_brake_ratio")
dr_braking_ratio_left = XLuaFindDataRef("sim/cockpit2/controls/left_brake_ratio")
dr_speedbrake_ratio = XLuaFindDataRef("sim/cockpit2/controls/speedbrake_ratio")


XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 105)

dr_nose_gear_depress = XLuaFindDataRef("sim/flightmodel/parts/tire_vrt_def_veh[0]") 
dr_left_gear_depress = XLuaFindDataRef("sim/flightmodel/parts/tire_vrt_def_veh[1]") 
dr_right_gear_depress = XLuaFindDataRef("sim/flightmodel/parts/tire_vrt_def_veh[2]") 

dr_airspeed_kts_pilot = XLuaFindDataRef("sim/flightmodel/position/indicated_airspeed") 
dr_gear = XLuaFindDataRef("sim/cockpit/switches/gear_handle_status") 

XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 106)
dr_altitude = XLuaFindDataRef("sim/flightmodel/misc/h_ind") 

dr_master_caution = XLuaFindDataRef("sim/cockpit2/annunciators/master_caution")
dr_master_warning = XLuaFindDataRef("sim/cockpit2/annunciators/master_warning")
dr_gear_warning = XLuaFindDataRef("sim/cockpit2/annunciators/gear_warning")


sim_fuel1 = find_dataref("sim/flightmodel/weight/m_fuel_total")
-- Egna JAS dataref

XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 110)

sim_jas_system_ess_power = find_dataref("JAS/system/ess/power")
sim_jas_system_ess_startup = find_dataref("JAS/system/ess/startup")

sim_jas_sys_test = find_dataref("JAS/io/vu22/knapp/syst")

sim_jas_button_lt_kran = find_dataref("JAS/io/vu22/knapp/ltbra")
sim_jas_button_hstrom = find_dataref("JAS/io/vu22/knapp/hstrom")
sim_jas_button_ess = find_dataref("JAS/io/vu22/knapp/ess")
sim_jas_button_apu = find_dataref("JAS/io/vu22/knapp/apu")

sim_jas_button_lt_kran_io = find_dataref("JAS/io/vu22/di/ltbra")
sim_jas_button_hstrom_io = find_dataref("JAS/io/vu22/di/hstrom")
sim_jas_button_ess_io = find_dataref("JAS/io/vu22/di/ess")
sim_jas_button_apu_io = find_dataref("JAS/io/vu22/di/apu")

sim_jas_button_start = find_dataref("JAS/io/frontpanel/knapp/start")

sim_jas_vu22_falltank = find_dataref("JAS/io/vu22/knapp/falltank")

XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 111)
sim_jas_lamps_spak = find_dataref("JAS/io/frontpanel/lamp/spak")
sim_jas_lamps_att = find_dataref("JAS/io/frontpanel/lamp/att")
sim_jas_lamps_hojd = find_dataref("JAS/io/frontpanel/lamp/hojd")
sim_jas_lamps_afk = find_dataref("JAS/io/frontpanel/lamp/afk")
sim_jas_lamps_airbrake = find_dataref("JAS/io/frontpanel/lamp/airbrake")
--sim_jas_lamps_gears = find_dataref("JAS/lamps/gears")
sim_jas_lamps_master = find_dataref("JAS/system/larm/master")
sim_jas_lamps_master1 = find_dataref("JAS/io/frontpanel/lamp/master1")
sim_jas_lamps_master2 = find_dataref("JAS/io/frontpanel/lamp/master2")
sim_jas_lamps_apu_gar = find_dataref("JAS/io/vu22/lamp/apugar")
sim_jas_lamps_apu_red = find_dataref("JAS/io/vu22/lamp/apured")

jas_ti_land_lat = find_dataref("JAS/ti/land/lat")
jas_ti_land_lon = find_dataref("JAS/ti/land/lon")
jas_ti_land_alt = find_dataref("JAS/ti/land/alt")
jas_ti_land_head = find_dataref("JAS/ti/land/head")
jas_ti_land_lmod = find_dataref("JAS/ti/land/lmod")
jas_ti_land_bear = find_dataref("JAS/ti/land/bearing")
jas_ti_land_dist = find_dataref("JAS/ti/land/dist")
jas_ti_menu_currentmenu = find_dataref("JAS/ti/menu/menu")

d_land = create_dataref("JAS/ti/land/debug", "number")

jas_si_nav_prickx = find_dataref("JAS/si/nav/prick_x")
jas_si_nav_pricky = find_dataref("JAS/si/nav/prick_y")
jas_si_nav_prickactive = find_dataref("JAS/si/nav/prick_active")
jas_si_nav_heading = find_dataref("JAS/si/nav/heading")
jas_si_nav_banax = find_dataref("JAS/si/nav/bana_x")
jas_si_nav_banay = find_dataref("JAS/si/nav/bana_y")
jas_si_nav_lat = find_dataref("JAS/si/nav/lat")
jas_si_nav_lon = find_dataref("JAS/si/nav/lon")
jas_si_nav_bearing = find_dataref("JAS/si/nav/bearing")
jas_si_nav_alt = find_dataref("JAS/si/nav/alt")
jas_si_nav_course = find_dataref("JAS/si/nav/course")


jas_auto_afk_mode = find_dataref("JAS/autopilot/afk_mode")
jas_auto_afk = find_dataref("JAS/autopilot/afk")
-- Oanvända i vu22

sim_jas_vu22_sand = find_dataref("JAS/io/vu22/knapp/sand")
sim_jas_vu22_rhm = find_dataref("JAS/io/vu22/knapp/rhm")
sim_jas_vu22_mkv = find_dataref("JAS/io/vu22/knapp/mkv")
sim_jas_vu22_tb = find_dataref("JAS/io/vu22/knapp/termbatt")

sim_jas_vu22_vapensim = find_dataref("JAS/io/vu22/knapp/vapensim")

sim_jas_vu22_lamp_sand = find_dataref("JAS/io/vu22/lamp/sand")
sim_jas_vu22_lamp_rhm = find_dataref("JAS/io/vu22/lamp/rhm")
sim_jas_vu22_lamp_mkv = find_dataref("JAS/io/vu22/lamp/mkv")
sim_jas_vu22_lamp_tb = find_dataref("JAS/io/vu22/lamp/termbatt")
--dap

sim_jas_system_dap_power = find_dataref("JAS/system/dap/power")
sim_jas_system_dap_startup = find_dataref("JAS/system/dap/startup")
sim_jas_system_dap_pluv = find_dataref("JAS/system/dap/lamp/pluv")

-- motmedel
sim_jas_system_mot_fack = find_dataref("JAS/system/mot/fack")
sim_jas_system_mot_rems = find_dataref("JAS/system/mot/rems")


XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 112)
sim_jas_auto_mode = find_dataref("JAS/autopilot/mode")
dr_jas_auto_att = XLuaFindDataRef("JAS/autopilot/att")
dr_jas_auto_alt = XLuaFindDataRef("JAS/autopilot/alt")


sim_apu_power = find_dataref("JAS/system/apu/power")
sim_vat_power = find_dataref("JAS/vat/power")
sim_vat_larm1 = find_dataref("JAS/vat/larm/larm1")

jas_lampprov_p1 = find_dataref("JAS/lampprov/p1")
jas_io_vu22_knapp_lampprov = find_dataref("JAS/io/vu22/knapp/lampprov")
sim_systprov = find_dataref("JAS/io/vu22/knapp/syst")

sim_vu22_lamp_apubrand = find_dataref("JAS/io/vu22/lamp/apubrand")
--JAS/vu22/lamp/apugar	int	y	unit	M25
sim_vu22_lamp_apugar = find_dataref("JAS/io/vu22/lamp/apugar")
--JAS/vu22/lamp/apured	int	y	unit	M26
sim_vu22_lamp_apured = find_dataref("JAS/io/vu22/lamp/apured")
--/vu22/lamp/termbatt	int	y	unit	M27
sim_vu22_lamp_termbatt = find_dataref("JAS/io/vu22/lamp/termbatt")
--JAS/vu22/lamp/sand		int	y	unit	M28
sim_vu22_lamp_sand = find_dataref("JAS/io/vu22/lamp/sand")
--JAS/vu22/lamp/rhm		int	y	unit	M29
sim_vu22_lamp_rhm = find_dataref("JAS/io/vu22/lamp/rhm")
--JAS/vu22/lamp/mkv		int	y	unit	M30
sim_vu22_lamp_mkv = find_dataref("JAS/io/vu22/lamp/mkv")
--JAS/vu22/lamp/belysning	int	y	unit	M31
--sim_vu22_lamp_belysning = find_dataref("JAS/vu22/lamp/belysning")

sim_jas_override_vu22 = XLuaFindDataRef("JAS/vu22/override/knappar")
sim_jas_override_frontpanel = XLuaFindDataRef("JAS/frontpanel/override/knappar")


XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 120)
dr_fog = XLuaFindDataRef("sim/private/controls/fog/fog_be_gone")
dr_cloud_shadow = XLuaFindDataRef("sim/private/controls/clouds/cloud_shadow_lighten_ratio")

dr_baro_set = XLuaFindDataRef("sim/cockpit/misc/barometer_setting")
dr_baro_current = XLuaFindDataRef("sim/weather/barometer_sealevel_inhg")

dr_fuel1 =  XLuaFindDataRef("sim/flightmodel/weight/m_fuel1")
dr_fuel2 =  XLuaFindDataRef("sim/flightmodel/weight/m_fuel[0]")
dr_payload =  XLuaFindDataRef("sim/flightmodel/weight/m_fixed")

sim_apu_n1 = find_dataref("sim/cockpit2/electrical/APU_N1_percent")
sim_engine_n1 = find_dataref("sim/flightmodel2/engines/N1_percent")
sim_battery_on = find_dataref("sim/cockpit2/electrical/battery_on")
sim_power_bus_volt = find_dataref("sim/cockpit2/electrical/bus_volts")
sim_fuel_tank_pump = find_dataref("sim/cockpit2/fuel/fuel_tank_pump_on")
sim_fuel_pump = find_dataref("sim/cockpit/engine/fuel_pump_on")

sim_knapparfunkar = find_dataref("JAS/knapparfunkar")

sim_fuel = find_dataref("sim/flightmodel/weight/m_fuel1")


-- Kommandon
simCMD_apu_start = find_command("sim/electrical/APU_start")
simCMD_apu_off = find_command("sim/electrical/APU_off")
simCMD_apu_gen_on = find_command("sim/electrical/APU_generator_on")
simCMD_apu_gen_off = find_command("sim/electrical/APU_generator_off")

simCMD_apu_bleed_air = find_command("sim/bleed_air/bleed_air_apu")

simCMD_gen_on = find_command("sim/electrical/generator_1_on")
simCMD_gen_off = find_command("sim/electrical/generator_1_off")

simCMD_engine_starter = find_command("sim/engines/engage_starters")


simCMD_flare = find_command("sim/weapons/deploy_flares")
simCMD_chaff = find_command("sim/weapons/deploy_chaff")
simCMD_drop_tank = find_command("sim/flight_controls/drop_tank")

simCMD_reset_flight = find_command("sim/operation/reset_flight")

-- publika variabler

g_groundContact = 0

-- Plugin funktioner
XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 104)
function flight_start() 
	XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 201)
	
		
	
	XLuaSetNumber(dr_fuel1, 2200)
	XLuaSetNumber(dr_fuel2, 2200)
	XLuaSetNumber(dr_payload, 0) 
	--XLuaSetNumber(dr_fuel2, 1600) 
	--XLuaSetNumber(dr_override_surfaces, 1) 
	XLuaSetNumber(XLuaFindDataRef("sim/joystick/eq_pfc_yoke"), 1) -- ta bort krysset som dyker upp om man inte har joystick
	
	--clouds = XLuaFindDataRef("sim/private/controls/skyc/white_out_in_clouds")
	--XLuaSetNumber(clouds, 0)
	--logMsg("Flight started with LUA")
	XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 299)
	
	-- Set alla knappar på om knappar inte funkar
	if (sim_knapparfunkar == 0) then
		sim_jas_button_lt_kran_io = 1
		sim_jas_button_hstrom_io = 1
		sim_jas_button_ess_io = 1
		--sim_jas_button_start = 1
		sim_jas_button_apu_io = 1
	end
end

function aircraft_unload()
	--XLuaSetNumber(dr_override_surfaces, 0) 
	--logMsg("EXIT LUA")
end

function do_on_exit()
	--XLuaSetNumber(dr_override_surfaces, 0) 
	--logMsg("EXIT LUA")
end


-- Hjälpfunktioner

function constrain(val, lower, upper)

    if lower > upper then 
        lower, upper = upper, lower 
    end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

function interpolate(x1, y1, x2, y2, value)
	y = y1 + (y2-y1)/(x2-x1)*(value-x1)
	return y
end
function myfilter(currentValue, newValue, amp)
	if (currentValue ~= currentValue) then
		print("is nan!!")
		currentValue = 0
	end
	if (newValue ~= newValue) then
		print("is nan!!")
		newValue = 0
	end
	return ((currentValue*amp) + (newValue))/(amp+1)
	
end

blink1s = 0
blinktimer = 0
function blink1sFunc()
	blinktimer = blinktimer + sim_FRP
	t2 = math.floor(blinktimer)
	if (t2 % 2 == 0) then
		blink1s = 1
	else 
		blink1s = 0
	end
end
-- function myGetAlpha() 
-- 
--  	vx = sim_acf_vx
-- 	vy = sim_acf_vy
-- 	vz = sim_acf_vz
-- 	pitch = sim_pitch
-- 
-- 	length = math.sqrt(vy * vy + vx * vx + vz * vz)
-- 	if (length > 1.0) then
-- 		alpha = math.asin(vy / length)
-- 		alpha = pitch - math.deg(alpha)
-- 		return alpha
-- 	else 
-- 		return 0.0
-- 	end
-- end
-- 
-- function myGetFlightAngle() 
-- 
-- 	vx = sim_acf_vx
-- 	vy = sim_acf_vy
-- 	vz = sim_acf_vz
-- 	pitch = sim_pitch
-- 
-- 	length = math.sqrt(vy * vy + vx * vx + vz * vz)
-- 	if (length > 1.0) then
-- 		angle = math.asin(vy / length)
-- 		return math.deg(angle)
-- 	else 
-- 		return 0.0
-- 	end
-- end

-- Våra program funktioner
sim_FRP = 1
function update_dataref()
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 401)
	local getnumber = XLuaGetNumber


	sim_pitch = getnumber(dr_acf_pitch)

	sim_acf_vx = getnumber(dr_acf_vx)
	sim_acf_vy = getnumber(dr_acf_vy)
	sim_acf_vz = getnumber(dr_acf_vz)
	-- sim_acf_flight_angle = myGetFlightAngle()
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 402)
	sim_left_gear_depress = getnumber(dr_left_gear_depress)
	sim_right_gear_depress = getnumber(dr_right_gear_depress)
	sim_nose_gear_depress = getnumber(dr_nose_gear_depress)
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 403)
	sim_speedbrake_ratio = getnumber(dr_speedbrake_ratio)
	-- sim_braking_ratio = getnumber(dr_braking_ratio)
	-- sim_braking_ratio_left = getnumber(dr_braking_ratio_left)
	-- sim_braking_ratio_right = getnumber(dr_braking_ratio_right)
	-- sim_airspeed_kts_pilot = getnumber(dr_airspeed_kts_pilot)
	-- sim_gear = getnumber(dr_gear)
	-- sim_altitude = getnumber(dr_altitude)
    
    sim_master_caution = getnumber(dr_master_caution)
    sim_master_warning = getnumber(dr_master_warning)
    sim_gear_warning = getnumber(dr_gear_warning)
	
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 404)
	
	
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 405)
	
	-- sim_jas_auto_mode = getnumber(dr_jas_auto_mode)
	sim_jas_auto_alt = getnumber(dr_jas_auto_alt)
	sim_jas_auto_att = getnumber(dr_jas_auto_att)
	
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 406)
	sim_FRP = (sim_FRP*19+ getnumber(dr_FRP))/20
	if sim_FRP == 0 then 
		sim_FRP = 1 
	end
	
	-- sim_true_alpha = myGetAlpha()
	
	if (sim_nose_gear_depress) > 0 then 
		g_groundContact = 1 
	else 
		g_groundContact = 0 
	end
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 407)
	XLuaSetNumber(dr_fog, 0.1) 
	XLuaSetNumber(dr_cloud_shadow, 1.0) 
	
	XLuaSetNumber(dr_baro_set, getnumber(dr_baro_current)) 
	
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 408)
	glasdarkness =  XLuaFindDataRef("HUDplug/glass_darkness")
	light_attenuation = getnumber(XLuaFindDataRef("sim/graphics/misc/light_attenuation"))
	darkness = interpolate(0.3, 0.5, 0.8, 0.0, light_attenuation )
	if (light_attenuation>= 1.0) then
		darkness = 0.5 -- x-plane 12
	end
	XLuaSetNumber(glasdarkness, darkness) 
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 499)
end




function lampAirbrake()

    if (sim_speedbrake_ratio > 0) then
		sim_jas_lamps_airbrake = 1
    else
		sim_jas_lamps_airbrake = 0
	end
end


function lampMasterWarning()
    if ( (sim_master_caution > 0) or (sim_master_warning > 0) or (sim_gear_warning > 0)) then
        sim_vat_larm1 = 1

    end
end

function lampAPUGar()
	if (sim_apu_n1>99) then
		sim_jas_lamps_apu_gar = 1
		sim_jas_lamps_apu_red = 0
	else
		sim_jas_lamps_apu_gar = 0
		if(sim_jas_button_apu == 1) then
			sim_jas_lamps_apu_red = 1
		end
	end
end

apu_state = 0
function buttonAPU()
	if (sim_fuel1 <1 or sim_jas_button_lt_kran == 0) then
		simCMD_apu_off:once()
	else
	    if (sim_jas_button_apu == 1) then
	        if (apu_state == 0) then
	            -- start apu
	            simCMD_apu_start:start()
	            simCMD_apu_bleed_air:once()
				
	            apu_state = 1
	        end
	    end
	    if (sim_jas_button_apu == 0) then
	        if (apu_state == 1) then
	            simCMD_apu_start:stop()
	            -- stop apu
	            simCMD_apu_off:once()
	            apu_state = 0
	        end
	    end
	end
end

power_state = 0
function buttonPower()
	sim_battery_on[0] = sim_jas_button_hstrom
    if (sim_jas_button_hstrom == 1) then
		if (power_state == 0) then
			power_state = 1
        	simCMD_apu_gen_on:once()
			simCMD_gen_on:once()
		end
    else
		if (power_state == 1) then
			power_state = 0
			simCMD_apu_gen_off:once()
			simCMD_gen_off:once()
		end
	end
end

start_state = 0
function buttonStart()
    if (sim_jas_button_start == 1) then
		if (start_state == 0) then
			start_state = 1
			simCMD_apu_bleed_air:once()
			simCMD_engine_starter:start()
		end
	else
		
		if (start_state == 1) then
			start_state = 0
			simCMD_engine_starter:stop()
		end
	end
end


function buttonLTKran()
    if (sim_jas_button_lt_kran == 1) then
		sim_fuel_tank_pump[0] = 1
		sim_fuel_pump[0] = 1
	else
		sim_fuel_tank_pump[0] = 0
		sim_fuel_pump[0] = 0
		
	end
end

knapp = 0
function update_buttons()
    knapp = 0
    buttonAPU()
    buttonPower()
    buttonStart()
    buttonLTKran()
    
	if (sim_jas_vu22_falltank == 1) then
		simCMD_drop_tank:once()
	end
    
end

ess_uppstart = 1
function sysESS()
	if (sim_jas_button_ess == 1 and sim_power_bus_volt[0]>20) then
		sim_jas_system_ess_power = 1
		if (ess_uppstart == 0) then
			ess_uppstart = 1
			sim_jas_auto_mode = 4
			sim_jas_system_ess_startup = 1
		end
		if (sim_jas_system_ess_startup == 1 and sim_jas_auto_mode == 4) then
			
			sim_jas_lamps_spak = blink1s
			sim_jas_lamps_att = blink1s
			sim_jas_lamps_hojd = blink1s
		
		end
		if (sim_jas_sys_test == 1) then
			sim_jas_system_ess_startup = 0
		end
	else
		ess_uppstart = 0
		sim_jas_system_ess_power = 0
		sim_jas_lamps_spak = 0
		sim_jas_lamps_att = 0
		sim_jas_lamps_hojd = 0
		sim_jas_lamps_afk = 0
	end
	
end


flare = 0.0
chaff = 0.0

function sysDAP()
	if (sim_power_bus_volt[0]>20) then
		sim_vat_power = 1
		sim_jas_system_dap_power = 1
		sim_jas_system_dap_startup = sim_jas_system_dap_startup + (sim_FRP*1000)
		if (sim_jas_system_dap_startup > 1000*10) then
			sim_jas_system_dap_pluv = 1
		else
			sim_jas_system_dap_pluv = 0
		end
	else
		sim_vat_power = 0
		sim_jas_system_dap_power = 0
		sim_jas_system_dap_startup = 0
		sim_jas_system_dap_pluv = 0
	end
	
	if (flare >0) then
		flare = flare - sim_FRP
		simCMD_flare:stop()
	end
	if (chaff == 1) then
		chaff = 0
		simCMD_chaff:stop()
	end
	if (sim_jas_system_mot_fack == 1 and flare <=0) then
		simCMD_flare:start()
		flare = 0.25
	end
	if (sim_jas_system_mot_rems == 1) then
		simCMD_chaff:start()
		chaff = 1
	end
end


function vu22()

	sim_heartbeat = 500

	if jas_io_vu22_knapp_lampprov == 1 then
		jas_lampprov_p1 = 1
	else
		jas_lampprov_p1 = 0
	end

	sim_heartbeat = 501
	
end

kn11 = 0
function fusk()
	kn2 = 0
	if (sim_jas_vu22_rhm == 1) then
		kn2 = 1
		if (kn11 == 0) then
			kn11 = 1
			sim_jas_auto_mode = 5
			jas_ti_menu_currentmenu = 3
			jas_auto_afk_mode = 1
			jas_auto_afk = 1
		end
	end
	if (sim_jas_vu22_vapensim == 1) then
		
		
		if (sim_jas_vu22_sand == 1) then
			kn2 = 1
			if (kn11 == 0) then
				kn11 = 1
				sim_fuel = 2200
			end
		end
		if (sim_jas_vu22_rhm == 1) then
			kn2 = 1
			if (kn11 == 0) then
				kn11 = 1
				sim_jas_auto_mode = 5
				jas_ti_menu_currentmenu = 3
				jas_auto_afk_mode = 1
				jas_auto_afk = 1
			end
		end
		if (sim_jas_vu22_mkv == 1) then
			kn2 = 1
			if (kn11 == 0) then
				kn11 = 1
				
			end
		end
		if (sim_jas_vu22_tb == 1) then
			kn2 = 1
			if (kn11 == 0) then
				kn11 = 1
				simCMD_reset_flight:once()
			end
		end
		
	end
	if (kn2 == 0) then
		kn11 = 0
	end
end

sys_test_counter = 0
function systest()
	if (sim_jas_sys_test == 1) then
		sim_knapparfunkar = 1
		sys_test_counter = sys_test_counter +sim_FRP
		time1 = math.floor(sys_test_counter)
		if (time1 == 0) then
			sim_jas_lamps_master1 = 1
			sim_jas_lamps_master2 = 0
			sim_jas_lamps_airbrake = 0
		end
		if (time1 == 1) then
			sim_jas_lamps_master1 = 0
			sim_jas_lamps_master2 = 1
			sim_jas_lamps_airbrake = 0
		end
		if (time1 == 2) then
			sim_jas_lamps_master1 = 0
			sim_jas_lamps_master2 = 0
			sim_jas_lamps_airbrake = 1
			
		end
		if (time1 == 3) then
			sim_jas_lamps_master1 = 1
			sim_jas_lamps_master2 = 1
			sim_jas_lamps_airbrake = 1
		end
		if (time1 >= 4) then
			sys_test_counter = 0
		end
	end
end

function distance(lat, long, lat22, long22)
	sim_heartbeat = 810
	lat1 = math.rad(lat)
	-- sim_heartbeat = 8001
	long1 = math.rad(long)
	-- sim_heartbeat = 8002
		
	lat2 = math.rad(lat22)
	-- sim_heartbeat = 8003
	long2 = math.rad(long22)
	-- sim_heartbeat = 8004
	dlong = long2 - long1
	-- sim_heartbeat = 8005
	dlat = lat2 - lat1
	-- sim_heartbeat = 8006
	ans = math.pow(math.sin(dlat / 2), 2) + math.cos(lat1) * math.cos(lat2) * math.pow(math.sin(dlong / 2), 2)
	-- sim_heartbeat = 8007
	ans = 2 * math.asin(math.sqrt(ans))
	-- sim_heartbeat = 8008
	R = 6371000
	ans = ans * R
	sim_heartbeat = 8009
	return ans
end

function bearing(dlat, dlon, dlat2, dlon2)
	lat = math.rad(dlat)
	lon = math.rad(dlon)
	lat2 = math.rad(dlat2)
	lon2 = math.rad(dlon2)
	y =  math.sin( lon2-lon) *  math.cos( lat2)
	x =  math.cos( lat)*  math.sin( lat2) -  math.sin( lat) *  math.cos( lat2) *  math.cos( lon2-lon)
	brng = math.atan2(y,x)
	brng = math.deg(brng)
	if (brng < 0) then
		brng = brng + 360
	end
	return brng

end

function gpsAddDistance(latitude, longitude, dist, heading)
	-- sim_heartbeat = 1700
	r_earth = 6371000
	heading_rad = math.rad(heading)
	dy = math.cos(heading_rad) * dist
	dx = math.sin(heading_rad) * dist
	-- sim_heartbeat = 1701
	new_latitude  = latitude  + (dy / r_earth) * (180 / math.pi);
	new_longitude = longitude + (dx / r_earth) * (180 / math.pi) / math.cos(latitude * math.pi/180);
	-- sim_heartbeat = 1702
	return new_latitude, new_longitude
end

function fix180(input)
	if (input <-180) then
		input = input +360
	end
	if (input >180) then
		input = input -360
	end	
	return input
end

d_debug2 = create_dataref("JAS/ti/land/debug2", "number")
d_debug3 = create_dataref("JAS/ti/land/debug3", "number")
d_debug4 = create_dataref("JAS/ti/land/debug4", "number")
prickx_filter = 0

function landingprick()
	sim_heartbeat = 1101
	
	jas_si_nav_prickactive = 0
	if (jas_ti_menu_currentmenu == 3) then
		-- target_l* flyttar vi med if satser för att skapa inflygningsbanor
		-- 23 graders kon för simpelt system
		target_bearing =  bearing(dr_lat, dr_lon, jas_ti_land_lat, jas_ti_land_lon)
		ang = jas_ti_land_head - target_bearing
		if (ang <-180) then
			ang = ang +360
		end
		if (ang >180) then
			ang = ang -360
		end
		d_debug2 = ang
		
		
		utanfor = 0
		if (jas_ti_land_lmod == 1) then
			-- GS kort inflygning
			ring_dist = 10000
		else 
			-- IP
			ring_dist = 20000
		end
		if (ang >23 or ang <-23) then
			sidkurs = 23
			if (ang<0) then
				sidkurs = 23
			else
				sidkurs = -23
			end
			target_lat, target_lon = gpsAddDistance(jas_ti_land_lat ,jas_ti_land_lon, ring_dist, jas_ti_land_head+180+sidkurs)
			jas_si_nav_course = jas_ti_land_head+180
			utanfor = 1
		else
			target_lat, target_lon = gpsAddDistance(jas_ti_land_lat ,jas_ti_land_lon, 0, 0)
			jas_si_nav_course = jas_ti_land_head
		end
		
		jas_si_nav_lat = target_lat
		jas_si_nav_lon = target_lon
		
		d_land = 1
		-- Vi behöver alltid räkna ut avståndet till vald flygplats för annan instrumentering också
		jas_ti_land_dist = distance(jas_ti_land_lat, jas_ti_land_lon, dr_lat, dr_lon)
		--Prick Y
		--triangel sett från sidan med 3.0 grader inflygningsvinkel
		--		     /|
		--		  c / | a
		--		   /  |
		--        /   |
		--    <3.0-----
		--          b
		-- d_land = 2
		-- d_debug2 = target_lat
		-- d_debug3 = target_lon
		b = distance(target_lat, target_lon, dr_lat, dr_lon)
		c = b/math.cos(math.rad(3.0))
		a = math.sqrt(c*c-b*b)
		sim_heartbeat = 1102
		ang_alt = math.deg(math.atan((dr_alt-jas_ti_land_alt)/b))
		-- a blir höjden den tycker att vi ska ha med det avståndet vi har.
		a = constrain(a, 0,500)
		jas_si_nav_alt = jas_ti_land_alt+a+10 -- lägg på 10m för att landa en bit in på banan
		
		jas_si_nav_prickactive = 1
		if (utanfor == 1) then
			jas_si_nav_alt = jas_ti_land_alt+500
			jas_si_nav_prickactive = 2
		end
		
		sim_heartbeat = 1103
		-- Ritar vart flygplatsen är i SI
		jas_si_nav_banax = jas_ti_land_bear - dr_acf_truehdg
		jas_si_nav_banay = -ang_alt
		
		if (jas_ti_land_dist>ring_dist+5000) then
			jas_si_nav_prickactive = 2
			hojd = interpolate(ring_dist+5000, 0, 35000, 2000,  jas_ti_land_dist )
			hojd = constrain(hojd, 0,2000)
			jas_si_nav_alt = jas_ti_land_alt+500 + hojd
		end
	end
	sim_heartbeat = 1199
end

filter_prickx = 0

function prick()
	-- Prick funktionen ska endast visa pricken mot longitud och latitud som är satt till si/nav/lat 
	-- jas_si_nav_lat
	-- jas_si_nav_lon
	-- jas_si_nav_course
	-- jas_si_nav_alt
	
	--Prick X
	--triangel sett uppifrån 
	--		                 /|
	--		              b / | ax
	--	                   /  |
	--                    /   |
	--   LANDINGSBANA <ang-----
	--                      c
	sim_heartbeat = 700
	
	if (jas_si_nav_prickactive == 1) then
		-- prickactive 1 så ska den navigera till en riktning i linje med bearing mot gps koordinaten och ta med höjden
		
		target_lat = jas_si_nav_lat
		target_lon = jas_si_nav_lon
		target_course = jas_si_nav_course
		if (target_course>360) then
			target_course = target_course -360
		end
		sim_heartbeat = 701
		target_bearing =  bearing(dr_lat, dr_lon, target_lat, target_lon)
		sim_heartbeat = 702
		target_heading = dr_acf_truehdg - target_bearing 
		-- d_debug2 = target_course
		-- d_debug3 = target_bearing
		-- d_debug4 = target_heading

		sim_heartbeat = 703


		test = jas_ti_land_head 
		test2 = dr_acf_truehdg 
		--test3 = jas_ti_land_bear+360

		sim_heartbeat = 704
		--d_debug2 = target_lat
		--d_debug3 = target_lon
		d_land = 3
		b = distance(target_lat, target_lon, dr_lat, dr_lon)
		sim_heartbeat = 7001
		target_dist = b
		sim_heartbeat = 7011

		sim_heartbeat = 705
		c = b/math.cos(math.rad(3.0))
		a = math.sqrt(c*c-b*b)
		ang_alt = math.deg(math.atan((dr_alt-jas_ti_land_alt)/b))

		sim_heartbeat = 706
		ang = target_course - target_bearing
		d_land = ang
		-- banan = math.sin(math.rad(ang))
		-- d_land = banan
		sim_heartbeat = 707
				
		-- Nya pricken, räkna ut ett gradtal man ska navigera mot istället...
		b2 = b * math.cos(math.rad(ang))
		radie = 4000
		ax = b2 * math.tan(math.rad(ang))
		sim_heartbeat = 7071

		-- funkar men slår
		target_heading = target_heading
		if (target_heading > 180) then
			target_heading = target_heading - 360
		end
		if (target_heading < -180) then
			target_heading = target_heading+360
		end
		sim_heartbeat = 7072
		--d_debug4 = land_bearing
		beta = 0
		
		inflygningvinkel = interpolate(20000, 0.95, 25000, -0.0,  target_dist )
		inflygningvinkel = constrain(inflygningvinkel, -0.0,0.95)
		glapp = 100
		if (ax <0) then
			--ax = ax + glapp
			if (ax>0) then
				--ax = 0
				
				-- prickx_g = -target_heading
				-- ang2 = constrain((ax/radie)+1, -inflygningvinkel, 1.0)
				-- beta = math.deg(math.acos(ang2))
				-- prickx = (target_course) -(dr_acf_truehdg) + beta
				-- prickx = (prickx+prickx_g)/2
			else 
				
				ang2 = constrain((ax/radie)+1, -inflygningvinkel, 1.0)
				beta = math.deg(math.acos(ang2))
				prickx = (target_course) -(dr_acf_truehdg) + beta
			end
			d_debug4 = ax
			-- if (ax >-30) then
			-- 	radie = interpolate(-30, 4000, -0, 8000,  ax )
			-- 	radie = constrain(radie, 3000,26000)
			-- end
			
			if (ax<glapp and ax>-glapp) then
				prickx = constrain(interpolate(-glapp, prickx, 0, -target_heading, ax), -50, 55)
			end
		else
			--ax = ax - glapp
			if (ax<0) then
				--ax = 0
				ang2 =  constrain((ax/radie)-1, -1.0, inflygningvinkel)
				
				beta = -(180-math.deg(math.acos(ang2)))
				prickx = (target_course) -(dr_acf_truehdg) + beta
				prickx_g = -target_heading
				
				prickx = (prickx+prickx_g)/2
			else
				ang2 =  constrain((ax/radie)-1, -1.0, inflygningvinkel)
				
				beta = -(180-math.deg(math.acos(ang2)))
				prickx = (target_course) -(dr_acf_truehdg) + beta
			end
			d_debug4 = ax
			-- if (ax <30) then
			-- 	radie = interpolate(0, 8000, 30, 4000,  ax )
			-- 	radie = constrain(radie, 3000,16000)
			-- end
			
			
			if (ax<glapp and ax>-glapp) then
				prickx = constrain(interpolate(0, -target_heading, glapp, prickx, ax), -50, 55)
			end
		end

		if (prickx >=360) then
			prickx = prickx - 360
		end
		
		
		if (prickx > 180) then
			prickx = prickx-360
		end
		if (prickx < -180) then
			prickx = prickx+360
		end
		
		if (b<600) then
			prickx = land_bearing
		end
		if (b<200) then
			prickx = 0
		end

		-- Prick Y
		alt_diff = jas_si_nav_alt - dr_alt
		pricky = -3.0 + alt_diff/15
		pricky = constrain(pricky, -10,10)
		
		sim_heartbeat = 708
		jas_si_nav_prickx = prickx
		jas_si_nav_pricky = pricky

		jas_si_nav_heading = jas_ti_land_bear
	
	end
	
	sim_heartbeat = 7000
	if (jas_si_nav_prickactive == 2) then
		sim_heartbeat = 720
		-- Mode 2 styr bara rakt mot positionen baserat på gps
		target_lat = jas_si_nav_lat
		target_lon = jas_si_nav_lon

		target_bearing =  bearing(dr_lat, dr_lon, target_lat, target_lon)

		target_heading = dr_acf_truehdg - target_bearing 
		prickx = fix180(-target_heading)
		
		-- Prick Y
		alt_diff = jas_si_nav_alt - dr_alt
		pricky = -3.0 + alt_diff/15
		pricky = constrain(pricky, -10,10)
		jas_si_nav_prickx = prickx
		jas_si_nav_pricky = pricky

		jas_si_nav_heading = jas_ti_land_bear
	end


	sim_heartbeat = 799
end


function prickold()
	sim_heartbeat = 700
	
	-- För att kunna jämföra utan att ta hänsyn till om man är nära överlappet mellan 359-0 grader lägger jag på 360 på alla 
	test = jas_ti_land_head +360
	test2 = dr_acf_truehdg +360
	--test3 = jas_ti_land_bear+360
	target_lat, target_lon = gpsAddDistance(jas_ti_land_lat ,jas_ti_land_lon, 1000, 90)
	sim_heartbeat = 701
	d_debug2 = target_lat
	d_debug3 = target_lon
	test3 =  bearing(dr_lat, dr_lon, target_lat, target_lon)+360
	b = distance(target_lat, target_lon, dr_lat, dr_lon)
	sim_heartbeat = 7001
	jas_ti_land_dist = b
	sim_heartbeat = 7011
	-- Kolla om vi flyger mot  landningsbanan isåfall visar vi pricken
	--if (test3 < test+90 and test3 > test-90 and jas_ti_land_lmod == 0) then
	if (jas_ti_menu_currentmenu == 3) then
		jas_si_nav_prickactive = 1
		
		sim_heartbeat = 701
		c = b/math.cos(math.rad(3.0))
		a = math.sqrt(c*c-b*b)
		ang_alt = math.deg(math.atan((dr_alt-jas_ti_land_alt)/b))
		-- a blir höjden den tycker att vi ska ha med det avståndet vi har.
		a = constrain(a, 0,500)
		alt_diff = (a+jas_ti_land_alt+10) - dr_alt -- här lägger vi på någon meter på banans höjd för att inte landa precis på bankanten
		pricky = -3.0 + alt_diff/15
		pricky = constrain(pricky, -10,10)
		sim_heartbeat = 702
		ang = jas_ti_land_head - test3
		
		-- banan = math.sin(math.rad(ang))
		-- d_land = banan
		sim_heartbeat = 703
		prickx = b * -math.sin(math.rad(ang)) -- gamla ILS liknande uträkningen
		
		-- Nya pricken, räkna ut ett gradtal man ska navigera mot istället...
		b2 = b * math.cos(math.rad(ang))
		radie = 4000
		ax = b2 * math.tan(math.rad(ang))
		d_land = ax
		
		
		
		
		-- funkar men slår
		land_bearing = -(test2 -test3)
		if (land_bearing > 180) then
			land_bearing = land_bearing - 360
		end
		if (land_bearing < -180) then
			land_bearing = land_bearing+360
		end
		--d_debug4 = land_bearing
		beta = 0
		
		inflygningvinkel = interpolate(20000, 0.95, 25000, -0.0,  jas_ti_land_dist )
		inflygningvinkel = constrain(inflygningvinkel, -0.0,0.95)
		if (ax <0) then
			if (ax >-30) then
				radie = interpolate(-30, 4000, -0, 8000,  ax )
				radie = constrain(radie, 3000,26000)
			end
			ang2 = constrain((ax/radie)+1, -inflygningvinkel, 1.0)
			beta = math.deg(math.acos(ang2))
			prickx = (jas_ti_land_head) -(dr_acf_truehdg) + beta
			if (ax<13.5 and ax>-13.5) then
				prickx = constrain(interpolate(-13.5, prickx, 0, land_bearing, ax), -10, 15)
				
			end
		else
			if (ax <30) then
				radie = interpolate(0, 8000, 30, 4000,  ax )
				radie = constrain(radie, 3000,16000)
			end
			
			ang2 =  constrain((ax/radie)-1, -1.0, inflygningvinkel)
			
			beta = -(180-math.deg(math.acos(ang2)))
			prickx = (jas_ti_land_head) -(dr_acf_truehdg) + beta
			if (ax<13.5 and ax>-13.5) then
				--res = -(jas_ti_land_head) +(dr_acf_truehdg) -land_bearing
				prickx = constrain(interpolate(0, land_bearing, 13.5, prickx, ax), -10, 15)
			end
		end
		--d_debug2 = (jas_ti_land_head) -(dr_acf_truehdg) 
		
		--prickx = (jas_ti_land_head) -(dr_acf_truehdg) + beta
		--prickx = land_bearing
		d_land =  beta
		
		if (prickx >=360) then
			prickx = prickx - 360
		end
		
		
		beta = 0

		
		--d_debug2 = ax
		--d_debug3 = radie
		
		-- bro sin formel
		-- ang2 = constrain(ax/150, -0.9, 0.9)
		-- beta =  math.deg(math.asin(ang2))
		-- prickx = jas_ti_land_head - dr_acf_truehdg - beta
		--d_land =  beta
		
		if (prickx > 180) then
			prickx = prickx-360
		end
		if (prickx < -180) then
			prickx = prickx+360
		end
		
		if (b<600) then
			prickx = land_bearing
		end
		if (b<200) then
			prickx = 0
		end
		--prickx = myfilter(prickx_filter, prickx, 10)
		
		sim_heartbeat = 704
		if (jas_ti_land_lmod == 0) then
			sim_heartbeat = 705
			--prickx = constrain(prickx, -8,8)
			--pricky = constrain(pricky, -9,9)
			jas_si_nav_prickx = prickx
			jas_si_nav_pricky = pricky
			jas_si_nav_banax = land_bearing
			
			jas_si_nav_banay = -ang_alt
			
		else
			jas_si_nav_prickactive = 0
		end
	else
		jas_si_nav_prickactive = 0
	end
	-- jas_ti_land_lat = find_dataref("JAS/ti/land/lat")
	-- jas_ti_land_lon = find_dataref("JAS/ti/land/lon")
	-- jas_ti_land_alt = find_dataref("JAS/ti/land/alt")
	-- jas_ti_land_head = find_dataref("JAS/ti/land/head")
	-- jas_ti_land_lmod = find_dataref("JAS/ti/land/lmod")
	
	
	sim_heartbeat = 706
	jas_si_nav_heading = jas_ti_land_bear
	sim_heartbeat = 799
end

heartbeat = 0
function before_physics() 
	sim_heartbeat = 300
	-- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 301)
	blink1sFunc()
	update_dataref()
	sim_heartbeat = 301
	sim_apu_power = 1
	-- -- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 302)
    update_buttons()
	sim_heartbeat = 302
    lampAirbrake()
    lampMasterWarning()
	sim_heartbeat = 303
	lampAPUGar()
	sysDAP()
	sysESS()
	sim_heartbeat = 306
	landingprick()
	sim_heartbeat = 307
	prick()
	sim_heartbeat = 308
	vu22()
	sim_heartbeat = 309
	fusk()
	sim_heartbeat = 310
	systest()
    -- XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 303)
    -- XLuaSetNumber(dr_status, heartbeat) 
	sim_heartbeat = heartbeat
    heartbeat = heartbeat + 1
end

-- function after_physics() 	
-- 	XLuaSetNumber(dr_override_surfaces, 0) 
-- end
XLuaSetNumber(XLuaFindDataRef("JAS/system/logic/heartbeat"), 199)
