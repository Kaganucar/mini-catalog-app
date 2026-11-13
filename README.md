# Mini Katalog Uygulaması

Flutter ile geliştirilen örnek ürün kataloğu. Keşfet ekranında ürünler kartlarla listelenir. Ürün detayında ürün bilgileri görülür ve ürün sepete eklenebilir. Sepet ekranında eklenen ürünler görüntülenebilir ve kaldırılabilir.

## Kullanılan Flutter sürümü

Projenin arşivdeki SDK kaydı Flutter 3.47.9 ve Dart 3.13.7 sürümlerini gösterir. Kurulu SDK'yı `flutter --version` ile kontrol edin.

## Çalıştırma

Proje klasöründe bağımlılıkları yükleyin.

```bash
flutter pub get
```

Android Studio'da bir emülatör başlatın veya fiziksel cihaz bağlayın. Cihazı listeleyip uygulamayı çalıştırın.

```bash
flutter devices
flutter run
```

Chrome ile çalıştırmak için `flutter run -d chrome` komutunu kullanabilirsiniz.

## Katalog verileri

Banner ve 20 WANTAPI ürünü uygulama paketindeki dosyalardan okunur. Yedi görsel yönergenin 4. sayfasındaki örnek ekranlardan kırpıldı. Kalan 13 ürün için temsili görseller üretildi. 20 ürünün tamamı görselini assets/products klasöründen okur. Fake Store API ve DummyJSON çıktıları `ornek_veriler/` klasöründedir.

## Sepet ve demo sipariş

Sepetteki eksi düğmesi bir adedi kaldırır. Checkout ürün adedini ve toplam tutarı gösterir. Demo siparişi onaylandığında sepet boşalır. Ödeme alınmaz.
