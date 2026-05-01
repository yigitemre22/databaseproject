from db import get_cursor,db

def tedarikci_listele():
    cursor=get_cursor()
    cursor.callproc('tedarikci_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def tedarikci_ekle(firma_adi,iletisim_kisi,firma_telefon,firma_adres):
    cursor=get_cursor()
    cursor.callproc('tedarikci_ekle',[firma_adi,iletisim_kisi,firma_telefon,firma_adres])
    db.commit()

def tedarikci_guncelle(tedarikci_id,firma_adi,iletisim_kisi,firma_telefon,firma_adres):
    cursor=get_cursor()
    cursor.callproc('tedarikci_guncelle',[tedarikci_id,firma_adi,iletisim_kisi,firma_telefon,firma_adres])
    db.commit()

def tedarikci_sil(tedarikci_id):
    cursor=get_cursor()
    cursor.callproc('tedarikci_sil',[tedarikci_id])
    db.commit()
    
