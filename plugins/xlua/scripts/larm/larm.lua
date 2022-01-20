-- Samlingsfil för att räkna ut små enstaka larm
-- Följande larm är här:
-- Minska fart larm
-- Transsonik
-- Öka pådrag
-- Landställ ej ute
-- Parkeringsbroms på i luften

sim_heartbeat = find_dataref("JAS/system/larm/heartbeat") 

sim_heartbeat = 100


-- Knappar
jas_io_vu22_knapp_syst = find_dataref("JAS/io/vu22/knapp/syst")

-- Egna dataref

jas_sys_larm_transsonik = find_dataref("JAS/system/larm/transsonik")
jas_sys_larm_minskafart = find_dataref("JAS/system/larm/minskafart")

jas_system_vat_landst = find_dataref("JAS/system/vat/landst")
jas_system_vat_bromsar = find_dataref("JAS/system/vat/bromsar")

-- Dataref från x-plane
dr_FRP = find_dataref("sim/operation/misc/frame_rate_period")
dr_mach = find_dataref("sim/flightmodel/misc/machno")
dr_ias = find_dataref("sim/flightmodel/position/indicated_airspeed")
dr_gear = find_dataref("sim/cockpit/switches/gear_handle_status") 
dr_nose_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[0]") 
dr_left_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[1]") 

dr_radar_alt = find_dataref("sim/flightmodel/position/y_agl")

dr_gear_warning = find_dataref("sim/cockpit2/annunciators/gear_warning")
dr_parking_brake = find_dataref("sim/cockpit2/controls/parking_brake_ratio")

dr_throttle = find_dataref("sim/flightmodel/engine/ENGN_thro") 


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


function gearWarning()
    jas_system_vat_landst = 0
    if (dr_gear_warning >=1) then
        jas_system_vat_landst = 1
    end
    if (dr_gear == 0 and dr_nose_gear_depress > 0) then
        jas_system_vat_landst = 1
    end
    
end

function bromsar()
    jas_system_vat_bromsar = 0
    if (dr_parking_brake > 0 and dr_left_gear_depress == 0 and dr_radar_alt>10) then
        jas_system_vat_bromsar = 1
    end
    
    if (dr_throttle[0]>0.5 and dr_parking_brake > 0) then -- Parkeringsbroms på och gas över 50%
        jas_system_vat_bromsar = 1
    end
    
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
    sim_heartbeat = 301
	transsonic()
    sim_heartbeat = 302
    gearWarning()
    sim_heartbeat = 303
    bromsar()
    sim_heartbeat = 304
	systest()
	sim_heartbeat = heartbeat
    heartbeat = heartbeat + 1
end

sim_heartbeat = 199