from db import get_cursor,db

def personel_listele():
    cursor=get_cursor()
    cursor.callproc('personel_listele')
    for result in cursor.stored_results():
        return result.fetchall()
    return[]

def personel_ekle(personel_ad,personel_sifre):
    cursor=get_cursor()
    cursor.callproc('personel_ekle',[personel_ad,personel_sifre])
    db.commit()

def personel_guncelle(personel_id,personel_ad,personel_sifre):
    cursor=get_cursor()
    cursor.callproc('personel_guncelle',[personel_id,personel_ad,personel_sifre])
    db.commit()

def personel_sil(personel_id):
    cursor=get_cursor()
    cursor.callproc('personel_sil',[personel_id])
    db.commit()