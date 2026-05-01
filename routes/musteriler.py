from flask import Blueprint,render_template,request,jsonify
import businesslayer.musteriler_bl as musteriler_bl

musteriler_bp=Blueprint('musteriler',__name__)

@musteriler_bp.route('/musteriler')
def musteri_listele():
    musteri_listesi=musteriler_bl.musteri_listele()
    return render_template('musteri.html',musteriler=musteri_listesi)

@musteriler_bp.route('/musteriler/ekle',methods=['POST'])
def musteri_ekle():
    try:
        data=request.get_json()
        musteriler_bl.musteri_ekle(
            data['musteri_adi'],data['musteri_soyadi'],
            data['musteri_telefon']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})
@musteriler_bp.route('/musteriler/guncelle/<int:musteri_id>',methods=['POST'])
def musteri_guncelle(musteri_id):
    try:
        data=request.get_json()
        musteriler_bl.musteri_guncelle(
            musteri_id,data['musteri_adi'],data['musteri_soyadi'],data['musteri_telefon']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@musteriler_bp.route('/musteriler/sil/<int:musteri_id>',methods=['POST'])
def musteri_sil(musteri_id):
    try:
        musteriler_bl.musteri_sil(musteri_id)
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})
