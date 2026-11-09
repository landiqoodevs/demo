# Landiqoo Estates — Premium Real Estate Demo

Single-file, mobile-first demo site. No build step.

## Run it
Open `index.html` in a browser, or serve the folder:
    python3 -m http.server 8000   # then visit http://localhost:8000
Needs internet on first load for Three.js (jsDelivr) and Google Fonts.
For offline/production, download `three.min.js` and `GLTFLoader.js` (three r128) into `assets/` and change the two <script src> tags.

## Configure (top of the <script> in index.html)
- `CFG.phone` — dialer number, e.g. "+919876543210" (used by every INQUIRE NOW button)
- `CFG.show` — number as displayed on screen
- `CFG.broker` — name, title, bio, experience, areas, specialisation
- `P` array — one object per property (price, beds, baths, area, status, description `d`, amenities `am`, colours `pal`)
- Add a property: copy one object in `P`, give it a unique `id`; its page appears at `#p-<id>`.

## Replace demo assets
Demo video, 3D models and images are clearly labelled placeholders.
- Video: put an MP4 (H.264, 720p, under ~8 MB) in `assets/videos/` and set `video:"assets/videos/aurora.mp4"`.
- 3D model: export GLB (Draco-compressed, under ~10 MB) to `assets/models/` and set `model:"assets/models/aurora.glb"`. Falls back to the placeholder if it fails.
- Photos: the gallery currently draws SVG illustrations via `art()`. Replace the gallery rendering with `<img loading="lazy" src="assets/images/...">` (WebP, ~1600px wide). This needs a small code change.
Note: GLB/video files must be served over http(s), not opened from file://.

## Adding a real property-management backend
The demo has no uploads or admin. For the broker to self-manage you need:
1. A CMS or database (Sanity, Strapi, Directus, Supabase) holding the same fields as the `P` objects.
2. File storage + CDN (Cloudflare R2/Stream, S3, Cloudinary, Mux) for videos, images and GLB files, with size limits and optimisation.
3. An authenticated admin UI (CMS dashboard or custom) to add/edit price, description, availability and contact details.
4. Replace the `P` constant with a fetch from the API (or a build-time fetch) and cache it.
5. HTTPS hosting (Netlify, Vercel, Cloudflare Pages) with HTTP range support for video and server-side validation.
6. Optional: per-property prerendered pages for SEO and analytics for call-button taps.

## Backend
See SETUP.md: the admin portal (admin.html) saves to this GitHub repo; no other service needed.
