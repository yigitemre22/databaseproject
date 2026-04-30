from flask import Blueprint,render_template,request,jsonify
import businesslayer.tedarikci_bl as tedarikci_bl

tedarikci_bp=Blueprint('tedarikci',__name__)

@tedarikci_bp.route('/tedarikci')
def tedarikci_listele():
    tedarikci=tedarikci_bl.tedarikci_listele()
    return render_template('tedarikci.html',tedarikci=tedarikci)

@tedarikci_bp.route('/tedarikci/ekle',methods=['POST'])
def tedarikci_ekle():
    try:
        data=request.get_json()
        tedarikci_bl.tedarikci_ekle(
            data['iletisim_kisi'],data['firma_telefon'],data['firma_adres']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@tedarikci_bp.route('tedarikci/guncelle/<int:tedarikci_id>',methods=['POST'])
def tedarikci_guncelle(tedarikci_id):
    try:
        data=request.get_json()
        tedarikci_bl.tedarikci_guncelle(
            tedarikci_id,data['iletisim_kisi'],data['firma_telefon'],data['firma_adres']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@tedarikci_bp.route('/tedarikci/sil/<int:tedarikci_id>')
def tedarikci_sil(tedarikci_id):
    try:
        data=request.get_json()
        tedarikci_bl.tedarikci_sil(tedarikci_id)
        return jsonify({'success':True})
    except Exception as e:
        return({'success':False,'message':str(e)})