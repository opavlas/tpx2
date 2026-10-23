# Timepix2 — interactive pages

Two self-contained static projects from a cosmic-ray dosimetry campaign flown with
a **Timepix2** silicon pixel detector. No framework, no build step, no server-side
code — open either folder's entry page and it runs.

## Private archive — keep it that way

**This repo is not published and must stay private.** It holds the HardPix CAD
models (163 MB of `.glb`) and the film score, neither of which is cleared for
public distribution.

The flight pages *are* published, from a separate repo with its own history:
**[opavlas.github.io/tpx2](https://opavlas.github.io/tpx2/)**. A fresh history was
the point — dropping `3d/` in a commit here would leave the models and the score
in this repo's history, fetchable by anyone, the moment it went public.

`index.html` at the root links both folders for local browsing. It is deliberately
static — no canvas, no data bundle — so the heavy pages are only paid for when
someone asks for one.

## Where these come from

The pages are **generated**, not authored here: they are built from the analysis
project and copied in. Edits made directly in this repo are overwritten on the next
sync, so change the source, regenerate, then push.

## `flights/` — dose replays

| | |
|---|---|
| `index.html` | **Dose Field at 11 km** — three airliner legs replayed over the CARI-7A simulated dose field, measured against model |
| `balloons.html` | **The Pfotzer Maximum** — two stratospheric balloon flights, dose rate against altitude |

Each page is one HTML file plus its data as plain `.js` globals. 7.2 MB total.
See `flights/README.md`.

## `3d/` — the film and model viewers

A three.js film of the detector assembly, plus model viewers. `3d/index.html` is the
entry point; `3d/assets/film.js` drives the film.

Large assets are tracked here so the pages work on clone: the models are 22–87 MB
each. Renders, source music and `node_modules` are deliberately **not** tracked —
see `.gitignore`.

## Running locally

Both folders use relative paths only, so a plain static server is enough:

```bash
python -m http.server 8000
# then http://localhost:8000/flights/  and  http://localhost:8000/3d/
```

Opening `flights/*.html` directly from disk also works. The `3d/` pages load `.glb`
models by fetch and need the server.

## Notes

- No cookies, no storage, no tracking, no analytics. The only external request is
  to Google Fonts.
- The `.js` data bundles under `flights/` are plain text and contain the full
  measured dataset.
- `.nojekyll` switches off Jekyll processing — these are plain static files and
  nothing here needs building.
