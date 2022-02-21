sim_heartbeat = create_dataref("JAS/system/radar/heartbeat", "number")
sim_heartbeat = 100

jas_radar_aktiv = find_dataref("JAS/radar/aktiv")
jas_radar_ping = find_dataref("JAS/radar/ping")
jas_radar_bore = find_dataref("JAS/radar/bore")
jas_radar_range = find_dataref("JAS/radar/range")
sim_heartbeat = 105

dr_target_lat = find_dataref("sim/cockpit2/tcas/targets/position/lat")
dr_target_lon = find_dataref("sim/cockpit2/tcas/targets/position/lon")
dr_target_ele = find_dataref("sim/cockpit2/tcas/targets/position/ele")
dr_target_num = find_dataref("sim/cockpit2/tcas/indicators/tcas_num_acf")
sim_heartbeat = 110

dr_target_bearing = find_dataref("sim/cockpit2/tcas/indicators/relative_bearing_degs")
dr_target_distance = find_dataref("sim/cockpit2/tcas/indicators/relative_distance_mtrs")

dr_target_onground = find_dataref("sim/cockpit2/tcas/targets/position/weight_on_wheels")
dr_target_selected = find_dataref("sim/cockpit/weapons/plane_target_index")


sim_heartbeat = 120


function radar()
	sim_heartbeat = 300
	jas_radar_aktiv = 1
	sim_heartbeat = 3011
	jas_radar_range = 100000
	jas_radar_bore = 15
	sim_heartbeat = 301
	if (jas_radar_aktiv == 1) then
		bore1 = jas_radar_bore
		bore2 = jas_radar_bore * -1
		sim_heartbeat = 302
		
		mindist = 99999999
		target = -1
		for i=1, dr_target_num-1 do
			if (dr_target_bearing[i] < bore1 and dr_target_bearing[i] > bore2) then
				if (dr_target_distance[i] < jas_radar_range) then
					jas_radar_ping[i] = 1000
					if (dr_target_distance[i] <mindist) then -- För tillfället låser vi automatiskt närmaste målet
						target = i
						mindist = dr_target_distance[i]
					end
				end
			end
		end
		dr_target_selected = target
	else
		dr_target_selected = -1
	end
	sim_heartbeat = 303
	for i=1, 20 do
		
		jas_radar_ping[i] = jas_radar_ping[i] - 1
		if (jas_radar_ping[i]<0) then 
			jas_radar_ping[i] = 0
		end
	end
end

heartbeat = 0
function before_physics()
	
	sim_heartbeat = 200 
	radar()
	

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