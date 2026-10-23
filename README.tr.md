# Steam Tarayıcı Eklentileri

**Augmented Steam** ve **SteamDB** gibi Chrome eklentilerini doğrudan Steam masaüstü uygulamasının içinde çalıştırın. Ek program yok, enjeksiyon yok, değiştirilen dosya yok.

[English](README.md)

## Nasıl çalışıyor

Steam uygulaması Chromium (CEF) üzerine kurulu. Uygulamadaki bazı bağlantılara farenin orta tuşuyla tıklayınca sekmeli ve adres çubuklu tam bir Chromium penceresi açılıyor. Bu pencere Chrome Web Mağazası'na erişebiliyor. Eklentiler Steam'in kendi tarayıcı profiline kuruluyor ve Steam'in içindeki bütün mağaza ve topluluk sayfalarında çalışıyor.

Hiçbir dosya değiştirilmiyor, hiçbir şey enjekte edilmiyor. Eklentiler Steam'in normal tarayıcı profilinde duruyor:

```
%LOCALAPPDATA%\Steam\htmlcache\Default\Extensions
```

## Adımlar

1. Steam'i açın ve **Mağaza**'da herhangi bir oyun sayfasına gidin.
2. **Community Hub** (Topluluk Merkezi) düğmesine **orta tıklayın**. Adres çubuklu ayrı bir Chromium penceresi açılır.
3. Eklentinin Chrome Web Mağazası linkini o pencerenin adres çubuğuna yapıştırın:
   - Augmented Steam: `https://chromewebstore.google.com/detail/augmented-steam/dnhpnfgdlenaccegplpojghhmaamnnfp`
   - SteamDB: `https://chromewebstore.google.com/detail/steamdb/kdbmhfkmnlmbkgbabkdealhhbfhlmmon`
4. "Switch to Chrome?" sorusu çıkarsa **No thanks** deyin.
5. **Add to Chrome**'a, ardından **Add extension**'a tıklayın.
6. Steam uygulamasına dönüp bir mağaza sayfasını yenileyin. Eklenti artık çalışıyor.

### Eklenti ayarlarını açmak

Aynı Chromium penceresine eklentinin ayar adresini yapıştırın:

| Eklenti | Ayar adresi |
|---|---|
| Augmented Steam | `chrome-extension://dnhpnfgdlenaccegplpojghhmaamnnfp/html/options.html` |
| Diğer eklentiler | `chrome://extensions` → **Details** → **Extension options** |

### Eklenti kaldırmak

Aynı pencerede `chrome://extensions` adresini açıp **Remove**'a tıklayın. Steam ayarlarından web tarayıcısı verilerini silmek de kurulu bütün eklentileri kaldırır.

## Kurulu eklentileri kontrol etmek

```powershell
powershell -ExecutionPolicy Bypass -File .\check-extensions.ps1
```

Steam'in tarayıcı profilindeki eklentileri adı ve sürümüyle listeler. Yalnız dosya okur, hiçbir şeyi değiştirmez.

## Önerilen ayarlar

[`settings/AugmentedSteam.json`](settings/AugmentedSteam.json), SteamDB eklentisiyle birlikte kullanılmak üzere sadeleştirilmiş bir Augmented Steam ayar dosyası:

- SteamDB ve PCGamingWiki düğmeleri kapalı, çünkü SteamDB eklentisi bunları zaten ekliyor.
- Kalabalık yapmasın diye Twitch, YouTube, SteamPeek, WSGF ve fazladan profil bağlantıları kapalı.
- Fiyat geçmişi, en düşük fiyat, IsThereAnyDeal, HowLongToBeat, oyuncu sayıları, inceleme puanları ve DRM bilgisi açık.

Augmented Steam ayar sayfasındaki **Import** ile içe aktarın.

## Güvenlik

**Bu penceredeki eklentiler, oturum açtığınız Steam hesabını paylaşır.** Buraya kurulan bir eklenti envanterinizi görebilir ve hesabınız adına işlem yapabilir; takas teklifi göndermek dahil.

- Yalnız güvendiğiniz eklentileri kurun. Augmented Steam ve SteamDB açık kaynak ve yaygın kullanılan eklentiler.
- Bu pencereyi genel internette gezinmek ya da başka sitelere giriş yapmak için kullanmayın.

## Sınırlamalar

- Bu davranış belgelenmemiş. Bir Steam güncellemesi orta tıkla açılan pencereyi kaldırabilir. Kurulu eklentiler büyük ihtimalle çalışmaya devam eder, ama yeni eklenti kurulamayabilir.
- Bu penceredeki `chrome://settings` ayarlarını değiştirmeyin. Aynı tarayıcı Steam uygulamasının arayüzünü de çalıştırıyor.

## Test edilen ortam

- Windows 11
- Steam istemcisi sürümü `1792618285`
- Steam CEF `126.0.0` (Chromium `126.0.6478.183`)

## Lisans

[MIT](LICENSE)
