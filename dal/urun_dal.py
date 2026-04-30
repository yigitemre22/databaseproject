from db import get_cursor,db

def urun_listele():
    cursor=get_cursor()
    cursor.callproc('urun_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def urun_ekle(maliyet,satis_fiyat,stok,notlar):
    cursor=get_cursor()
    cursor.callproc('urun_ekle',[maliyet,satis_fiyat,stok,notlar])
    db.commit()

def urun_guncelle(urun_id,maliyet,satis_fiyat,stok,notlar):
    cursor=get_cursor()
    cursor.callproc('urun_guncelle',[urun_id,maliyet,satis_fiyat,stok,notlar])
    db.commit()

def urun_sil(urun_id):
    cursor=get_cursor()
    cursor.callproc('urun_sil',[urun_id])
    db.commit()

    