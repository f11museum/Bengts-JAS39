-- Multi Function Display
sim_heartbeat = find_dataref("JAS/heartbeat/mfdlua") 

jas_io_fi_knapp_knappram = find_dataref("JAS/io/fi/knapp/knappram")
jas_io_ti_knapp_knappram = find_dataref("JAS/io/ti/knapp/knappram")
jas_io_mi_knapp_knappram = find_dataref("JAS/io/mi/knapp/knappram")


jas_io_ti_pekare_x = find_dataref("JAS/io/ti/pekare/x")
jas_io_ti_pekare_y = find_dataref("JAS/io/ti/pekare/y")

jas_ti_menu_currentmenu = find_dataref("JAS/ti/menu/menu")
jas_fi_menu_currentmenu = find_dataref("JAS/fi/menu/menu")
jas_mi_menu_currentmenu = find_dataref("JAS/mi/menu/menu")
jas_ti_menu_submenu = find_dataref("JAS/ti/menu/submenu")

jas_ti_land_rikt = find_dataref("JAS/ti/land/rikt")
jas_ti_land_bana = find_dataref("JAS/ti/land/bana")
jas_ti_land_bibana = find_dataref("JAS/ti/land/bibana")
jas_ti_land_flygplats = find_dataref("JAS/ti/land/index")

jas_ti_map_zoom = find_dataref("JAS/ti/map/zoom")
jas_ti_map_type = find_dataref("JAS/ti/map/type")
jas_ti_map_color = find_dataref("JAS/ti/map/color")

jas_ti_land_rikt2 = find_dataref("JAS/ti/land/rikt2")
jas_ti_land_bana2 = find_dataref("JAS/ti/land/bana2")
jas_ti_land_bibana2 = find_dataref("JAS/ti/land/bibana2")
jas_ti_land_flygplats2 = find_dataref("JAS/ti/land/index2")

jas_ti_map_zoom2 = find_dataref("JAS/ti/map/zoom2")
jas_ti_map_type2 = find_dataref("JAS/ti/map/type2")
jas_ti_map_color2 = find_dataref("JAS/ti/map/color2")

jas_udat_lon = find_dataref("JAS/udat/lon")
jas_udat_lat = find_dataref("JAS/udat/lat")
jas_udat_namn = find_dataref("JAS/udat/namn")

jas_vu22_vapenop = find_dataref("JAS/io/vu22/knapp/vapenop")

jas_huvudmod = find_dataref("JAS/huvudmod")
jas_vapen_mode = find_dataref("JAS/vapen/mode")

function knappar_ti()

end

function knappar_mi()
	
		if ((jas_io_mi_knapp_knappram[0] == 1) ) then
			jas_huvudmod = 1
		end	
		if ((jas_io_mi_knapp_knappram[1] == 1) ) then
			jas_huvudmod = 2
		end	
		if ((jas_io_mi_knapp_knappram[2] == 1) ) then
			jas_huvudmod = 3
		end	

end
vapenop_prev = 0
function vapenlast()
	
	if (jas_vu22_vapenop == 1) then
		if (vapenop_prev == 0) then
			vapenop_prev = 1
			jas_fi_menu_currentmenu = 3
		end
		
	end
	if (jas_vu22_vapenop == 0) then
		if (vapenop_prev == 1) then
			vapenop_prev = 0
			jas_fi_menu_currentmenu = 1
		end
		
	end
end

heartbeat = 0
function before_physics() 
	knappar_ti() 
	knappar_mi()
	vapenlast()

	sim_heartbeat = heartbeat
	heartbeat = heartbeat + 1
end

function flight_start() 
	jas_ti_land_flygplats = 24179 -- self.xp.sendDataref("JAS/ti/land/index", self.airportDict["ESKN"]["index"])
	jas_ti_land_bana = 0 -- self.xp.sendDataref("JAS/ti/land/bana", 0)
	jas_ti_land_bibana = 0-- self.xp.sendDataref("JAS/ti/land/bibana", 0)
	jas_ti_land_rikt = 1-- self.xp.sendDataref("JAS/ti/land/rikt", 1)
	
end

function aircraft_unload()

end

function do_on_exit()

end
