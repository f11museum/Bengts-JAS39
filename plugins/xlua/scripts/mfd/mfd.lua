-- Multi Function Display

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

function knappar_ti()
	

end

function before_physics() 
	knappar_ti()
	--jas_ti_menu_currentmenu = jas_ti_menu_currentmenu2 
	--jas_ti_land_rikt = jas_ti_land_rikt2 
	--jas_ti_land_bana = jas_ti_land_bana2 
	--jas_ti_land_bibana = jas_ti_land_bibana2 
	--jas_ti_land_flygplats = jas_ti_land_flygplats2

	--jas_ti_map_zoom = jas_ti_map_zoom2
	--jas_ti_map_type = jas_ti_map_type2
	--jas_ti_map_color = jas_ti_map_color2
end

function flight_start() 

end

function aircraft_unload()

end

function do_on_exit()

end
