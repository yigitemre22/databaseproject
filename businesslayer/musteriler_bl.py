import dal.musteriler_dal as musteriler_dal

def hareket_listele():
    return musteriler_dal.musteri_listele()

def musteri_ekle(musteri_adi,musteri_soyadi,musteri_telefon):
    if not musteri_adi or not musteri_soyadi or not musteri_telefon:
        raise ValueError('Tüm alanlar doldurulmak zorundadır.')
    musteriler_dal.musteri_ekle(musteri_adi,musteri_soyadi,musteri_telefon)
def musteri_guncelle(musteri_id,musteri_adi,musteri_soyadi,musteri_telefon):
    if musteri_id or not musteri_adi or not musteri_soyadi or not musteri_telefon:
           raise ValueError('Tüm alanlar doldurulmak zorundadır.')
    musteriler_dal.musteri_guncelle(musteri_id,musteri_adi,musteri_soyadi,musteri_telefon)
def musteri_sil(musteri_id):
    if not musteri_id:
          raise ValueError('MüşteriID zorunludur.')
    musteriler_dal.musteri_sil(musteri_id)
 
    