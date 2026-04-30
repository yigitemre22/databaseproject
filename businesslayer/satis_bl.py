import dal.satis_dal as satis_dal

def satis_listele():
    return satis_dal.satis_listele()

def urun_listele():
    return satis_dal.urun_listele()

def personel_listele():
    return satis_dal.personel_listele()

def musteri_listele():
    return satis_dal.musteri_listele()

def satis_ekle(urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id):
    if not urun_adi or not adet or not personel_id or not fiyat or not tarih or not musteri_id or not urun_id:
        raise ValueError('Tüm alanlar zorunludur.')
    if float(adet) <= 0:
        raise ValueError('Adet sıfırdan büyük olmalıdır.')
    if float(fiyat) <= 0:
        raise ValueError('Fiyat sıfırdan büyük olmalıdır.')
    satis_dal.satis_ekle(urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id)

def satis_guncelle(satis_id, urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id):
    if not urun_adi or not adet or not personel_id or not fiyat or not tarih or not musteri_id or not urun_id:
        raise ValueError('Tüm alanlar zorunludur.')
    if float(adet) <= 0:
        raise ValueError('Adet sıfırdan büyük olmalıdır.')
    if float(fiyat) <= 0:
        raise ValueError('Fiyat sıfırdan büyük olmalıdır.')
    satis_dal.satis_guncelle(satis_id, urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id)

def satis_sil(satis_id):
    if not satis_id:
        raise ValueError('Satış ID zorunludur.')
    satis_dal.satis_sil(satis_id)