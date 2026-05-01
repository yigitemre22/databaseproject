from db import get_cursor,db

def malzeme_listele():
    cursor = get_cursor()
    cursor.callproc('malzeme_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def hareket_listele():
    cursor = get_cursor()
    cursor.callproc('hareket_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def tedarikci_listele():
    cursor = get_cursor()
    cursor.callproc('tedarikci_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def hareket_ekle(malzeme_id,alis_tarih,alinan_miktar,birimfiyat,toplam_miktar,tedarikci_id):
    cursor=get_cursor()
    cursor.callproc('hareket_ekle',[malzeme_id,alis_tarih,alinan_miktar,birimfiyat,toplam_miktar,tedarikci_id])
    db.commit()
def hareket_guncelle(hareket_id,malzeme_id,alis_tarih,alinan_miktar,birimfiyat,toplam_miktar,tedarikci_id):
    cursor=get_cursor()
    cursor.callproc('hareket_guncelle',[hareket_id,malzeme_id,alis_tarih,alinan_miktar,birimfiyat,toplam_miktar,tedarikci_id])
    db.commit()
def hareket_sil(hareket_id):
    cursor=get_cursor()
    cursor.callproc('hareket_sil',[hareket_id])
    db.commit()