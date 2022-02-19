-- Multi Function Display

jas_io_fi_knapp_knappram = find_dataref("JAS/io/fi/knapp/knappram")
jas_io_ti_knapp_knappram = find_dataref("JAS/io/ti/knapp/knappram")
jas_io_mi_knapp_knappram = find_dataref("JAS/io/mi/knapp/knappram")

jas_io_ti_knapp_knapp1 = find_dataref("JAS/io/ti/knapp/knapp1")
jas_io_ti_knapp_knapp2 = find_dataref("JAS/io/ti/knapp/knapp2")
jas_io_ti_knapp_knapp3 = find_dataref("JAS/io/ti/knapp/knapp3")
jas_io_ti_knapp_knapp4 = find_dataref("JAS/io/ti/knapp/knapp4")
jas_io_ti_knapp_knapp5 = find_dataref("JAS/io/ti/knapp/knapp5")
jas_io_ti_knapp_knapp6 = find_dataref("JAS/io/ti/knapp/knapp6")
jas_io_ti_knapp_knapp7 = find_dataref("JAS/io/ti/knapp/knapp7")
jas_io_ti_knapp_knapp8 = find_dataref("JAS/io/ti/knapp/knapp8")
jas_io_ti_knapp_knapp9 = find_dataref("JAS/io/ti/knapp/knapp9")
jas_io_ti_knapp_knapp10 = find_dataref("JAS/io/ti/knapp/knapp10")

jas_ti_map_zoom = find_dataref("JAS/ti/map/zoom")

function before_physics() 
    if (jas_ti_map_zoom == 0) then
        jas_ti_map_zoom = 10
    end
    jas_io_ti_knapp_knapp1 = jas_io_ti_knapp_knappram[0]
    jas_io_ti_knapp_knapp2 = jas_io_ti_knapp_knappram[1]
    jas_io_ti_knapp_knapp3 = jas_io_ti_knapp_knappram[2]
    jas_io_ti_knapp_knapp4 = jas_io_ti_knapp_knappram[3]
    jas_io_ti_knapp_knapp5 = jas_io_ti_knapp_knappram[4]
    jas_io_ti_knapp_knapp6 = jas_io_ti_knapp_knappram[5]
    jas_io_ti_knapp_knapp7 = jas_io_ti_knapp_knappram[6]
    jas_io_ti_knapp_knapp8 = jas_io_ti_knapp_knappram[7]
    jas_io_ti_knapp_knapp9 = jas_io_ti_knapp_knappram[8]
    jas_io_ti_knapp_knapp10 = jas_io_ti_knapp_knappram[9]
	
end

function flight_start() 

end

function aircraft_unload()

end

function do_on_exit()

end
