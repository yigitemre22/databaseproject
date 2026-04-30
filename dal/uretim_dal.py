from db import get_cursor, db

def uretim_listele():
    cursor = get_cursor()
    cursor.callproc('uretim_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def malzeme_listele():
    cursor = get_cursor()
    cursor.callproc('malzeme_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return []

def uretim_ekle(urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari):
    cursor = get_cursor()
    cursor.callproc('uretim_ekle', [urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari])
    db.commit()

def uretim_guncelle(uretim_id, urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari):
    cursor = get_cursor()
    cursor.callproc('uretim_guncelle', [uretim_id, urun_id, malzeme_id, malzeme_miktar, urun_adi, malzeme_adi, uretim_miktari])
    db.commit()

def uretim_sil(uretim_id):
    cursor = get_cursor()
    cursor.callproc('uretim_sil', [uretim_id])
    db.commit()