-- Samlingsfil för att räkna ut små enstaka larm
-- Följande larm är här:
-- Minska fart larm
-- Transsonik
-- Öka pådrag

sim_heartbeat = find_dataref("JAS/system/larm/heartbeat") 

sim_heartbeat = 100


-- Knappar
jas_io_vu22_knapp_syst = find_dataref("JAS/io/vu22/knapp/syst")

-- Egna dataref

jas_sys_larm_transsonik = find_dataref("JAS/system/larm/transsonik")
jas_sys_larm_minskafart = find_dataref("JAS/system/larm/minskafart")

-- Dataref från x-plane
dr_FRP = find_dataref("sim/operation/misc/frame_rate_period")
dr_mach = find_dataref("sim/flightmodel/misc/machno")
dr_ias = find_dataref("sim/flightmodel/position/indicated_airspeed")
dr_gear = find_dataref("sim/cockpit/switches/gear_handle_status") 
dr_nose_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[0]") 

sim_heartbeat = 101

-- Lokala variabler


function flight_start() 
	sim_heartbeat = 200
end

function aircraft_unload()

end

function do_on_exit()

end


mach_lo = 0.95
mach_hi = 1.05
mach_pass = 0
mach_mute = 0
function transsonic()
    jas_sys_larm_transsonik = 0
	sim_mach = dr_mach + 0.0
	if (sim_mach > mach_lo and sim_mach < mach_hi ) then
		jas_sys_larm_transsonik = 1
	end
	
end


function minskafart()
    maxspeed = 2000
    if (dr_gear == 1) then
        maxspeed = 324 -- 600km/h max fart med ställ ute
    end
    if (dr_nose_gear_depress > 0) then
        maxspeed = 190 -- 350km/h max fart på marken
    end
    
    if (dr_ias > maxspeed) then
        jas_sys_larm_minskafart = 1
    else
        jas_sys_larm_minskafart = 0
    end
    
end

function okapadrag()
    
end

sys_test_counter = 0
function systest()
	sim_heartbeat = 900
	if (jas_io_vu22_knapp_syst == 1) then
		
		sys_test_counter = sys_test_counter +dr_FRP
		time1 = math.floor(sys_test_counter)
		if (time1 == 0) then
			--jas_pratorn_tal_systemtest = 1
		end
		if (time1 == 1) then
			jas_pratorn_larm_mkv = 1
		end
		
		if (time1 >= 2) then
			sys_test_counter = 0
		end
	end
end

heartbeat = 0
function before_physics() 
    sim_heartbeat = 300
	
	minskafart()
	transsonic()
	systest()
	sim_heartbeat = heartbeat
    heartbeat = heartbeat + 1
end

sim_heartbeat = 199