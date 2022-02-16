-------------------------------------------------------
---- elektroniksystem för JAS
---- F11 Museum 2021 Bengt
---- F1  Museum 2022 Kasper
-------------------------------------------------------

sim_el_heartbeat = find_dataref("JAS/heartbeat/el")

sim_el_heartbeat = 100

jas_system_ess_power = find_dataref("JAS/system/ess/power")

jas_io_vu22_knapp_syst = find_dataref("JAS/io/vu22/knapp/syst")

jas_io_vat_lamp_luftsys = find_dataref("JAS/io/vat/lamp/luftsys")

jas_el_skena_huv_vac_a = find_dataref("JAS/el/stromskena/huvud_vac_a")		--AFK AMOT TNS fenpitotrör alfagivare-vänster RT36 FR38 FRM39 IK f/s EP17-TI-FI-SI förbandbelys taxistrålk identbelys
jas_el_skena_sek_vac_a = find_dataref("JAS/el/stromskena/sekundar_vac_a")	--AVAP+balkar nospitotrör alfagivare-höger betagivare MIP CEM TS EP17-pp2-MI lant antikol strålk
jas_el_skena_sek_vac_b = find_dataref("JAS/el/stromskena/sekundar_vac_b")	--radar
jas_el_skena_huv_a	= find_dataref("JAS/el/stromskena/huvud_a")				--AFPL huvudblock
jas_el_skena_huv_a1	= find_dataref("JAS/el/stromskena/huvud_a1")			--AMOT hydraul el TNS DAP LD7 utlopp-rpm-ind horizontgyro broms ident indiker belys 
jas_el_skena_huv_a2	= find_dataref("JAS/el/stromskena/huvud_a2")			--NÖDF RGENsys
jas_el_skena_huv_c	= find_dataref("JAS/el/stromskena/huvud_c")				--AMOT RHM TILS SSR vingspetsljus CEM SD EP17 minnes hålln
jas_el_skena_huv_e	= find_dataref("JAS/el/stromskena/huvud_e")				--ESS
jas_el_skena_sek_a	= find_dataref("JAS/el/stromskena/sekundar_a")			--AVAP + balkar lampkontr radar-EFF-HFE
jas_el_skena_bat_c	= find_dataref("JAS/el/stromskena/batteri_c")			--AFPL krikiska block samt broms

--reffar från xp
dr_FRP = find_dataref("sim/operation/misc/frame_rate_period")
dr_hot_and_ready = find_dataref("sim/operation/prefs/startup_running")
dr_engine_running = find_dataref("sim/flightmodel2/engines/engine_is_burning_fuel[0]")
dr_apu_n1 = find_dataref("sim/cockpit2/electrical/APU_N1_percent")

dr_wow_front = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[0]")
dr_wow_left = find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[1]")
dr_wow_right =find_dataref("sim/flightmodel/parts/tire_vrt_def_veh[2]")



sim_el_heartbeat = 101


sim_FRP = 0.1
function update_dataref()
	-- Här filtrerar jag tiden och begränsar den till att aldrig bli för stor eller liten vid hack och när den stannar korta stunder för att ladda nya kartor osv...
	sim_FRP = (sim_FRP*19+ dr_FRP)/20
	if sim_FRP == 0 then 
		sim_FRP = 0.1 
	end
	if sim_FRP > 1 then 
		sim_FRP = 1
	end
end

blink1s = 0
blink05s = 0
blink025s = 0
gametimer = 0
function blink1sFunc()
	-- Välanvänd funktion, här snor vi och åker snålskjuss på gametimer
	gametimer = gametimer + sim_FRP
	t2 = math.floor(gametimer)
	if (t2 % 2 == 0) then
		blink1s = 1
	else 
		blink1s = 0
	end
	t2 = math.floor(gametimer*2)
	if (t2 % 2 == 0) then
		blink05s = 1
	else 
		blink05s = 0
	end
	t2 = math.floor(gametimer*4)
	if (t2 % 2 == 0) then
		blink025s = 1
	else 
		blink025s = 0
	end
end

--strömmoder
-- 1=Beredskap(batt) 
-- 3=temprering(apu-resgen) 
-- 4=sysmod test(apu-resgen) 
-- 5=sysmod PLUV(apu-resgen) 
-- 6=ordinarie(motor hgen) 
-- 7=motorstopp(batt+TB) 
-- 8=dubbellikriktarbortfall(batt+motor hgen) 
-- 9=huvudgen fel(Motor rgen) 
--10=växelströmsbortfall(batt+TB) 
--11=Tillfällig batteriförsöjning
--0=null
strommod = 0
function elektronik()

	sim_el_heartbeat = 200



end

dator_power_on = 0
dator_started = 0
dator_start_timer = 0
function dator()
	
	if (gametimer>dator_start_timer and dator_power_on == 1) then
		-- datorn är igång och kör
		if (dator_started == 0)  then
			-- Gör något bara en gång när den startat
			dator_started = 1
			
		end
		jas_io_vat_lamp_luftsys = 0 -- släck lampan när den är startad
	elseif (dator_power_on == 1) then
		-- Gör något om vi har startorder och väntar på att starttiden ska bli klar
		
		jas_io_vat_lamp_luftsys = blink025s -- blinka lampan medans systemet startar
	end
	
	if (jas_system_ess_power == 1) then -- Kolla om datorn ska startas och va igång, koppla om denna till strömskenor eller annat som ska trigga starten
		if (dator_power_on == 0) then
			dator_power_on = 1
			dator_start_timer = gametimer + 20.0 -- Här säger vi åt att datorn ska startas om 20s
		end
	else
		-- Om strömen är avstängd så nollställer vi så den måste startas på nytt
		dator_power_on = 0
		dator_started = 0
		jas_io_vat_lamp_luftsys = 1 -- lys lampan om den inte är igång -- det här ska väll igentligen gå till en larmvariabel i VAT men som exempel bara att vi ser att datorn startar....
	end
		
end

heartbeat = 0
function before_physics() 

	update_dataref()
	blink1sFunc()

	sim_el_heartbeat = heartbeat
	heartbeat = heartbeat + 1
end

function flight_start() 

end

function aircraft_unload()

end

function do_on_exit()

end
