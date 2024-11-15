-------------------------------------------------------
---- Stabiliserings system för JAS
---- F11 Museum 2021 Bengt
-------------------------------------------------------
sim_heartbeat = find_dataref("JAS/system/ess/heartbeat")
sim_heartbeat = 100

--- Helt nytt stabiliserings system för det befintliga funkade inte så bra och hamnade i super stall vid helt korrekta manövrar

-- Kalibreringsvariabler

soft_stop = 0.86 -- Softstoppet i styrspaken. omvandlas till att ge 73% utslag
soft_stop_prc = 0.733
hard_stop_fram = 0.433 -- max utslag på spaken framåt

optimal_angle = 20 -- För fram vingen

max_pitch_rate = 20

max_pitch_rate_0 = 30
max_pitch_rate_300 = 25
max_pitch_rate_500 = 35 -- vid 500 måste vi börja plocka upp en godtycklig max alpha istället för max g
max_pitch_rate_600 = 45
max_pitch_rate_1000 = 29
max_pitch_rate_1300 = 24
max_roll_rate_val = 270 -- den här bestämmer max roll rate-- påstås va 270-320 men jag tycker det går fortare på en video där dom flyger, jag kan mäta det till ca 320
max_roll_rate = 270 -- uppdateras i beräkning till nuvarande max
min_roll_rate = 60 -- orginal 60
max_yaw_rate = 50

elevator_rate_to_angle = 2

deadzone = 0.050
deadzone_pedaler = 0.020
autopilot_disable = 0.192307692308 -- 1.5 grader
autopilot_disable_roll = 0.192307692308 -- 1.5 grader
autopilot_disable_pitch = 0.166666666667 -- detta stämmer för spak mot magen 2.5 grader av totalt 15 grader
autopilot_disable_pitch_up = 0.357142857143 -- detta stämmer för spak FRÅN magen 2.5 grader av totalt 7 grader

max_alpha_softstop = 28
max_alpha_up = 28 -- 26 är max tillåten alfa
max_alpha_up_normal = 28 -- 26 är max tillåten alfa
max_alpha_down = -15
max_alpha_fade = 2
alpha_correction = 100

max_g_softstop = 9.0
max_g_pos = 10.5
max_g_neg = -4
max_g_fade = 2
max_g_fade_rate = 2
g_correction = 0.25

motor_speed = 200 
motor_speed = 56*10 -- riktiga planet 56 grader per sekund
motor_speed_canard = 56*10 -- riktiga planet 56 grader per sekund
motor_speed_rudder = 56
motor_speed_roll = 56


fade_out = 0.6

-- Datareffar

-- Debug
d_true_alpha = create_dataref("JAS/debug/fbw/true_alpha", "number")
d_soft_stop = create_dataref("JAS/debug/fbw/soft_stop", "number")
d_nos = create_dataref("JAS/debug/fbw/nos", "number")
d_frametime = create_dataref("JAS/debug/fbw/frametime", "number")
d_machfade = create_dataref("JAS/debug/fbw/machfade", "number")
d_max_g_softstop = create_dataref("JAS/debug/fbw/max_g_softstop", "number")
d_max_roll_softstop = create_dataref("JAS/debug/fbw/max_roll_softstop", "number")

d_fbw_ele_wanted_rate = create_dataref("JAS/debug/fbw/ele_wanted_rate", "number")
d_fbw_ele_wanted_filter = create_dataref("JAS/debug/fbw/ele_wanted_filter", "number")
debug_fbw_canard = create_dataref("JAS/debug/fbw/canard", "number")

d_elv_yoke = create_dataref("JAS/debug/fbw/elv_yoke", "number")
d_elv_calc = create_dataref("JAS/debug/fbw/elv_calc", "number")
-- 
dr_status = XLuaFindDataRef("JAS/system/ess/heartbeat2") 
dr_status2 = XLuaFindDataRef("HUDplug/stabilisatorStatus") 

sim_override_throttles = find_dataref("sim/operation/override/override_throttles") 
sim_throttle_use = find_dataref("sim/flightmodel/engine/ENGN_thro_use") 
sim_throttle = find_dataref("sim/flightmodel/engine/ENGN_thro") 
sim_throttle_burner = find_dataref("sim/flightmodel/engine/ENGN_burnrat") 
sim_m_total = find_dataref("sim/flightmodel/weight/m_total") 

dr_override_flightcontrol = XLuaFindDataRef("sim/operation/override/override_flightcontrol") 
dr_override_surfaces = XLuaFindDataRef("sim/operation/override/override_control_surfaces") 
dr_override_wheel = find_dataref("sim/operation/override/override_wheel_steer") 
dr_FRP = XLuaFindDataRef("sim/operation/misc/frame_rate_period")
sim_heartbeat = 101
-- input från användaren
dr_yoke_roll_ratio = XLuaFindDataRef("sim/joystick/yoke_roll_ratio") 
dr_yoke_heading_ratio = XLuaFindDataRef("sim/joystick/yoke_heading_ratio") 
dr_yoke_pitch_ratio = XLuaFindDataRef("sim/joystick/yoke_pitch_ratio") 
dr_elv_trim = XLuaFindDataRef("sim/flightmodel/controls/elv_trim") 


-- Noshjulet
-- sim/flightmodel2/gear/tire_steer_command_deg[0]
dr_tire_steer = find_dataref("sim/flightmodel2/gear/tire_steer_command_deg[0]") 
dr_tire_steer2 = find_dataref("sim/flightmodel2/gear/tire_steer_command_deg[3]") 

-- Vingar gamla jas
-- dr_left_elevator = XLuaFindDataRef("sim/flightmodel/controls/wing2l_ail1def")
-- dr_right_elevator = XLuaFindDataRef("sim/flightmodel/controls/wing2r_ail1def")
-- dr_left_aileron = XLuaFindDataRef("sim/flightmodel/controls/wing2l_ail2def")
-- dr_right_aileron = XLuaFindDataRef("sim/flightmodel/controls/wing2r_ail2def")

-- Viggen
dr_left_elevator = find_dataref("sim/flightmodel/controls/wing4l_elv1def")
dr_right_elevator = find_dataref("sim/flightmodel/controls/wing4r_elv1def")
dr_left_aileron = find_dataref("sim/flightmodel/controls/wing4l_ail1def")
dr_right_aileron = find_dataref("sim/flightmodel/controls/wing4r_ail1def")

dr_left_elevator1 = find_dataref("sim/flightmodel/controls/wing1l_elv1def")
dr_right_elevator1 = find_dataref("sim/flightmodel/controls/wing1r_elv1def")
dr_left_aileron1 = find_dataref("sim/flightmodel/controls/wing2l_ail1def")
dr_right_aileron1 = find_dataref("sim/flightmodel/controls/wing2r_ail1def")


dr_left_canard = XLuaFindDataRef("sim/flightmodel/controls/wing1l_elv2def")
dr_right_canard = XLuaFindDataRef("sim/flightmodel/controls/wing1r_elv2def")
dr_vstab = XLuaFindDataRef("sim/flightmodel/controls/vstab1_rud1def")
dr_canard_xp12 = find_dataref("sim/flightmodel2/controls/stabilizer_deflection_degrees")
dr_canard_xp12_test2 = find_dataref("sim/flightmodel/parts/elem_inc")

dr_acf_pitch = XLuaFindDataRef("sim/flightmodel/position/theta") 
dr_acf_roll = XLuaFindDataRef("sim/flightmodel/position/phi") 
dr_acf_hdg = XLuaFindDataRef("sim/flightmodel/position/psi") 
dr_acf_rollrate = XLuaFindDataRef("sim/flightmodel/position/P") 
dr_acf_pitchrate = XLuaFindDataRef("sim/flightmodel/position/Q") 
dr_acf_yawrate = XLuaFindDataRef("sim/flightmodel/position/R") 
dr_acf_rollrate_acc = XLuaFindDataRef("sim/flightmodel/position/P_dot") 
dr_acf_pitchrate_acc = XLuaFindDataRef("sim/flightmodel/position/Q_dot") 
dr_acf_yawrate_acc = XLuaFindDataRef("sim/flightmodel/position/R_dot") 
dr_acf_vx = XLuaFindDataRef("sim/flightmodel/position/local_vx") 
dr_acf_vy = XLuaFindDataRef("sim/flightmodel/position/local_vy") 
dr_acf_vz = XLuaFindDataRef("sim/flightmodel/position/local_vz") 
dr_groundspeed = find_dataref("sim/flightmodel2/position/groundspeed") 

dr_alpha = XLuaFindDataRef("sim/flightmodel/position/alpha") 
dr_g_nrml = XLuaFindDataRef("sim/flightmodel/forces/g_nrml") 
sim_heartbeat = 102

dr_N1 = XLuaFindDataRef("sim/flightmodel/engine/ENGN_N1_[0]")
dr_braking_ratio = XLuaFindDataRef("sim/cockpit2/controls/parking_brake_ratio")
dr_braking_ratio_right = XLuaFindDataRef("sim/cockpit2/controls/right_brake_ratio")
dr_braking_ratio_left = XLuaFindDataRef("sim/cockpit2/controls/left_brake_ratio")
dr_speedbrake_ratio = XLuaFindDataRef("sim/cockpit2/controls/speedbrake_ratio")

dr_speedbrake_wing_right = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake1_deg[0]")
dr_speedbrake_wing_left = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake1_deg[1]")
dr_speedbrake_wing_right2 = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake1_deg[2]")
dr_speedbrake_wing_left2 = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake1_deg[3]")

dr_speedbrake2_wing_right = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake2_deg[0]")
dr_speedbrake2_wing_left = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake2_deg[1]")
dr_speedbrake2_wing_right2 = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake2_deg[2]")
dr_speedbrake2_wing_left2 = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake2_deg[3]")

dr_nose_gear_depress = XLuaFindDataRef("sim/flightmodel/parts/tire_vrt_def_veh[0]") 
dr_left_gear_depress = XLuaFindDataRef("sim/flightmodel/parts/tire_vrt_def_veh[1]") 
dr_right_gear_depress = XLuaFindDataRef("sim/flightmodel/parts/tire_vrt_def_veh[2]") 

dr_airspeed_kts_pilot = XLuaFindDataRef("sim/flightmodel/position/indicated_airspeed") 
dr_mach = find_dataref("sim/flightmodel/misc/machno")
dr_gear = XLuaFindDataRef("sim/cockpit/switches/gear_handle_status") 

dr_altitude = XLuaFindDataRef("sim/flightmodel/misc/h_ind") 

sim_heartbeat = 103
-- Egna JAS dataref
dr_jas_button_spak = XLuaFindDataRef("JAS/io/frontpanel/knapp/spak") 
dr_jas_button_att = XLuaFindDataRef("JAS/io/frontpanel/knapp/att") 
dr_jas_button_hojd = XLuaFindDataRef("JAS/io/frontpanel/knapp/hojd") 
sim_jas_button_afk = find_dataref("JAS/io/frontpanel/knapp/afk")
sim_heartbeat = 104
dr_jas_lamps_spak = XLuaFindDataRef("JAS/io/frontpanel/lamp/spak") 
dr_jas_lamps_att = XLuaFindDataRef("JAS/io/frontpanel/lamp/att") 
dr_jas_lamps_hojd = XLuaFindDataRef("JAS/io/frontpanel/lamp/hojd")  
sim_jas_lamps_afk = find_dataref("JAS/io/frontpanel/lamp/afk")
sim_jas_lamps_a14 = find_dataref("JAS/io/frontpanel/lamp/a14")
sim_jas_lamps_ks = find_dataref("JAS/io/frontpanel/lamp/ks")

sim_heartbeat = 105
dr_jas_auto_mode = XLuaFindDataRef("JAS/autopilot/mode")
dr_jas_auto_att = XLuaFindDataRef("JAS/autopilot/att")
dr_jas_auto_alt = XLuaFindDataRef("JAS/autopilot/alt")
sim_jas_auto_afk = find_dataref("JAS/autopilot/afk")
sim_jas_auto_afk_mode = find_dataref("JAS/autopilot/afk_mode")
jas_auto_ks_mode = find_dataref("JAS/autopilot/ks_mode")
jas_auto_ks_roll = find_dataref("JAS/autopilot/ks_roll")

jas_pratorn_tal_alfa12 = find_dataref("JAS/pratorn/tal/alfa12")
jas_pratorn_tal_spak = find_dataref("JAS/pratorn/tal/spak")

sim_jas_sys_test = find_dataref("JAS/io/vu22/knapp/syst")

sim_heartbeat = 106

dr_fog = XLuaFindDataRef("sim/private/controls/fog/fog_be_gone")
dr_cloud_shadow = XLuaFindDataRef("sim/private/controls/clouds/cloud_shadow_lighten_ratio")

dr_baro_set = XLuaFindDataRef("sim/cockpit/misc/barometer_setting")
dr_baro_current = XLuaFindDataRef("sim/weather/barometer_sealevel_inhg")


jas_fbw_max_roll_rate = find_dataref("JAS/fbw/max_roll_rate")
jas_fbw_override_roll = find_dataref("JAS/fbw/override_roll")
jas_fbw_override_pitch = find_dataref("JAS/fbw/override_pitch")
jas_fbw_override_yaw = find_dataref("JAS/fbw/override_yaw")
jas_fbw_override = find_dataref("JAS/fbw/override")

-- publika variabler
s_canard = 0
s_elevator = 0
s_elevator_l = 0
s_elevator_r = 0
s_aileron = 0
s_aileron_l = 0
s_aileron_r = 0
s_rudder = 0

g_groundContact = 0

current_fade_out = 1.0
canard_fade_out = 1.0
machfade = 1.0

error_correction = 0


prev_rate = 0.0
g_rest = 0.0
g_restn = 0.0
avg_pitch_neg = 0.0

lock_pitch = 10.0
lock_pitch_movement = 0

-- Plugin funktioner

function flight_start() 
	sim_heartbeat = 200
	dr_fuel1 =  XLuaFindDataRef("sim/flightmodel/weight/m_fuel1")
	dr_fuel2 =  XLuaFindDataRef("sim/flightmodel/weight/m_fuel[0]")
	dr_payload =  XLuaFindDataRef("sim/flightmodel/weight/m_fixed")
		
	
	XLuaSetNumber(dr_fuel1, 2200) 
	XLuaSetNumber(dr_fuel2, 2200) 
	XLuaSetNumber(dr_payload, 0) 
	--XLuaSetNumber(dr_fuel2, 1600) 
	--XLuaSetNumber(dr_override_surfaces, 1) 
	XLuaSetNumber(XLuaFindDataRef("sim/joystick/eq_pfc_yoke"), 1) -- ta bort krysset som dyker upp om man inte har joystick
	
	
	XLuaSetNumber(dr_jas_auto_mode, 1) 
	--clouds = XLuaFindDataRef("sim/private/controls/skyc/white_out_in_clouds")
	--XLuaSetNumber(clouds, 0)
	--logMsg("Flight started with LUA")
	sim_heartbeat = 299
end

function aircraft_unload()
	XLuaSetNumber(dr_override_surfaces, 0) 
	--logMsg("EXIT LUA")
end

function do_on_exit()
	XLuaSetNumber(dr_override_surfaces, 0) 
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


function myGetAlpha() 
	
 	vx = sim_acf_vx
	vy = sim_acf_vy
	vz = sim_acf_vz
	pitch = sim_pitch
	
	length = math.sqrt(vy * vy + vx * vx + vz * vz)
	if (length > 1.0) then
		alpha = math.asin(vy / length)
		alpha = pitch - math.deg(alpha)
		return alpha
	else 
		return 0.0
	end
end
function myGetFlightAngle() 
	
 	vx = sim_acf_vx
	vy = sim_acf_vy
	vz = sim_acf_vz
	pitch = sim_pitch
	
	length = math.sqrt(vy * vy + vx * vx + vz * vz)
	if (length > 1.0) then
		angle = math.asin(vy / length)
		return math.deg(angle)
	else 
		return 0.0
	end
end

blink1s = 0
blink05s = 0
blinktimer = 0
function blink1sFunc()
	blinktimer = blinktimer + sim_FRP
	t2 = math.floor(blinktimer)
	if (t2 % 2 == 0) then
		blink1s = 1
	else 
		blink1s = 0
	end
    t2 = math.floor(blinktimer*2)
	if (t2 % 2 == 0) then
		blink05s = 1
	else 
		blink05s = 0
	end
end


th_cumError = 0
th_lastError = 0
function PIDth(error)
	l_kp = 0.07
	l_ki = 0.05
	l_kd = 0.1
	-- PID försök 

	elapsedTime = sim_FRP

	--error = lock_pitch - sim_pitch -- determine error
	th_cumError = constrain(th_cumError + error * elapsedTime, -10,10) --compute integral
	rateError = constrain((error - th_lastError)/elapsedTime, -10,10) --compute derivative

	out = l_kp*error + l_ki*th_cumError + l_kd*rateError --PID output               

	th_lastError = error --remember current error

	return out
end

-- Våra program funktioner
sim_FRP = 1
function update_dataref()

	local getnumber = XLuaGetNumber


	sim_yoke_pitch_ratio = getnumber(dr_yoke_pitch_ratio) 
	sim_yoke_pitch_ratio2 = getnumber(dr_yoke_pitch_ratio) 
	max_g_softstop = constrain(  interpolate(8000, 9.0, 12000, 2.0,  sim_m_total )   , 6.0,9.0)
	max_g_softstop =  interpolate(8000, 9.0, 12000, 2.0,  sim_m_total )  
	if (sim_yoke_pitch_ratio>soft_stop) then
		sim_yoke_pitch_ratio2 = interpolate(soft_stop, soft_stop_prc,1.0, 1.0,  sim_yoke_pitch_ratio )
		max_g_softstop = interpolate(soft_stop, max_g_softstop,1.0, max_g_pos,  sim_yoke_pitch_ratio )
	elseif (sim_yoke_pitch_ratio>0) then
		sim_yoke_pitch_ratio2 = interpolate(0.0, 0.0, soft_stop, soft_stop_prc, sim_yoke_pitch_ratio )
	end
	
	--sim_yoke_pitch_ratio2 = interpolate(0.0, 0.0, soft_stop, 1.0 ,sim_yoke_pitch_ratio2 )

	if (sim_yoke_pitch_ratio<0) then
		sim_yoke_pitch_ratio2 = interpolate(-1.0, -hard_stop_fram, 0.0, 0.0,  sim_yoke_pitch_ratio2 )
	end
	sim_yoke_pitch_ratio = sim_yoke_pitch_ratio2
	d_soft_stop = sim_yoke_pitch_ratio2
	
	
	sim_yoke_roll_ratio = getnumber(dr_yoke_roll_ratio) 
	sim_yoke_heading_ratio = getnumber(dr_yoke_heading_ratio)
	sim_elv_trim = getnumber(dr_elv_trim)
	
	sim_acf_pitchrate = getnumber(dr_acf_pitchrate)
	sim_acf_rollrate = getnumber(dr_acf_rollrate)
	sim_acf_yawrate = getnumber(dr_acf_yawrate)
	sim_acf_pitch = getnumber(dr_acf_pitch)
	sim_pitch = getnumber(dr_acf_pitch)
	sim_acf_roll = getnumber(dr_acf_roll)
	sim_alpha = getnumber(dr_alpha)
	sim_g_nrml = getnumber(dr_g_nrml)
	sim_N1 = getnumber(dr_N1)
	sim_acf_vx = getnumber(dr_acf_vx)
	sim_acf_vy = getnumber(dr_acf_vy)
	sim_acf_vz = getnumber(dr_acf_vz)
	sim_acf_flight_angle = myGetFlightAngle()
	
	sim_left_gear_depress = getnumber(dr_left_gear_depress)
	sim_right_gear_depress = getnumber(dr_right_gear_depress)
	sim_nose_gear_depress = getnumber(dr_nose_gear_depress)
	
	sim_speedbrake_ratio = getnumber(dr_speedbrake_ratio)
	sim_braking_ratio = getnumber(dr_braking_ratio)
	sim_braking_ratio_left = getnumber(dr_braking_ratio_left)
	sim_braking_ratio_right = getnumber(dr_braking_ratio_right)
	sim_airspeed_kts_pilot = getnumber(dr_airspeed_kts_pilot)
	sim_gear = getnumber(dr_gear)
	sim_altitude = getnumber(dr_altitude)
	
	sim_jas_button_spak = getnumber(dr_jas_button_spak)
	sim_jas_button_att = getnumber(dr_jas_button_att)
	sim_jas_button_hojd = getnumber(dr_jas_button_hojd)
	
	sim_jas_lamps_spak = getnumber(dr_jas_lamps_spak)
	sim_jas_lamps_att = getnumber(dr_jas_lamps_att)
	sim_jas_lamps_hojd = getnumber(dr_jas_lamps_hojd)
	
	sim_jas_auto_mode = getnumber(dr_jas_auto_mode)
	sim_jas_auto_alt = getnumber(dr_jas_auto_alt)
	sim_jas_auto_att = getnumber(dr_jas_auto_att)
	
	sim_FRP = (sim_FRP*19+ getnumber(dr_FRP))/20
	if sim_FRP == 0 then 
		sim_FRP = 1 
	end
	
	

	sim_true_alpha = myGetAlpha()
	d_true_alpha = sim_true_alpha
	
	if (sim_nose_gear_depress) > 0 then 
		g_groundContact = 1 
	else 
		g_groundContact = 0 
	end
	
	current_fade_out = interpolate(0, 1.0, 500, fade_out, sim_airspeed_kts_pilot )
	current_fade_out = constrain(current_fade_out, fade_out,1.0)
	
	canard_fade_out = interpolate(0, 1.0, 500, 0, sim_airspeed_kts_pilot )
	canard_fade_out = constrain(canard_fade_out, 0,1.0)
	
	max_roll_rate_softstop = constrain(  interpolate(8000, 0, 12000, 120,  sim_m_total )   , 0,120)
	
	max_roll_rate = interpolate(150, min_roll_rate,320, max_roll_rate_val+20, sim_airspeed_kts_pilot )
	max_roll_rate = constrain(max_roll_rate, min_roll_rate,max_roll_rate_val+20-max_roll_rate_softstop)
	d_max_roll_softstop = max_roll_rate
	dr_payload =  XLuaFindDataRef("sim/flightmodel/weight/m_fixed")
	jas_fbw_max_roll_rate = max_roll_rate


	if (sim_airspeed_kts_pilot > 1000*0.539957) then
		max_pitch_rate = interpolate(1000*0.539957, max_pitch_rate_1000, 1300*0.539957, max_pitch_rate_1300, sim_airspeed_kts_pilot )
		max_pitch_rate = constrain(max_pitch_rate, max_pitch_rate_1300,max_pitch_rate_1000)
	elseif (sim_airspeed_kts_pilot > 600*0.539957) then
		max_pitch_rate = interpolate(600*0.539957, max_pitch_rate_600, 1000*0.539957, max_pitch_rate_1000, sim_airspeed_kts_pilot )
		max_pitch_rate = constrain(max_pitch_rate, max_pitch_rate_1000,max_pitch_rate_600)
	elseif (sim_airspeed_kts_pilot > 500*0.539957) then
		max_pitch_rate = interpolate(500*0.539957, max_pitch_rate_500, 600*0.539957, max_pitch_rate_600, sim_airspeed_kts_pilot )
		max_pitch_rate = constrain(max_pitch_rate, max_pitch_rate_600,max_pitch_rate_500)
	elseif (sim_airspeed_kts_pilot > 300*0.539957) then
		max_pitch_rate = interpolate(300*0.539957, max_pitch_rate_300, 500*0.539957, max_pitch_rate_500, sim_airspeed_kts_pilot )
		max_pitch_rate = constrain(max_pitch_rate, max_pitch_rate_500,max_pitch_rate_300)
	elseif (sim_airspeed_kts_pilot > 0*0.539957) then
		max_pitch_rate = interpolate(0*0.539957, max_pitch_rate_0, 300*0.539957, max_pitch_rate_300, sim_airspeed_kts_pilot )
		max_pitch_rate = constrain(max_pitch_rate, max_pitch_rate_300,max_pitch_rate_0)
	end
	extra_rate = 1.0
	if (sim_alpha>0 and sim_yoke_pitch_ratio<0) then
		max_pitch_rate = max_pitch_rate*2
	end
	if (sim_alpha<0 and sim_yoke_pitch_ratio>0) then
		max_pitch_rate = max_pitch_rate*2
	end
	
	max_alpha_up = interpolate(500*0.539957, max_alpha_up_normal, 600*0.539957, 25, sim_airspeed_kts_pilot )
	max_alpha_up = constrain(max_alpha_up, 25,max_alpha_up_normal)
	
	
	-- XLuaSetNumber(dr_fog, 0.1) 
	-- XLuaSetNumber(dr_cloud_shadow, 1.0) 
	-- 
	-- XLuaSetNumber(dr_baro_set, getnumber(dr_baro_current)) 
	-- 
	-- 
	-- glasdarkness =  XLuaFindDataRef("HUDplug/glass_darkness")
	-- light_attenuation = getnumber(XLuaFindDataRef("sim/graphics/misc/light_attenuation"))
	-- darkness = interpolate(0.3, 0.5, 0.8, 0.0, light_attenuation )
	-- XLuaSetNumber(glasdarkness, darkness) 
	
end

function myfilter(currentValue, newValue, amp)
	if (currentValue ~= currentValue) then
		print("is nan!!")
		currentValue = 0
	end
	return ((currentValue*amp) + (newValue))/(amp+1)
	
end

function motor2(inval, target, spd)
	
	return target
end

function motor(inval, target, spd)
	
	-- Lånad från Nils anim()
	elapsedTime = constrain(sim_FRP, 0,0.040)
	local retval = inval
	-- retval = target
	-- return retval
	if inval == target then
		return retval
	else
		if target > inval then
			retval = inval + spd * elapsedTime
			if retval > target then 
				retval = target 
			end
			return retval 
		else
			retval = inval - spd * elapsedTime
			if retval < target then 
				retval = target 
			end
			return retval 
		end
	end
end


a_lastError = 0.0
a_cumError = 0.0


wanted_roll = 0
stick_roll = 0
delta_prev = 0
ks_mode = 0
autoback_timer = 0


d_ail_req = create_dataref("JAS/debug/fbw/ail_req", "number")
d_ail_fade = create_dataref("JAS/debug/fbw/ail_fade", "number")
d_ail_wanted = create_dataref("JAS/debug/fbw/ail_wanted", "number")
d_ail_yoke = create_dataref("JAS/debug/fbw/ail_yoke", "number")

d_override_roll = create_dataref("JAS/debug/fbw/override_roll", "number")

sim_acf_rollrate_filtered = 0

function calculateAileron()
	rate_to_deg = 220/320
	fadeout = constrain(interpolate(100, 1, 1000, 0.2, sim_airspeed_kts_pilot ), 0.2, 1.0)
	sim_acf_rollrate_filtered = myfilter (sim_acf_rollrate_filtered, sim_acf_rollrate, 2)
	--fadeout = 1
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/d1"), interpolate(0, 1, 1000, 0.01, sim_airspeed_kts_pilot )) 
	--m_aileron = sim_yoke_roll_ratio*8
	-- Först kollar vi vad piloten vill ha för ändring på rollen, multiplicerat med en faktor för maximal roitationshastighet
	stick = 1
	current_deadzone = deadzone
	if (sim_jas_auto_mode == 2 or sim_jas_auto_mode == 3 or sim_jas_auto_mode == 5 ) then
		current_deadzone = autopilot_disable_roll
	end
		
	if (sim_yoke_roll_ratio<current_deadzone and sim_yoke_roll_ratio > -current_deadzone) then
		stick = 0
	end
	if (stick == 0) then
		
		-- ingen rör spaken
		if (stick_roll == 1) then
			stick_roll = 0
		end
		wanted_rate = 0
		-- Kollar vad planet har för nuvarande rotationshastighet 
		current_rate = sim_acf_rollrate
		-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
		delta = wanted_rate-current_rate
		delta = delta * fadeout * fadeout
		
		-- lägg på liten justering för att gå tillbaka dit man va när man släppte spaken
		delta2 = 0
		if (sim_acf_pitch <60 and sim_acf_pitch>-60) then -- den här ifsatsen kopplar ur roll hållningen när man loopar, annars så vill den dra 180 efter loopen
			delta2 = wanted_roll - sim_acf_roll
		else 
			wanted_roll = sim_acf_roll
		end
		if (jas_auto_ks_mode == 1 and (sim_jas_auto_mode == 3 or sim_jas_auto_mode == 5 or jas_fbw_override >=1)) then -- om höjd styrning och planet är i level så håller den kvar det
			delta2 = jas_auto_ks_roll - sim_acf_roll
			wanted_roll = jas_auto_ks_roll
			sim_jas_lamps_ks = 1
		end	

		
		XLuaSetNumber(XLuaFindDataRef("JAS/debug/d1"), delta2) 
		if (delta2>180) then
			delta2 = wanted_roll - (sim_acf_roll+360)
		end
		if (delta2<-180) then
			delta2 = wanted_roll - (sim_acf_roll-360)
		end
		
		
		delta3 = delta2*delta2
		if (delta2<0) then
			delta3 = -delta3
		end
		--delta2 = delta3
		delta = delta + (delta2 * 0.9)
		
		--delta = delta * fadeout
		
		--delta = delta2 * fadeout  * 0.1
		delta = myfilter (delta_prev, delta2, 10)
	else
		if (jas_auto_ks_mode == 1 and sim_jas_auto_mode == 3) then
			sim_jas_lamps_ks = blink1s
		else
			sim_jas_lamps_ks = 0
		end
		
		
		wanted_roll = sim_acf_roll
		if (sim_yoke_roll_ratio<0) then
			sim_yoke_roll_ratio = sim_yoke_roll_ratio + deadzone
			wanted_rate = sim_yoke_roll_ratio * max_roll_rate
		else
			sim_yoke_roll_ratio = sim_yoke_roll_ratio -deadzone
			wanted_rate = sim_yoke_roll_ratio * max_roll_rate
		end
		scale_deadzone = 1/(1.0-deadzone)
		wanted_rate = sim_yoke_roll_ratio * max_roll_rate*scale_deadzone
		d_ail_yoke = sim_yoke_roll_ratio * scale_deadzone
		-- Kollar vad planet har för nuvarande rotationshastighet 
		
		current_rate = sim_acf_rollrate_filtered
		-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
		delta = wanted_rate-current_rate
		delta = delta*rate_to_deg * fadeout
	end
	d_ail_wanted = wanted_rate
	d_ail_fade = fadeout
	--sim_acf_roll
	
	-- XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[2]"), wanted_roll) 
	-- XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[3]"), sim_acf_roll) 
	-- XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[4]"), delta2) 
	if (jas_fbw_override >=1) then --  override
		d_override_roll = 1
		delta2 = jas_fbw_override_roll - sim_acf_roll
		wanted_roll = jas_fbw_override_roll
		if (delta2>180) then
			delta2 = wanted_roll - (sim_acf_roll+360)
		end
		if (delta2<-180) then
			delta2 = wanted_roll - (sim_acf_roll-360)
		end
		delta = delta2*rate_to_deg * fadeout*0.5
	else 
		d_override_roll = 2
	end	
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/d"), delta) 
	m_aileron = delta + fadeout*sim_yoke_roll_ratio*10
	--m_aileron = sim_yoke_roll_ratio*10
	d_ail_req = m_aileron
	
	-- 
	-- 
	-- 
	-- -- PID försök till att få en bättre trim
	-- a_kp = 0.3
	-- a_kp = interpolate(0, a_kp, 1000, 0.01, sim_airspeed_kts_pilot )
	-- a_ki = 0.0001
	-- a_kd = 0.0021
	-- 
	-- elapsedTime = sim_FRP
	-- 
	-- -- mho_BEGIN
	-- error = wanted_roll-sim_acf_roll -- determine error
	-- error = (wanted_rate-current_rate)
	-- a_cumError = a_cumError + error * elapsedTime --compute integral
	-- a_rateError = (error - a_lastError)/elapsedTime --compute derivative
	-- 
	-- out = a_kp*error + a_ki*a_cumError + a_kd*a_rateError --PID output               
	-- 
	-- -- Justerar integrationskonstanten så att man inte kan få någon windup (tror det kan ge konstiga problem)
	-- if (out > 50) then
	-- 	a_cumError = a_cumError - ( out - 50 ) / a_ki
	-- end
	-- if (out < -50) then
	-- 	a_cumError = a_cumError - ( out + 50 ) / a_ki
	-- end
	-- --m_aileron = constrain(out, -50,50)
	-- -- mho_END
	-- 
	-- error = wanted_roll-sim_acf_roll -- determine error
	-- a_cumError = constrain(a_cumError + error * elapsedTime, -10,10) --compute integral
	-- a_rateError = constrain((error - a_lastError)/elapsedTime, -10,10) --compute derivative
	-- 
	-- out = a_kp*error + a_ki*a_cumError + a_kd*a_rateError --PID output               
	-- 
	-- a_lastError = error --remember current error
	-- previousTime = currentTime --remember current time
	-- 
	-- --m_aileron = constrain(out, -50,50)
end

rudder_delta_prev = 0
sim_acf_yawrate_filtered = 1

function calculateRudder()
	fadelagg = 1/sim_FRP
	machfade = constrain(1.5-dr_mach, 0.1,1)
	
	
	rate_to_deg = (fadelagg*18)/320
	input = 0
	if (sim_yoke_heading_ratio<deadzone_pedaler and sim_yoke_heading_ratio > -deadzone_pedaler) then
		input = 0
		
	else
		-- piloten rör pedaler
		if (sim_yoke_heading_ratio<0) then
			input = sim_yoke_heading_ratio + deadzone_pedaler
		else
			input = sim_yoke_heading_ratio - deadzone_pedaler
		end
		machfade = constrain(1.5-dr_mach, 0.5,1)
	end
	d_machfade = machfade
	-- Först kollar vi vad piloten vill ha för ändring på rollen, multiplicerat med en faktor för maximal roitationshastighet
	wanted_rate = input * max_yaw_rate
	sim_acf_yawrate_filtered = myfilter (sim_acf_yawrate_filtered, sim_acf_yawrate, 2)
	-- Kollar vad planet har för nuvarande rotationshastighet 
	current_rate = sim_acf_yawrate
	
	-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
	delta = -current_rate*0.1
	--if (g_groundContact == 1) then
	--	delta = 0
	--else
	--	delta = -current_rate*0.1
	--end
	
	
	rudder_delta_prev = delta
	
	
	
	-- ## GAMLA roderuträkningen
	-- Först kollar vi vad piloten vill ha för ändring på rollen, multiplicerat med en faktor för maximal roitationshastighet
	wanted_rate = input * max_yaw_rate
	
	-- Kollar vad planet har för nuvarande rotationshastighet 
	current_rate = sim_acf_yawrate
	-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
	delta = wanted_rate-current_rate
	--if (g_groundContact == 1) then
	--	delta = wanted_rate
	--end
	m_rudder = delta*rate_to_deg * current_fade_out * machfade
	--m_rudder = input *25
	
	
	if (sim_jas_auto_mode == 3) then
		m_rudder = 0
	end
	
	-- Noshjulet
	nos = interpolate(0, 45, 20, 1, dr_groundspeed )
	nos_multi = math.abs(constrain(nos, 5,45))
	nos_auto = constrain(m_rudder*0.9, -10,10)
	d_nos = nos_multi
	dr_tire_steer = constrain(input * nos_multi + nos_auto, -45,45)
	dr_tire_steer2 = input * nos_multi + nos_auto
end

lock_avg = 0.0
auto_alt = 0.0
autopilot_hold_alti = 0
autopilot_hold_att = 0

auto_trim = 0.0

lastError = 0.0
cumError = 0.0
kp = 20
ki = 2
kd = 1

clock_test = 0.0
error_prev = 0
rateError_prev = 0
sim_acf_pitchrate_filtered = 1

function calculateAutopilot(wanted_rate)
	if (sim_jas_auto_mode == 0) then
		return 0
	end
	--sim_acf_pitchrate_filtered = myfilter (sim_acf_pitchrate_filtered, sim_acf_pitchrate, 2)
	sim_acf_pitchrate_filtered = sim_acf_pitchrate
	lock = 0
	error = 0
	
	-- Koppla ur auitopiloten om man dra mycket i spaken
	-- if (sim_yoke_pitch_ratio>autopilot_disable or sim_yoke_pitch_ratio < -autopilot_disable) then
	-- 	if (sim_jas_auto_mode > 1) then
	-- 		autopilot_hold_alti = 0
	-- 		autopilot_hold_att = 0
	-- 		XLuaSetNumber(dr_jas_lamps_spak, 1)
	-- 		XLuaSetNumber(dr_jas_lamps_att, 0)
	-- 		XLuaSetNumber(dr_jas_lamps_hojd, 0)
	-- 		XLuaSetNumber(dr_jas_auto_mode, 1) 
	-- 		jas_pratorn_tal_spak = 1
	-- 	end
	-- 
	-- end
	if (sim_jas_auto_mode == 5) then
		if lock_pitch_movement == 1 then
			lock_pitch_movement = 0
			--autopilot_hold_alti = sim_altitude
			--autopilot_hold_alti = autopilot_hold_alti + wanted_rate
			--XLuaSetNumber(dr_jas_auto_alt, autopilot_hold_alti) 
		end
		
	end
	if (sim_jas_auto_mode == 3) then
		if lock_pitch_movement == 1 then
			lock_pitch_movement = 0
			--autopilot_hold_alti = sim_altitude
			--autopilot_hold_alti = autopilot_hold_alti + wanted_rate
			--XLuaSetNumber(dr_jas_auto_alt, autopilot_hold_alti) 
		end
		demand = -(sim_altitude - sim_jas_auto_alt)/50
		
		autopilot_hold_att = constrain(demand, -10,10)
		XLuaSetNumber(dr_jas_auto_att, autopilot_hold_att) 
		
		
	end
	if (sim_jas_auto_mode == 2 or sim_jas_auto_mode == 3 or sim_jas_auto_mode == 5) then
		if (lock_pitch_movement == 1 and sim_jas_auto_mode == 2) then
			lock_pitch_movement = 0
			--autopilot_hold_att = autopilot_hold_att + wanted_rate/100
			--XLuaSetNumber(dr_jas_auto_att, autopilot_hold_att) 
		end
		demand = sim_jas_auto_att - sim_acf_flight_angle
		error = constrain(demand, -10,10)
		wanted_rate = error * math.cos(math.rad(sim_acf_roll))
		
		--wanted_rate = error * math.cos(math.rad(sim_acf_roll))
		--return demand *5
		kp = 15
		kp = constrain(interpolate(0, 10, 500, 0.01, sim_airspeed_kts_pilot ), 0.0001,100)
		ki = 4*current_fade_out
		kd = 0
	end
	
	if (jas_fbw_override >= 1 ) then
		
		demand = jas_fbw_override_pitch - sim_acf_flight_angle
		error = constrain(demand, -15,15)
		wanted_rate = error * math.cos(math.rad(sim_acf_roll))
		
		--wanted_rate = error * math.cos(math.rad(sim_acf_roll))
		--return demand *5
		kp = 15
		kp = constrain(interpolate(0, 10, 500, 0.01, sim_airspeed_kts_pilot ), 0.0001,100)
		ki = 4*current_fade_out
		kd = 0
	end
	
	if (sim_jas_auto_mode == 1 or sim_jas_auto_mode == 2 or sim_jas_auto_mode == 3 or sim_jas_auto_mode == 5 or sim_jas_auto_mode == 20 or sim_jas_auto_mode == 30) then 
		if lock_pitch_movement == 1 then
			lock_pitch = sim_pitch
			lock_pitch_movement = 0
			
		end
		error = (wanted_rate - sim_acf_pitchrate_filtered) * 0.3 -- determine error
		
		-- kp = 15*current_fade_out
		-- kp = constrain(interpolate(0, 1, 1000, 0.01, sim_airspeed_kts_pilot ), 0.0001,100)
		-- ki = 4*current_fade_out
		-- kd = 0 --0.5--/current_fade_out/current_fade_out
		--XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[2]"), wanted_rate) 
		--XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[3]"), error) 
	end
	

	-- PID försök till att få en bättre autotrim

	elapsedTime = constrain(sim_FRP, 0,0.025)

	--error = lock_pitch - sim_pitch -- determine error
	error = constrain(error, -100,100)
	
	cumError = constrain(cumError + error * (elapsedTime)*10, -5,5) --compute integral
	rateError = constrain((error - lastError)/elapsedTime, -20,20) --compute derivative
	rateError = myfilter(rateError_prev, rateError, 8)
	rateError_prev = constrain(rateError, -20,20)
	
	--error = myfilter(error_prev, error, 0)
	error_prev = constrain(error, -200,200)

	kp = constrain(interpolate(0, 10, 1000, 0.01, sim_airspeed_kts_pilot ), 0.0001,5)
	ki = 5
	kd = 1
	out = kp*error + ki*cumError + kd*rateError --PID output       
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/p"), kp*error) 
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/i"), ki*cumError) 
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/d"), kd*rateError)         

	lastError = error --remember current error
	previousTime = currentTime --remember current time

	lock = (out)
	--lock = lock_pitch -sim_pitch 
	-- if (sim_gear == 0 and sim_jas_auto_mode > 1) then -- använd inte låsning av vinkeln om landstället är nere
	-- 	lock = (out)* math.cos(math.rad(sim_acf_roll)) -- använd rollen för att inte dra fel när man rollar
	-- 
	-- else
	-- 	lock = (out)
	-- end
	
	lock = constrain(lock, -50,50)
	--XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[7]"), lock) 
	--XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[1]"), sim_FRP) 
	-- clock_test = clock_test + sim_FRP
	-- XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[2]"), clock_test) 
	return lock
end


auto1 = 0
delta_prev = 0
angle_prev = 0
wanted_prev = 0

function calculateElevator()
	lock = 0
	delta = 0
	wanted_rate = 0
	if (sim_airspeed_kts_pilot >10) then
		rate_to_deg = 30/sim_airspeed_kts_pilot
	else
		rate_to_deg = 30/10
	end
	machfade = constrain(1.5-dr_mach, 0.5,1)
	-- Först kollar vi vad piloten vill ha för ändring på höjden, multiplicerat med en faktor för maximal roitationshastighet
	-- Eftersom du kan dra -3 g åt ena hållet bara så förösker vi minska utslaget här, men vill ha kvar samma rate i början och dala av mot halva
	if (sim_yoke_pitch_ratio<deadzone and sim_yoke_pitch_ratio > -deadzone) then
		
		-- ingen rör spaken
		sim_yoke_pitch_ratio = 0
		wanted_rate = 0
		
		-- Kollar vad planet har för nuvarande rotationshastighet 
		current_rate = sim_acf_pitchrate
		-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
		delta = -current_rate*2
		
		
	else
		-- piloten rör spaken
		if (sim_yoke_pitch_ratio<0) then
			sim_yoke_pitch_ratio = sim_yoke_pitch_ratio + deadzone
			wanted_rate = sim_yoke_pitch_ratio * max_pitch_rate
		else
			sim_yoke_pitch_ratio = sim_yoke_pitch_ratio -deadzone
			wanted_rate = sim_yoke_pitch_ratio * max_pitch_rate
		end
		lock_pitch_movement = 1
		if (sim_gear == 0) then
			lock = lock_avg
			auto_trim = 0
		end
		-- Kollar vad planet har för nuvarande rotationshastighet 
		current_rate = sim_acf_pitchrate
		-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
		delta = -current_rate*2
		wanted_rate = wanted_rate
	end
	d_elv_yoke = sim_yoke_pitch_ratio
	if (sim_jas_auto_mode == 0) then
		--lock = delta
		wanted_rate = wanted_rate*5
	end
	
	-- fade ut kontrollutslag för att försöka minska studsande
	if (sim_alpha > max_alpha_up-max_alpha_fade) then
		wanted_rate = constrain(wanted_rate - (sim_alpha-(max_alpha_up-max_alpha_fade))*max_pitch_rate/max_alpha_fade, -max_pitch_rate, max_pitch_rate)
	end
	if (sim_alpha < max_alpha_down+max_alpha_fade) then
		wanted_rate = constrain(wanted_rate - (sim_alpha-(max_alpha_down+max_alpha_fade))*max_pitch_rate/max_alpha_fade, -max_pitch_rate, max_pitch_rate )
	end
	-- G fade
	d_max_g_softstop = max_g_softstop
	if (sim_g_nrml > max_g_softstop-max_g_fade) then
		if (prev_rate == 0.0) then
			prev_rate = sim_acf_pitchrate
			g_rest = g_rest + 0.3
		end
		
		diff = sim_g_nrml-(max_g_softstop-max_g_fade)
		wanted_rate = interpolate(0,wanted_rate, max_g_fade*2, 0, diff/5)

		--wanted_rate = constrain(wanted_rate - prev_rate *(sim_g_nrml-(max_g_pos-max_g_fade))*max_pitch_rate/max_g_fade, -max_pitch_rate, max_pitch_rate)
	elseif (sim_g_nrml < max_g_neg+max_g_fade) then
		
		--wanted_rate = constrain(wanted_rate, prev_rate, max_pitch_rate)
		diff = sim_g_nrml-(max_g_neg+max_g_fade)
		wanted_rate = interpolate(0,wanted_rate, -max_g_fade*2, 0, diff/5)
		--wanted_rate = constrain(wanted_rate - (sim_g_nrml-(max_g_neg+max_g_fade))*max_pitch_rate/max_g_fade, -max_pitch_rate, max_pitch_rate)
	else 
		prev_rate = 0.0
		--g_restn = constrain(g_restn - 0.1, 0,1000)
		--g_rest = constrain(g_rest - 0.01, 0,1000)
	end
	auto1 = calculateAutopilot(wanted_rate)
	if (sim_jas_auto_mode >= 1 or sim_jas_auto_mode == 2 or sim_jas_auto_mode == 3) then
		--auto_trim = (auto_trim*9 + auto1)/10
		delta = 0
		wanted_rate = auto1
	-- elseif (sim_jas_auto_mode == 2 or sim_jas_auto_mode == 3) then
	-- 	--lock = delta
	-- 	delta = 0
	-- 	wanted_rate = wanted_rate*0.02 + auto1 * current_fade_out
	else
		--lock = delta
		wanted_rate = wanted_rate + auto1 * current_fade_out
	end
	
	
	
	delta = delta * current_fade_out
	-- Begränsningar för alpha och G krafter

	
	error_correction = 0
	error_correction_g = 0
	error_correction_g_c = 0
	if (sim_alpha > max_alpha_up) then
		-- om vinklen överstiger önskat värde så börjar vi lägga på en felkorrigering baserat på hur mycket över värdet vi är
		-- Alla fel har kalibreringsvärden på hur aggresivt den ska motverka felet
		error_correction = error_correction -  (sim_alpha - max_alpha_up)*alpha_correction
	end
	if (sim_alpha < max_alpha_down) then
		error_correction = error_correction -  (sim_alpha + max_alpha_down)*alpha_correction
	end
	-- 
	-- G-force limit
	if (sim_g_nrml > max_g_softstop) then
		diff = (sim_g_nrml - max_g_softstop)/2
		error_correction_g = error_correction_g -  (diff*diff)*g_correction/1
		prev_rate = prev_rate * 0.95
	end
	if (sim_g_nrml > max_g_softstop+1) then
		diff = (sim_g_nrml - max_g_softstop)/2
		error_correction_g_c = error_correction_g_c -  (diff*diff)*g_correction/1
	end
	if (sim_g_nrml < max_g_neg) then
		diff = (sim_g_nrml + max_g_neg)/2
		error_correction_g = error_correction_g + (diff*diff) * (g_correction/3)
		prev_rate = prev_rate * 0.95
	end
	if (sim_g_nrml < max_g_neg-1) then
		diff = (sim_g_nrml + max_g_neg)/2
		error_correction_g_c = error_correction_g_c + (diff*diff) * (g_correction/3)
	end
	
	
	
	

	
	-- Börja med att vinkla framvingarna så dom ligger helt plant med färdvinkeln (alpha) i detta läget så sker ingen påverkan på planets rotation
	-- Där efter så adderar vi alla önskade korrigeringar och fel
	-- Vi begränsar sedan värdet så det inte överstiger dom vinklar som ger högst rotationskraft så den inte stallar
	
	-- Omvandla önskade ändringar på vinkeln till roderutslag i grader
	--wanted_rate = wanted_rate * current_fade_out
	lock = lock * current_fade_out

	trim = sim_elv_trim*-20*elevator_rate_to_angle
	
	fadeout = 1 --interpolate(0, 1, 1000, 0.3, sim_airspeed_kts_pilot )
	--delta = delta * fadeout
	--delta = myfilter(delta_prev, delta, 5)
	--delta_prev = delta
	--wanted_rate = myfilter(angle_prev, wanted_rate, 10)
	--angle_prev = wanted_rate
	--auto_trim = auto_trim * fadeout
	--error_correction_g = error_correction_g * fadeout
	--XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[3]"), lock) 
	--XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[2]"), sim_pitch) 
	--error_correction = error_correction * current_fade_out
	
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/auto_trim"), auto_trim) 
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/delta"), delta) 
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/trim"), trim) 
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/error_correction"), error_correction) 
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/error_correction_g"), error_correction_g) 
	d_fbw_ele_wanted_rate = wanted_rate
	wanted_rate = myfilter(wanted_prev, wanted_rate, 2)
	wanted_prev = wanted_rate
	d_fbw_ele_wanted_filter = wanted_rate
	XLuaSetNumber(XLuaFindDataRef("JAS/debug/wanted_rate"), wanted_rate) 
	d_frametime = sim_FRP
	angle = (auto_trim+delta+wanted_rate+error_correction+error_correction_g+trim) / elevator_rate_to_angle
	canard_angle = (delta+(wanted_rate*0.9 * current_fade_out)+error_correction+error_correction_g_c*0.1) / elevator_rate_to_angle
	--angle = angle * current_fade_out
	angle = angle * machfade
	canard_angle = canard_angle * machfade
	
	canard = -sim_alpha + constrain(canard_angle, -optimal_angle, optimal_angle)


	-- Här kollar vi om vi ska aktivera luftbroms med framvingarna vid landning
	-- Är motorn på låg fart och någon broms aktiverad samtidigt som hjulen är i marken så aktiverar vi bromsen
	brake = 0
	if sim_N1 < 50 and g_groundContact == 1 and ((sim_braking_ratio_right > 0.01 and sim_braking_ratio_left > 0.1) or sim_braking_ratio > 0.1 or sim_speedbrake_ratio > 0.1) then 
		canard = canard -55 -- har tagit bort dragkraften från canarden vid detta läget för det blir ostabilt vid landning, men vi vinklar den för syns skull
		brake = -40
		-- kör med vingbromsar istället
		XLuaSetNumber(dr_speedbrake_wing_right, 45)
		XLuaSetNumber(dr_speedbrake_wing_left, 45)
		XLuaSetNumber(dr_speedbrake_wing_right2, 45)
		XLuaSetNumber(dr_speedbrake_wing_left2, 45)
		
		XLuaSetNumber(dr_speedbrake2_wing_right, 35)
		XLuaSetNumber(dr_speedbrake2_wing_left, 35)
		XLuaSetNumber(dr_speedbrake2_wing_right2, 35)
		XLuaSetNumber(dr_speedbrake2_wing_left2, 35)
	else
		XLuaSetNumber(dr_speedbrake_wing_right, 0)
		XLuaSetNumber(dr_speedbrake_wing_left, 0)
		XLuaSetNumber(dr_speedbrake_wing_right2, 0)
		XLuaSetNumber(dr_speedbrake_wing_left2, 0)
		XLuaSetNumber(dr_speedbrake2_wing_right, 0)
		XLuaSetNumber(dr_speedbrake2_wing_left, 0)
		XLuaSetNumber(dr_speedbrake2_wing_right2, 0)
		XLuaSetNumber(dr_speedbrake2_wing_left2, 0)
	end
	-- XLuaSetNumber(dr_left_canard, constrain(canard, -80, 90) )
	-- XLuaSetNumber(dr_right_canard, constrain(canard, -80, 90) )
	m_canard = canard
	m_elevator = -(angle) + brake
	--fc_roll = 0

	
	--XLuaSetNumber(dr_left_elevator , -wanted_rate + fc_roll - constrain(delta+wanted_rate+error_correction, -optimal_angle, optimal_angle))
	--XLuaSetNumber(dr_right_elevator, -wanted_rate - fc_roll - constrain(delta+wanted_rate+error_correction, -optimal_angle, optimal_angle))
	
end

knapp = 0
knapp2 = 0
current_th = 0

function update_buttons()
	if (sim_jas_button_spak == 1) then
		if (knapp == 0) then
			knapp = 1
			if (sim_jas_auto_mode == 1) then
				XLuaSetNumber(dr_jas_lamps_spak, 0)
				XLuaSetNumber(dr_jas_lamps_att, 0)
				XLuaSetNumber(dr_jas_lamps_hojd, 0)
				
				XLuaSetNumber(dr_jas_auto_mode, 0) 
			else
				XLuaSetNumber(dr_jas_lamps_spak, 1)
				XLuaSetNumber(dr_jas_lamps_att, 0)
				XLuaSetNumber(dr_jas_lamps_hojd, 0)
				
				XLuaSetNumber(dr_jas_auto_mode, 1) 
				
				jas_pratorn_tal_spak = 1
			end
		end
	else
		knapp = 0
	end
	if (sim_jas_button_att == 1) then
		autopilot_hold_att = sim_acf_flight_angle
		XLuaSetNumber(dr_jas_lamps_spak, 0)
		XLuaSetNumber(dr_jas_lamps_att, 1)
		XLuaSetNumber(dr_jas_lamps_hojd, 0)
		XLuaSetNumber(dr_jas_auto_att, autopilot_hold_att) 
		XLuaSetNumber(dr_jas_auto_mode, 2) 
	end
	if (sim_jas_button_hojd == 1) then
		autopilot_hold_alti = sim_altitude
		XLuaSetNumber(dr_jas_lamps_spak, 0)
		XLuaSetNumber(dr_jas_lamps_att, 0)
		XLuaSetNumber(dr_jas_lamps_hojd, 1)
		XLuaSetNumber(dr_jas_auto_alt, autopilot_hold_alti)
		XLuaSetNumber(dr_jas_auto_mode, 3)  
		
		if (sim_acf_roll <5 and sim_acf_roll >-5) then
			ks_mode = 1
		else
			ks_mode = 0
		end
	end
	
	
end

function update_lamps()
	
	if (sim_jas_auto_mode == 0) then
		XLuaSetNumber(dr_jas_lamps_spak, 0)
		XLuaSetNumber(dr_jas_lamps_att, 0)
		XLuaSetNumber(dr_jas_lamps_hojd, 0)
	end
	if (sim_jas_auto_mode == 1) then
		XLuaSetNumber(dr_jas_lamps_spak, 1)
		XLuaSetNumber(dr_jas_lamps_att, 0)
		XLuaSetNumber(dr_jas_lamps_hojd, 0)
	end
	if (sim_jas_auto_mode == 2) then
		XLuaSetNumber(dr_jas_lamps_spak, 1)
		XLuaSetNumber(dr_jas_lamps_att, 1)
		XLuaSetNumber(dr_jas_lamps_hojd, 0)
	end
	if (sim_jas_auto_mode == 3) then
		XLuaSetNumber(dr_jas_lamps_spak, 1)
		XLuaSetNumber(dr_jas_lamps_att, 1)
		XLuaSetNumber(dr_jas_lamps_hojd, 1)
	end
	
end



sys_test_counter = 0
function systest()
	if (sim_jas_sys_test == 1) then
		sys_test_counter = sys_test_counter +sim_FRP
		time1 = math.floor(sys_test_counter)
		if (time1 == 0) then
			XLuaSetNumber(dr_jas_lamps_spak, 1)
			XLuaSetNumber(dr_jas_lamps_att, 0)
			XLuaSetNumber(dr_jas_lamps_hojd, 0)
			--sim_jas_lamps_afk = 0
		end
		if (time1 == 1) then
			XLuaSetNumber(dr_jas_lamps_spak, 0)
			XLuaSetNumber(dr_jas_lamps_att, 1)
			XLuaSetNumber(dr_jas_lamps_hojd, 0)
			--sim_jas_lamps_afk = 0
		end
		if (time1 == 2) then
			XLuaSetNumber(dr_jas_lamps_spak, 0)
			XLuaSetNumber(dr_jas_lamps_att, 0)
			XLuaSetNumber(dr_jas_lamps_hojd, 1)
			--sim_jas_lamps_afk = 0
			
		end
		if (time1 == 3) then
			XLuaSetNumber(dr_jas_lamps_spak, 0)
			XLuaSetNumber(dr_jas_lamps_att, 0)
			XLuaSetNumber(dr_jas_lamps_hojd, 0)
			--sim_jas_lamps_afk = 1
			sys_test_counter = 0
		end
		if (sys_test_counter > 4) then
			
			sys_test_counter = 0
		end
	end
end
heartbeat = 0
function before_physics() 
	sim_heartbeat = 300
	update_dataref()
	sim_heartbeat = 3001
	blink1sFunc()
	sim_heartbeat = 301
	if (sim_jas_sys_test == 1) then
		systest()
		return
	end
	sim_heartbeat = 302
	--update_buttons()
	sim_heartbeat = 303
	--update_lamps()
	sim_heartbeat = 304
	m_canard = 0
	m_elevator = 0
	m_elevator_roll = 0
	m_aileron = 0
	m_rudder = 0
	XLuaSetNumber(dr_override_surfaces, 1) 
	dr_override_wheel = 1
	--XLuaSetNumber(dr_right_elevator, sim_yoke_pitch_ratio*90) -- för felkoll
	
	sim_heartbeat = 304
	calculateElevator()
	calculateAileron()
	calculateRudder()
	sim_heartbeat = 306
	--XLuaSetNumber(dr_right_canard, sim_yoke_pitch_ratio*90) -- för felkoll
	-- Sätt värden på alla vingar efter vad som räknats ut
	-- Framvingen ska bara ha sin uträkning från canard
	motor_speed_error = motor_speed
	--m_canard = -sim_alpha - m_elevator
	if (error_correction>0) then
		m_canard = constrain(m_canard, -55-10, 25+20) -- ge den lite extra spelrumm när den ska göra nödvändiga stabiliseringar
		s_canard = motor(s_canard, m_canard, 56*10*8)
		motor_speed_error = 56*80
	else
		m_canard = constrain(m_canard, -55, 25)
		s_canard = motor(s_canard, m_canard, motor_speed_canard)
	end
	
	--s_canard = m_canard
	-- Höjdrodret på bakvingen ska ha höjdroder och lite hjälp vid roll så ska den även slå till
	m_elevator_l = constrain(m_elevator, -30, 30)
	m_elevator_r = constrain(m_elevator, -30, 30)
	--m_elevator_l = constrain(m_elevator, -40, 40)
	--m_elevator_r = constrain(m_elevator, -40, 40)
	s_elevator_l = motor(s_elevator_l, m_elevator_l, motor_speed_error)
	s_elevator_r = motor(s_elevator_r, m_elevator_r, motor_speed_error)
	
	-- Skevrodret på bakvingen ska ha bara ha input från roll
	m_aileron_l = constrain(m_aileron, -40, 40)
	--m_aileron_r = constrain(-m_aileron, -40, 40)
	s_aileron_l = motor(s_aileron_l, m_aileron_l, motor_speed_roll)
	machfade2 = constrain(1.0-dr_mach, 0,1)
	s_aileron_e = constrain(s_aileron_l, -20, 20)*machfade2
	--s_aileron_r = motor(s_aileron_r, m_aileron_r, motor_speed)

	-- sidoroder
	m_rudder = constrain(m_rudder*0.5, -30, 30)
	
	s_rudder = motor(s_rudder, m_rudder, motor_speed_rudder)

	
	
	XLuaSetNumber(dr_left_canard, 0 )
	XLuaSetNumber(dr_right_canard, 0 )
		sim_heartbeat = 360
	dr_canard_xp12 = s_canard
	debug_fbw_canard = s_canard
	--dr_canard_xp12_test2[0] = sim_alpha
	sim_heartbeat = 361
	--dr_canard_xp12_test2[1] = sim_alpha
	sim_heartbeat = 362
	--dr_left_elevator = s_elevator_l+s_aileron_e
	--dr_right_elevator = s_elevator_r-s_aileron_e
	dr_left_elevator1 = s_elevator_l+s_aileron_e
	dr_right_elevator1 = s_elevator_r-s_aileron_e
	--XLuaSetNumber(dr_left_elevator , s_elevator_l+s_aileron_e)

	--XLuaSetNumber(dr_right_elevator, s_elevator_r-s_aileron_e)
	sim_heartbeat = 363
	--dr_left_aileron = s_aileron_l	
	--dr_right_aileron = -s_aileron_l
	dr_left_aileron1 = s_aileron_l	
	dr_right_aileron1 = -s_aileron_l
	--XLuaSetNumber(dr_left_aileron, s_aileron_l)
--XLuaSetNumber(dr_right_aileron, -s_aileron_l)
		sim_heartbeat = 364
	XLuaSetNumber(dr_vstab, s_rudder)
	sim_heartbeat = 365
	jas_fbw_override = 0
-- Sätt status så vi vet om det här scriuptet fungerar 
	
	XLuaSetNumber(dr_status, 1)

	
	sim_heartbeat = 399
	sim_heartbeat = heartbeat
	heartbeat = heartbeat + 1
end

function after_physics() 	
	XLuaSetNumber(dr_override_surfaces, 0) 

end
sim_heartbeat = 199
