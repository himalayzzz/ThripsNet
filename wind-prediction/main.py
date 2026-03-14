from wind_service import get_wind_data
from drift_model import predict_spread_cone
from map_visualization import generate_map


def predict_thrips_spread(lat, lon):

    speed, direction = get_wind_data(lat, lon)

    spread_points = predict_spread_cone(
        lat,
        lon,
        speed,
        direction
    )

    map_file = generate_map(
        lat,
        lon,
        spread_points
    )

    return {
        "origin": [lat, lon],
        "wind_speed": speed,
        "wind_direction": direction,
        "predicted_spread": spread_points,
        "map": map_file
    }


result = predict_thrips_spread(12.9716, 77.5946)

print(result)
