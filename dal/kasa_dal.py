# dal/kasa_dal.py
from db import get_cursor

def dashboard_istatistik_getir():
    cursor = get_cursor()
    # Veritabanında 'sp_dashboard_verileri' adında bir prosedür olduğunu varsayıyoruz
    cursor.callproc('sp_dashboard_verileri')
    sonuclar = []
    for result in cursor.stored_results():
        sonuclar.append(result.fetchall())
    return sonuclar # [0] Son Satışlar, [1] Düşük Stok, [2] Kasa Toplamı