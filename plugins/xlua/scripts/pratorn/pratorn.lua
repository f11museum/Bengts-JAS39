-- Prat datorn, pratorn

-- Sätter variabler i JAS/pratorn/* som sedan spelas upp av externt program.
-- Sätt till 1 för att bara spela ljudet en gång
-- Sätt till 2 för att spela repeterande så länge som variabeln är kvar som 2
-- Sätt till 3 för att spela upprepande men med lite längre mellanrum


sim_heartbeat = find_dataref("JAS/system/pratornlua/heartbeat") 

sim_heartbeat = 100

-- Tal signaler
jas_pratorn_tal_spak = find_dataref("JAS/pratorn/tal/spak")
jas_pratorn_tal_taupp = find_dataref("JAS/pratorn/tal/taupp")
jas_pratorn_tal_okapadrag = find_dataref("JAS/pratorn/tal/okapadrag")
jas_pratorn_tal_alfa12 = find_dataref("JAS/pratorn/tal/alfa12")
jas_pratorn_tal_fix = find_dataref("JAS/pratorn/tal/fix")
jas_pratorn_tal_minskafart = find_dataref("JAS/pratorn/tal/minskafart")
jas_pratorn_tal_ejtils = find_dataref("JAS/pratorn/tal/ejtils")
jas_pratorn_tal_hojd = find_dataref("JAS/pratorn/tal/hojd")
jas_pratorn_tal_marktryckfel = find_dataref("JAS/pratorn/tal/marktryckfel")
jas_pratorn_tal_transsonik = find_dataref("JAS/pratorn/tal/transsonik")
jas_pratorn_tal_systemtest = find_dataref("JAS/pratorn/tal/systemtest")

jas_pratorn_larm_mkv = find_dataref("JAS/pratorn/larm/mkv")
jas_pratorn_larm_transsonik = find_dataref("JAS/pratorn/larm/transsonik")
jas_pratorn_larm_gransvarde = find_dataref("JAS/pratorn/larm/gransvarde")


-- Knappar
jas_io_vu22_knapp_syst = find_dataref("JAS/io/vu22/knapp/syst")

-- Egna dataref

jas_sys_mkv_larm = find_dataref("JAS/system/mkv/larm")
jas_sys_larm_transsonik = find_dataref("JAS/system/larm/transsonik")
jas_sys_larm_minskafart = find_dataref("JAS/system/larm/minskafart")
jas_sys_larm_okapadrag = find_dataref("JAS/system/larm/okapadrag")

-- Dataref från x-plane
dr_FRP = find_dataref("sim/operation/misc/frame_rate_period")
dr_mach = find_dataref("sim/flightmodel/misc/machno")


sim_heartbeat = 101

-- Lokala variabler
mach_lo = 0.95
mach_hi = 1.05
mach_pass = 0
mach_mute = 0

function flight_start() 
	sim_heartbeat = 200
end

function aircraft_unload()

end

function do_on_exit()

end

function transsonic()
	sim_mach = dr_mach + 0.0
	if (sim_mach > mach_lo and sim_mach < mach_hi and mach_pass == 0) then
		mach_pass = 1
		if (mach_mute == 0) then
			jas_pratorn_tal_transsonik = 1
			jas_pratorn_larm_transsonik = 1
			mach_mute = 1
		end
	end
	
	
	if (mach_mute == 1) then
		if (sim_mach < mach_lo-0.005) then
			mach_mute = 0
			mach_pass = 0
		end
		if (sim_mach > mach_hi+0.005) then
			mach_mute = 0
			mach_pass = 0
		end
	end
	
end

sys_test_counter = 0
function systest()
	sim_heartbeat = 900
	if (jas_io_vu22_knapp_syst == 1) then
		
		sys_test_counter = sys_test_counter +dr_FRP
		time1 = math.floor(sys_test_counter)
		if (time1 == 0) then
			jas_pratorn_tal_systemtest = 1
		end
		if (time1 == 1) then
			--jas_pratorn_tal_systemtest = 1
		end
		
		if (time1 >= 2) then
			sys_test_counter = 0
		end
	end
end

transsonik_once = 0

heartbeat = 0
function before_physics() 
    sim_heartbeat = 300
	
	if (jas_sys_mkv_larm >= 1) then
		jas_pratorn_tal_taupp = 2
		--jas_pratorn_tal_hojd = 2
		jas_pratorn_larm_mkv = 2
	else
		jas_pratorn_tal_taupp = 0
		--jas_pratorn_tal_hojd = 0
		jas_pratorn_larm_mkv = 0
	end
	
	--transsonic()
	if (jas_sys_larm_transsonik >= 1) then
		if (transsonik_once == 0) then
			jas_pratorn_tal_transsonik = 1
			jas_pratorn_larm_transsonik = 1
			transsonik_once = 1
		end
	else
		transsonik_once = 0
	end
	
	--Minska fart
	if (jas_sys_larm_minskafart >= 1) then
		jas_pratorn_tal_minskafart = 1
		jas_pratorn_larm_transsonik = 1
	end
	
	-- Öka pådrag
	if (jas_sys_larm_okapadrag >= 1) then
		jas_pratorn_tal_okapadrag = 1
		--jas_pratorn_larm_gransvarde = 1
	end
	
	systest()
	sim_heartbeat = heartbeat
    heartbeat = heartbeat + 1
end

sim_heartbeat = 199