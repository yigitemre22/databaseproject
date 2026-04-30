import dal.uretim_dal as uretim_dal
import dal.satis_dal as satis_dal

def uretim_listele():
    return uretim_dal.uretim_listele()

def urun_listele():
    return satis_dal.urun_listele()

def malzeme_listele():
    return uretim_dal.malzeme_listele()

def uretim_ekle(urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari):
    if not urun_id or not malzeme_id or not malzeme_miktar or not uretim_miktari:
        raise ValueError('Tüm alanlar zorunludur.')
    if float(malzeme_miktar) <= 0:
        raise ValueError('Malzeme miktarı sıfırdan büyük olmalıdır.')
    if float(uretim_miktari) <= 0:
        raise ValueError('Üretim miktarı sıfırdan büyük olmalıdır.')
    uretim_dal.uretim_ekle(urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari)

def uretim_guncelle(uretim_id, urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari):
    if not uretim_id or not urun_id or not malzeme_id or not malzeme_miktar or not uretim_miktari:
        raise ValueError('Tüm alanlar zorunludur.')
    if float(malzeme_miktar) <= 0:
        raise ValueError('Malzeme miktarı sıfırdan büyük olmalıdır.')
    if float(uretim_miktari) <= 0:
        raise ValueError('Üretim miktarı sıfırdan büyük olmalıdır.')
    uretim_dal.uretim_guncelle(uretim_id, urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari)

def uretim_sil(uretim_id):
    if not uretim_id:
        raise ValueError('Üretim ID zorunludur.')
    uretim_dal.uretim_sil(uretim_id)