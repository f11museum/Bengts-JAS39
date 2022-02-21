-- RB 74 irsökande -> AIM9 i spelet, Räckvidd ?, type 8 i spelet
-- RB 99 radar -> AIM120 i spelet, Räckvidd >50 km, type 9 i spelet

-- ARAK Raketkapsel M/70 6st raketer, totalvikt laddad 365kg



-- knappar
-- hat1 up HVP huvudvapen, välj bästa huvudvapen baserat på J/A/S mod
-- hat1 down AK AKAN automatkanon
-- hat1 left SIJIR Siktesmod Jakt IR. Ska välja sikte för ir-robot på SI
-- hat1 right SIJAK Siktersmod Jakt AKAN. Ska välja sikte för skjuting med AKAN


--sim_mkv_heartbeat = find_dataref("JAS/system/mkv/heartbeat") 
sim_heartbeat = create_dataref("JAS/system/vapen/heartbeat", "number")
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


jas_huvudmod = find_dataref("JAS/huvudmod")

sim_heartbeat = 101
dr_fire = find_command("sim/weapons/fire_any_armed")
dr_wpn_sel_console = find_dataref("sim/cockpit/weapons/wpn_sel_console")
dr_wpn_type = find_dataref("sim/weapons/type") 
dr_wpn_firing = find_dataref("sim/weapons/firing") 

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


heartbeat = 0
function before_physics()
	
	sim_heartbeat = 200 
	avtryckare()
	
	sim_heartbeat = 201
	hvp()
	
	sim_heartbeat = 202
	huvudmod()
	
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