
-- Demo på hur en timer kan fungera


jas_system_ess_power = find_dataref("JAS/system/ess/power")

jas_io_vu22_knapp_syst = find_dataref("JAS/io/vu22/knapp/syst")

jas_io_vat_lamp_luftsys = find_dataref("JAS/io/vat/lamp/luftsys")

dr_FRP = find_dataref("sim/operation/misc/frame_rate_period")



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

function before_physics() 

	update_dataref()
	blink1sFunc()
	dator()
	-- sim_mkv_heartbeat = heartbeat
	-- heartbeat = heartbeat + 1
end

function flight_start() 

end

function aircraft_unload()

end

function do_on_exit()

end
