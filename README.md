# ThripsNet — Early detection and community alerts for TSWV

Short description
-----------------
ThripsNet detects Tomato Spotted Wilt Virus (TSWV) from farmer-submitted leaf photos, flags potential resistance-breaking infections using seed variety metadata, and predicts short-term thrips-driven spread using weather data. The repository is organized by responsibility: mobile frontend, backend services, model code, datasets, forecasting, notifications and demo assets.

Repository layout
-----------------
- `frontend/` — Mobile application (Flutter) that captures images, runs on-device inference, and displays risk heatmaps and alerts.
- `backend/` — API and aggregation services: handles advanced inference, report ingestion, heatmap generation and alert orchestration.
- `ai-model/` — Model training, evaluation and exported artifacts (SavedModel / TFLite). See `ai-model/README.md` for details.
- `dataset/` — Guidelines and manifests for datasets used to train detection models.
- `wind-prediction/` — Weather ingestion and migration/prediction logic producing short-term risk forecasts.
- `notifications/` — Notification integrations (FCM, Twilio/WhatsApp, SMS) and event schema.
- `demo-assets/` — Presentation media, sample images and short video clips for demos.

Quick start
-----------
1. Pick the module you want to work on (see folders above).
2. Follow that module's README for setup and run instructions — each module contains targeted developer notes.
3. For model work, start in `ai-model/`; for integration tests, start `backend/` + `frontend/`.

How we work
-----------
- Each module owns its own README and setup instructions.
- Models must include provenance: training dataset version, code commit, and export format.
- All changes that affect the API contract must add/update `backend/` API docs and notify frontend/mobile teams.

Contact & contributions
-----------------------
Open issues for bugs, new features or integration questions. Maintain clear PR descriptions and reference the module(s) affected.

Last updated: 2026-08-19
