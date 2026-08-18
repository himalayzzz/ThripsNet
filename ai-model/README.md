# ThripsNet — AI model module

Project: ThripsNet — Detecting Resistance-Breaking TSWV and Predicting Thrips Spread

Theme: AI-Driven Crop Health & Climate-Smart Agriculture

Team: Hello World

Overview
--------
ThripsNet combines leaf-image diagnosis, seed-variety metadata and weather-driven migration modelling to provide early, field-level warnings for Tomato Spotted Wilt Virus (TSWV). The ai-model module contains training, evaluation and inference code for the visual detection and migration-prediction components used by the mobile app and backend services.

Why this matters
-----------------
- TSWV is a major disease of tomato and pepper, spread by thrips — tiny insects that travel on wind currents.
- Resistant seed varieties are increasingly failing due to resistance-breaking (RB) strains.
- Lab confirmation (PCR) takes days, during which thrips can spread the virus.
- ThripsNet gives early, actionable intelligence: image-based symptom detection + seed variety validation + weather-driven spread forecasts.

Key capabilities
----------------
- Leaf Image Analysis: AI-powered detection of TSWV symptoms (ring spots, bronzing) from phone photos.
- Seed Variety Cross-Check: Combine farmer-provided seed type to flag possible resistance-breaking infections.
- Weather-Driven Prediction: Wind, temperature and humidity data to predict likely downwind spread and generate risk heatmaps.
- Edge-Ready: Models exported for TensorFlow Lite for offline inference on low-cost Android phones.

Detection workflow (high level)
-------------------------------
1. Capture: farmer takes a leaf photo in the mobile app.
2. Detect: on-device model (TFLite) or backend inference identifies probable TSWV symptoms.
3. Verify: farmer confirms seed variety in-app.
4. Flag: if symptoms + resistant seed → mark as possible resistance-breaking (RB) case.
5. Log & Alert: record GPS + time and broadcast community alerts (Firebase / WhatsApp / SMS).

Repository structure (recommended for this module)
-----------------------------------------------
- `training/` – training scripts, model definitions, training configs.
- `inference/` – inference wrappers, postprocessing, examples for batch and single-image prediction.
- `export/` – exported artifacts (SavedModel, TFLite, ONNX), labels, and metadata.
- `datasets/` – dataset manifests and preprocessing utilities.
- `notebooks/` – EDA and experiment notebooks.

Model & data notes
-------------------
- Baseline visual detector: YOLOv8 or a comparable detection/classification backbone trained on annotated leaf images.
- Export path: provide a `SavedModel` and a TFLite quantized variant for mobile.
- Labels: include clear label schema (TSWV symptoms, healthy, other diseases) and a seed-variety field in reports.
- Dataset: ensure train/val/test splits contain a mixture of seed varieties and environmental conditions (lighting, background, damage levels).

Thrips migration prediction
---------------------------
- Use weather APIs (OpenWeather / IMD) to fetch wind speed/direction, temperature and humidity.
- Simple migration model idea: particle advection downwind from reported locations + humidity/temperature suitability to produce short-term (24–72h) risk heatmaps.
- Combine historical outbreak patterns to improve persistence and community-level risk scoring.

Integration & architecture
------------------------
- Mobile: Android app captures photos and runs TFLite inference when offline.
- Backend: Python Flask service for model hosting, aggregation, and advanced forecasting.
- Alerts: Firebase Cloud Messaging for app alerts; Twilio / WhatsApp integration for community notifications.

Quickstart (developer)
----------------------
Prereqs: Python 3.8+, virtualenv, (optional) CUDA for training.

Install dependencies (example):

```powershell
python -m venv venv
venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

Run a sample inference (replace with your script paths):

```powershell
python inference/run_inference.py --model export/tflite/model.tflite --image samples/leaf.jpg
```

Notes: this module intentionally focuses on model and data tasks. Mobile integration, alerting and backend services are implemented in the `frontend/` and `backend/` folders respectively.

Contributing
------------
- Please keep experiments in `notebooks/` and training runs under `training/`.
- Add model exports to `export/` and provide a `README` entry with provenance (framework, commit, training data version).

Further work
------------
- Provide baseline training scripts and example datasets.
- Add end-to-end inference tests and a lightweight evaluation dashboard.
- Implement a documented API contract for how the mobile app submits reports and fetches heatmaps.

Contact
-------
For questions or collaboration, open an issue or reach out to the maintainers via the repository issue tracker.

