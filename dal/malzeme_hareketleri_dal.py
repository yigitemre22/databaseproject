from db import get_cursor,db

def hareket_listele():
    cursor=get_cursor()
    cursor.callproc('hareket_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return[]

def hareket_ekle(malzeme_id,alis_tarih,alinan_miktar,birim_fiyat,toplam_miktar,tedarikci_id):
    cursor=get_cursor()
    cursor.callproc('hareket_ekle',[malzeme_id,alis_tarih,alinan_miktar,birim_fiyat,toplam_miktar,tedarikci_id])
    db.commit()
def hareket_guncelle(hareket_id,malzeme_id,alis_tarih,alinan_miktar,birim_fiyat,toplam_miktar,tedarikci_id):
    cursor=get_cursor()
    cursor.callproc('hareket_guncelle',[hareket_id,malzeme_id,alis_tarih,alinan_miktar,birim_fiyat,toplam_miktar,tedarikci_id])
    db.commit()
def malzeme_sil(hareket_id):
    cursor=get_cursor()
    cursor.callproc('hareket_sil',[hareket_id])
    db.commit()