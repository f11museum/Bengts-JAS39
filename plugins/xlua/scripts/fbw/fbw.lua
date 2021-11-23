-------------------------------------------------------
---- Stabiliserings system för JAS
---- F11 Museum 2021 Bengt
-------------------------------------------------------



--- Helt nytt stabiliserings system för det befintliga funkade inte så bra och hamnade i super stall vid helt korrekta manövrar

-- Kalibreringsvariabler
optimal_angle = 20 -- För fram vingen
max_pitch_rate = 50
max_roll_rate = 300
max_yaw_rate = 50




max_g_pos = 1
max_g_neg = -1
g_correction = 20

motor_speed = 800 


-- Datareffar

dr_override_flightcontrol = XLuaFindDataRef("sim/operation/override/override_flightcontrol") 
dr_override_surfaces = XLuaFindDataRef("sim/operation/override/override_control_surfaces") 
dr_FRP = XLuaFindDataRef("sim/operation/misc/frame_rate_period")

-- input från användaren
dr_yoke_roll_ratio = XLuaFindDataRef("sim/joystick/yoke_roll_ratio") 
dr_yoke_heading_ratio = XLuaFindDataRef("sim/joystick/yoke_heading_ratio") 
dr_yoke_pitch_ratio = XLuaFindDataRef("sim/joystick/yoke_pitch_ratio") 

-- Vingar
dr_left_elevator = XLuaFindDataRef("sim/flightmodel/controls/wing2l_ail1def")
dr_right_elevator = XLuaFindDataRef("sim/flightmodel/controls/wing2r_ail1def")
dr_left_aileron = XLuaFindDataRef("sim/flightmodel/controls/wing2l_ail2def")
dr_right_aileron = XLuaFindDataRef("sim/flightmodel/controls/wing2r_ail2def")
dr_left_canard = XLuaFindDataRef("sim/flightmodel/controls/wing4l_elv2def")
dr_right_canard = XLuaFindDataRef("sim/flightmodel/controls/wing4r_elv2def")
dr_vstab = XLuaFindDataRef("sim/flightmodel/controls/vstab1_rud1def")


dr_acf_pitch = XLuaFindDataRef("sim/flightmodel/position/theta") 
dr_acf_roll = XLuaFindDataRef("sim/flightmodel/position/phi") 
dr_acf_hdg = XLuaFindDataRef("sim/flightmodel/position/psi") 
dr_acf_rollrate = XLuaFindDataRef("sim/flightmodel/position/P") 
dr_acf_pitchrate = XLuaFindDataRef("sim/flightmodel/position/Q") 
dr_acf_yawrate = XLuaFindDataRef("sim/flightmodel/position/R") 
dr_acf_rollrate_acc = XLuaFindDataRef("sim/flightmodel/position/P_dot") 
dr_acf_pitchrate_acc = XLuaFindDataRef("sim/flightmodel/position/Q_dot") 
dr_acf_yawrate_acc = XLuaFindDataRef("sim/flightmodel/position/R_dot") 

dr_alpha = XLuaFindDataRef("sim/flightmodel/position/alpha") 
dr_g_nrml = XLuaFindDataRef("sim/flightmodel/forces/g_nrml") 


dr_N1 = XLuaFindDataRef("sim/flightmodel/engine/ENGN_N1_[0]")
dr_braking_ratio = XLuaFindDataRef("sim/cockpit2/controls/parking_brake_ratio")
dr_braking_ratio_right = XLuaFindDataRef("sim/cockpit2/controls/right_brake_ratio")
dr_braking_ratio_left = XLuaFindDataRef("sim/cockpit2/controls/left_brake_ratio")

dr_speedbrake_wing_right = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake1_deg[0]")
dr_speedbrake_wing_left = XLuaFindDataRef("sim/flightmodel2/wing/speedbrake1_deg[1]")

-- publika variabler
s_canard = 0
s_elevator = 0
s_elevator_l = 0
s_elevator_r = 0
s_aileron = 0
s_aileron_l = 0
s_aileron_r = 0
s_rudder = 0

-- Plugin funktioner

function flight_start() 
	dr_fuel1 =  XLuaFindDataRef("sim/flightmodel/weight/m_fuel1")
	dr_fuel2 =  XLuaFindDataRef("sim/flightmodel/weight/m_fuel2")
	XLuaSetNumber(dr_fuel1, 1337) 
	--XLuaSetNumber(dr_fuel2, 1600) 
	--XLuaSetNumber(dr_override_surfaces, 1) 
	XLuaSetNumber(dr_ecam_mode, 1) 

	--clouds = XLuaFindDataRef("sim/private/controls/skyc/white_out_in_clouds")
	--XLuaSetNumber(clouds, 0)
	--logMsg("Flight started with LUA")
	
end

function aircraft_unload()
	XLuaSetNumber(dr_override_surfaces, 0) 
	XLuaSetNumber(dr_ecam_mode, 0)
	--logMsg("EXIT LUA")
end

function do_on_exit()
	XLuaSetNumber(dr_override_surfaces, 0) 
	XLuaSetNumber(dr_ecam_mode, 0)
	--logMsg("EXIT LUA")
end


-- Hjälpfunktioner

function constrain(val, lower, upper)
    
    if lower > upper then 
        lower, upper = upper, lower 
    end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end


-- Våra program funktioner

function update_dataref()

	local getnumber = XLuaGetNumber


	sim_yoke_pitch_ratio = getnumber(dr_yoke_pitch_ratio) 
	sim_yoke_roll_ratio = getnumber(dr_yoke_roll_ratio) 
	sim_yoke_heading_ratio = getnumber(dr_yoke_heading_ratio)
	sim_acf_pitchrate = getnumber(dr_acf_pitchrate)
	sim_acf_rollrate = getnumber(dr_acf_rollrate)
	sim_alpha = getnumber(dr_alpha)
	sim_g_nrml = getnumber(dr_g_nrml)
	
	sim_FRP = getnumber(dr_FRP); if sim_FRP == 0 then sim_FRP = 1 end
	
end


function myfilter(currentValue, newValue)

	return ((currentValue*3) + (newValue))/4
	
end

function motor(inval, target, spd)
	-- Lånad från Nils anim()
	local retval = inval
	
	if inval == target then
		return retval
	else
		if target > inval then
			retval = inval + spd * sim_FRP
			if retval > target then 
				retval = target 
			end
			return retval 
		else
			retval = inval - spd * sim_FRP
			if retval < target then 
				retval = target 
			end
			return retval 
		end
	end
end

function calculateAileron()
	-- Först kollar vi vad piloten vill ha för ändring på rollen, multiplicerat med en faktor för maximal roitationshastighet
	wanted_rate = sim_yoke_roll_ratio * max_roll_rate
	
	-- Kollar vad planet har för nuvarande rotationshastighet 
	current_rate = sim_acf_rollrate
	-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
	delta = wanted_rate-current_rate
	
	m_aileron = delta
end

function calculateRudder()
	-- Först kollar vi vad piloten vill ha för ändring på rollen, multiplicerat med en faktor för maximal roitationshastighet
	wanted_rate = sim_yoke_heading_ratio * max_yaw_rate
	
	-- Kollar vad planet har för nuvarande rotationshastighet 
	current_rate = sim_acf_yawrate
	-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
	delta = wanted_rate-current_rate
	
	m_rudder = delta
end

function calculateElevator()

	-- Först kollar vi vad piloten vill ha för ändring på höjden, multiplicerat med en faktor för maximal roitationshastighet
	wanted_rate = sim_yoke_pitch_ratio * max_pitch_rate
	
	-- Kollar vad planet har för nuvarande rotationshastighet 
	current_rate = sim_acf_pitchrate
	-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
	delta = -current_rate
	
	-- Begränsningar för alpha och G krafter
	max_alpha_up = 5
	max_alpha_down = -5
	alpha_correction = 10
	
	error_correction = 0
	if (sim_alpha > max_alpha_up) then
		--XLuaSetNumber(dr_speedbrake_wing_right, 80)
		-- om vinklen överstiger önskat värde så börjar vi lägga på en felkorrigering baserat på hur mycket över värdet vi är
		-- Alla fel har kalibreringsvärden på hur aggresivt den ska motverka felet
		error_correction = error_correction -  (sim_alpha - max_alpha_up)*alpha_correction
	end
	if (sim_alpha < max_alpha_down) then
		error_correction = error_correction -  (sim_alpha + max_alpha_down)*alpha_correction
	end
	-- 
	-- G-force limit
	if (sim_g_nrml > max_g_pos) then
		error_correction = error_correction -  (sim_g_nrml - max_g_pos)*g_correction
	end
	if (sim_g_nrml < max_g_neg) then
		error_correction = error_correction -  (sim_g_nrml + max_g_neg)*(g_correction/4)
	end
	
	-- Börja med att vinkla framvingarna så dom ligger helt plant med färdvinkeln (alpha) i detta läget så sker ingen påverkan på planets rotation
	-- Där efter så adderar vi alla önskade korrigeringar och fel
	-- Vi begränsar sedan värdet så det inte överstiger dom vinklar som ger högst rotationskraft så den inte stallar
	canard = -sim_alpha + constrain(delta+wanted_rate+error_correction, -optimal_angle, optimal_angle)


	-- Här kollar vi om vi ska aktivera luftbroms med framvingarna vid landning
	-- Är motorn på låg fart och någon broms aktiverad samtidigt som hjulen är i marken så aktiverar vi bromsen
	-- if sim_N1 < 50 and g_wow == 1 and ((sim_braking_ratio_right > 0.01 and sim_braking_ratio_left > 0.1) or sim_braking_ratio > 0.1) then 
	-- 	canard = canard -80
	-- 	XLuaSetNumber(dr_speedbrake_wing_right, 80)
	-- 	XLuaSetNumber(dr_speedbrake_wing_left, 80)
	-- else
	-- 	XLuaSetNumber(dr_speedbrake_wing_right, 0)
	-- 	XLuaSetNumber(dr_speedbrake_wing_left, 0)
	-- end
	-- XLuaSetNumber(dr_left_canard, constrain(canard, -80, 90) )
	-- XLuaSetNumber(dr_right_canard, constrain(canard, -80, 90) )
	m_canard = canard
	m_elevator = -(delta+wanted_rate+error_correction)
	--fc_roll = 0

	
	--XLuaSetNumber(dr_left_elevator , -wanted_rate + fc_roll - constrain(delta+wanted_rate+error_correction, -optimal_angle, optimal_angle))
	--XLuaSetNumber(dr_right_elevator, -wanted_rate - fc_roll - constrain(delta+wanted_rate+error_correction, -optimal_angle, optimal_angle))
	
end

function before_physics() 
	update_dataref()
	m_canard = 0
	m_elevator = 0
	m_elevator_roll = 0
	m_aileron = 0
	m_rudder = 0
	XLuaSetNumber(dr_override_surfaces, 1) 
	XLuaSetNumber(dr_right_elevator, sim_yoke_pitch_ratio*90) -- för felkoll
	
	
	
	calculateElevator()
	calculateAileron()
	calculateRudder()
	
	XLuaSetNumber(dr_right_canard, sim_yoke_pitch_ratio*90) -- för felkoll
	-- Sätt värden på alla vingar efter vad som räknats ut
	-- Framvingen ska bara ha sin uträkning från canard
	m_canard = constrain(m_canard, -80, 90)
	--s_canard = motor(s_canard, m_canard, motor_speed)
	s_canard = m_canard
	-- Höjdrodret på bakvingen ska ha höjdroder och lite hjälp vid roll så ska den även slå till
	m_elevator_l = constrain(m_elevator+m_aileron, -40, 40)
	m_elevator_r = constrain(m_elevator-m_aileron, -40, 40)
	s_elevator_l = motor(s_elevator_l, m_elevator_l, motor_speed)
	s_elevator_r = motor(s_elevator_r, m_elevator_r, motor_speed)
	
	-- Skevrodret på bakvingen ska ha bara ha input från roll
	m_aileron_l = constrain(m_aileron, -40, 40)
	--m_aileron_r = constrain(-m_aileron, -40, 40)
	s_aileron_l = motor(s_aileron_l, m_aileron_l, motor_speed)
	--s_aileron_r = motor(s_aileron_r, m_aileron_r, motor_speed)

	-- sidoroder
	m_rudder = constrain(m_aileron, -40, 40)
	--m_aileron_r = constrain(-m_aileron, -40, 40)
	s_rudder = motor(s_rudder, m_rudder, motor_speed)

	
	
	XLuaSetNumber(dr_left_canard, s_canard )
	XLuaSetNumber(dr_right_canard, s_canard )
	
	XLuaSetNumber(dr_left_elevator , s_elevator_l)
	XLuaSetNumber(dr_right_elevator, s_elevator_r)
	
	XLuaSetNumber(dr_left_aileron, s_aileron_l)
	XLuaSetNumber(dr_right_aileron, -s_aileron_l)
	
	XLuaSetNumber(dr_vstab, )
--	


end

function after_physics() 	
	XLuaSetNumber(dr_override_surfaces, 0) 
end
