-- ============================================================
-- PASTAHANE VERİTABANI
-- ============================================================

CREATE DATABASE IF NOT EXISTS pastahane;
USE pastahane;

-- ============================================================
-- 1. TABLOLAR
-- ============================================================

DROP TABLE IF EXISTS gelir_gider;
DROP TABLE IF EXISTS kasa;
DROP TABLE IF EXISTS malzeme_hareketleri;
DROP TABLE IF EXISTS malzemeler;
DROP TABLE IF EXISTS musteriler;
DROP TABLE IF EXISTS satis;
DROP TABLE IF EXISTS uretim;
DROP TABLE IF EXISTS urunler;
DROP TABLE IF EXISTS tedarikciler;
DROP TABLE IF EXISTS personel;
DROP TABLE IF EXISTS yonetici;

CREATE TABLE tedarikciler (
    tedarikci_id INT NOT NULL AUTO_INCREMENT,
    firma_adi VARCHAR(50) NOT NULL,
    iletisim_kisi VARCHAR(50) NOT NULL,
    firma_telefon VARCHAR(15) NOT NULL,
    firma_adres VARCHAR(150) NOT NULL,
    PRIMARY KEY (tedarikci_id)
);

CREATE TABLE malzemeler (
    malzeme_id INT NOT NULL AUTO_INCREMENT,
    malzeme_ad VARCHAR(50) NOT NULL,
    malzeme_stok DECIMAL(10,2) DEFAULT NULL,
    malzeme_fiyat DECIMAL(10,2) DEFAULT NULL,
    malzeme_notlar VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (malzeme_id)
);

CREATE TABLE musteriler (
    musteri_id INT NOT NULL AUTO_INCREMENT,
    musteri_adi VARCHAR(30) NOT NULL,
    musteri_soyadi VARCHAR(30) NOT NULL,
    musteri_telefon VARCHAR(11) DEFAULT NULL,
    PRIMARY KEY (musteri_id)
);

CREATE TABLE personel (
    personel_id INT NOT NULL AUTO_INCREMENT,
    personel_ad VARCHAR(50) NOT NULL,
    personel_sifre VARCHAR(30) NOT NULL,
    rol VARCHAR(20) DEFAULT 'personel',
    PRIMARY KEY (personel_id)
);

CREATE TABLE yonetici (
    yonetici_id INT NOT NULL AUTO_INCREMENT,
    yonetici_adi_soyadi VARCHAR(30) NOT NULL,
    yonetici_sifre VARCHAR(30) NOT NULL,
    rol VARCHAR(10) DEFAULT 'admin',
    PRIMARY KEY (yonetici_id)
);

CREATE TABLE urunler (
    urun_id INT NOT NULL AUTO_INCREMENT,
    urun_adi VARCHAR(30) NOT NULL,
    maliyet DECIMAL(10,2) NOT NULL,
    satis_fiyat DECIMAL(10,2) NOT NULL,
    stok DECIMAL(10,2) DEFAULT NULL,
    notlar VARCHAR(50) DEFAULT NULL,
    kar_orani DECIMAL(5,2) NOT NULL DEFAULT '50.00',
    PRIMARY KEY (urun_id)
);

CREATE TABLE satis (
    satis_id INT NOT NULL AUTO_INCREMENT,
    urun_adi VARCHAR(30) NOT NULL,
    adet DECIMAL(10,2) NOT NULL,
    personel_id INT NOT NULL,
    fiyat DECIMAL(10,2) NOT NULL,
    tarih DATE NOT NULL,
    musteri_id INT NOT NULL,
    urun_id INT NOT NULL,
    PRIMARY KEY (satis_id),
    FOREIGN KEY (urun_id) REFERENCES urunler(urun_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (musteri_id) REFERENCES musteriler(musteri_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (personel_id) REFERENCES personel(personel_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE uretim (
    uretim_id INT NOT NULL AUTO_INCREMENT,
    urun_id INT NOT NULL,
    malzeme_id INT NOT NULL,
    malzeme_miktar DECIMAL(10,2) NOT NULL,
    urun_adi VARCHAR(30) NOT NULL,
    malzeme_adi VARCHAR(30) NOT NULL,
    uretim_miktari DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (uretim_id),
    FOREIGN KEY (urun_id) REFERENCES urunler(urun_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (malzeme_id) REFERENCES malzemeler(malzeme_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE malzeme_hareketleri (
    hareket_id INT NOT NULL AUTO_INCREMENT,
    malzeme_id INT NOT NULL,
    alis_tarih DATE NOT NULL,
    alinan_miktar DECIMAL(10,2) NOT NULL,
    birimfiyat DECIMAL(10,2) NOT NULL,
    toplam_miktar DECIMAL(10,2) NOT NULL,
    tedarikci_id INT NOT NULL,
    PRIMARY KEY (hareket_id),
    FOREIGN KEY (malzeme_id) REFERENCES malzemeler(malzeme_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler(tedarikci_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE kasa (
    kasa_id INT NOT NULL AUTO_INCREMENT,
    bakiye DECIMAL(10,2) NOT NULL DEFAULT '0.00',
    son_guncelleme DATETIME NOT NULL,
    kayit_id INT DEFAULT NULL,
    PRIMARY KEY (kasa_id),
    FOREIGN KEY (kayit_id) REFERENCES gelir_gider(kayit_id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE gelir_gider (
    kayit_id INT NOT NULL AUTO_INCREMENT,
    islem_tipi ENUM('gelir','gider') NOT NULL,
    islem_tarihi DATE NOT NULL,
    aciklama VARCHAR(100) DEFAULT NULL,
    tutar DECIMAL(10,2) NOT NULL,
    malzeme_id INT DEFAULT NULL,
    alinan_miktar DECIMAL(10,2) DEFAULT NULL,
    birim_fiyat DECIMAL(10,2) DEFAULT NULL,
    tedarikci_id INT DEFAULT NULL,
    satis_id INT DEFAULT NULL,
    urun_id INT DEFAULT NULL,
    satilan_adet DECIMAL(10,2) DEFAULT NULL,
    hareket_id INT DEFAULT NULL,
    PRIMARY KEY (kayit_id),
    FOREIGN KEY (malzeme_id) REFERENCES malzemeler(malzeme_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (tedarikci_id) REFERENCES tedarikciler(tedarikci_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (satis_id) REFERENCES satis(satis_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (urun_id) REFERENCES urunler(urun_id) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (hareket_id) REFERENCES malzeme_hareketleri(hareket_id) ON DELETE SET NULL ON UPDATE CASCADE
);

-- ============================================================
-- 2. VERİLER
-- ============================================================

INSERT INTO tedarikciler (firma_adi, iletisim_kisi, firma_telefon, firma_adres) VALUES
('Başak Un Gıda', 'Hasan Başak', '02121234567', 'İstanbul, Bağcılar'),
('Tatlım Malzeme', 'Selin Tatlı', '03121234567', 'Ankara, Çankaya'),
('Güven Gıda', 'Kemal Güven', '02321234567', 'İzmir, Bornova');

INSERT INTO malzemeler (malzeme_ad, malzeme_stok, malzeme_fiyat, malzeme_notlar) VALUES
('Un', 150.00, 5.00, 'kg'),
('Şeker', 40.00, 7.00, 'kg'),
('Tereyağı', 20.00, 45.00, 'kg'),
('Kakao', 15.00, 80.00, 'kg'),
('Krem Peynir', 10.00, 80.00, 'kg'),
('Yumurta', 200.00, 3.00, 'adet'),
('Krema', 24.00, 30.00, 'litre'),
('Bisküvi', 30.00, 20.00, 'kg');

INSERT INTO musteriler (musteri_adi, musteri_soyadi, musteri_telefon) VALUES
('Ahmet', 'Yılmaz', '05301234567'),
('Ayşe', 'Kaya', '05421234567'),
('Mehmet', 'Demir', '05531234567'),
('Fatma', 'Çelik', '05061234567'),
('Ali', 'Şahin', '05321234567');

INSERT INTO personel (personel_ad, personel_sifre, rol) VALUES
('Elif Arslan', 'elif123', 'personel'),
('Murat Koç', 'murat123', 'personel'),
('Zeynep Aydın', 'zeynep123', 'personel');

INSERT INTO yonetici (yonetici_adi_soyadi, yonetici_sifre, rol) VALUES
('yigit emre', '123456', 'admin');

INSERT INTO urunler (urun_adi, maliyet, satis_fiyat, stok, notlar, kar_orani) VALUES
('Çikolatalı Pasta', 35.50, 53.25, 12.00, 'Günlük taze', 50.00),
('Cheesecake', 43.00, 64.50, 8.00, NULL, 50.00),
('Tiramisu', 49.00, 73.50, 16.00, 'İtalyan tarifi', 50.00),
('Profiterol', 15.00, 22.50, 15.00, NULL, 50.00),
('Mozaik Pasta', 29.00, 43.50, 1.00, 'Soğuk servis', 50.00);

INSERT INTO satis (urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id) VALUES
('Cheesecake', 1.00, 2, 280.00, '2024-12-05', 2, 2),
('Tiramisu', 3.00, 1, 750.00, '2024-12-06', 3, 3),
('Profiterol', 2.00, 3, 400.00, '2024-12-06', 4, 4),
('Mozaik Pasta', 1.00, 2, 220.00, '2024-12-07', 5, 5),
('Çikolatalı Pasta', 1.00, 3, 350.00, '2024-12-07', 1, 1),
('Cheesecake', 2.00, 1, 560.00, '2024-12-08', 3, 2);

INSERT INTO uretim (urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari) VALUES
(1, 1, 0.50, 'Çikolatalı Pasta', 'Un', 1.00),
(1, 4, 0.30, 'Çikolatalı Pasta', 'Kakao', 1.00),
(1, 3, 0.20, 'Çikolatalı Pasta', 'Tereyağı', 1.00),
(2, 5, 0.40, 'Cheesecake', 'Krem Peynir', 1.00),
(2, 8, 0.30, 'Cheesecake', 'Bisküvi', 1.00),
(3, 7, 0.50, 'Tiramisu', 'Krema', 1.00),
(3, 8, 0.20, 'Tiramisu', 'Bisküvi', 1.00),
(4, 7, 0.30, 'Profiterol', 'Krema', 1.00),
(4, 6, 2.00, 'Profiterol', 'Yumurta', 1.00),
(5, 8, 0.40, 'Mozaik Pasta', 'Bisküvi', 1.00),
(5, 4, 0.20, 'Mozaik Pasta', 'Kakao', 1.00);

INSERT INTO malzeme_hareketleri (malzeme_id, alis_tarih, alinan_miktar, birimfiyat, toplam_miktar, tedarikci_id) VALUES
(1, '2024-12-01', 20.00, 5.00, 100.00, 1),
(2, '2024-12-01', 15.00, 7.00, 105.00, 1),
(3, '2024-12-02', 10.00, 45.00, 450.00, 2),
(4, '2024-12-02', 5.00, 60.00, 300.00, 2),
(5, '2024-12-03', 8.00, 80.00, 640.00, 3),
(6, '2024-12-03', 100.00, 3.00, 300.00, 3),
(7, '2024-12-04', 10.00, 30.00, 300.00, 2),
(8, '2024-12-04', 12.00, 20.00, 240.00, 1);

INSERT INTO kasa (bakiye, son_guncelleme) VALUES (0.00, NOW());

-- ============================================================
-- 3. FONKSİYONLAR
-- ============================================================

DELIMITER //

CREATE FUNCTION urun_kar_hesapla(p_urun_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_satis_fiyat DECIMAL(10,2);
    DECLARE v_maliyet DECIMAL(10,2);
    SELECT satis_fiyat, maliyet INTO v_satis_fiyat, v_maliyet
    FROM urunler WHERE urun_id = p_urun_id;
    RETURN v_satis_fiyat - v_maliyet;
END//

CREATE FUNCTION toplam_satis_tutari(p_musteri_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_toplam DECIMAL(10,2);
    SELECT COALESCE(SUM(fiyat), 0) INTO v_toplam
    FROM satis WHERE musteri_id = p_musteri_id;
    RETURN v_toplam;
END//

DELIMITER ;

-- ============================================================
-- 4. STORED PROCEDURE'LAR
-- ============================================================

DELIMITER //

-- Müşteri
CREATE PROCEDURE musteri_ekle(IN p_musteri_adi VARCHAR(30), IN p_musteri_soyadi VARCHAR(30), IN p_musteri_telefon VARCHAR(11))
BEGIN
    INSERT INTO musteriler(musteri_adi, musteri_soyadi, musteri_telefon)
    VALUES (p_musteri_adi, p_musteri_soyadi, p_musteri_telefon);
END//

CREATE PROCEDURE musteri_guncelle(IN p_musteri_id INT, IN p_musteri_adi VARCHAR(30), IN p_musteri_soyadi VARCHAR(30), IN p_musteri_telefon VARCHAR(11))
BEGIN
    UPDATE musteriler SET musteri_adi=p_musteri_adi, musteri_soyadi=p_musteri_soyadi, musteri_telefon=p_musteri_telefon
    WHERE musteri_id=p_musteri_id;
END//

CREATE PROCEDURE musteri_sil(IN p_musteri_id INT)
BEGIN
    DELETE FROM musteriler WHERE musteri_id=p_musteri_id;
END//

CREATE PROCEDURE musteri_listele()
BEGIN
    SELECT m.*, toplam_satis_tutari(m.musteri_id) AS toplam_harcama FROM musteriler m;
END//

CREATE PROCEDURE musteri_getir(IN p_musteri_id INT)
BEGIN
    SELECT * FROM musteriler WHERE musteri_id=p_musteri_id;
END//

-- Personel
CREATE PROCEDURE personel_ekle(IN p_personel_ad VARCHAR(50), IN p_personel_sifre VARCHAR(30))
BEGIN
    INSERT INTO personel(personel_ad, personel_sifre) VALUES (p_personel_ad, p_personel_sifre);
END//

CREATE PROCEDURE personel_guncelle(IN p_personel_id INT, IN p_personel_ad VARCHAR(50), IN p_personel_sifre VARCHAR(30))
BEGIN
    UPDATE personel SET personel_ad=p_personel_ad, personel_sifre=p_personel_sifre
    WHERE personel_id=p_personel_id;
END//

CREATE PROCEDURE personel_sil(IN p_personel_id INT)
BEGIN
    DELETE FROM personel WHERE personel_id=p_personel_id;
END//

CREATE PROCEDURE personel_listele()
BEGIN
    SELECT * FROM personel;
END//

-- Tedarikçi
CREATE PROCEDURE tedarikci_ekle(IN p_firma_adi VARCHAR(50), IN p_iletisim_kisi VARCHAR(50), IN p_firma_telefon VARCHAR(15), IN p_firma_adres VARCHAR(150))
BEGIN
    INSERT INTO tedarikciler(firma_adi, iletisim_kisi, firma_telefon, firma_adres)
    VALUES (p_firma_adi, p_iletisim_kisi, p_firma_telefon, p_firma_adres);
END//

CREATE PROCEDURE tedarikci_guncelle(IN p_tedarikci_id INT, IN p_firma_adi VARCHAR(50), IN p_iletisim_kisi VARCHAR(50), IN p_firma_telefon VARCHAR(15), IN p_firma_adres VARCHAR(150))
BEGIN
    UPDATE tedarikciler SET firma_adi=p_firma_adi, iletisim_kisi=p_iletisim_kisi, firma_telefon=p_firma_telefon, firma_adres=p_firma_adres
    WHERE tedarikci_id=p_tedarikci_id;
END//

CREATE PROCEDURE tedarikci_sil(IN p_tedarikci_id INT)
BEGIN
    DELETE FROM tedarikciler WHERE tedarikci_id=p_tedarikci_id;
END//

CREATE PROCEDURE tedarikci_listele()
BEGIN
    SELECT * FROM tedarikciler;
END//

-- Ürün
CREATE PROCEDURE urun_ekle(IN p_urun_adi VARCHAR(30), IN p_maliyet DECIMAL(10,2), IN p_satis_fiyat DECIMAL(10,2), IN p_stok DECIMAL(10,2), IN p_notlar VARCHAR(50))
BEGIN
    INSERT INTO urunler(urun_adi, maliyet, satis_fiyat, stok, notlar)
    VALUES (p_urun_adi, p_maliyet, p_satis_fiyat, p_stok, p_notlar);
END//

CREATE PROCEDURE urun_guncelle(IN p_urun_id INT, IN p_urun_adi VARCHAR(30), IN p_maliyet DECIMAL(10,2), IN p_satis_fiyat DECIMAL(10,2), IN p_stok DECIMAL(10,2), IN p_notlar VARCHAR(50))
BEGIN
    UPDATE urunler SET urun_adi=p_urun_adi, maliyet=p_maliyet, satis_fiyat=p_satis_fiyat, stok=p_stok, notlar=p_notlar
    WHERE urun_id=p_urun_id;
END//

CREATE PROCEDURE urun_sil(IN p_urun_id INT)
BEGIN
    DELETE FROM urunler WHERE urun_id=p_urun_id;
END//

CREATE PROCEDURE urun_listele()
BEGIN
    SELECT u.*, urun_kar_hesapla(u.urun_id) AS kar FROM urunler u;
END//

-- Malzeme
CREATE PROCEDURE malzeme_ekle(IN p_malzeme_ad VARCHAR(50), IN p_malzeme_stok DECIMAL(10,2), IN p_malzeme_fiyat DECIMAL(10,2), IN p_malzeme_notlar VARCHAR(50))
BEGIN
    INSERT INTO malzemeler(malzeme_ad, malzeme_stok, malzeme_fiyat, malzeme_notlar)
    VALUES (p_malzeme_ad, p_malzeme_stok, p_malzeme_fiyat, p_malzeme_notlar);
END//

CREATE PROCEDURE malzeme_guncelle(IN p_malzeme_id INT, IN p_malzeme_ad VARCHAR(50), IN p_malzeme_stok DECIMAL(10,2), IN p_malzeme_fiyat DECIMAL(10,2), IN p_malzeme_notlar VARCHAR(50))
BEGIN
    UPDATE malzemeler SET malzeme_ad=p_malzeme_ad, malzeme_stok=p_malzeme_stok, malzeme_fiyat=p_malzeme_fiyat, malzeme_notlar=p_malzeme_notlar
    WHERE malzeme_id=p_malzeme_id;
END//

CREATE PROCEDURE malzeme_sil(IN p_malzeme_id INT)
BEGIN
    DELETE FROM malzemeler WHERE malzeme_id=p_malzeme_id;
END//

CREATE PROCEDURE malzeme_listele()
BEGIN
    SELECT * FROM malzemeler;
END//

-- Malzeme Hareketleri
CREATE PROCEDURE hareket_ekle(IN p_malzeme_id INT, IN p_alis_tarih DATE, IN p_alinan_miktar DECIMAL(10,2), IN p_birimfiyat DECIMAL(10,2), IN p_toplam_miktar DECIMAL(10,2), IN p_tedarikci_id INT)
BEGIN
    INSERT INTO malzeme_hareketleri(malzeme_id, alis_tarih, alinan_miktar, birimfiyat, toplam_miktar, tedarikci_id)
    VALUES (p_malzeme_id, p_alis_tarih, p_alinan_miktar, p_birimfiyat, p_toplam_miktar, p_tedarikci_id);
END//

CREATE PROCEDURE hareket_guncelle(IN p_hareket_id INT, IN p_malzeme_id INT, IN p_alis_tarih DATE, IN p_alinan_miktar DECIMAL(10,2), IN p_birimfiyat DECIMAL(10,2), IN p_toplam_miktar DECIMAL(10,2), IN p_tedarikci_id INT)
BEGIN
    UPDATE malzeme_hareketleri SET malzeme_id=p_malzeme_id, alis_tarih=p_alis_tarih, alinan_miktar=p_alinan_miktar,
    birimfiyat=p_birimfiyat, toplam_miktar=p_toplam_miktar, tedarikci_id=p_tedarikci_id
    WHERE hareket_id=p_hareket_id;
END//

CREATE PROCEDURE hareket_sil(IN p_hareket_id INT)
BEGIN
    DELETE FROM malzeme_hareketleri WHERE hareket_id=p_hareket_id;
END//

CREATE PROCEDURE hareket_listele()
BEGIN
    SELECT mh.*, m.malzeme_ad, t.firma_adi
    FROM malzeme_hareketleri mh
    JOIN malzemeler m ON mh.malzeme_id = m.malzeme_id
    JOIN tedarikciler t ON mh.tedarikci_id = t.tedarikci_id
    ORDER BY mh.alis_tarih DESC;
END//

-- Satış
CREATE PROCEDURE satis_ekle(IN p_urun_adi VARCHAR(30), IN p_adet DECIMAL(10,2), IN p_personel_id INT, IN p_fiyat DECIMAL(10,2), IN p_tarih DATE, IN p_musteri_id INT, IN p_urun_id INT)
BEGIN
    INSERT INTO satis(urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id)
    VALUES(p_urun_adi, p_adet, p_personel_id, p_fiyat, p_tarih, p_musteri_id, p_urun_id);
END//

CREATE PROCEDURE satis_guncelle(IN p_satis_id INT, IN p_urun_adi VARCHAR(30), IN p_adet DECIMAL(10,2), IN p_personel_id INT, IN p_fiyat DECIMAL(10,2), IN p_tarih DATE, IN p_musteri_id INT, IN p_urun_id INT)
BEGIN
    UPDATE satis SET urun_adi=p_urun_adi, adet=p_adet, personel_id=p_personel_id, fiyat=p_fiyat,
    tarih=p_tarih, musteri_id=p_musteri_id, urun_id=p_urun_id
    WHERE satis_id=p_satis_id;
END//

CREATE PROCEDURE satis_sil(IN p_satis_id INT)
BEGIN
    DELETE FROM satis WHERE satis_id=p_satis_id;
END//

CREATE PROCEDURE satis_listele()
BEGIN
    SELECT s.*, p.personel_ad, m.musteri_adi, m.musteri_soyadi
    FROM satis s
    JOIN personel p ON s.personel_id = p.personel_id
    JOIN musteriler m ON s.musteri_id = m.musteri_id
    ORDER BY s.tarih DESC;
END//

-- Üretim
CREATE PROCEDURE uretim_ekle(IN p_urun_id INT, IN p_malzeme_id INT, IN p_malzeme_miktar DECIMAL(10,2), IN p_urun_adi VARCHAR(30), IN p_malzeme_adi VARCHAR(30), IN p_uretim_miktari DECIMAL(10,2))
BEGIN
    INSERT INTO uretim(urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari)
    VALUES(p_urun_id, p_malzeme_id, p_malzeme_miktar, p_urun_adi, p_malzeme_adi, p_uretim_miktari);
END//

CREATE PROCEDURE uretim_guncelle(IN p_uretim_id INT, IN p_urun_id INT, IN p_malzeme_id INT, IN p_malzeme_miktar DECIMAL(10,2), IN p_urun_adi VARCHAR(30), IN p_malzeme_adi VARCHAR(30), IN p_uretim_miktari DECIMAL(10,2))
BEGIN
    UPDATE uretim SET urun_id=p_urun_id, malzeme_id=p_malzeme_id, malzeme_miktar=p_malzeme_miktar,
    urun_adi=p_urun_adi, malzeme_adi=p_malzeme_adi, uretim_miktari=p_uretim_miktari
    WHERE uretim_id=p_uretim_id;
END//

CREATE PROCEDURE uretim_sil(IN p_uretim_id INT)
BEGIN
    DELETE FROM uretim WHERE uretim_id=p_uretim_id;
END//

CREATE PROCEDURE uretim_listele()
BEGIN
    SELECT * FROM uretim;
END//

-- Gelir Gider
CREATE PROCEDURE gelir_gider_ekle(IN p_islem_tipi ENUM('gelir','gider'), IN p_islem_tarihi DATE, IN p_aciklama VARCHAR(100), IN p_tutar DECIMAL(10,2), IN p_malzeme_id INT, IN p_alinan_miktar DECIMAL(10,2), IN p_birim_fiyat DECIMAL(10,2), IN p_tedarikci_id INT, IN p_satis_id INT, IN p_urun_id INT, IN p_satilan_adet DECIMAL(10,2))
BEGIN
    INSERT INTO gelir_gider(islem_tipi, islem_tarihi, aciklama, tutar, malzeme_id, alinan_miktar, birim_fiyat, tedarikci_id, satis_id, urun_id, satilan_adet)
    VALUES(p_islem_tipi, p_islem_tarihi, p_aciklama, p_tutar, p_malzeme_id, p_alinan_miktar, p_birim_fiyat, p_tedarikci_id, p_satis_id, p_urun_id, p_satilan_adet);
END//

CREATE PROCEDURE gelir_gider_guncelle(IN p_kayit_id INT, IN p_islem_tipi ENUM('gelir','gider'), IN p_islem_tarihi DATE, IN p_aciklama VARCHAR(100), IN p_tutar DECIMAL(10,2), IN p_malzeme_id INT, IN p_alinan_miktar DECIMAL(10,2), IN p_birim_fiyat DECIMAL(10,2), IN p_tedarikci_id INT, IN p_satis_id INT, IN p_urun_id INT, IN p_satilan_adet DECIMAL(10,2))
BEGIN
    UPDATE gelir_gider SET islem_tipi=p_islem_tipi, islem_tarihi=p_islem_tarihi, aciklama=p_aciklama, tutar=p_tutar,
    malzeme_id=p_malzeme_id, alinan_miktar=p_alinan_miktar, birim_fiyat=p_birim_fiyat, tedarikci_id=p_tedarikci_id,
    satis_id=p_satis_id, urun_id=p_urun_id, satilan_adet=p_satilan_adet
    WHERE kayit_id=p_kayit_id;
END//

CREATE PROCEDURE gelir_gider_sil(IN p_kayit_id INT)
BEGIN
    DELETE FROM gelir_gider WHERE kayit_id=p_kayit_id;
END//

CREATE PROCEDURE gelir_gider_listele()
BEGIN
    SELECT * FROM gelir_gider;
END//

-- Giriş
CREATE PROCEDURE sp_GirisYap(IN p_kullanici_adi VARCHAR(50), IN p_sifre VARCHAR(50))
BEGIN
    SELECT yonetici_adi_soyadi AS kullanici_adi, rol FROM yonetici
    WHERE yonetici_adi_soyadi = p_kullanici_adi AND yonetici_sifre = p_sifre
    UNION ALL
    SELECT personel_ad AS kullanici_adi, rol FROM personel
    WHERE personel_ad = p_kullanici_adi AND personel_sifre = p_sifre;
END//

-- Dashboard
CREATE PROCEDURE sp_son_satislar()
BEGIN
    SELECT u.urun_adi, s.satilan_adet AS adet, s.tutar AS fiyat, s.islem_tarihi AS tarih
    FROM gelir_gider s
    JOIN urunler u ON s.urun_id = u.urun_id
    WHERE s.islem_tipi = 'gelir'
    ORDER BY s.islem_tarihi DESC LIMIT 5;
END//

CREATE PROCEDURE sp_dusuk_stok_uyarisi()
BEGIN
    SELECT urun_adi, stok FROM urunler WHERE stok < 5 ORDER BY stok ASC;
END//

DELIMITER ;

-- ============================================================
-- 5. TRIGGER'LAR
-- ============================================================

DELIMITER //

-- Satış Trigger'ları
CREATE TRIGGER satis_insert
AFTER INSERT ON satis
FOR EACH ROW
BEGIN
    IF (SELECT stok FROM urunler WHERE urun_id = NEW.urun_id) < NEW.adet THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Yetersiz stok!';
    ELSE
        UPDATE urunler SET stok = stok - NEW.adet WHERE urun_id = NEW.urun_id;
        INSERT INTO gelir_gider(islem_tipi, islem_tarihi, aciklama, tutar, satis_id, urun_id, satilan_adet)
        VALUES('gelir', NEW.tarih, NEW.urun_adi, NEW.fiyat, NEW.satis_id, NEW.urun_id, NEW.adet);
        UPDATE kasa SET bakiye = bakiye + NEW.fiyat, son_guncelleme = NOW() WHERE kasa_id = 1;
    END IF;
END//

CREATE TRIGGER satis_update
AFTER UPDATE ON satis
FOR EACH ROW
BEGIN
    UPDATE urunler SET stok = stok + OLD.adet - NEW.adet WHERE urun_id = OLD.urun_id;
    UPDATE gelir_gider SET islem_tarihi=NEW.tarih, tutar=NEW.fiyat, urun_id=NEW.urun_id, satilan_adet=NEW.adet
    WHERE satis_id = NEW.satis_id;
    UPDATE kasa SET bakiye = bakiye - OLD.fiyat + NEW.fiyat, son_guncelleme = NOW() WHERE kasa_id = 1;
END//

CREATE TRIGGER satis_delete
AFTER DELETE ON satis
FOR EACH ROW
BEGIN
    UPDATE urunler SET stok = stok + OLD.adet WHERE urun_id = OLD.urun_id;
    DELETE FROM gelir_gider WHERE satis_id = OLD.satis_id;
    UPDATE kasa SET bakiye = bakiye - OLD.fiyat, son_guncelleme = NOW() WHERE kasa_id = 1;
END//

-- Malzeme Hareketleri Trigger'ları
CREATE TRIGGER malzeme_hareketleri_insert
AFTER INSERT ON malzeme_hareketleri
FOR EACH ROW
BEGIN
    UPDATE malzemeler SET malzeme_stok = malzeme_stok + NEW.alinan_miktar, malzeme_fiyat = NEW.birimfiyat
    WHERE malzeme_id = NEW.malzeme_id;
    INSERT INTO gelir_gider(islem_tipi, islem_tarihi, tutar, malzeme_id, alinan_miktar, birim_fiyat, tedarikci_id, hareket_id)
    VALUES('gider', NEW.alis_tarih, NEW.toplam_miktar, NEW.malzeme_id, NEW.alinan_miktar, NEW.birimfiyat, NEW.tedarikci_id, NEW.hareket_id);
    UPDATE kasa SET bakiye = bakiye - NEW.toplam_miktar, son_guncelleme = NOW() WHERE kasa_id = 1;
END//

CREATE TRIGGER malzeme_hareketleri_update
AFTER UPDATE ON malzeme_hareketleri
FOR EACH ROW
BEGIN
    UPDATE malzemeler SET malzeme_stok = malzeme_stok + OLD.alinan_miktar - NEW.alinan_miktar, malzeme_fiyat = NEW.birimfiyat
    WHERE malzeme_id = OLD.malzeme_id;
    UPDATE gelir_gider SET islem_tarihi=NEW.alis_tarih, alinan_miktar=NEW.alinan_miktar, birim_fiyat=NEW.birimfiyat,
    tutar=NEW.toplam_miktar, tedarikci_id=NEW.tedarikci_id WHERE hareket_id = NEW.hareket_id;
    UPDATE kasa SET bakiye = bakiye + OLD.toplam_miktar - NEW.toplam_miktar, son_guncelleme = NOW() WHERE kasa_id = 1;
END//

CREATE TRIGGER malzeme_hareketleri_delete
AFTER DELETE ON malzeme_hareketleri
FOR EACH ROW
BEGIN
    UPDATE malzemeler SET malzeme_stok = malzeme_stok - OLD.alinan_miktar, malzeme_fiyat = OLD.birimfiyat
    WHERE malzeme_id = OLD.malzeme_id;
    DELETE FROM gelir_gider WHERE hareket_id = OLD.hareket_id;
    UPDATE kasa SET bakiye = bakiye + OLD.toplam_miktar, son_guncelleme = NOW() WHERE kasa_id = 1;
END//

-- Üretim Trigger'ları
CREATE TRIGGER uretim_insert
AFTER INSERT ON uretim
FOR EACH ROW
BEGIN
    UPDATE urunler SET stok = stok + NEW.uretim_miktari WHERE urun_id = NEW.urun_id;
    UPDATE malzemeler SET malzeme_stok = malzeme_stok - NEW.malzeme_miktar WHERE malzeme_id = NEW.malzeme_id;
END//

CREATE TRIGGER uretim_update
AFTER UPDATE ON uretim
FOR EACH ROW
BEGIN
    UPDATE urunler SET stok = stok - OLD.uretim_miktari + NEW.uretim_miktari WHERE urun_id = NEW.urun_id;
    UPDATE malzemeler SET malzeme_stok = malzeme_stok + OLD.malzeme_miktar - NEW.malzeme_miktar WHERE malzeme_id = NEW.malzeme_id;
END//

CREATE TRIGGER uretim_delete
AFTER DELETE ON uretim
FOR EACH ROW
BEGIN
    UPDATE urunler SET stok = stok - OLD.uretim_miktari WHERE urun_id = OLD.urun_id;
    UPDATE malzemeler SET malzeme_stok = malzeme_stok + OLD.malzeme_miktar WHERE malzeme_id = OLD.malzeme_id;
END//

-- Malzemeler Update Trigger'ı
CREATE TRIGGER malzemeler_update
AFTER UPDATE ON malzemeler
FOR EACH ROW
BEGIN
    UPDATE urunler u SET
        maliyet = (SELECT SUM(m.malzeme_fiyat * ut.malzeme_miktar) FROM uretim ut JOIN malzemeler m ON ut.malzeme_id = m.malzeme_id WHERE ut.urun_id = u.urun_id),
        satis_fiyat = (SELECT SUM(m.malzeme_fiyat * ut.malzeme_miktar) FROM uretim ut JOIN malzemeler m ON ut.malzeme_id = m.malzeme_id WHERE ut.urun_id = u.urun_id) * (1 + u.kar_orani / 100)
    WHERE u.urun_id IN (SELECT DISTINCT urun_id FROM uretim WHERE malzeme_id = NEW.malzeme_id);
END//

DELIMITER ;