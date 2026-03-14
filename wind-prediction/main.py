from wind_service import get_wind_data
from drift_model import predict_spread_cone


def predict_thrips_spread(lat, lon):

    speed, direction = get_wind_data(lat, lon)

    spread_points = predict_spread_cone(
        lat,
        lon,
        speed,
        direction
    )

    return {
        "origin": [lat, lon],
        "wind_speed": speed,
        "wind_direction": direction,
        "predicted_spread": spread_points
    }


result = predict_thrips_spread(12.9716, 77.5946)

print(result)
