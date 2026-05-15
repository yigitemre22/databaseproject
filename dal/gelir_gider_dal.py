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

# gelir_gider_dal.py dosyasına ekle
def dashboard_verilerini_getir():
    cursor = get_cursor()
    cursor.callproc('sp_dashboard_verileri')
    sonuclar = []
    # Birden fazla SELECT sonucu (Satışlar ve Stoklar) olduğu için stored_results kullanılır
    for result in cursor.stored_results():
        sonuclar.append(result.fetchall())
    return sonuclar

def son_satisları_getir():
    cursor = get_cursor()
    cursor.callproc('sp_son_satislar')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def dusuk_stoklari_getir():
    cursor = get_cursor()
    cursor.callproc('sp_dusuk_stok_uyarisi')
    for result in cursor.stored_results():
        return result.fetchall()
    return []