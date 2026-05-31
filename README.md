# Üretim ve Stok Takip Sistemi

## Proje Hakkında

Bu proje, Flask kullanılarak geliştirilmiş bir **Üretim, Stok, Satış ve Muhasebe Yönetim Sistemi**dir.

Sistem üzerinden;

* Müşteri yönetimi
* Ürün yönetimi
* Malzeme yönetimi
* Tedarikçi yönetimi
* Satış işlemleri
* Üretim işlemleri
* Gelir/Gider takibi
* Kasa yönetimi
* Personel ve yönetici işlemleri

gerçekleştirilebilmektedir.

Veritabanı tasarımı ilişkisel yapıda oluşturulmuş olup müşteri, ürün, satış, üretim, malzeme hareketleri ve finansal kayıtlar arasında ilişkiler bulunmaktadır.

---





###  Gerekli Paketleri Kurun

Projenin çalışabilmesi için requirements.txt dosyasındaki paketlerin kurulması gerekmektedir.

```bash
pip install -r requirements.txt
```

---

## Projeyi Çalıştırma

db.py adlı dosyadan mysql de kullandığınız kullanıcı adı ve şifrenizi giriniz.

### Visual Studio Code

1. Projeyi VS Code ile açın.
2. `project.py` dosyasını açın.
3. F5 tuşuna basarak projeyi çalıştırın.

---

## Veritabanı Modülleri

### Müşteriler

Müşteri kayıtlarının tutulduğu modül.

### Ürünler

Ürün bilgileri, maliyet, satış fiyatı ve stok bilgileri.

### Satışlar

Gerçekleştirilen satış işlemleri.

### Üretim

Üretim kayıtları ve kullanılan malzemeler.

### Malzemeler

Hammadde ve üretim malzemeleri.

### Malzeme Hareketleri

Malzeme giriş kayıtları.

### Tedarikçiler

Tedarikçi firma bilgileri.

### Gelir/Gider

Finansal hareketlerin takibi.

### Kasa

Güncel kasa bakiyesi ve işlemler.

### Personel ve Yönetici

Sistem kullanıcıları ve yetkilendirme işlemleri.

---

---


