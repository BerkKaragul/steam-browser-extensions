# Steam Browser Extensions

Run Chrome extensions such as **Augmented Steam** and **SteamDB** directly inside the Steam desktop client, with no extra software, no injection, and no modified files.

[Türkçe](README.tr.md)

## How it works

The Steam client is built on Chromium (CEF). Middle-clicking certain links in the client opens a full Chromium window with tabs and an address bar. That window can reach the Chrome Web Store, so extensions install into Steam's own browser profile and then apply to every store and community page inside Steam.

Nothing is patched or injected. The extensions live in Steam's normal browser profile:

```
%LOCALAPPDATA%\Steam\htmlcache\Default\Extensions
```

## Steps

1. Open Steam and go to any game page in the **Store**.
2. **Middle-click** the **Community Hub** button. A separate Chromium window with an address bar opens.
3. Paste an extension's Chrome Web Store link into that address bar:
   - Augmented Steam: `https://chromewebstore.google.com/detail/augmented-steam/dnhpnfgdlenaccegplpojghhmaamnnfp`
   - SteamDB: `https://chromewebstore.google.com/detail/steamdb/kdbmhfkmnlmbkgbabkdealhhbfhlmmon`
4. If a "Switch to Chrome?" prompt appears, choose **No thanks**.
5. Click **Add to Chrome**, then **Add extension**.
6. Go back to the Steam client and reload a store page. The extension is now active.

### Opening extension settings

Paste the extension's options URL into the same Chromium window:

| Extension | Options URL |
|---|---|
| Augmented Steam | `chrome-extension://dnhpnfgdlenaccegplpojghhmaamnnfp/html/options.html` |
| Other extensions | Open `chrome://extensions`, then **Details**, then **Extension options** |

### Removing an extension

Open `chrome://extensions` in the same window and click **Remove**. Clearing Steam's web browser data in Steam's settings also removes every installed extension.

## Check what is installed

```powershell
powershell -ExecutionPolicy Bypass -File .\check-extensions.ps1
```

It lists the extensions in Steam's browser profile with their names and versions. It only reads files.

## Recommended settings

[`settings/AugmentedSteam.json`](settings/AugmentedSteam.json) is a cleaned-up Augmented Steam preset meant to sit alongside the SteamDB extension:

- SteamDB and PCGamingWiki buttons are turned off, since the SteamDB extension already adds them.
- Twitch, YouTube, SteamPeek, WSGF and extra profile links are turned off to reduce clutter.
- Price history, lowest price, IsThereAnyDeal, HowLongToBeat, player counts, review scores and DRM info stay on.

Import it from the Augmented Steam options page (**Import**).

## Security

**Extensions in this window share your logged-in Steam session.** An extension installed here can read your inventory and act on your account, including sending trade offers.

- Install only extensions you trust. Augmented Steam and SteamDB are open source and widely used.
- Do not use this window for general browsing or for logging into other sites.

## Limitations

- This behavior is undocumented. A Steam client update could remove the middle-click window. Extensions that are already installed would most likely keep working, but new installs might not be possible.
- Do not change settings in `chrome://settings` inside this window. The same browser also renders the Steam client itself.

## Tested on

- Windows 11
- Steam client build `1792618285`
- Steam CEF `126.0.0` (Chromium `126.0.6478.183`)

## License

[MIT](LICENSE)
