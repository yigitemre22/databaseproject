from flask import Blueprint,render_template,request,jsonify
import businesslayer.malzemeler_bl as malzemeler_bl

malzemeler_bp=Blueprint('malzemeler',__name__)

@malzemeler_bp.route('/malzemeler')
def malzemeler():
    malzeme_listesi=malzemeler_bl.malzeme_listele()
    return render_template('malzemeler.html',malzemeler=malzeme_listesi)

@malzemeler_bp.route('/malzemeler/ekle',methods=['POST'])
def malzeme_ekle():
    try:
        data=request.get_json()
        malzemeler_bl.malzeme_ekle(
            data['malzeme_ad'],data['malzeme_stok'],data['malzeme_fiyat'],
            data['malzeme_notlar']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@malzemeler_bp.route('/malzemeler/guncelle/<int:malzeme_id>',methods=['POST'])
def malzeme_guncelle(malzeme_id):
    try:
        data=request.get_json()
        malzemeler_bl.malzeme_guncelle(
            malzeme_id,data['malzeme_ad'],data['malzeme_stok'],data['malzeme_fiyat'],
            data['malzeme_notlar']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({"success":False,'message':str(e)})
@malzemeler_bp.route('/malzemeler/sil/<int:malzeme_id>',methods=['POST'])
def malzeme_sil(malzeme_id):
    try:
        malzemeler_bl.malzeme_sil(malzeme_id)
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})
