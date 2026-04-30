create database pastahane;
use pastahane;

create table urunler(
	urun_id int primary key auto_increment not null,
    urun_adi varchar(30) not null,
    maliyet decimal(10,2) not null,
    satis_fiyat decimal(10,2) not null,
    stok decimal(10,2),
    notlar varchar(50)
);
create table malzemeler(
	malzeme_id int primary key auto_increment not null,
    malzeme_ad varchar(50) not null,
    malzeme_stok decimal(10,2),
    malzeme_fiyat decimal(10,2),
    malzeme_notlar varchar(50)
);
create table musteriler(
	musteri_id int primary key auto_increment not null,
    musteri_adi varchar(30) not null,
    musteri_soyadi varchar(30) not null,
    musteri_telefon varchar(11)
);
create table personel(
	personel_id int primary key auto_increment not null,
    personel_ad varchar(50) not null,
    personel_sifre varchar(30) not null
);
create table tedarikciler(
	tedarikci_id int primary key auto_increment not null,
    firma_adi varchar(50) not null,
    iletisim_kisi varchar(50) not null,
    firma_telefon varchar(15) not null,
    firma_adres varchar(150) not null
);
create table malzeme_hareketleri(
	hareket_id int primary key auto_increment not null,
    malzeme_id int not null,
    alis_tarih date not null,
    alinan_miktar decimal(10,2) not null,
    birimfiyat decimal(10,2) not null,
    toplam_miktar decimal(10,2) not null,
    tedarikci_id int not null,
    
    foreign key(malzeme_id) references malzemeler(malzeme_id)
    on delete cascade on update cascade,
    foreign key (tedarikci_id) references tedarikciler(tedarikci_id)
    on delete cascade on update cascade
);
create table satis(
	satis_id int primary key auto_increment not null,
    urun_adi varchar(30) not null,
    adet decimal(10,2) not null,
    personel_id int not null,
    fiyat decimal(10,2) not null,
    tarih date not null,
    musteri_id int not null,
    urun_id int not null,
    
    foreign key (urun_id) references urunler(urun_id)
    on delete cascade on update cascade,
    foreign key (musteri_id) references musteriler(musteri_id)
    on delete cascade on update cascade,
    foreign key (personel_id) references personel(personel_id)
    on delete cascade on update cascade
);
create table uretim(
	uretim_id int primary key auto_increment not null,
    urun_id	int not null,
    malzeme_id int not null,
    malzeme_miktar decimal(10,2) not null,
    urun_adi varchar(30) not null,
    malzeme_adi varchar(30) not null,
    uretim_miktari decimal(10,2) not null,
    
    foreign key (urun_id) references urunler(urun_id)
    on delete cascade on update cascade,
    foreign key (malzeme_id) references malzemeler(malzeme_id)
    on delete cascade on update cascade
);

-- Ürünler
INSERT INTO urunler (urun_adi, maliyet, satis_fiyat, stok, notlar) VALUES
('Çikolatalı Pasta', 150.00, 350.00, 10.00, 'Günlük taze'),
('Cheesecake', 120.00, 280.00, 8.00, NULL),
('Tiramisu', 100.00, 250.00, 12.00, 'İtalyan tarifi'),
('Profiterol', 80.00, 200.00, 15.00, NULL),
('Mozaik Pasta', 90.00, 220.00, 5.00, 'Soğuk servis');

-- Malzemeler
INSERT INTO malzemeler (malzeme_ad, malzeme_stok, malzeme_fiyat, malzeme_notlar) VALUES
('Un', 50.00, 5.00, 'kg'),
('Şeker', 40.00, 7.00, 'kg'),
('Tereyağı', 20.00, 45.00, 'kg'),
('Kakao', 15.00, 60.00, 'kg'),
('Krem Peynir', 10.00, 80.00, 'kg'),
('Yumurta', 200.00, 3.00, 'adet'),
('Krema', 25.00, 30.00, 'litre'),
('Bisküvi', 30.00, 20.00, 'kg');

-- Müşteriler
INSERT INTO musteriler (musteri_adi, musteri_soyadi, musteri_telefon) VALUES
('Ahmet', 'Yılmaz', '05301234567'),
('Ayşe', 'Kaya', '05421234567'),
('Mehmet', 'Demir', '05531234567'),
('Fatma', 'Çelik', '05061234567'),
('Ali', 'Şahin', '05321234567');

-- Personel
INSERT INTO personel (personel_ad, personel_sifre) VALUES
('Elif Arslan', 'elif123'),
('Murat Koç', 'murat123'),
('Zeynep Aydın', 'zeynep123');

-- Tedarikciler
INSERT INTO tedarikciler (firma_adi, iletisim_kisi, firma_telefon, firma_adres) VALUES
('Başak Un Gıda', 'Hasan Başak', '02121234567', 'İstanbul, Bağcılar'),
('Tatlım Malzeme', 'Selin Tatlı', '03121234567', 'Ankara, Çankaya'),
('Güven Gıda', 'Kemal Güven', '02321234567', 'İzmir, Bornova');

-- Malzeme Hareketleri
INSERT INTO malzeme_hareketleri (malzeme_id, alis_tarih, alinan_miktar, birimfiyat, toplam_miktar, tedarikci_id) VALUES
(1, '2024-12-01', 20.00, 5.00, 100.00, 1),
(2, '2024-12-01', 15.00, 7.00, 105.00, 1),
(3, '2024-12-02', 10.00, 45.00, 450.00, 2),
(4, '2024-12-02', 5.00, 60.00, 300.00, 2),
(5, '2024-12-03', 8.00, 80.00, 640.00, 3),
(6, '2024-12-03', 100.00, 3.00, 300.00, 3),
(7, '2024-12-04', 10.00, 30.00, 300.00, 2),
(8, '2024-12-04', 12.00, 20.00, 240.00, 1);

-- Satışlar
INSERT INTO satis (urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id) VALUES
('Çikolatalı Pasta', 2.00, 1, 700.00, '2024-12-05', 1, 1),
('Cheesecake', 1.00, 2, 280.00, '2024-12-05', 2, 2),
('Tiramisu', 3.00, 1, 750.00, '2024-12-06', 3, 3),
('Profiterol', 2.00, 3, 400.00, '2024-12-06', 4, 4),
('Mozaik Pasta', 1.00, 2, 220.00, '2024-12-07', 5, 5),
('Çikolatalı Pasta', 1.00, 3, 350.00, '2024-12-07', 1, 1),
('Cheesecake', 2.00, 1, 560.00, '2024-12-08', 3, 2);

-- Üretim
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

-- Gelir/Gider kaydı
create table gelir_gider(
    kayit_id int primary key auto_increment not null,
    islem_tipi enum('gelir', 'gider') not null,
    islem_tarihi date not null,
    aciklama varchar(100),
    tutar decimal(10,2) not null,
    
    -- Gider için (malzeme alımı)
    malzeme_id int,
    alinan_miktar decimal(10,2),
    birim_fiyat decimal(10,2),
    tedarikci_id int,
    
    -- Gelir için (satış)
    satis_id int,
    urun_id int,
    satilan_adet decimal(10,2),
    
    foreign key (malzeme_id) references malzemeler(malzeme_id)
        on delete set null on update cascade,
    foreign key (tedarikci_id) references tedarikciler(tedarikci_id)
        on delete set null on update cascade,
    foreign key (satis_id) references satis(satis_id)
        on delete set null on update cascade,
    foreign key (urun_id) references urunler(urun_id)
        on delete set null on update cascade
);

-- Kasa
create table kasa(
    kasa_id int primary key auto_increment not null,
    bakiye decimal(10,2) not null default 0.00,
    son_guncelleme datetime not null,
    kayit_id int,
    
    foreign key (kayit_id) references gelir_gider(kayit_id)
        on delete set null on update cascade
);

-- Başlangıç kasası
INSERT INTO kasa (bakiye, son_guncelleme) VALUES (0.00, NOW());

-- Gelir kayıtları (mevcut satışlardan)
INSERT INTO gelir_gider (islem_tipi, islem_tarihi, aciklama, tutar, satis_id, urun_id, satilan_adet) VALUES
('gelir', '2024-12-05', 'Çikolatalı Pasta satışı', 700.00, 1, 1, 2.00),
('gelir', '2024-12-05', 'Cheesecake satışı', 280.00, 2, 2, 1.00),
('gelir', '2024-12-06', 'Tiramisu satışı', 750.00, 3, 3, 3.00),
('gelir', '2024-12-06', 'Profiterol satışı', 400.00, 4, 4, 2.00),
('gelir', '2024-12-07', 'Mozaik Pasta satışı', 220.00, 5, 5, 1.00),
('gelir', '2024-12-07', 'Çikolatalı Pasta satışı', 350.00, 6, 1, 1.00),
('gelir', '2024-12-08', 'Cheesecake satışı', 560.00, 7, 2, 2.00);

-- Gider kayıtları (mevcut malzeme alımlarından)
INSERT INTO gelir_gider (islem_tipi, islem_tarihi, aciklama, tutar, malzeme_id, alinan_miktar, birim_fiyat, tedarikci_id) VALUES
('gider', '2024-12-01', 'Un alımı', 100.00, 1, 20.00, 5.00, 1),
('gider', '2024-12-01', 'Şeker alımı', 105.00, 2, 15.00, 7.00, 1),
('gider', '2024-12-02', 'Tereyağı alımı', 450.00, 3, 10.00, 45.00, 2),
('gider', '2024-12-02', 'Kakao alımı', 300.00, 4, 5.00, 60.00, 2),
('gider', '2024-12-03', 'Krem Peynir alımı', 640.00, 5, 8.00, 80.00, 3),
('gider', '2024-12-03', 'Yumurta alımı', 300.00, 6, 100.00, 3.00, 3),
('gider', '2024-12-04', 'Krema alımı', 300.00, 7, 10.00, 30.00, 2),
('gider', '2024-12-04', 'Bisküvi alımı', 240.00, 8, 12.00, 20.00, 1);

-- Kasa güncelleme
-- Toplam gelir: 700+280+750+400+220+350+560 = 3.260
-- Toplam gider: 100+105+450+300+640+300+300+240 = 2.435
-- Bakiye: 3.260 - 2.435 = 825
UPDATE kasa SET 
    bakiye = 825.00,
    son_guncelleme = '2024-12-08'
WHERE kasa_id = 1;

ALTER TABLE urunler ADD COLUMN kar_orani decimal(5,2) NOT NULL DEFAULT 50.00;
SET SQL_SAFE_UPDATES = 0;
UPDATE urunler SET kar_orani = 50.00;
SET SQL_SAFE_UPDATES = 1;


delimiter //

create procedure musteri_ekle(
		in p_musteri_adi varchar(30),
        in p_musteri_soyadi varchar(30),
        in p_musteri_telefon varchar(11)
)
	begin
		insert into musteriler(musteri_adi,musteri_soyadi,musteri_telefon)
        values (p_musteri_adi,p_musteri_soyadi,p_musteri_telefon);
	end //

create procedure musteri_guncelle(
		in p_musteri_id int,
		in p_musteri_adi varchar(30),
        in p_musteri_soyadi varchar(30),
        in p_musteri_telefon varchar(11)
)
	begin
		update musteriler set
			musteri_adi=p_musteri_adi,
			musteri_soyadi=p_musteri_soyadi,
			musteri_telefon=p_musteri_telefon
        where musteri_id=p_musteri_id;
	end//

create procedure musteri_sil(
		in p_musteri_id int
)
		begin
			delete from musteriler where musteri_id=p_musteri_id;
		end//

create procedure musteri_listele()
	begin
    select * from musteriler;
    end//


create procedure musteri_getir(
		in p_musteri_id int
)
	begin 
		select * from musteriler where musteri_id=p_musteri_id;
	end//

create procedure personel_ekle(
        in p_personel_ad varchar(50),
        in p_personel_sifre varchar(30)
)
		begin
			insert into personel (personel_ad,personel_sifre)
            values (p_personel_ad,p_personel_sifre);
		end//

create procedure personel_guncelle(
		in p_personel_id int,
        in p_personel_ad varchar(50),
        in p_personel_sifre varchar(30)
)
		begin
			update personel set
            personel_ad=p_personel_ad,
            personel_sifre=p_personel_sifre
            where personel_id=p_personel_id;
		end//

create procedure personel_sil(
		in p_personel_id int
)
		begin
			delete from personel where personel_id=p_personel_id;
		end//
create procedure personel_listele()
		begin
			select * from personel;
        end//

create procedure tedarikci_ekle(
		in p_firma_adi varchar(50),
		in p_iletisim_kisi varchar(50),
		in p_firma_telefon varchar(15),
		in p_firma_adres varchar(150)
)
		begin
			insert into tedarikciler (firma_adi,iletisim_kisi,firma_telefon,firma_adres)
            values (p_firma_adi,p_iletisim_kisi,p_firma_telefon,p_firma_adres);
		end//
create procedure tedarikci_guncelle(
		in p_tedarikci_id int,
        in p_firma_adi varchar(50),
		in p_iletisim_kisi varchar(50),
		in p_firma_telefon varchar(15),
		in p_firma_adres varchar(150)
)
		begin
			update tedarikciler set
				firma_adi=p_firma_adi,
                iletisim_kisi=p_iletisim_kisi,
                firma_telefon=p_firma_telefon,
                firma_adres=p_firma_adres
                where tedarikci_id=p_tedarikci_id;
		end//
create procedure tedarikci_sil(
		in p_tedarikci_id int
)
		begin
			delete from tedarikciler where tedarikci_id=p_tedarikci_id;
		end//
create procedure tedarikci_listele()
		begin
			select * from tedarikciler;
		end//

delimiter ;

delimiter //

create procedure urun_ekle(
		in p_urun_adi varchar(30),
		in p_maliyet decimal(10,2),
		in p_satis_fiyat decimal(10,2),
		in p_stok decimal(10,2),
		in p_notlar varchar(50)
)
		begin
			insert into urunler(urun_adi,maliyet,satis_fiyat,stok,notlar)
            values (p_urun_adi,p_maliyet,p_satis_fiyat,p_stok,p_notlar);
		end//
create procedure urun_guncelle(
		in p_urun_id int,
        in p_urun_adi varchar(30),
		in p_maliyet decimal(10,2),
		in p_satis_fiyat decimal(10,2),
		in p_stok decimal(10,2),
		in p_notlar varchar(50)
)
		begin
			update urunler set 
				urun_adi=p_urun_adi,
                maliyet=p_maliyet,
                satis_fiyat=p_satis_fiyat,
                stok=p_stok,
                notlar=p_notlar
                where urun_id=p_urun_id;
		end//
create procedure urun_sil(
		in p_urun_id int
)
	begin 
		delete from urunler where urun_id=p_urun_id;
	end//
create procedure urun_listele()
		begin
			select * from urunler;
		end//
        
delimiter ;

delimiter //

create procedure malzeme_ekle(
		in p_malzeme_ad varchar(50),
		in p_malzeme_stok decimal(10,2),
		in p_malzeme_fiyat decimal(10,2),
		in p_malzeme_notlar varchar(50)
)
		begin
			insert into malzemeler(malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar)
            values (p_malzeme_ad,p_malzeme_stok,p_malzeme_fiyat,p_malzeme_notlar);
		end//
create procedure malzeme_guncelle(
		in p_malzeme_id int,
        in p_malzeme_ad varchar(50),
		in p_malzeme_stok decimal(10,2),
		in p_malzeme_fiyat decimal(10,2),
		in p_malzeme_notlar varchar(50)
)
		begin
			update malzemeler set 
				malzeme_ad=p_malzeme_ad,
                malzeme_stok=p_malzeme_stok,
                malzeme_fiyat=p_malzeme_fiyat,
                malzeme_notlar=p_malzeme_notlar
                where malzeme_id=p_malzeme_id;
		end//
create procedure malzeme_sil(
		in p_malzeme_id int
)
		begin 
			delete from malzemeler where malzeme_id=p_malzeme_id;
		end//
create procedure malzeme_listele()
		begin
			select * from malzemeler;
		end//

create procedure hareket_ekle(
		in p_malzeme_id int,
		in p_alis_tarih date,
		in p_alinan_miktar decimal(10,2),
		in p_birimfiyat decimal(10,2),
		in p_toplam_miktar decimal(10,2),
		in p_tedarikci_id int
)
		begin
			insert into malzeme_hareketleri(malzeme_id,alis_tarih,alinan_miktar,birimfiyat,toplam_miktar,tedarikci_id)
            values (p_malzeme_id,p_alis_tarih,p_alinan_miktar,p_birimfiyat,p_toplam_miktar,p_tedarikci_id);
		end//
create procedure hareket_guncelle(
		in p_hareket_id int,
        in p_malzeme_id int,
		in p_alis_tarih date,
		in p_alinan_miktar decimal(10,2),
		in p_birimfiyat decimal(10,2),
		in p_toplam_miktar decimal(10,2),
		in p_tedarikci_id int
)
		begin 
			update malzeme_hareketleri set
				malzeme_id=p_malzeme_id,
                alis_tarih=p_alis_tarih,
                alinan_miktar=p_alinan_miktar,
                birimfiyat=p_birimfiyat,
                toplam_miktar=p_toplam_miktar,
                tedarikci_id=p_tedarikci_id
                where hareket_id=p_hareket_id;
		end//
create procedure hareket_sil(
		in p_hareket_id int
)
		begin
			delete from malzeme_hareketleri where hareket_id=p_hareket_id;
		end//
create procedure hareket_listele()
		begin
			select * from malzeme_hareketleri;
		end//
delimiter ;

delimiter // 

create procedure satis_ekle(
		in p_urun_adi varchar(30),
		in p_adet decimal(10,2),
		in p_personel_id int,
		in p_fiyat decimal(10,2),
		in p_tarih date,
		in p_musteri_id int,
		in p_urun_id int
)
		begin
			insert into satis(urun_adi,adet,personel_id,fiyat,tarih,musteri_id,urun_id)
            values(p_urun_adi,p_adet,p_personel_id,p_fiyat,p_tarih,p_musteri_id,p_urun_id);
		end//
create procedure satis_guncelle(
		in p_satis_id int,
		in p_urun_adi varchar(30),
		in p_adet decimal(10,2),
		in p_personel_id int,
		in p_fiyat decimal(10,2),
		in p_tarih date,
		in p_musteri_id int,
		in p_urun_id int
)
		begin 
			update satis set
            urun_adi=p_urun_adi,
            adet=p_adet,
            personel_id=p_personel_id,
            fiyat=p_fiyat,
            tarih=p_tarih,
            musteri_id=p_musteri_id,
            urun_id=p_urun_id
            where satis_id=p_satis_id;
		end//
create procedure satis_sil(
		in p_satis_id int
)
		begin
			delete from satis where satis_id=p_satis_id;
		end//
create procedure satis_listele()
		begin
			select * from satis;
		end//

create procedure uretim_ekle(
		in p_urun_id	int,
		in p_malzeme_id int,
		in p_malzeme_miktar decimal(10,2),
		in p_urun_adi varchar(30),
		in p_malzeme_adi varchar(30),
		in p_uretim_miktari decimal(10,2)
)
		begin
			insert into uretim(urun_id,malzeme_id,malzeme_miktar,urun_adi,malzeme_adi,uretim_miktari)
            values(p_urun_id,p_malzeme_id,p_malzeme_miktar,p_urun_adi,p_malzeme_adi,p_uretim_miktari);
		end//
create procedure uretim_guncelle(
		in p_uretim_id int,
        in p_urun_id	int,
		in p_malzeme_id int,
		in p_malzeme_miktar decimal(10,2),
		in p_urun_adi varchar(30),
		in p_malzeme_adi varchar(30),
		in p_uretim_miktari decimal(10,2)
)
		begin
			update uretim set
				urun_id=p_urun_id,
                malzeme_id=p_malzeme_id,
                malzeme_miktar=p_malzeme_miktar,
                urun_adi=p_urun_adi,
                malzeme_adi=p_malzeme_adi,
                uretim_miktari=p_uretim_miktari
                where uretim_id=p_uretim_id;
		end//
create procedure uretim_sil(
		in p_uretim_id	int
)
		begin
			delete from uretim where uretim_id=p_uretim_id;
		end//
create procedure uretim_listele()
		begin
			select * from uretim;
		end//
delimiter ;

delimiter //

create procedure gelir_gider_ekle(
		in p_islem_tipi enum('gelir', 'gider'),
		in p_islem_tarihi date,
		in p_aciklama varchar(100),
		in p_tutar decimal(10,2),
		in p_malzeme_id int,
		in p_alinan_miktar decimal(10,2),
		in p_birim_fiyat decimal(10,2),
		in p_tedarikci_id int,
		in p_satis_id int,
		in p_urun_id int,
		in p_satilan_adet decimal(10,2)
)
		begin
			insert into gelir_gider (islem_tipi,islem_tarihi,aciklama,tutar,malzeme_id,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet)
            values(p_islem_tipi,p_islem_tarihi,p_aciklama,p_tutar,p_malzeme_id,p_alinan_miktar,p_birim_fiyat,p_tedarikci_id,p_satis_id,p_urun_id,p_satilan_adet);
		end//
create procedure gelir_gider_guncelle(
		in p_kayit_id int,
		in p_islem_tipi enum('gelir', 'gider'),
		in p_islem_tarihi date,
		in p_aciklama varchar(100),
		in p_tutar decimal(10,2),
		in p_malzeme_id int,
		in p_alinan_miktar decimal(10,2),
		in p_birim_fiyat decimal(10,2),
		in p_tedarikci_id int,
		in p_satis_id int,
		in p_urun_id int,
		in p_satilan_adet decimal(10,2)
)
		begin
			update gelir_gider set
				islem_tipi=p_islem_tipi,
                islem_tarihi=p_islem_tarihi,
                aciklama=p_aciklama,
                tutar=p_tutar,
                malzeme_id=p_malzeme_id,
                alinan_miktar=p_alinan_miktar,
                birim_fiyat=p_birim_fiyat,
                tedarikci_id=p_tedarikci_id,
                satis_id=p_satis_id,
                urun_id=p_urun_id,
                satilan_adet=p_satilan_adet
                where kayit_id=p_kayit_id;
		end//
create procedure gelir_gider_sil(
		in p_kayit_id int
)
		begin
			delete from gelir_gider where kayit_id=p_kayit_id;
		end//
create procedure gelir_gider_listele()
		begin
			select * from gelir_gider;
		end//
delimiter ;


delimiter //
create trigger satis_insert
after insert on satis
for each row
begin
	if (select stok from urunler where urun_id=NEW.urun_id)<NEW.adet THEN
		SIGNAL SQLSTATE '45000' SET message_text="Yetersiz Stok!";
    else
		update urunler
			set stok=stok-NEW.adet
			where urun_id=NEW.urun_id;
		
		insert into gelir_gider(islem_tipi,islem_tarihi,aciklama,tutar,satis_id,urun_id,satilan_adet)
		values('gelir',NEW.tarih,NEW.urun_adi,NEW.fiyat,NEW.urun_id,NEW.adet);
		
		update kasa
			set bakiye=bakiye+NEW.fiyat,
				son_guncelleme=NOW()
				where kasa_id=1;
	end if;
end//

create trigger satis_delete
after delete on satis
for each row 
	begin
		update urunler 
			set stok=stok+OLD.adet
            where urun_id=OLD.urun_id;
		
        delete from gelir_gider
			where satis_id=OLD.satis_id;
            
        update kasa
			set bakiye=bakiye-OLD.fiyat,
				son_guncelleme=NOW()
                where kasa_id=1;
	end//

create trigger satis_update
after update on satis
for each row
		begin
			update urunler
				set stok=stok+OLD.adet-NEW.adet
					where urun_id=OLD.urun_id;
			
            update gelir_gider
				set
					islem_tarihi=NEW.tarih,
                    tutar=NEW.fiyat,
                    urun_id=NEW.urun_id,
                    satilan_adet=NEW.adet
                    where satis_id=NEW.satis_id;
            
            update kasa
				set bakiye=bakiye-OLD.fiyat+NEW.fiyat,
                son_guncelleme=NOW()
                where kasa_id=1;
		end//
delimiter ;
select * from malzeme_hareketleri;
select * from malzemeler;
select * from gelir_gider;
delimiter //

create trigger malzeme_hareketleri_insert
after insert on malzeme_hareketleri
for each row
		begin
			update malzemeler set
				malzeme_stok=malzeme_stok+NEW.alinan_miktar,
                malzeme_fiyat=NEW.birimfiyat
					where malzeme_id=NEW.malzeme_id;
			insert into gelir_gider(islem_tipi,islem_tarihi,tutar,malzeme_id,alinan_miktar,birim_fiyat,tedarikci_id,hareket_id)
				values('gider',NEW.alis_tarih,NEW.toplam_miktar,NEW.malzeme_id,NEW.alinan_miktar,NEW.birimfiyat,NEW.tedarikci_id,NEW.hareket_id);
			update kasa set
				bakiye=bakiye-NEW.toplam_miktar,
					son_guncelleme=NOW()
                    where kasa_id=1;
		end//
delimiter //
create trigger malzeme_hareketleri_delete
after delete on malzeme_hareketleri
for each row
		begin
			update 
				malzemeler set
					malzeme_stok=malzeme_stok-OLD.alinan_miktar,
                    malzeme_fiyat=OLD.birimfiyat
						where malzeme_id=OLD.malzeme_id;
			delete from gelir_gider
				where hareket_id=OLD.hareket_id;
			update 
				kasa set
					bakiye=bakiye+OLD.toplam_miktar,
                    son_guncelleme=NOW()
                    where kasa_id=1;
		end//
delimiter //
create trigger malzeme_hareketleri_update
after update on malzeme_hareketleri
for each row
		begin
			update malzemeler set
				malzeme_stok=malzeme_stok+OLD.alinan_miktar-NEW.alinan_miktar,
                malzeme_fiyat=NEW.birimfiyat
					where malzeme_id=OLD.malzeme_id;
			update gelir_gider set
					islem_tarihi=NEW.alis_tarih,
                    alinan_miktar=NEW.alinan_miktar,
                    birimfiyat=NEW.birimfiyat,
                    tutar=NEW.toplam_miktar,
                    tedarikci_id=NEW.tedarikci_id
                    where hareket_id=NEW.hareket_id;
                    
			update 
				kasa set
					bakiye=bakiye+OLD.toplam_miktar-NEW.toplam_miktar,
                    son_guncelleme=NOW()
                    where kasa_id=1;
		end//
delimiter ;

select * from uretim;
select * from urunler;
select * from malzemeler;
delimiter //

create trigger uretim_insert
after insert on uretim
for each row
		begin
			update urunler set
				stok=stok+NEW.uretim_miktari
					where urun_id=new.urun_id;
			update malzemeler set
				malzeme_stok=malzeme_stok-new.malzeme_miktar
					where malzeme_id=new.malzeme_id;
			
		end//
create trigger uretim_update
after update on uretim
for each row
		begin
			update urunler set
				stok=stok-OLD.uretim_miktari+NEW.uretim_miktari
					where urun_id=new.urun_id;
			update malzemeler set
				malzeme_stok=malzeme_stok+OLD.malzeme_miktar-NEW.malzeme_miktar
					where malzeme_id=new.malzeme_id;
		end//
create trigger uretim_delete
after delete on uretim
for each row
		begin
			update urunler set
				stok=stok-OLD.uretim_miktari
					where urun_id=OLD.urun_id;
			update malzemeler set
				malzeme_stok=malzeme_stok+OLD.malzeme_miktar
					where malzeme_id=OLD.malzeme_id;
		end//
delimiter ;

ALTER TABLE gelir_gider ADD COLUMN hareket_id INT;
ALTER TABLE gelir_gider ADD FOREIGN KEY (hareket_id) REFERENCES malzeme_hareketleri(hareket_id)
    ON DELETE SET NULL ON UPDATE CASCADE;
    
SET SQL_SAFE_UPDATES = 0;
UPDATE gelir_gider gd
JOIN malzeme_hareketleri mh ON gd.malzeme_id = mh.malzeme_id 
    AND gd.islem_tarihi = mh.alis_tarih
SET gd.hareket_id = mh.hareket_id
WHERE gd.islem_tipi = 'gider';
SET SQL_SAFE_UPDATES = 1;

delimiter //

create trigger malzemeler_update
after update on malzemeler
for each row
		begin 
			update urunler u
            set 
				maliyet=(
					select sum(m.malzeme_fiyat*ut.malzeme_miktar)
                    from uretim ut
                    join malzemeler m on ut.malzeme_id=m.malzeme_id
                    where ut.urun_id=u.urun_id
                ),
                satis_fiyat=(
					select sum(m.malzeme_fiyat*ut.malzeme_miktar)
                    from uretim ut
                    join malzemeler m on ut.malzeme_id=m.malzeme_id
                    where ut.urun_id=u.urun_id)*(1+u.kar_orani/100)
                    where u.urun_id in (
						select distinct urun_id from uretim
                        where malzeme_id=NEW.malzeme_id
                    );
		end//
delimiter ;

-- Stokta 10 adet var, 999 adet satmaya çalış
CALL satis_ekle('Çikolatalı Pasta', 999.00, 1, 700.00, '2024-12-10', 1, 1);
-- 'Yetersiz stok!' hatası vermeli
CALL hareket_ekle(1, '2024-12-10', 50.00, 5.00, 250.00, 1);
select * from malzemeler;
-- Kakao fiyatını değiştir
CALL malzeme_guncelle(4, 'Kakao', 15.00, 80.00, 'kg');
-- Çikolatalı Pasta maliyeti güncellendi mi kontrol et
select * from urunler;
select * from gelir_gider;
select * from kasa;
CALL satis_sil(1);

CALL satis_ekle('Tiramisu', 1.00, 1, 250.00, CURDATE(), 2, 3);

-- Kontrol et
SELECT * FROM satis;
SELECT * FROM gelir_gider;
SELECT * FROM kasa;

show create procedure satis_ekle;
DESCRIBE satis;
SHOW CREATE TRIGGER satis_insert;

DROP TRIGGER satis_insert;
DELIMITER //
CREATE TRIGGER satis_insert
AFTER INSERT ON satis
FOR EACH ROW
BEGIN
    IF (SELECT stok FROM urunler WHERE urun_id = NEW.urun_id) < NEW.adet THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Yetersiz stok!';
    ELSE
        UPDATE urunler 
            SET stok = stok - NEW.adet
            WHERE urun_id = NEW.urun_id;
        
        INSERT INTO gelir_gider(islem_tipi, islem_tarihi, aciklama, tutar, satis_id, urun_id, satilan_adet)
            VALUES('gelir', NEW.tarih, NEW.urun_adi, NEW.fiyat, NEW.satis_id, NEW.urun_id, NEW.adet);
        
        UPDATE kasa 
            SET bakiye = bakiye + NEW.fiyat,
                son_guncelleme = NOW()
            WHERE kasa_id = 1;
    END IF;
END//
DELIMITER ;

CALL satis_ekle('Tiramisu', 1.00, 1, 250.00, CURDATE(), 2, 3);

-- Kontrol et
SELECT * FROM satis;
SELECT * FROM gelir_gider;
SELECT * FROM kasa;
select* from urunler;
select * from malzemeler;
SHOW CREATE TRIGGER uretim_insert;
SET SQL_SAFE_UPDATES = 0;
CALL uretim_ekle(3, 7, 0.50, 'Tiramisu', 'Krema', 5.00);

SELECT stok FROM urunler WHERE urun_id = 3;
SELECT malzeme_stok FROM malzemeler WHERE malzeme_id = 7;
SET SQL_SAFE_UPDATES = 1;


DROP PROCEDURE IF EXISTS satis_listele;

DELIMITER //
CREATE PROCEDURE satis_listele()
BEGIN
    SELECT s.*, p.personel_ad, m.musteri_adi, m.musteri_soyadi
    FROM satis s
    JOIN personel p ON s.personel_id = p.personel_id
    JOIN musteriler m ON s.musteri_id = m.musteri_id
    ORDER BY s.tarih DESC;
END//
DELIMITER ;


delimiter //
create function urun_kar_hesapla(p_urun_id int)
returns decimal(10,2)
deterministic
begin
	declare v_satis_fiyat decimal(10,2);
    declare v_maliyet decimal (10,2);
    
    select satis_fiyat,maliyet
    into v_satis_fiyat,v_maliyet
    from urunler
    where urun_id=p_urun_id;
	return v_satis_fiyat-v_maliyet;
end//

create function toplam_satis_tutari(p_musteri_id int)
returns decimal(10,2)
deterministic
begin
	declare v_toplam decimal(10,2);
    
    select coalesce(SUM(fiyat),0)
    into v_toplam
    from satis
    where musteri_id=p_musteri_id;
    
    return v_toplam;
end//
delimiter ;

DROP PROCEDURE IF EXISTS hareket_listele;

DELIMITER //
CREATE PROCEDURE hareket_listele()
BEGIN
    SELECT mh.*, m.malzeme_ad, t.firma_adi
    FROM malzeme_hareketleri mh
    JOIN malzemeler m ON mh.malzeme_id = m.malzeme_id
    JOIN tedarikciler t ON mh.tedarikci_id = t.tedarikci_id
    ORDER BY mh.alis_tarih DESC;
END//
DELIMITER ;

SELECT urun_kar_hesapla(1);
SELECT toplam_satis_tutari(1);
SHOW PROCEDURE STATUS WHERE Db = 'pastahane';
SHOW CREATE PROCEDURE personel_ekle;