-- RB 74 irsökande -> AIM9 i spelet, Räckvidd ?, type 8 i spelet
-- RB 99 radar -> AIM120 i spelet, Räckvidd >50 km, type 9 i spelet
	
-- ARAK Raketkapsel M/70 6st raketer, totalvikt laddad 365kg



-- knappar
-- hat1 up HVP huvudvapen, välj bästa huvudvapen baserat på J/A/S mod
-- hat1 down AK AKAN automatkanon
-- hat1 left SIJIR Siktesmod Jakt IR. Ska välja sikte för ir-robot på SI
-- hat1 right SIJAK Siktersmod Jakt AKAN. Ska välja sikte för skjuting med AKAN


--sim_mkv_heartbeat = find_dataref("JAS/system/mkv/heartbeat") 
sim_heartbeat = find_dataref("JAS/heartbeat/vapen", "number")
sim_heartbeat = 100
jas_io_spak_knapp_fire = find_dataref("JAS/io/spak/knapp/fire")
jas_io_spak_knapp_hat1_up = find_dataref("JAS/io/spak/knapp/hat1_up")
jas_io_spak_knapp_hat1_down = find_dataref("JAS/io/spak/knapp/hat1_down")
jas_io_spak_knapp_hat1_left = find_dataref("JAS/io/spak/knapp/hat1_left")
jas_io_spak_knapp_hat1_right = find_dataref("JAS/io/spak/knapp/hat1_right")
jas_io_st_knapp_hvp = find_dataref("JAS/io/st/knapp/HVP")
jas_io_st_knapp_irb = find_dataref("JAS/io/st/knapp/IRB")
jas_io_st_knapp_ak = find_dataref("JAS/io/st/knapp/AK")
jas_io_st_knapp_j = find_dataref("JAS/io/st/knapp/J")
jas_io_st_knapp_a = find_dataref("JAS/io/st/knapp/A")
jas_io_st_knapp_s = find_dataref("JAS/io/st/knapp/S")

jas_io_st_lamp_j = find_dataref("JAS/io/st/lamp/J")
jas_io_st_lamp_a = find_dataref("JAS/io/st/lamp/A")
jas_io_st_lamp_s = find_dataref("JAS/io/st/lamp/S")

jas_vu22_vapenred = find_dataref("JAS/io/vu22/knapp/vapenred")
jas_vu22_vapenop = find_dataref("JAS/io/vu22/knapp/vapenop")
jas_vu22_vapensim = find_dataref("JAS/io/vu22/knapp/vapensim")
jas_vu22_vapenfikt = find_dataref("JAS/io/vu22/knapp/vapenfikt")

jas_fuel_total = find_dataref("JAS/fuel/total")
jas_fuel_eta = find_dataref("JAS/fuel/eta")
jas_fuel_range = find_dataref("JAS/fuel/range")
jas_fuel_pct = find_dataref("JAS/fuel/pct")

jas_fuel = find_dataref("JAS/fuel")

jas_huvudmod = find_dataref("JAS/huvudmod")
jas_vapen_mode = find_dataref("JAS/vapen/mode")

sim_heartbeat = 101
dr_fire = find_command("sim/weapons/fire_any_armed")
dr_wpn_sel_console = find_dataref("sim/cockpit/weapons/wpn_sel_console")
dr_wpn_type = find_dataref("sim/weapons/type") 
dr_wpn_firing = find_dataref("sim/weapons/firing") 
dr_wpn_fuel_warhead_mass_now = find_dataref("sim/weapons/fuel_warhead_mass_now") 
dr_m_fuel_total = find_dataref("sim/flightmodel/weight/m_fuel_total") 
dr_fuel_flow = find_dataref("sim/flightmodel/engine/ENGN_FF_") 
dr_groundspeed = find_dataref("sim/flightmodel/position/groundspeed") 

dr_balk1_l_type = find_dataref("sim/weapons/type[1]") -- Balknumrering enligt handbok, 1 Vingspetsar
balk1_l_index = 7
dr_balk1_r_type = find_dataref("sim/weapons/type[2]") -- 1 Vingspetsar
balk1_r_index = 6
dr_balk2_l_type = find_dataref("sim/weapons/type[3]") -- 2 yttervinge
dr_balk2_r_type = find_dataref("sim/weapons/type[4]")
balk2_l_index = 4
balk2_r_index = 5
dr_balk3_l_type = find_dataref("sim/weapons/type[5]") -- 3 innervinge
dr_balk3_r_type = find_dataref("sim/weapons/type[6]")
balk3_l_index = 2
balk3_r_index = 3
dr_balk4_type = find_dataref("sim/weapons/type[7]") -- sidoplats på kroppen
balk4_index = 10
dr_balk5_type = find_dataref("sim/weapons/type[8]") -- Mittenplatsen
balk5_index = 0
dr_balk6_type = find_dataref("sim/weapons/type[9]") -- balk 6 finns inte men hänvisar till AKAN
balk6_index = 1

dr_payload =  find_dataref("sim/flightmodel/weight/m_fixed") -- den dumma extra vikten som x-plane alltid lägger på planet
 

d_selected = create_dataref("JAS/debug/vapen/selected", "number")
d_klick = create_dataref("JAS/debug/vapen/klick", "number")
-- d_fuel = create_dataref("JAS/debug/vapen/fuel", "number")


function myfilter(currentValue, newValue, amp)

	return ((currentValue*amp) + (newValue))/(amp+1)
	
end

sim_heartbeat = 102
avtryckare_prev = 0
function avtryckare()
	if (jas_io_spak_knapp_fire == 1) then
		if (avtryckare_prev == 0) then
			avtryckare_prev = 1
			dr_fire:start()
		end
	else
		if (avtryckare_prev == 1) then
			avtryckare_prev = 0
			dr_fire:stop()
		end
	end	
end

function selectByType(typ)
	selected = -1
	for i=0, 10 do
		if (dr_wpn_type[i] == typ and dr_wpn_firing[i] == 0) then
			dr_wpn_sel_console = i
			selected = i
			return selected
		end
	end
	return selected
end

function selectHVPjakt()
	-- Leta efter radar robot, typ 9 i spelet 
	d_selected = selectByType(9)
end
function selectHVPattack()
	-- Leta efter ARAK, typ 4 i spelet 
	d_selected = selectByType(4)
end

function selectIRjakt()
	-- Leta efter ir robot, typ 8 i spelet 
	d_selected = selectByType(8)
end
function selectAKAN()
	-- Leta efter ir robot, typ 8 i spelet 
	d_selected = selectByType(3)
end

hvp_prev = 0
test_h = 0
function hvp()

-- if J/A/S olika vapen


	-- HVP Huvudvapen väljare
	if ((jas_io_st_knapp_hvp == 1) or (jas_io_spak_knapp_hat1_up == 1)) then
		if (jas_huvudmod == 1) then
			selectHVPjakt()
		end
		if (jas_huvudmod == 2) then
			selectHVPattack()
		end
		
	end	
	-- IRB väljare
	if ((jas_io_st_knapp_irb == 1) ) then
		selectIRjakt()
		
	end	
	--AKAN
	if ((jas_io_st_knapp_ak == 1) or (jas_io_spak_knapp_hat1_down == 1) ) then
		selectAKAN()
		
	end	
end

function huvudmod()
	if ((jas_io_st_knapp_j == 1) ) then
		jas_huvudmod = 1
	end	
	if ((jas_io_st_knapp_a == 1) ) then
		jas_huvudmod = 2
	end	
	if ((jas_io_st_knapp_s == 1) ) then
		jas_huvudmod = 3
	end	
	
	if (jas_huvudmod == 1) then
		jas_io_st_lamp_j = 1
		jas_io_st_lamp_a = 0
		jas_io_st_lamp_s = 0
	end
	if (jas_huvudmod == 2) then
		jas_io_st_lamp_j = 0
		jas_io_st_lamp_a = 1
		jas_io_st_lamp_s = 0
	end
	if (jas_huvudmod == 3) then
		jas_io_st_lamp_j = 0
		jas_io_st_lamp_a = 0
		jas_io_st_lamp_s = 1
	end
end

function vapenmod()
    -- sim_heartbeat = 300
    -- Vapenväljarens mod
    if (jas_vu22_vapenop == 1) then
        -- sim_heartbeat = 301
        jas_vapen_mode = 2
    elseif (jas_vu22_vapenred == 1) then
        -- sim_heartbeat = 302
        jas_vapen_mode = 1
    elseif (jas_vu22_vapensim == 1) then
        -- sim_heartbeat = 303
        jas_vapen_mode = 3
    elseif (jas_vu22_vapenfikt == 1) then
        -- sim_heartbeat = 304
        jas_vapen_mode = 4
    else
        -- sim_heartbeat = 305
        jas_vapen_mode = 0
        -- sim_heartbeat = 306
    end
    -- sim_heartbeat = 399
end

function isFuelTank(index) 
	-- sim_heartbeat = 40020
	if (dr_wpn_type[index] == 23 and dr_wpn_firing[index] == 0) then
		-- sim_heartbeat = 40021
		return 1
	end
	-- sim_heartbeat = 40022
	return 0
end

function getFuelInTank(index) 
	-- sim_heartbeat = 40010
	if (isFuelTank(index) == 1) then
		return dr_wpn_fuel_warhead_mass_now[index]
	end
	return 0.0
end

eta_prev = 0
function totalFuel()
	-- sim_heartbeat = 4000
	total = 0.0
	total = total + dr_m_fuel_total
	-- sim_heartbeat = 400
	total = total + getFuelInTank(0)
	-- sim_heartbeat = 401
	total = total + getFuelInTank(2)
	-- sim_heartbeat = 402
	total = total + getFuelInTank(3)
	total = total + getFuelInTank(4)
	total = total + getFuelInTank(5)
	sim_heartbeat = 406
	jas_fuel_total = total
	
	sim_heartbeat = 4061
	jas_fuel_pct = jas_fuel_total /(2750*0.8)*100
	sim_heartbeat = 4062
	-- d_fuel = jas_fuel
	if (dr_fuel_flow[0]>0) then
		eta = total / dr_fuel_flow[0]
		jas_fuel_eta = myfilter(eta_prev,eta , 10)
		eta_prev = eta
	end
	sim_heartbeat = 407
	jas_fuel_range = dr_groundspeed * jas_fuel_eta
	sim_heartbeat = 408
end

run_at_interval(totalFuel, 1.0)

heartbeat = 0
function before_physics()
	
	sim_heartbeat = 200 
	avtryckare()
	
	sim_heartbeat = 201
	hvp()
	
	sim_heartbeat = 202
	huvudmod()

	sim_heartbeat = 203
	vapenmod()
	
	sim_heartbeat = 204
	--totalFuel()
	
	dr_payload =  0-- ta bort den dumma extra vikten som x-plane alltid lägger på planet
	
	sim_heartbeat = heartbeat
	heartbeat = heartbeat + 1
end

function flight_start() 

end

function aircraft_unload()

end

function do_on_exit()

end
sim_heartbeat = 199
