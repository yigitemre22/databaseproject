import dal.malzeme_hareketleri_dal as malzeme_harektleri_dal

def hareket_listele():
    return malzeme_harektleri_dal.hareket_listele()

def hareket_ekle(malzeme_id,alis_tarih,alinan_miktar,birim_fiyat,toplam_miktar,tedarikci_id):
    if not malzeme_id or not alis_tarih or not alinan_miktar or not birim_fiyat or not toplam_miktar or not tedarikci_id:
        raise ValueError('Tüm alanlar doldurulmak zorundadır')
    if float(alinan_miktar)<=0:
        raise ValueError("Alınan miktar 0'dan büyük olmalıdır.")
    if float(birim_fiyat)<=0:
        raise ValueError("Birim fiyat 0'dan büyük olmalıdır.")
    if float(alinan_miktar)<=0:
        raise ValueError("Alınan miktar 0'dan büyük olmalıdır.")
    malzeme_harektleri_dal.hareket_ekle(malzeme_id,alis_tarih,alinan_miktar,birim_fiyat,toplam_miktar,tedarikci_id)

def hareket_guncelle(hareket_id,malzeme_id,alis_tarih,alinan_miktar,birim_fiyat,toplam_miktar,tedarikci_id):
    if not hareket_id or not malzeme_id or not alis_tarih or not alinan_miktar or not birim_fiyat or not toplam_miktar or not tedarikci_id:
        raise ValueError('Tüm alanlar doldurulmak zorundadır')
    if float(birim_fiyat)<=0:
        raise ValueError("Birim fiyat 0'dan büyük olmalıdır.")
    if float(alinan_miktar)<=0:
        raise ValueError("Alınan miktar 0'dan büyük olmalıdır.")
    malzeme_harektleri_dal.hareket_guncelle(hareket_id,malzeme_id,alis_tarih,alinan_miktar,birim_fiyat,toplam_miktar,tedarikci_id)
def hareket_sil(hareket_id):
    if not hareket_id:
        raise ValueError('HareketID zorunludur.')
    malzeme_harektleri_dal.harekt_sil(hareket_id)