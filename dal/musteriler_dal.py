from db import get_cursor,db

def musteri_listele():
    cursor=get_cursor()
    cursor.callproc('musteri_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def musteri_ekle(musteri_adi,musteri_soyadi,musteri_telefon):
    cursor=get_cursor()
    cursor.callproc('musteri_ekle',[musteri_adi,musteri_soyadi,musteri_telefon])
    db.commit()

def musteri_guncelle(musteri_id,musteri_adi,musteri_soyadi,musteri_telefon):
    cursor=get_cursor()
    cursor.callproc('musteri_guncelle',[musteri_id,musteri_adi,musteri_soyadi,musteri_telefon])
    db.commit()

def musteri_sil(musteri_id):
    cursor=get_cursor()
    cursor.callproc('musteri_sil',[musteri_id])
    db.commit()