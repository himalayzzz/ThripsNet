# Dataset — training data guidelines

Purpose
-------
This folder contains dataset manifests, preprocessing utilities and small, documented example subsets for development. Large raw datasets should be stored externally and referenced by manifest files.

Structure (recommended)
-----------------------
- `manifests/` — CSV/JSON lists describing image paths, labels, bounding boxes and seed-variety metadata.
- `preprocess/` — scripts to normalize, augment and convert data to training-ready formats.
- `examples/` — small, permissively licensed examples for rapid testing.

Data handling notes
-------------------
- Never commit full-size, sensitive or licensed datasets to this repo; use cloud storage and add manifests.
- Maintain a clear label schema: `tswv`, `healthy`, `other_disease`, and include `seed_variety` where available.
- Keep reproducible splits (train/val/test) and record the split version in dataset manifests.

How to add data
---------------
1. Add raw data to external storage.
2. Add or update a manifest in `manifests/` pointing to the storage URIs.
3. Run `preprocess/` scripts locally to generate training inputs.
