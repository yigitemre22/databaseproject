from flask import Blueprint,render_template,request,jsonify
import businesslayer.malzeme_hareketleri_bl as malzemele_hareketleri_bl

malzemele_hareketleri_bp=Blueprint('malzeme_hareketleri',__name__)
@malzemele_hareketleri_bp.route('/malzeme_hareketleri')
def malzeme_listele():
    hareket_listesi = malzemele_hareketleri_bl.hareket_listele()
    malzeme_listesi = malzemele_hareketleri_bl.malzemele_listele()
    tedarikci_listesi = malzemele_hareketleri_bl.tedarikci_listele()
    return render_template('malzeme_hareketleri.html',
                           hareketler=hareket_listesi,
                           malzemeler=malzeme_listesi,
                           tedarikciler=tedarikci_listesi)

@malzemele_hareketleri_bp.route('/malzeme_hareketleri/ekle',methods=['POST'])
def hareket_ekle():
    try:
        data=request.get_json()
        malzemele_hareketleri_bl.hareket_ekle(
            data['malzeme_id'],data['alis_tarih'],data['alinan_miktar'],
            data['birimfiyat'],data['toplam_miktar'],data['tedarikci_id']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({"success":False,'message':str(e)})

@malzemele_hareketleri_bp.route('/malzeme_hareketleri/guncelle/<int:hareket_id>',methods=['POST'])
def hareket_guncelle(hareket_id):
    try:
        data=request.get_json()
        malzemele_hareketleri_bl.hareket_guncelle(
            hareket_id,data['malzeme_id'],data['alis_tarih'],data['alinan_miktar'],
            data['birimfiyat'],data['alinan_miktar'],data['tedarikci_id']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({"success":False,'message':str(e)})

@malzemele_hareketleri_bp.route('/malzeme_hareketleri/sil/<int:hareket_id>',methods=['POST'])
def malzeme_sil(hareket_id):
    try:
        malzemele_hareketleri_bl.hareket_sil(hareket_id)
        return jsonify({"success":True})
    except Exception as e:
        return jsonify({"success":False,"message":str(e)})
