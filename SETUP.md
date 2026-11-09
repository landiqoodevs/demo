# Setup — client self-service uploads (about 20 minutes)

How it works: the broker signs in at `admin.html`, fills in a form and uploads video, photos and a 3D model.
Data goes to Supabase (database + file storage). The public `index.html` loads it live, so changes appear
on the website instantly with no redeploy.

## 1. Create the backend (free tier is enough to start)
1. Create an account and a new project at https://supabase.com.
2. Open SQL Editor, paste all of `supabase/schema.sql`, click Run.
3. Authentication -> Users -> Add user: create the broker's login (email + password, tick "auto confirm").
4. Authentication settings: turn OFF "Allow new users to sign up" so only the broker you created can log in.
5. Project Settings -> API: copy the Project URL and the `anon` public key.

## 2. Connect the website
Open `config.js` and paste the URL and anon key. The anon key is designed to be public; row-level security in the SQL protects the data.

## 3. Deploy both files
Upload this whole folder to Netlify, Vercel, Cloudflare Pages or GitHub Pages (HTTPS required).
- Website: `https://your-domain/`
- Broker portal: `https://your-domain/admin.html` (bookmark it; it is not linked from the site)

## 4. Broker workflow
Sign in -> Add property -> fill details, map coordinates, upload video / 3D model / photos -> Save & publish.
"Broker details" updates the phone number and profile everywhere. "Published" off hides a property.
Map: right-click the spot in Google Maps and click the coordinates to copy latitude and longitude.

## Limits and tips
- Supabase free tier allows ~50 MB per file and 1 GB storage. Compress videos (MP4 H.264, 720p, under 40 MB).
  For longer or larger videos use Cloudflare Stream or Mux and paste the link in the "video link" field.
- 3D models: GLB under ~10 MB (Draco/Meshopt compression recommended).
- Deleting a property does not delete its files from storage; clear them in Supabase -> Storage if needed.
- The "map" is an OpenStreetMap embed with an Open in Google Maps link. A true 3D map (satellite/terrain) would need Google Maps or Mapbox and an API key.
- If Supabase is unreachable or empty, the site falls back to the built-in demo properties.
