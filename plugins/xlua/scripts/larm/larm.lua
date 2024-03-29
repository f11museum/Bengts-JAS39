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
jas_io_vu22_knapp_ltbra = find_dataref("JAS/io/vu22/knapp/ltbra")
-- Egna dataref

jas_sys_larm_transsonik = find_dataref("JAS/system/larm/transsonik")
jas_sys_larm_minskafart = find_dataref("JAS/system/larm/minskafart")

jas_vat_larm_landst = find_dataref("JAS/vat/larm/landst")
jas_vat_larm_bromsar = find_dataref("JAS/vat/larm/bromsar")
jas_vat_larm_dragkr = find_dataref("JAS/vat/larm/dragkr")
jas_vat_larm_bramgd = find_dataref("JAS/vat/larm/bramgd")
jas_vat_larm_brasys = find_dataref("JAS/vat/larm/brasys")

jas_vat_larmkod = find_dataref("JAS/vat/larmkod")

jas_pratorn_larm_gransvarde = find_dataref("JAS/pratorn/larm/gransvarde")
jas_pratorn_larm_gransvarde_g = find_dataref("JAS/pratorn/larm/gransvarde_g")

jas_fuel_total = find_dataref("JAS/fuel/total")
jas_fuel_pct = find_dataref("JAS/fuel/pct")
jas_fuel_home = find_dataref("JAS/fuel/home")

-- Dataref från x-plane
dr_FRP = find_dataref("sim/operation/misc/frame_rate_period")
dr_mach = find_dataref("sim/flightmodel/misc/machno")
dr_ias = find_dataref("sim/flightmodel/position/indicated_airspeed")
dr_gear = find_dataref("sim/cockpit/switches/gear_handle_status") 
dr_nose_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[0]") 
dr_left_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[1]") 
dr_right_gear_depress = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[2]") 
dr_alpha = find_dataref("sim/flightmodel/position/alpha") 
dr_g_nrml = find_dataref("sim/flightmodel/forces/g_nrml") 

dr_radar_alt = find_dataref("sim/flightmodel/position/y_agl")

dr_gear_warning = find_dataref("sim/cockpit2/annunciators/gear_warning")
dr_parking_brake = find_dataref("sim/cockpit2/controls/parking_brake_ratio")
dr_speedbrake_ratio = find_dataref("sim/cockpit2/controls/speedbrake_ratio")

dr_throttle = find_dataref("sim/flightmodel/engine/ENGN_thro") 
dr_fuel1 = find_dataref("sim/flightmodel/weight/m_fuel_total")
dr_warn_fuel_press = find_dataref("sim/cockpit/warnings/annunciators/fuel_pressure")

sim_heartbeat = 101

-- Lokala variabler
g_markkontakt = 1

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


function landst()
	jas_vat_larm_landst = 0
	if (dr_gear_warning >=1) then -- x-plane tycker landstället borde va ute
		jas_vat_larm_landst = 1
	end
	
	--LANDST 163 LANDST-SPAK Otillåten hantering av landställspaken, Infällning beordras när Fpl har vikt på hjulen. 
	if (dr_gear == 0 and dr_nose_gear_depress > 0) then
		jas_vat_larm_landst = 1
		jas_vat_larmkod[163] = 1
	end
	
	-- LANDST 166 HÖG FART LANDST För hög fart för stället, utfällning över 600km/h, eller ställ ej infällt över 610km/h
	if (dr_gear == 1 and dr_ias>324) then
		jas_vat_larm_landst = 1
		jas_vat_larmkod[166] = 1
	end
	
	-- LANDST 167 GLÖM EJ LANDST Påminnelse att fälla ut landställen vid landing, när indikerad fart mindre än 325km/h, markkorrigeradhöjd mindre än 500m, pådrag med manöverarmsvinkel mindre än 55grader
	if (dr_gear == 0 and dr_ias<175 and dr_throttle[0]<0.5 and dr_radar_alt<500) then
		jas_vat_larm_landst = 1
		jas_vat_larmkod[167] = 1
	end
end

function bromsar()
	jas_vat_larm_bromsar = 0
	if (dr_parking_brake > 0 and dr_left_gear_depress == 0 and dr_radar_alt>10) then
		jas_vat_larm_bromsar = 1
		jas_vat_larmkod[177] = 1
	end
	
	if (dr_throttle[0]>0.5 and dr_parking_brake > 0) then -- Parkeringsbroms på och gas över 50%
		jas_vat_larm_bromsar = 1
		jas_vat_larmkod[177] = 1
	end
	if (dr_throttle[0]>0.85 and dr_speedbrake_ratio > 0) then -- Luftbroms på och gas över 85%
		jas_vat_larm_bromsar = 1
		jas_vat_larmkod[178] = 1
	end
end

function dragkr()
	-- DRAGKR 056 UNDER FTG Dragkraftsreglaget har förts förbi FTG under flygning
	if (dr_throttle[0] < 0.01 and g_markkontakt == 0) then
		jas_vat_larmkod[56] = 1
		jas_vat_larm_dragkr = 1
	else
		--jas_vat_larmkod[56] = 0
		
		jas_vat_larm_dragkr = 0
	end
end


function brasys()
	jas_vat_larm_brasys = 0
	-- BRÄ SYS 020 LT-KRAN STÄNGD Strömställare LT-BRÄ är i läge stängd
	if (jas_io_vu22_knapp_ltbra == 0) then
		jas_vat_larm_brasys = 1
		jas_vat_larmkod[20] = 1
	end
	
	-- BRÄ SYS 025 BRÄ-UPPF TANKPUMP Bränsletrycket från tankpumpens utlopp är lågt...
	if (dr_warn_fuel_press >0) then -- läs från x-plane
		jas_vat_larm_brasys = 1
		jas_vat_larmkod[25] = 1
	end
end

function bramgd()
	jas_vat_larm_bramgd = 0
	-- 24% larmgräns
	if (jas_fuel_pct <25) then 
		jas_vat_larm_bramgd = 1
		jas_vat_larmkod[30] = 1 -- generarar larm 030

	end
	
	if (jas_fuel_pct < jas_fuel_home ) then
		jas_vat_larm_bramgd = 1
		jas_vat_larmkod[298] = 1 -- generarar larm 298 HEMFLYG-BRÄNSLE
		jas_vat_larmkod[29] = 1 
	end
	
end

function stall()
	
	if (dr_ias>50 and dr_alpha>20) then
		jas_pratorn_larm_gransvarde = 1
	end
end

function maxg()
	
	if (dr_g_nrml > 8.1 or dr_g_nrml < -3.1) then
		jas_pratorn_larm_gransvarde_g = 1
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
	if (dr_nose_gear_depress>0 or dr_left_gear_depress>0 or dr_right_gear_depress>0) then
		g_markkontakt = 1
	else
		g_markkontakt = 0
	end

	minskafart()
	sim_heartbeat = 301
	transsonic()
	sim_heartbeat = 302
	landst()
	sim_heartbeat = 303
	bromsar()
	sim_heartbeat = 304
	dragkr()
	sim_heartbeat = 305
	bramgd()
	sim_heartbeat = 306
	brasys()
	sim_heartbeat = 307
	stall()
	sim_heartbeat = 308
	maxg()
	
	systest()
	sim_heartbeat = heartbeat
	heartbeat = heartbeat + 1
end

sim_heartbeat = 199