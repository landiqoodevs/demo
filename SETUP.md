# Setup — client self-service uploads using only GitHub (no other service)

How it works: the broker opens `admin.html`, unlocks it with a password, fills in a form and uploads video,
photos and a 3D model. The page saves them into your GitHub repository (`data/*.json` and `assets/`).
GitHub Pages republishes the site automatically, so changes go live in about 1–2 minutes.

## One-time setup (you, the developer)
1. Put this folder in a PUBLIC GitHub repo (free GitHub Pages needs public) and turn on Pages:
   Settings -> Pages -> Deploy from a branch -> `main` / `(root)`.
2. Create an access token for the broker's admin page:
   GitHub -> your profile photo -> Settings -> Developer settings -> Personal access tokens -> Fine-grained tokens -> Generate new token.
   - Repository access: "Only select repositories" -> choose this repo.
   - Permissions -> Repository permissions -> Contents: **Read and write** (nothing else).
   - Expiration: the longest allowed. Note the renewal date; when it expires, make a new token and repeat step 3.
   Copy the token (starts with `github_pat_`).
3. Open `https://YOUR-USERNAME.github.io/REPO-NAME/admin.html` on the broker's phone or laptop.
   Paste the token, choose a strong password (12+ characters) and tap Save & unlock.
   The token is encrypted with that password and stored only on that device.
   From then on the broker only types the password. Do this on each device he will use.
4. If you use a custom domain, fill in `owner` and `repo` in `config.js`.

## Broker workflow
Website footer -> "🔒 Admin login" -> password -> Add property -> fill the form, upload files -> Save & publish.
"Broker details" changes the phone number and profile. "Published" off hides a property.
Map coordinates: right-click the spot in Google Maps and tap the numbers to copy latitude/longitude.

## Limits and tips
- Photos are resized to 1600 px automatically. Keep videos under ~40 MB (MP4 H.264, 720p); hard limit in the form is 70 MB.
  For longer videos host them on YouTube/Cloudflare Stream/Mux and paste the link in "video link"
  (YouTube pages cannot play inside the video tag; use a direct MP4 URL).
- 3D models: GLB under ~10 MB.
- Every upload is a commit; the repo grows with each file. GitHub recommends repos stay under ~1 GB.
- Deleting a property or removing a photo does not delete the files from the repo.
- The token is secret. Anyone who learns the password AND gets the broker's browser data could use it,
  so use a strong password. The token can only edit this one repository. If lost, revoke it on GitHub and make a new one.
- Because the repo is public, anyone can read the property data and media (it is public on the website anyway).
- If GitHub is unreachable, the site falls back to the built-in demo properties.
