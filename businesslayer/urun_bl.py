import dal.urun_dal as urun_dal

def urun_listele():
    return urun_dal.urun_listele()

def urun_ekle(maliyet,satis_fiyat,stok,notlar):
    if not maliyet or not satis_fiyat or not stok:
        raise ValueError('Tüm alanlar doldurulmak zorundadır')
    if float(maliyet)<=0:
        raise ValueError("Maliyet 0'dan büyük olmalıdır")
    if float(satis_fiyat)<=0:
        raise ValueError("Satış Fiyatı 0'dan büyük olmalıdır")
    if float(stok)<=0:
        raise ValueError("Stok 0'dan büyük olmalıdır")
    urun_dal.urun_ekle(maliyet,satis_fiyat,stok,notlar)

def urun_guncelle(urun_id,maliyet,satis_fiyat,stok,notlar):
    if urun_id or not maliyet or not satis_fiyat or not stok:
        raise ValueError('Tüm alanlar doldurulmak zorundadır')
    if float(maliyet)<=0:
        raise ValueError("Maliyet 0'dan büyük olmalıdır")
    if float(satis_fiyat)<=0:
        raise ValueError("Satış Fiyatı 0'dan büyük olmalıdır")
    if float(stok)<=0:
        raise ValueError("Stok 0'dan büyük olmalıdır")
    urun_dal.urun_guncelle(urun_id,maliyet,satis_fiyat,stok,notlar)

def urun_sil(urun_id):
    if not urun_id:
        raise ValueError('UrunID zorunludur')
    urun_dal.urun_sil(urun_id)