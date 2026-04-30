from flask import Blueprint,render_template,request,jsonify
import businesslayer.personel_bl as personel_bl

personel_bp=Blueprint('personel',__name__)

@personel_bp.route('/personel')
def personel_listele():
    personel_listesi=personel_bl.personel_listele()
    return render_template('personel.html',hareketler=personel_listesi)
@personel_bp.route('personel/ekle',methods=['POST'])
def personel_ekle():
    try:
        data=request.get_json()
        personel_bl.personel_ekle(
            data['personel_adi'],data['personel_sifre']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@personel_bp.route('personel/guncelle/<int:personel_id>',methods=['POST'])
def personel_guncelle(personel_id):
    try:
        data=request.get_json()
        personel_bl.personel_guncelle(
            personel_id,data['personel_ad'],data['personel_sifre']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@personel_bp.route('personel/sil/<int:personel_id>',methods=['POST'])
def personel_sil(personel_id):
    try:
        data=request.get_json()
        personel_bl.personel_sil(
            personel_id
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})