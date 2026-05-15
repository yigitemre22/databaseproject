# businesslayer/kasa_bl.py
import dal.kasa_dal as kasa_dal

def dashboard_verilerini_hazirla():
    # DAL'dan gelen ham veriyi alıp Web katmanına gönderiyoruz
    return kasa_dal.dashboard_istatistik_getir()