import folium


def generate_map(origin_lat, origin_lon, spread_points):

    m = folium.Map(location=[origin_lat, origin_lon], zoom_start=11)

    # infected farm
    folium.Marker(
        [origin_lat, origin_lon],
        popup="Infected Farm",
        icon=folium.Icon(color="red")
    ).add_to(m)

    # predicted spread points
    for lat, lon in spread_points:

        folium.Marker(
            [lat, lon],
            popup="Possible Spread Area",
            icon=folium.Icon(color="orange")
        ).add_to(m)

        folium.PolyLine(
            [[origin_lat, origin_lon], [lat, lon]],
            color="blue",
            weight=2
        ).add_to(m)

    m.save("wind_prediction_map.html")

    return "wind_prediction_map.html"
