

sim_mkv_heartbeat = find_dataref("JAS/system/mkv/heartbeat") 

sim_mkv_heartbeat = 100

-- Lampor
jas_io_vu22_lamp_mkv = find_dataref("JAS/io/vu22/lamp/mkv")

-- Knappar
jas_io_vu22_knapp_syst = find_dataref("JAS/io/vu22/knapp/syst")

-- Egna dataref
jas_sys_mkv_eta = find_dataref("JAS/system/mkv/eta")
jas_sys_mkv_larm = find_dataref("JAS/system/mkv/larm")

-- Dataref från x-plane
sim_FRP = find_dataref("sim/operation/misc/frame_rate_period")
sim_radar_alt = find_dataref("sim/flightmodel/position/y_agl")
sim_vy = find_dataref("sim/flightmodel/position/local_vy")

sim_gear = find_dataref("sim/cockpit/switches/gear_handle_status")


sim_mkv_heartbeat = 101

function flight_start() 
	sim_mkv_heartbeat = 200
end

function aircraft_unload()

end

function do_on_exit()

end

function mkv()
	-- 
--     float vy = getVY();
--     float radaralt = getRadarAltitude();
--     int gear = getGear();
-- 
--     if (!gear) {
--         if (vy < 0) {
--             if (-vy * 7 > radaralt) {
--                 float timeLeft = radaralt / -vy;
--                 SetGLTransparentLines();
--                 SetGLText();
--                 sprintf(temp, "MARKKOLLISION %.1f", timeLeft);
--                 DrawHUDText(temp, &fontMain, 0, (50) - ((textHeight(1.0) * text_scale) / 2), 1, color);
--                 setWarning(1);
--             } else {
--                 setWarning(0);
--             }
--         }
--     }    
	sim_mkv_heartbeat = 400

	radaralt = sim_radar_alt
	gear = sim_gear
	vy  = sim_vy


	larm = 0
	if (gear == 0) then
		if (vy < 0) then
			if ( (-vy * 7) > radaralt) then
				timeLeft = radaralt/-vy
				jas_sys_mkv_eta = timeLeft
				larm = 1
			end
		end
	else
		-- Markkollitionsvarning fast vi har stället ute om en hög hastighet nedåt uppstår
		-- TODO
	end
	jas_sys_mkv_larm = larm

end


sys_test_counter = 0
function systest()
	sim_mkv_heartbeat = 900
	if (jas_io_vu22_knapp_syst == 1) then
		
		sys_test_counter = sys_test_counter +sim_FRP
		time1 = math.floor(sys_test_counter)
		if (time1 == 0) then
			sim_jas_lamps_mkv = 1
		end
		if (time1 == 1) then
			sim_jas_lamps_mkv = 0
		end
		
		if (time1 >= 2) then
			sys_test_counter = 0
		end
	end
end

heartbeat = 0
function before_physics() 
    sim_mkv_heartbeat = 300
	mkv()
	systest()
	sim_mkv_heartbeat = heartbeat
    heartbeat = heartbeat + 1
end

sim_mkv_heartbeat = 199