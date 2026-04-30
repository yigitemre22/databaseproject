import dal.malzemeler_dal as malzeme_dal

def malzeme_listele():
    return malzeme_dal.malzeme_listele()

def malzeme_ekle(malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar):
    if not malzeme_ad or not malzeme_stok or not malzeme_fiyat:
        raise ValueError('Not hariç tüm alanlar zorunludur')
    if float(malzeme_stok)<=0:
        raise ValueError("Stok miktari 0'dan büyük olmalıdır.")
    if float(malzeme_fiyat)<=0:
        raise ValueError("Malzeme fiyatı 0'dan büyük olmalıdır")
    malzeme_dal.malzeme_ekle(malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar)

def malzeme_guncelle(malzeme_id,malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar):
    if not malzeme_id or not malzeme_ad or not malzeme_stok or not malzeme_fiyat:
        raise ValueError('Tüm alanlar zorunludur')
    if float(malzeme_stok)<=0:
        raise ValueError("Stok miktari 0'dan büyük olmalıdır.")
    if float(malzeme_fiyat)<=0:
        raise ValueError("Malzeme fiyatı 0'dan büyük olmalıdır")
    malzeme_dal.malzeme_guncelle(malzeme_id,malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar)

def malzeme_sil(malzeme_id):
    if not malzeme_id:
        raise ValueError('MalzemeID zorunludur')
    malzeme_dal.malzeme_sil(malzeme_id)
