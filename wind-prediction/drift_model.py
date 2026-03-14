from geopy.distance import geodesic


def predict_spread_cone(lat, lon, wind_speed, wind_deg):

    # distance thrips travel (meters)
    distance = wind_speed * 500

    km = distance / 1000

    origin = (lat, lon)

    # create spread angles
    angles = [
        wind_deg - 20,
        wind_deg - 10,
        wind_deg,
        wind_deg + 10,
        wind_deg + 20
    ]

    points = []

    for angle in angles:
        destination = geodesic(kilometers=km).destination(origin, angle)
        points.append((destination.latitude, destination.longitude))

    return points
