from db import get_cursor, db

def satis_listele():
    cursor = get_cursor()
    cursor.callproc('satis_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def urun_listele():
    cursor = get_cursor()
    cursor.callproc('urun_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def personel_listele():
    cursor = get_cursor()
    cursor.callproc('personel_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def musteri_listele():
    cursor = get_cursor()
    cursor.callproc('musteri_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def satis_ekle(urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id):
    cursor = get_cursor()
    cursor.callproc('satis_ekle', [urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id])
    db.commit()

def satis_guncelle(satis_id, urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id):
    cursor = get_cursor()
    cursor.callproc('satis_guncelle', [satis_id, urun_adi, adet, personel_id, fiyat, tarih, musteri_id, urun_id])
    db.commit()

def satis_sil(satis_id):
    cursor = get_cursor()
    cursor.callproc('satis_sil', [satis_id])
    db.commit()