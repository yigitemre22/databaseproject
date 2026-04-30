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
