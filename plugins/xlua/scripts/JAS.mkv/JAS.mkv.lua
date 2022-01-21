

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
jas_sys_mkv_gneed = find_dataref("JAS/system/mkv/gneed")
jas_sys_mkv_needmore = find_dataref("JAS/system/mkv/needmore")
jas_sys_vat_larmmkv = find_dataref("JAS/vat/larm/larmmkv")

jas_sys_larm_okapadrag = find_dataref("JAS/system/larm/okapadrag")

jas_pratorn_tal_taupp = find_dataref("JAS/pratorn/tal/taupp")
jas_pratorn_larm_mkv = find_dataref("JAS/pratorn/larm/mkv")
jas_pratorn_tal_hojd = find_dataref("JAS/pratorn/tal/hojd")

jas_fbw_max_roll_rate = find_dataref("JAS/fbw/max_roll_rate")

-- debug
d_ground_diff = create_dataref("JAS/debug/mkv/ground_diff", "number")
d_upprullningstid = create_dataref("JAS/debug/mkv/upprull", "number")
d_gneed = create_dataref("JAS/debug/mkv/gneed", "number")
d_radie = create_dataref("JAS/debug/mkv/radie", "number")
d_vinkel = create_dataref("JAS/debug/mkv/vinkel", "number")
d_uppalt = create_dataref("JAS/debug/mkv/uppalt", "number")

-- Dataref från x-plane
sim_FRP = find_dataref("sim/operation/misc/frame_rate_period")
sim_radar_alt = find_dataref("sim/flightmodel/position/y_agl")
dr_above_sea_alt = find_dataref("sim/flightmodel/position/elevation")
sim_vy = find_dataref("sim/flightmodel/position/local_vy")
dr_ias = find_dataref("sim/flightmodel/position/indicated_airspeed")
dr_true_speed = find_dataref("sim/flightmodel/position/true_airspeed") -- är i meter/s
dr_throttle = find_dataref("sim/flightmodel/engine/ENGN_thro") 
dr_acf_roll = find_dataref("sim/flightmodel/position/phi") 
dr_alpha = find_dataref("sim/flightmodel/position/alpha") 
dr_acf_pitch = find_dataref("sim/flightmodel/position/theta") 
dr_g_nrml = find_dataref("sim/flightmodel/forces/g_nrml") 

sim_gear = find_dataref("sim/cockpit/switches/gear_handle_status")


sim_mkv_heartbeat = 101

function flight_start() 
	sim_mkv_heartbeat = 200
end

function aircraft_unload()

end

function do_on_exit()

end

blink1s = 0
blink025s = 0
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
    t2 = math.floor(blinktimer*4)
	if (t2 % 2 == 0) then
		blink025s = 1
	else 
		blink025s = 0
	end
	sim_heartbeat = 499
end


ground_max = 0

speed_prev = 0

--profil1 = {64,128,192,256,320,384,448,512}
profil1 = {}
profil1[1] = 5
profil1[2] = 64
profil1[3] = 128
profil1[4] = 192
profil1[5] = 256
profil1[6] = 320
profil1[7] = 384
profil1[8] = 448
profil1[9] = 512
--profil2 = {128,256,384,512, 640, 768, 896, 1024 1152,1280,1408,1536,1664,1792,1920}

function mkv()

	sim_mkv_heartbeat = 400

	radaralt = sim_radar_alt
	seaalt = dr_above_sea_alt
	gear = sim_gear
	vy  = sim_vy
	roll = math.abs(dr_acf_roll)
	
	max_roll_rate = jas_fbw_max_roll_rate
	
	sim_mkv_heartbeat = 400

	-- Beräkna en terrängprofil
	ground = seaalt - radaralt
	if (ground> ground_max) then
		ground_max = ground
	end
	ground_diff = ground_max - ground
	d_ground_diff = ground_diff
	sim_mkv_heartbeat = 401	
	local i = 1
	while profil1[i] do
		if (profil1[i] > ground) then
			break
		end
		i = i + 1
	end
	
	-- if (radaralt < profil1[i]) then
	-- 	jas_pratorn_tal_hojd = 1
	-- end
	sim_mkv_heartbeat = 402
	hsak = radaralt - radaralt*0.01
	
	if (hsak < 1) then
		hsak = 1
	end
	
	upprullningstid = (roll/max_roll_rate)*3
	d_upprullningstid = upprullningstid
	kollitionstid = 7+upprullningstid
	
	uppbyggnadstid = (9-dr_g_nrml)*0.12
	
	sim_mkv_heartbeat = 403
	upp_alt = (radaralt*0.90) - (-vy*upprullningstid) - (-vy*uppbyggnadstid)
	d_uppalt = upp_alt
	sim_mkv_heartbeat = 4031
	if (upp_alt<=1) then
		upp_alt = 1
	end
	sim_mkv_heartbeat = 4032
	-- Räkna ut halvcirkellängd baserat på planets vinkel och avstånd till marken 
	-- pi/180 = 0.01745329251
	
	-- Räkna ut radien först

	vinkel = -math.rad(dr_acf_pitch-dr_alpha)
	d_vinkel = vinkel
	radie = upp_alt/(1-math.cos(vinkel))
	d_radie = radie

	gneed = (dr_true_speed*dr_true_speed) / radie
	
	jas_sys_mkv_gneed = gneed/9.82 +1
	
	if (dr_g_nrml < jas_sys_mkv_gneed) then
		jas_sys_mkv_needmore = blink025s
	else
		jas_sys_mkv_needmore = 0
	end
	
	sim_mkv_heartbeat = 405
	larm = 0
	if (gear == 0) then
		if (vy < 0) then
			if ( (-vy * (kollitionstid)) > upp_alt) then
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
	sim_mkv_heartbeat = 406
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
		if (timeLeft < 7 or (jas_sys_mkv_needmore and jas_sys_mkv_gneed>3) ) then
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
	blink1sFunc()
	mkv()
	systest()
	sim_mkv_heartbeat = heartbeat
    heartbeat = heartbeat + 1
end

sim_mkv_heartbeat = 199