

sim_mkv_heartbeat = find_dataref("JAS/system/mkv/heartbeat") 

sim_mkv_heartbeat = 100

-- Lampor
jas_io_vu22_lamp_mkv = find_dataref("JAS/io/vu22/lamp/mkv")
jas_io_frontpanel_lamp_hojdvarn = find_dataref("JAS/io/frontpanel/lamp/hojdvarn")

-- Knappar
jas_io_vu22_knapp_syst = find_dataref("JAS/io/vu22/knapp/syst")

-- Egna dataref
jas_sys_mkv_eta = find_dataref("JAS/system/mkv/eta")
jas_sys_mkv_larm = find_dataref("JAS/system/mkv/larm")
jas_sys_vat_larmmkv = find_dataref("JAS/vat/larm/larmmkv")

jas_sys_larm_okapadrag = find_dataref("JAS/system/larm/okapadrag")

-- debug
d_ground_diff = create_dataref("JAS/debug/mkv/ground_diff", "number")

-- Dataref från x-plane
sim_FRP = find_dataref("sim/operation/misc/frame_rate_period")
sim_radar_alt = find_dataref("sim/flightmodel/position/y_agl")
dr_above_sea_alt = find_dataref("sim/flightmodel/position/elevation")
sim_vy = find_dataref("sim/flightmodel/position/local_vy")
dr_ias = find_dataref("sim/flightmodel/position/indicated_airspeed")


sim_gear = find_dataref("sim/cockpit/switches/gear_handle_status")


sim_mkv_heartbeat = 101

function flight_start() 
	sim_mkv_heartbeat = 200
end

function aircraft_unload()

end

function do_on_exit()

end


ground_max = 0

function mkv()

	sim_mkv_heartbeat = 400

	radaralt = sim_radar_alt
	seaalt = dr_above_sea_alt
	gear = sim_gear
	vy  = sim_vy

	sim_mkv_heartbeat = 400

	-- Beräkna en terrängprofil
	ground = seaalt - radaralt
	if (ground> ground_max) then
		ground_max = ground
	end
	ground_diff = ground_max - ground
	d_ground_diff = ground_diff
	
	
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
		-- Markkollitionsvarning fast vi har stället ute om en hög hastighet nedåt uppstår, ska kunna ske enligt haveriraporten om man tolkat rätt?

		if (vy < -6) then
			if ( (-vy * 6) > radaralt) then
				timeLeft = radaralt/-vy
				jas_sys_mkv_eta = timeLeft
				larm = 1
			end
		end
		
	end
	
	-- Öka pådrag larmet
	jas_sys_larm_okapadrag = 0
	-- Larm vid hastighet under 300km/h(160knop) och höjd under 300m(1000foot) och markkontakt inom 12s
	if (gear == 0 and dr_ias < 160 and radaralt < 1000) then
		if (vy < 0) then
			if ( (-vy * 12) > radaralt) then
				jas_sys_larm_okapadrag = 1
			end
		end
	else
		-- Markkollitionsvarning fast vi har stället ute om en hög hastighet nedåt uppstår, ska kunna ske enligt haveriraporten om man tolkat rätt?
		-- TODO
	end
	
	jas_sys_mkv_larm = larm
	if (larm == 1) then
		jas_sys_vat_larmmkv = 1
		jas_io_frontpanel_lamp_hojdvarn = 1
	else
		jas_sys_vat_larmmkv = 0
		jas_io_frontpanel_lamp_hojdvarn = 0
	end
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