import dal.personel_dal as personel_dal

def personel_listele():
    return personel_dal.personel_listele()

def personel_ekle(personel_ad,personel_sifre):
    if not personel_ad or not personel_sifre:
        raise ValueError('Tüm alanlar doldurulmalıdır')
    personel_dal.personel_ekle(personel_ad,personel_sifre)

def personel_guncelle(personel_id,personel_ad,personel_sifre):
      if not personel_id or not personel_ad or not personel_sifre:
        raise ValueError('Tüm alanlar doldurulmalıdır')
      personel_dal.personel_guncelle(personel_id,personel_ad,personel_sifre)
def personel_sil(personel_id):
    if not personel_id:
        raise ValueError('PersonelID zorunludur')
    personel_dal.personel_sil(personel_id)
