# Backend — API & aggregation services

Purpose
-------
The backend ingests mobile reports, hosts models for advanced inference, aggregates reports into short-term risk heatmaps, and orchestrates notifications to communities.

Recommended stack
-----------------
- Python 3.8+ with FastAPI (preferred) or Flask
- PostgreSQL for structured reports and spatial queries
- Redis for caching and task queues
- Celery / RQ for background jobs (heatmap generation, notifications)

Developer quickstart
--------------------
1. Create a virtual environment and install requirements:

```powershell
python -m venv venv
venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

2. Run the development server (example FastAPI):

```powershell
uvicorn src.main:app --reload --port 8000
```

Key responsibilities
--------------------
- Request validation and authentication
- Storing and indexing reports (with GPS and metadata)
- Calling ai-model services for advanced inference
- Building short-term risk heatmaps from reports + weather
- Triggering notifications and retry logic

APIs & contracts
----------------
Before changing API schemas, update the OpenAPI/Swagger docs in `src/docs` and notify frontend maintainers.

Testing & CI
------------
- Add unit tests under `tests/` and run them in CI.
- Include integration tests for ingestion → aggregation → notification flows.
