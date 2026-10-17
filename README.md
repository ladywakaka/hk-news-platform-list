# 香港新聞平台名單 · HK News Platform List

A password-protected dashboard of Hong Kong and China news platforms on Instagram, Facebook, Threads and YouTube: 102 social platforms, 72 Hong Kong YouTube channels (Cantonese, Mandarin, English, finance, shipping), 23 outlet YouTube channels and 11 defunct outlets. Searchable, filterable by category and stance, sortable by followers.

Live page: https://ladywakaka.github.io/hk-news-platform-list/ (ask the owner for the password)

Data as of 18 Oct 2026, from the Claude doc 「香港及中國新聞 IG／Facebook 平台名單」. IG followers checked 17 Oct 2026; YouTube subscribers and last uploads checked 18 Oct 2026 from the channel pages.

## How it's protected

This repository is public, so the page is never stored in readable form.

1. `src/dashboard.html.enc` is the page, encrypted with AES-256. The key is the `SOURCE_KEY` repository secret; a copy is in the owner's macOS Keychain (item `hk-news-dashboard-source-key`).
2. On every push to `main` (or **Run workflow** in the Actions tab), `.github/workflows/deploy.yml` decrypts the page, locks it with the password using [StatiCrypt](https://github.com/robinmoisson/staticrypt), and publishes only the locked page to GitHub Pages.

| Secret | What it is |
|---|---|
| `SOURCE_KEY` | Key that decrypts `src/dashboard.html.enc` and the source bundle. Don't change it unless you re-encrypt both. |
| `DASHBOARD_PASSWORD` | The password viewers type. Change it here, then run the workflow again. A copy is in the Keychain (item `hk-news-dashboard-password`). |

## Updating

The source (`template.html`, `data.json`, `build.py`) is in `source/hk-news-source.tar.gz.enc`.

```sh
scripts/source-unpack.sh                       # unpacks to ./hk-news-source (ignored by git)
# edit hk-news-source/data.json or template.html
cd hk-news-source && python3 build.py && cd ..  # rebuilds index.html
scripts/source-pack.sh                         # re-encrypts the source and the page
git add -A && git commit -m "Update list" && git push
```
