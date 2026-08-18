# Notifications — alerting and communication

Purpose
-------
This module implements the delivery mechanisms for community alerts: mobile push (FCM), SMS/WhatsApp (Twilio) and any other configured channels. It also defines event schemas and retry strategies.

Key features
------------
- Event types: `report_received`, `rb_flagged`, `risk_heatmap_updated`, `alert_acknowledged`.
- Provider integrations: Firebase Cloud Messaging (FCM), Twilio/WhatsApp, SMTP for email fallbacks.
- Reliability: queued delivery, exponential backoff, and delivery status tracking.

Developer notes
---------------
- Store provider credentials in environment variables and do not commit them.
- Include opt-in/opt-out preferences in user profiles stored by the backend.

Local run (example)
-------------------
Start a local worker to process notification jobs (example using RQ):

```powershell
redis-server
python -m pip install rq
rq worker notifications
```

