import dal.tedarikci_dal as tedarikci_dal

def tedarikci_listele():
    return tedarikci_dal.tedarikci_listele()

def tedarikci_ekle(firma_adi,iletisim_kisi,firma_telefon,firma_adres):
    tedarikci_dal.tedarikci_ekle(firma_adi,iletisim_kisi,firma_telefon,firma_adres)

def tedarikci_guncelle(tedarikci_id,firma_adi,iletisim_kisi,firma_telefon,firma_adres):
    if not tedarikci_id:
        raise ValueError('TedarikciID zorunludur')
    tedarikci_dal.tedarikci_guncelle(tedarikci_id,firma_adi,iletisim_kisi,firma_telefon,firma_adres)

def tedarikci_sil(tedarikci_id):
    if not tedarikci_id:
        raise ValueError('TedarikciID zorunludur')
    tedarikci_dal.tedarikci_sil(tedarikci_id)
