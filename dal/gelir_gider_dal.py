from db import get_cursor,db

def gelir_gider_listele():
    cursor=get_cursor()
    cursor.callproc('gelir_gider_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return[]

def gelir_gider_ekle(islem_tipi,islem_tarihi,aciklama,tutar,malzeme,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet):
    cursor=get_cursor()
    cursor.callproc('gelir_gider_ekle',[islem_tipi,islem_tarihi,aciklama,tutar,malzeme,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet])
    db.commit()

def gelir_gider_guncelle(kayit_id,islem_tipi,islem_tarihi,aciklama,tutar,malzeme,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet):
    cursor=get_cursor()
    cursor.callproc('gelir_gider_guncelle',[kayit_id,islem_tipi,islem_tarihi,aciklama,tutar,malzeme,alinan_miktar,birim_fiyat,tedarikci_id,satis_id,urun_id,satilan_adet])
    db.commit()

def gelir_gider_sil(kayit_id):
    cursor=get_cursor()
    cursor.callproc('gelir_gider_sil',[kayit_id])
    db.commit()

