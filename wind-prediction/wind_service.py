import requests



API_KEY = "4e0f83c9a992b69e0447e7f83a157dde"

def get_wind_data(lat, lon):

    url = f"https://api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API_KEY}&units=metric"

    response = requests.get(url)
    data = response.json()

    if "wind" not in data:
        print("API Error:", data)
        raise Exception("Wind data not available")

    wind_speed = data["wind"]["speed"]
    wind_deg = data["wind"]["deg"]

    return wind_speed, wind_deg
