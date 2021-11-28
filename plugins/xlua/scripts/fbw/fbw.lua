-------------------------------------------------------
---- Stabiliserings system för JAS
---- F11 Museum 2021 Bengt
-------------------------------------------------------



--- Helt nytt stabiliserings system för det befintliga funkade inte så bra och hamnade i super stall vid helt korrekta manövrar

-- Kalibreringsvariabler
optimal_angle = 20 -- För fram vingen
max_pitch_rate = 100
max_roll_rate_val = 320 
max_roll_rate = 320 -- påstås va 270 men jag tycker det går fortare på en video där dom flyger, jag kan mäta det till ca 320
min_roll_rate = 60 -- orginal 60
max_yaw_rate = 50

elevator_rate_to_angle = 2

deadzone = 0.15
max_alpha_up = 30
max_alpha_down = -15
max_alpha_fade = 10
alpha_correction = 100

max_g_pos = 9.5
max_g_neg = -3
max_g_fade = 1
max_g_fade_rate = 1
g_correction = 0.025

motor_speed = 200 
motor_speed = 56 -- riktiga planet 56 grader per sekund
motor_speed_canard = 56*3 -- riktiga planet 56 grader per sekund

fade_out = 0.6

-- Datareffar

dr_status = XLuaFindDataRef("HUDplug/stabilisatorStatus") 

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

error_correction = 0


prev_rate = 0.0
g_rest = 0.0
g_restn = 0.0
avg_pitch_neg = 0.0

lock_pitch = 10.0
lock_pitch_movement = 0

-- Plugin funktioner

function flight_start() 
	dr_fuel1 =  XLuaFindDataRef("sim/flightmodel/weight/m_fuel1")
	dr_fuel2 =  XLuaFindDataRef("sim/flightmodel/weight/m_fuel[0]")
	dr_payload =  XLuaFindDataRef("sim/flightmodel/weight/m_fixed")
		
	
	XLuaSetNumber(dr_fuel1, 2970) 
	XLuaSetNumber(dr_fuel2, 2970) 
	XLuaSetNumber(dr_payload, 0) 
	--XLuaSetNumber(dr_fuel2, 1600) 
	--XLuaSetNumber(dr_override_surfaces, 1) 
	XLuaSetNumber(dr_ecam_mode, 1) 
	XLuaSetNumber(XLuaFindDataRef("sim/joystick/eq_pfc_yoke"), 1) -- ta bort krysset som dyker upp om man inte har joystick
	

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

function interpolate(x1, y1, x2, y2, value)
	y = y1 + (y2-y1)/(x2-x1)*(value-x1)
	return y
end

-- Våra program funktioner

function update_dataref()

	local getnumber = XLuaGetNumber


	sim_yoke_pitch_ratio = getnumber(dr_yoke_pitch_ratio) 
	sim_yoke_roll_ratio = getnumber(dr_yoke_roll_ratio) 
	sim_yoke_heading_ratio = getnumber(dr_yoke_heading_ratio)
	sim_acf_pitchrate = getnumber(dr_acf_pitchrate)
	sim_acf_rollrate = getnumber(dr_acf_rollrate)
	sim_acf_yawrate = getnumber(dr_acf_yawrate)
	sim_pitch = getnumber(dr_acf_pitch)
	sim_acf_roll = getnumber(dr_acf_roll)
	sim_alpha = getnumber(dr_alpha)
	sim_g_nrml = getnumber(dr_g_nrml)
	sim_N1 = getnumber(dr_N1)
	
	sim_left_gear_depress = getnumber(dr_left_gear_depress)
	sim_right_gear_depress = getnumber(dr_right_gear_depress)
	sim_nose_gear_depress = getnumber(dr_nose_gear_depress)
	
	sim_speedbrake_ratio = getnumber(dr_speedbrake_ratio)
	sim_braking_ratio = getnumber(dr_braking_ratio)
	sim_braking_ratio_left = getnumber(dr_braking_ratio_left)
	sim_braking_ratio_right = getnumber(dr_braking_ratio_right)
	sim_airspeed_kts_pilot = getnumber(dr_airspeed_kts_pilot)
	
	sim_FRP = getnumber(dr_FRP); if sim_FRP == 0 then sim_FRP = 1 end
	
	if (sim_nose_gear_depress) > 0 then 
		g_groundContact = 1 
	else 
		g_groundContact = 0 
	end
	
	current_fade_out = interpolate(0, 1.0, 500, fade_out, sim_airspeed_kts_pilot )
	current_fade_out = constrain(current_fade_out, fade_out,1.0)
	
	canard_fade_out = interpolate(0, 1.0, 500, 0, sim_airspeed_kts_pilot )
	canard_fade_out = constrain(canard_fade_out, 0,1.0)
	
	max_roll_rate = interpolate(min_roll_rate, 130, max_roll_rate_val, 300, sim_airspeed_kts_pilot )
	max_roll_rate = constrain(max_roll_rate, min_roll_rate,max_roll_rate_val)
	dr_payload =  XLuaFindDataRef("sim/flightmodel/weight/m_fixed")
	

	XLuaSetNumber(dr_payload, current_fade_out) 
	
	glasdarkness =  XLuaFindDataRef("HUDplug/glass_darkness")
	light_attenuation = getnumber(XLuaFindDataRef("sim/graphics/misc/light_attenuation"))
	darkness = interpolate(0.3, 0.5, 0.8, 0.0, light_attenuation )
	XLuaSetNumber(glasdarkness, darkness) 
	
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
	delta = wanted_rate -current_rate
	
	m_rudder = delta
end



function calculateElevator()
	lock = 0
	delta = 0
	-- Först kollar vi vad piloten vill ha för ändring på höjden, multiplicerat med en faktor för maximal roitationshastighet
	-- Eftersom du kan dra -3 g åt ena hållet bara så förösker vi minska utslaget här, men vill ha kvar samma rate i början och dala av mot halva
	if (sim_yoke_pitch_ratio<deadzone and sim_yoke_pitch_ratio > -deadzone) then
		sim_yoke_pitch_ratio = 0
		wanted_rate = 0
		if lock_pitch_movement == 1 then
			lock_pitch = sim_pitch
			lock_pitch_movement = 0
			XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[1]"), lock_pitch) 
		end
		lock = lock_pitch -sim_pitch 
		wanted_rate = (lock*10)* math.cos(math.rad(sim_acf_roll))
		XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[2]"), math.cos(math.rad(sim_acf_roll))) 
		-- Kollar vad planet har för nuvarande rotationshastighet 
		current_rate = sim_acf_pitchrate
		-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
		delta = -current_rate
		--lock = delta
	else

		if (sim_yoke_pitch_ratio<0) then
			sim_yoke_pitch_ratio = sim_yoke_pitch_ratio + deadzone
			wanted_rate = math.sin(sim_yoke_pitch_ratio*math.pi/2)*0.5 * max_pitch_rate
		else
			sim_yoke_pitch_ratio = sim_yoke_pitch_ratio -deadzone
			wanted_rate = sim_yoke_pitch_ratio * max_pitch_rate
		end
		lock_pitch_movement = 1
		
		-- Kollar vad planet har för nuvarande rotationshastighet 
		current_rate = sim_acf_pitchrate
		-- räknar ut en skillnad mellan nuvarande rotation och den piloten begär
		delta = -current_rate
	end
	
	
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
	if (sim_g_nrml > max_g_pos) then
		diff = (sim_g_nrml - max_g_pos)/2
		error_correction_g = error_correction_g -  (diff*diff)*g_correction/1
		prev_rate = prev_rate * 0.95
	end
	if (sim_g_nrml > max_g_pos+1) then
		diff = (sim_g_nrml - max_g_pos)/2
		error_correction_g_c = error_correction_g_c -  (diff*diff)*g_correction/1
	end
	if (sim_g_nrml < max_g_neg) then
		diff = (sim_g_nrml + max_g_neg)/2
		error_correction_g = error_correction_g + (diff*diff) * (g_correction/3)
		prev_rate = prev_rate * 0.95
	end
	if (sim_g_nrml > max_g_pos-1) then
		diff = (sim_g_nrml + max_g_neg)/2
		error_correction_g_c = error_correction_g_c + (diff*diff) * (g_correction/3)
	end
	
	
	
	-- fade ut kontrollutslag för att försöka minska studsande
	if (sim_alpha > max_alpha_up-max_alpha_fade) then
		wanted_rate = constrain(wanted_rate - (sim_alpha-(max_alpha_up-max_alpha_fade))*max_pitch_rate/max_alpha_fade, -max_pitch_rate, max_pitch_rate)
	end
	if (sim_alpha < max_alpha_down+max_alpha_fade) then
		wanted_rate = constrain(wanted_rate - (sim_alpha-(max_alpha_down+max_alpha_fade))*max_pitch_rate/max_alpha_fade, -max_pitch_rate, max_pitch_rate )
	end
	-- G fade
	if (sim_g_nrml > max_g_pos-max_g_fade) then
		if (prev_rate == 0.0) then
			prev_rate = sim_acf_pitchrate
			g_rest = g_rest + 0.3
		end
		
		diff = sim_g_nrml-(max_g_pos-max_g_fade)
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
	if (sim_yoke_pitch_ratio<0) then
		--wanted_rate = constrain(wanted_rate, wanted_rate,0)
	else
		--wanted_rate = constrain(wanted_rate, 0,wanted_rate)
	end
	
	-- Börja med att vinkla framvingarna så dom ligger helt plant med färdvinkeln (alpha) i detta läget så sker ingen påverkan på planets rotation
	-- Där efter så adderar vi alla önskade korrigeringar och fel
	-- Vi begränsar sedan värdet så det inte överstiger dom vinklar som ger högst rotationskraft så den inte stallar
	
	-- Omvandla önskade ändringar på vinkeln till roderutslag i grader
	wanted_rate = wanted_rate * current_fade_out
	lock = lock * current_fade_out


	--XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[3]"), lock) 
	--XLuaSetNumber(XLuaFindDataRef("sim/cockpit2/engine/actuators/throttle_ratio[2]"), sim_pitch) 
	--error_correction = error_correction * current_fade_out
	angle = (lock+delta*2+wanted_rate+error_correction+error_correction_g) / elevator_rate_to_angle
	canard_angle = (delta*2+(wanted_rate*0.5)+error_correction+error_correction_g_c*0.1) / elevator_rate_to_angle
	
	--angle = angle * current_fade_out
	
	canard = -sim_alpha + constrain(canard_angle, -optimal_angle, optimal_angle)


	-- Här kollar vi om vi ska aktivera luftbroms med framvingarna vid landning
	-- Är motorn på låg fart och någon broms aktiverad samtidigt som hjulen är i marken så aktiverar vi bromsen
	if sim_N1 < 50 and g_groundContact == 1 and ((sim_braking_ratio_right > 0.01 and sim_braking_ratio_left > 0.1) or sim_braking_ratio > 0.1 or sim_speedbrake_ratio > 0.1) then 
		canard = canard -55 -- har tagit bort dragkraften från canarden vid detta läget för det blir ostabilt vid landning, men vi vinklar den för syns skull
		-- kör med vingbromsar istället
		-- XLuaSetNumber(dr_speedbrake_wing_right, 45)
		-- XLuaSetNumber(dr_speedbrake_wing_left, 45)
		-- XLuaSetNumber(dr_speedbrake_wing_right2, 45)
		-- XLuaSetNumber(dr_speedbrake_wing_left2, 45)
		
		XLuaSetNumber(dr_speedbrake2_wing_right, 45)
		XLuaSetNumber(dr_speedbrake2_wing_left, 45)
		XLuaSetNumber(dr_speedbrake2_wing_right2, 45)
		XLuaSetNumber(dr_speedbrake2_wing_left2, 45)
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
	m_elevator = -(angle)
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
	--XLuaSetNumber(dr_right_elevator, sim_yoke_pitch_ratio*90) -- för felkoll
	
	
	
	calculateElevator()
	calculateAileron()
	calculateRudder()
	
	--XLuaSetNumber(dr_right_canard, sim_yoke_pitch_ratio*90) -- för felkoll
	-- Sätt värden på alla vingar efter vad som räknats ut
	-- Framvingen ska bara ha sin uträkning från canard
	if (error_correction>0) then
		m_canard = constrain(m_canard, -55-10, 25+20) -- ge den lite extra spelrumm när den ska göra nödvändiga stabiliseringar
		s_canard = motor(s_canard, m_canard, motor_speed_canard*2)
	else
		m_canard = constrain(m_canard, -55, 25+10)
		s_canard = motor(s_canard, m_canard, motor_speed_canard)
	end
	
	--s_canard = m_canard
	-- Höjdrodret på bakvingen ska ha höjdroder och lite hjälp vid roll så ska den även slå till
	m_elevator_l = constrain(m_elevator+m_aileron/2, -40, 40)
	m_elevator_r = constrain(m_elevator-m_aileron/2, -40, 40)
	s_elevator_l = motor(s_elevator_l, m_elevator_l, motor_speed)
	s_elevator_r = motor(s_elevator_r, m_elevator_r, motor_speed)
	
	-- Skevrodret på bakvingen ska ha bara ha input från roll
	m_aileron_l = constrain(m_aileron, -40, 40)
	--m_aileron_r = constrain(-m_aileron, -40, 40)
	s_aileron_l = motor(s_aileron_l, m_aileron_l, motor_speed*2)
	--s_aileron_r = motor(s_aileron_r, m_aileron_r, motor_speed)

	-- sidoroder
	m_rudder = constrain(m_rudder, -40, 40)
	--m_aileron_r = constrain(-m_aileron, -40, 40)
	s_rudder = motor(s_rudder, m_rudder, motor_speed)

	
	
	XLuaSetNumber(dr_left_canard, s_canard )
	XLuaSetNumber(dr_right_canard, s_canard )
	
	XLuaSetNumber(dr_left_elevator , s_elevator_l)
	XLuaSetNumber(dr_right_elevator, s_elevator_r)
	
	XLuaSetNumber(dr_left_aileron, s_aileron_l)
	XLuaSetNumber(dr_right_aileron, -s_aileron_l)
	
	XLuaSetNumber(dr_vstab, s_rudder)
	
-- Sätt status så vi vet om det här scriuptet fungerar 
	XLuaSetNumber(dr_status, 1)



end

function after_physics() 	
	XLuaSetNumber(dr_override_surfaces, 0) 
end
