from db import get_cursor,db

def malzeme_listele():
    cursor=get_cursor()
    cursor.callproc('malzeme_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return[]

def malzeme_ekle(malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar):
    cursor=get_cursor()
    cursor.callproc('malzeme_ekle',[malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar])
    db.commit()
def malzeme_guncelle(malzeme_id,malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar):
    cursor=get_cursor()
    cursor.callproc('malzeme_guncelle',[malzeme_id,malzeme_ad,malzeme_stok,malzeme_fiyat,malzeme_notlar])
    db.commit()
def malzeme_sil(malzeme_id):
    cursor=get_cursor()
    cursor.callproc('malzeme_sil',[malzeme_id])
    db.commit()