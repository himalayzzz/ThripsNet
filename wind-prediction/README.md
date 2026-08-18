# Wind prediction & migration modelling

Purpose
-------
This module ingests weather data (wind speed/direction, humidity, temperature) and produces short-term thrips migration forecasts and risk heatmaps used by the backend to notify at-risk farms.

Recommended layout
------------------
- `data_pipeline/` — connectors for OpenWeather / IMD / local weather feeds.
- `models/` — migration and suitability models (advection-based, plus environmental suitability filters).
- `service/` — API wrappers and output formats consumed by `backend/`.

Baseline approach
-----------------
- Use particle advection from report locations using current wind vectors to estimate downwind exposure over 24–72h.
- Apply humidity/temperature suitability masks (e.g., 28–32°C and high humidity increase thrips activity).
- Produce geojson heatmaps and a compact risk score for API consumption.

Developer notes
---------------
- Cache weather pulls to avoid rate limits and keep reproducibility.
- Version outputs so downstream services can detect breaking format changes.
