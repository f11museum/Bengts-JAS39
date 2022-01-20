

-- 1.12.4 Markkollisionsvarningssystemet (MKV)
-- För föraren presenteras markkollisionsvarning i fyra olika nivåer beroende på vilken grad av
-- manövrering som krävs för att häva tillståndet. Nedan följer en kortfattad förklaring av
-- nivåerna som benämns A, B, C och D.
-- A MKV-symbolen (pilar) tänds upp med fast sken på samtliga indikatorer och pratorvarning
-- ”ta upp” ges under en viss förvarningstid (3 sek i detta fall) innan föraren måste ansätta
-- upptagningsmanöver med motsvarande 80 % av tillgänglig lyftkraft.
-- B MKV-symbolen börjar blinka och höjdvarningslampan tänds när halva denna förvarningstid
-- gått utan att föraren vidtagit åtgärder. I samband med detta så aktiveras den akustiska
-- varningen i form av en tonorgel med max volym. Blinkningarna upphör när tillräcklig åtgärd
-- vidtagits.
-- C Förvarningstiden är slut och MKV symbolen passerar fartvektorsymbolen.
-- 16
-- D Därefter räcker det inte med manövrering enligt förutbestämda värden (a=80 % av MLLgräns). Då börjar MKV-symbolens pilspetsar att växa och den nödvändiga lastfaktorn skrivs ut
-- i numeriska värden vid symbolens nederkant.


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

jas_pratorn_tal_taupp = find_dataref("JAS/pratorn/tal/taupp")
jas_pratorn_larm_mkv = find_dataref("JAS/pratorn/larm/mkv")

-- debug
d_ground_diff = create_dataref("JAS/debug/mkv/ground_diff", "number")

-- Dataref från x-plane
sim_FRP = find_dataref("sim/operation/misc/frame_rate_period")
sim_radar_alt = find_dataref("sim/flightmodel/position/y_agl")
dr_above_sea_alt = find_dataref("sim/flightmodel/position/elevation")
sim_vy = find_dataref("sim/flightmodel/position/local_vy")
dr_ias = find_dataref("sim/flightmodel/position/indicated_airspeed")
dr_throttle = find_dataref("sim/flightmodel/engine/ENGN_thro") 

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

speed_prev = 0

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
			if ( (-vy * (7+3)) > radaralt) then
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
	fart_minskar = 0
	if (dr_ias < speed_prev) then
		fart_minskar = 1
	end
	speed_prev = dr_ias
	jas_sys_larm_okapadrag = 0
	-- Larm vid hastighet under 300km/h(160knop) och höjd under 300m(1000foot) och markkontakt inom 12s, och lågt pådrag
	if (gear == 0 and dr_ias < 160 and radaralt < 1000 and fart_minskar == 1 and dr_throttle[0] < 0.55) then
		if (vy < 0) then
			if ( (-vy * 15) > radaralt) then
				jas_sys_larm_okapadrag = 1
			end
		end
	else
		-- Markkollitionsvarning fast vi har stället ute om en hög hastighet nedåt uppstår, ska kunna ske enligt haveriraporten om man tolkat rätt?
		-- TODO
	end
	
	jas_sys_mkv_larm = larm
	if (larm == 1) then
		-- Nivå A
		jas_pratorn_tal_taupp = 2
		if (timeLeft < 7) then
			-- Nivå B aktivera tonorgel och höjdvarningslampa
			jas_sys_vat_larmmkv = 1
			jas_pratorn_larm_mkv = 2
			jas_io_frontpanel_lamp_hojdvarn = 1
		end
		if (timeLeft < 5) then
			-- Nivå C
		end
		
	else
		jas_pratorn_tal_taupp = 0
		jas_pratorn_larm_mkv = 0
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