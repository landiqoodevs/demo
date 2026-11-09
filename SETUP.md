# Admin page

## Demo mode (current)
`admin.html` opens directly, with no password. The footer "Admin" button on the website links to it.
Anything added there is stored in the browser (IndexedDB) and shown on the website on the same device and browser.
Nothing is uploaded to a server, so other visitors do not see the changes. "Reset demo data" restores the sample properties.
Serve the folder over http(s) (e.g. GitHub Pages) so the seed files in `data/` load.

## Going live later (optional)
`admin-live.html` is a version that saves real changes into the GitHub repo, protected by a password-encrypted access token.
To use it: rename it to `admin.html`, create a fine-grained GitHub token (this repo only, Contents: Read and write),
open the page, paste the token and choose a password. Changes then go live for all visitors in 1–2 minutes.
For a self-service portal with a proper account login, use a backend such as Supabase or a CMS.
