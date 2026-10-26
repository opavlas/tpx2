# Timepix2 — cosmic-ray dose, measured in flight

Two interactive pages from a dosimetry campaign flown with a **Timepix2** silicon
pixel detector.

**Live at [opavlas.github.io/tpx2](https://opavlas.github.io/tpx2/).**

| | |
|---|---|
| [**Dose Field at 11 km**](https://opavlas.github.io/tpx2/) | three airliner legs replayed over the CARI-7A simulated dose field at cruise altitude, measured against model |
| [**The Pfotzer Maximum**](https://opavlas.github.io/tpx2/balloons.html) | two stratospheric balloon flights, dose rate against altitude through the Regener–Pfotzer maximum |
| [**HardPix2**](https://opavlas.github.io/tpx2/3d/) | a 64-second real-time 3D film of the detector assembly, ending on real measured particle tracks |

The two flight pages link to each other; either is a fine place to start.

## Contents

```
index.html         the flight page
replay_data.js     its tracks, model and dose field          275 kB
frames_data.js     its detector frames                       5.4 MB
balloons.html      the balloon page
balloon_data.js    its ascent and profile data               1.6 MB
```

Each flight page is a single HTML file — a `<style>`, some `<canvas>` markup and one
inline `<script>` — with its data loaded beforehand as plain globals. No framework,
no build step, no server-side code. Static hosting is all that is required.

## `3d/` — the HardPix2 film

```
index.html                   the film
HardPix2_TPX2_nano.glb       the assembly                              85 MB
assets/ScrollTrigger-*.js    the three.js + GSAP runtime              0.7 MB
assets/film.js               what drives it; three-lib.js re-exports
                             three.js and GSAP out of the chunk above
assets/score.mp3             "Interstellar" by leberch, from Pixabay,
                             free under the Pixabay Content License    2 MB
data/hits.bin                13,230 one-second Timepix2 exposures    1.5 MB
```

Only the HardPix2 film is published. The two older scroll-driven exploded views
(`hardpix.html`, `assembly.html`) and their models stay in the private archive —
78 MB of geometry nobody asked to see.

Unlike the flight pages this one **cannot be opened from disk**: it is ES modules,
which browsers refuse over `file://`, and it fetches the model over HTTP. Serve it.

GitHub Pages serves this repo's root from `main`, so a push is live within about a
minute. There is no Actions workflow and nothing is built on the server.

## Generated — do not edit here

These files are built from sources in the analysis project (`presentation/`) by
`deploy_site.py`, which wraps each page in a full HTML document and rewrites the
navigation to relative paths. Edits made directly in this repo are overwritten on
the next deploy.

To update: re-run `deploy_site.py`, then commit and push.

## Notes

- All internal references are relative, so the folder also works opened from disk.
- No cookies, no storage, no tracking, no network calls. The only external request is
  to Google Fonts.
- The `.js` bundles are plain text and contain the full measured dataset.
- `.nojekyll` switches off Jekyll processing — these are plain static files.
