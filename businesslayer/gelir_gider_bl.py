import dal.gelir_gider_dal as gelir_gider_dal

def gelir_gider_listele():
    return gelir_gider_dal.gelir_gider_listele()

def gelir_gider_ekle(islem_tipi,islem_tarihi,aciklama,tutar,malzeme,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet):
    gelir_gider_dal.gelir_gider_ekle(islem_tipi,islem_tarihi,aciklama,tutar,malzeme,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet)

def gelir_gider_guncelle(kayit_id,islem_tipi,islem_tarihi,aciklama,tutar,malzeme,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet):
    if not kayit_id:
        raise ValueError('KayıtID zorunludur')
    gelir_gider_dal.gelir_gider_guncelle(kayit_id,islem_tipi,islem_tarihi,aciklama,tutar,malzeme,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet)

def gelir_gider_sil(kayit_id):
    if not kayit_id:
        raise ValueError('HareketID zorunludur.')
    gelir_gider_dal.gelir_gider_sil(kayit_id)
    
def dashboard_istatistiklerini_hazirla():
    ham_veri = gelir_gider_dal.dashboard_verilerini_getir()
    return {
        "son_satislar": ham_veri[0], # İlk SELECT sonucu
        "dusuk_stok": ham_veri[1]     # İkinci SELECT sonucu
    }

# businesslayer/gelir_gider_bl.py içine ekle
def dashboard_verilerini_hazirla():
    satislar = gelir_gider_dal.son_satisları_getir()
    stoklar = gelir_gider_dal.dusuk_stoklari_getir()
    return satislar, stoklar