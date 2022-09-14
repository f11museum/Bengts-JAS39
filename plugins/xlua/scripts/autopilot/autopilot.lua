-------------------------------------------------------
---- Stabiliserings system för JAS
---- F11 Museum 2021 Bengt
-------------------------------------------------------
sim_heartbeat = find_dataref("JAS/heartbeat/autopilot")
sim_heartbeat = 100

--- Helt nytt stabiliserings system för det befintliga funkade inte så bra och hamnade i super stall vid helt korrekta manövrar

-- Kalibreringsvariabler
autopilot_disable_roll = 0.192307692308 -- 1.5 grader
autopilot_disable_pitch = 0.166666666667 -- detta stämmer för spak mot magen 2.5 grader av totalt 15 grader
autopilot_disable_pitch_up = 0.357142857143 -- detta stämmer för spak FRÅN magen 2.5 grader av totalt 7 grader


-- Datareffar


dr_override_throttles = find_dataref("sim/operation/override/override_throttles") 
dr_throttle_use = find_dataref("sim/flightmodel/engine/ENGN_thro_use") 
dr_throttle = find_dataref("sim/flightmodel/engine/ENGN_thro") 
dr_throttle_burner = find_dataref("sim/flightmodel/engine/ENGN_burnrat") 

dr_FRP = XLuaFindDataRef("sim/operation/misc/frame_rate_period")
sim_heartbeat = 101
-- input från användaren
-- input från användaren
dr_yoke_roll_ratio = find_dataref("sim/joystick/yoke_roll_ratio") 
dr_yoke_heading_ratio = find_dataref("sim/joystick/yoke_heading_ratio") 
dr_yoke_pitch_ratio = find_dataref("sim/joystick/yoke_pitch_ratio") 

dr_pitch = find_dataref("sim/flightmodel/position/theta") 
dr_acf_vx = find_dataref("sim/flightmodel/position/local_vx") 
dr_acf_vy = find_dataref("sim/flightmodel/position/local_vy") 
dr_acf_vz = find_dataref("sim/flightmodel/position/local_vz") 
dr_acf_roll = find_dataref("sim/flightmodel/position/phi") 

sim_heartbeat = 102

dr_N1 = find_dataref("sim/flightmodel/engine/ENGN_N1_[0]")
dr_braking_ratio = find_dataref("sim/cockpit2/controls/parking_brake_ratio")
dr_braking_ratio_right = find_dataref("sim/cockpit2/controls/right_brake_ratio")
dr_braking_ratio_left = find_dataref("sim/cockpit2/controls/left_brake_ratio")
dr_speedbrake_ratio = find_dataref("sim/cockpit2/controls/speedbrake_ratio")

dr_nose_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[0]") 
dr_left_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[1]") 
dr_right_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[2]") 

dr_airspeed_kts_pilot = find_dataref("sim/flightmodel/position/indicated_airspeed") 
dr_gear = find_dataref("sim/cockpit/switches/gear_handle_status") 
dr_groundspeed = find_dataref("sim/flightmodel/position/groundspeed") 
dr_true_speed = find_dataref("sim/flightmodel/position/true_airspeed")

dr_altitude = find_dataref("sim/flightmodel/misc/h_ind") 

sim_heartbeat = 103
-- Egna JAS dataref



jas_button_spak = find_dataref("JAS/io/frontpanel/knapp/spak")
jas_button_att = find_dataref("JAS/io/frontpanel/knapp/att")
jas_button_hojd = find_dataref("JAS/io/frontpanel/knapp/hojd")
jas_button_afk = find_dataref("JAS/io/frontpanel/knapp/afk")

sim_heartbeat = 104

jas_lamps_spak = find_dataref("JAS/io/frontpanel/lamp/spak") 
jas_lamps_att = find_dataref("JAS/io/frontpanel/lamp/att") 
jas_lamps_hojd = find_dataref("JAS/io/frontpanel/lamp/hojd")
jas_lamps_ks = find_dataref("JAS/io/frontpanel/lamp/ks")
jas_lamps_afk = find_dataref("JAS/io/frontpanel/lamp/afk")
jas_lamps_a14 = find_dataref("JAS/io/frontpanel/lamp/a14")
sim_heartbeat = 105

jas_auto_mode = find_dataref("JAS/autopilot/mode")
jas_auto_att = find_dataref("JAS/autopilot/att")
jas_auto_alt = find_dataref("JAS/autopilot/alt")
jas_auto_afk = find_dataref("JAS/autopilot/afk")
jas_auto_afk_mode = find_dataref("JAS/autopilot/afk_mode")
jas_auto_ks_mode = find_dataref("JAS/autopilot/ks_mode")
jas_auto_ks_roll = find_dataref("JAS/autopilot/ks_roll")

jas_pratorn_tal_alfa12 = find_dataref("JAS/pratorn/tal/alfa12")
jas_pratorn_tal_spak = find_dataref("JAS/pratorn/tal/spak")

sim_jas_sys_test = find_dataref("JAS/io/vu22/knapp/syst")

jas_io_pedaler_left = find_dataref("JAS/io/pedaler/left")
jas_io_pedaler_right = find_dataref("JAS/io/pedaler/right")

sim_heartbeat = 106




-- publika variabler

g_groundContact = 0


-- Plugin funktioner

function flight_start() 
	sim_heartbeat = 200
	
	sim_heartbeat = 299
end

function aircraft_unload()
	dr_override_throttles = 0
	--logMsg("EXIT LUA")
end

function do_on_exit()
    dr_override_throttles = 0
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
	sim_heartbeat = 500
	vx = dr_acf_vx
	vy = dr_acf_vy
	vz = dr_acf_vz
	pitch = dr_pitch
	sim_heartbeat = 501
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
	
	vx = dr_acf_vx
	vy = dr_acf_vy
	vz = dr_acf_vz
	pitch = dr_pitch
	
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
blink032s = 0
blink025s = 0
blinktimer = 0

--ATT/HÖJD ska blinka med 650ms, 325ms släckt 325ms tänd
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
	t2 = math.floor(blinktimer*3)
	if (t2 % 2 == 0) then
		blink032s = 1
	else 
		blink032s = 0
	end
	t2 = math.floor(blinktimer*4)
	if (t2 % 2 == 0) then
		blink025s = 1
	else 
		blink025s = 0
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

	--error = lock_pitch - dr_pitch -- determine error
	th_cumError = constrain(th_cumError + error * elapsedTime, -10,10) --compute integral
	rateError = constrain((error - th_lastError)/elapsedTime, -10,10) --compute derivative

	out = l_kp*error + l_ki*th_cumError + l_kd*rateError --PID output               

	th_lastError = error --remember current error

	return out
end

-- Våra program funktioner
sim_FRP = 1
function update_dataref()
	sim_heartbeat = 400
	local getnumber = XLuaGetNumber

	sim_FRP = (sim_FRP*19+ getnumber(dr_FRP))/20
	if sim_FRP == 0 then 
		sim_FRP = 1 
	end
	sim_heartbeat = 401
	sim_true_alpha = myGetAlpha()
	sim_heartbeat = 402
	if (dr_nose_gear_depress) > 0 then 
		g_groundContact = 1 
	else 
		g_groundContact = 0 
	end
	
end

function myfilter(currentValue, newValue, amp)

	return ((currentValue*amp) + (newValue))/(amp+1)
	
end

function motor(inval, target, spd)
	
	-- Lånad från Nils anim()
	elapsedTime = constrain(sim_FRP, 0,0.040)
	local retval = inval
	
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


autostick_timer = 0
function read_stick()
	
	-- Roll rörelser
	if (jas_auto_mode>=2) then
		
		if (dr_yoke_roll_ratio<autopilot_disable_roll and dr_yoke_roll_ratio > -autopilot_disable_roll and dr_yoke_pitch_ratio<autopilot_disable_pitch and dr_yoke_pitch_ratio > -autopilot_disable_pitch) then
			-- ingen rör spaken
			if (autostick_timer<blinktimer) then
				if (jas_auto_mode == 20) then
					jas_auto_mode = 2
					jas_auto_att = myGetFlightAngle()
				end
				if (jas_auto_mode == 30) then
					autopilot_hold_alti = dr_altitude
					jas_auto_alt = autopilot_hold_alti
					auto_hold_pickup = blinktimer + 2.0
					jas_auto_mode = 3
				end
				if (auto_hold_pickup>blinktimer) then
					autopilot_hold_alti = dr_altitude
					jas_auto_alt = autopilot_hold_alti
					test = myGetFlightAngle() 
					if (test>1 or test<-1) then
						auto_hold_pickup = blinktimer + 2.0
					end
				end
				
			end
		else
			-- någon rör i spaken
			
			if (jas_auto_mode == 2) then
				jas_auto_mode = 20
			end
			if (jas_auto_mode == 3) then
				jas_auto_mode = 30
			end
			autostick_timer = blinktimer + 1.0
		end
	end
	

	if (jas_auto_mode == 4 and dr_true_speed > 13) then
		jas_auto_mode = 1
	end
end



knapp = 0
knapp2 = 0
current_th = 0

function update_buttons()
	sim_heartbeat = 600
	
	-- AFK
	if (jas_button_afk == 1) then
		sim_heartbeat = 601
		if (knapp2 == 0) then
			sim_heartbeat = 602
			knapp2 = 1
			if (dr_gear == 1) then
				-- Lås mellan alfa 12 eller alfa 14
				if (jas_auto_afk_mode == 2) then
					jas_auto_afk_mode = 3
					-- vi är i läge 12 och ska välja läge 14
				elseif (jas_auto_afk_mode == 3) then
					-- vi är i läge 14 och ska välja avstängt läge
					jas_auto_afk_mode = 0
				else
					-- vi är i avstängt läge eller normalläge och ska gå till läge 12
					jas_auto_afk_mode = 2
					jas_pratorn_tal_alfa12 = 1
					current_th = dr_throttle[0]
				end
			else
				if (jas_auto_afk_mode == 0) then
					jas_auto_afk_mode = 1
					jas_auto_afk = dr_airspeed_kts_pilot
					if (jas_auto_afk<172) then
						jas_auto_afk = 172
					end
					current_th = dr_throttle[0]
				else
					jas_auto_afk = 0
					jas_auto_afk_mode = 0
				end
			end
		else
			sim_heartbeat = 603
		end
	else
		knapp2 = 0
	end
	sim_heartbeat = 604
	-- SPAK
	if (jas_button_spak == 1) then
		if (knapp == 0) then
			knapp = 1
			if (sim_jas_auto_mode == 1) then
				jas_auto_mode = 0
			else
				jas_auto_mode = 1
				
				jas_pratorn_tal_spak = 1
			end
		end
	else
		knapp = 0
	end
	sim_heartbeat = 605
	koppla_roll = 0
	-- ATT
	if (jas_button_att == 1) then
		autopilot_hold_att = myGetFlightAngle()
		jas_auto_att = autopilot_hold_att
		jas_auto_mode = 2
		koppla_roll = 1
	end
	sim_heartbeat = 606
	-- HÖJD
	if (jas_button_hojd == 1) then
		autopilot_hold_alti = dr_altitude
		jas_auto_alt = autopilot_hold_alti
		jas_auto_mode = 3
		koppla_roll = 1
		
	end
	if (koppla_roll == 1) then
		if (dr_acf_roll <12 and dr_acf_roll >-12) then
			jas_auto_ks_mode = 1
			jas_auto_ks_roll = 0
		else
			jas_auto_ks_mode = 1
			jas_auto_ks_roll = dr_acf_roll
		end
		
		if (jas_auto_ks_roll>90 or jas_auto_ks_roll<-90) then
			jas_auto_ks_roll = 0
		end
		maxroll = interpolate(350, 30.0, 600, 60.0, dr_ias* 1.85200 )
		maxroll = constrain(maxroll, 30.0,60.0)
		if (jas_auto_ks_roll>maxroll) then
			jas_auto_ks_roll = maxroll
		end
		if (jas_auto_ks_roll<-maxroll) then
			jas_auto_ks_roll = -maxroll
		end
	end
	
	
	--sim_heartbeat = 699
end

function update_lamps()
	if (jas_auto_afk_mode >= 1) then
		jas_lamps_afk = 1
		if (jas_auto_afk_mode == 3) then
			jas_lamps_a14 = 1
		end
	else
		jas_lamps_afk = 0
		jas_lamps_a14 = 0
	end
	jas_lamps_spak = 0
	jas_lamps_att = 0
	jas_lamps_hojd = 0
	if (jas_auto_mode == 20) then
		jas_lamps_spak = 1
		jas_lamps_att = blink032s
	end
	if (jas_auto_mode == 30) then
		jas_lamps_spak = 1
		jas_lamps_att = blink032s
		jas_lamps_hojd = blink032s
	end
	if (jas_auto_mode == 1) then
		jas_lamps_spak = 1
	end
	if (jas_auto_mode == 2) then
		jas_lamps_spak = 1
		jas_lamps_att = 1
	end
	if (jas_auto_mode == 3) then
		jas_lamps_spak = 1
		jas_lamps_att = 1
		jas_lamps_hojd = 1
	end
end

alpha_filtered = 0
alpha_prev = 0
speed_prev = 0

function calculateThrottle()
	if (dr_gear == 1 and jas_auto_afk_mode == 1) then
		-- Byt läge till alfa12 när landstället fälls ner om afk va aktiv innan
		jas_auto_afk_mode = 2
		jas_pratorn_tal_alfa12 = 1
	end
	
	if (dr_gear == 0 and jas_auto_afk_mode >= 2) then
		-- Byt läge till vanlig afk om stället fälls upp igen
		jas_auto_afk_mode = 1
		jas_auto_afk = dr_airspeed_kts_pilot
		if (jas_auto_afk<172) then
			jas_auto_afk = 172
		end
	end
	
	--dr_override_throttles = 1
	alpha_prev = myfilter(alpha_prev, sim_true_alpha, 100)
	if (jas_auto_afk_mode == 1) then
		
		
		
	elseif (jas_auto_afk_mode == 2) then
		--alfa 12
		
		alpha_delta = 11.8-alpha_prev
		jas_auto_afk = dr_airspeed_kts_pilot - alpha_delta*10
		jas_auto_afk = myfilter(speed_prev, jas_auto_afk, 100)
		speed_prev = jas_auto_afk
		

	elseif (jas_auto_afk_mode == 3) then
		-- alfa 14
		
		alpha_delta = 13.8-alpha_prev
		jas_auto_afk = dr_airspeed_kts_pilot - alpha_delta*10
		jas_auto_afk = myfilter(speed_prev, jas_auto_afk, 100)
		speed_prev = jas_auto_afk
		
	else
		
		
	end
	
	if (jas_auto_afk >= 1 and jas_auto_afk_mode >= 1) then
		
		dr_override_throttles = 1
		
		error = jas_auto_afk - dr_airspeed_kts_pilot
		
		demand = constrain(PIDth(error), 0.0,1.0)
		dr_throttle_use[0] = demand
		dr_throttle_burner[0] = constrain( (demand-0.9)*10, 0.0,1.0)
		
		if (dr_throttle[0]>current_th+0.1 or dr_throttle[0]<current_th-0.1) then
			-- stäng av auto throttle om någon rör vid gasen
			jas_auto_afk_mode = 0
		end
	else
		dr_override_throttles = 0
		--dr_throttle_use[0] = dr_throttle[0]
	end
end

function bromsar()
	-- Gör så fotbromsarna bromsar lika mycket höger och vänster i högre hastigheter
	left = 0
	right = 0
	if (dr_groundspeed > 15) then
		total = math.max(jas_io_pedaler_left, jas_io_pedaler_right)
		left = total
		right = total
	else
		left = jas_io_pedaler_left
		right = jas_io_pedaler_right
	end
	
	dr_braking_ratio_left = left
	dr_braking_ratio_right = right
end

sys_test_counter = 0
function systest()
	if (sim_jas_sys_test == 1) then
		sys_test_counter = sys_test_counter +sim_FRP
		time1 = math.floor(sys_test_counter)
		if (time1 == 0) then
			jas_lamps_afk = 0
		end
		if (time1 == 1) then
			jas_lamps_afk = 1
		end
		if (time1 == 2) then
			jas_lamps_afk = 0
		end
		if (time1 == 3) then
			jas_lamps_afk = 1
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
	blink1sFunc()
	
	update_dataref()
	sim_heartbeat = 301

	sim_heartbeat = 302
	update_buttons()
	sim_heartbeat = 303
	update_lamps()
	sim_heartbeat = 304
	
	calculateThrottle()
	sim_heartbeat = 305
	bromsar()
	sim_heartbeat = 306
	read_stick()
	sim_heartbeat = 307
	
	systest()

	sim_heartbeat = 399
	sim_heartbeat = heartbeat
	heartbeat = heartbeat + 1
end

-- function after_physics() 	
-- 
-- end
sim_heartbeat = 199