# Timepix2 — interactive pages

Two self-contained static projects from a cosmic-ray dosimetry campaign flown with
a **Timepix2** silicon pixel detector. No framework, no build step, no server-side
code — open either folder's entry page and it runs.

## `flights/` — dose replays

| | |
|---|---|
| `index.html` | **Dose Field at 11 km** — three airliner legs replayed over the CARI-7A simulated dose field, measured against model |
| `balloons.html` | **The Pfotzer Maximum** — two stratospheric balloon flights, dose rate against altitude |

Each page is one HTML file plus its data as plain `.js` globals. 7.2 MB total.
See `flights/README.md`.

## `3d/` — the film and model viewers

A three.js film of the detector assembly, plus model viewers. `3d/film.html` is the
entry point; `3d/assets/film.js` drives it.

Large assets are tracked here so the pages work on clone: the models are 22–87 MB
each. Renders, source music and `node_modules` are deliberately **not** tracked —
see `.gitignore`.

## Running locally

Both folders use relative paths only, so a plain static server is enough:

```bash
python -m http.server 8000
# then http://localhost:8000/flights/  and  http://localhost:8000/3d/film.html
```

Opening `flights/*.html` directly from disk also works. The `3d/` pages load `.glb`
models by fetch and need the server.

## Notes

- No cookies, no storage, no tracking, no analytics. The only external request is
  to Google Fonts.
- The `.js` data bundles under `flights/` are plain text and contain the full
  measured dataset.
