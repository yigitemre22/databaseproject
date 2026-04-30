from flask import Blueprint,render_template,request,jsonify
import businesslayer.gelir_gider_bl as gelir_gider_bl

gelir_gider_bp=Blueprint('gelir_gider',__name__)

@gelir_gider_bp.route('/gelir_gider')
def gelir_gider_listele():
    gelir_gider=gelir_gider_bl.gelir_gider_listele()
    return render_template('gelir_gider.html',hareketler=gelir_gider)

@gelir_gider_bp.route('/gelir_gider/ekle',methods=['POST'])
def gelir_gider_ekle():
    try:
        data=request.get_json()
        gelir_gider_bl.gelir_gider_ekle(
            data['islem_tipi'],data['islem_tarihi'],data['aciklama'],data['tutar'],data['alinan_miktar'],data['birim_fiyat'],data['tedarikci_id'],data['satis_id'],data['urun_id'],data['satilan_adet']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})
@gelir_gider_bp.route('/gelir_gider/guncelle/<int:kayit_id>',methods=['POST'])
def gelir_gider_guncelle(kayit_id):
    try:
        data=request.get_json()
        gelir_gider_bl.gelir_gider_guncelle(
            kayit_id, data['islem_tipi'],data['islem_tarihi'],data['aciklama'],data['tutar'],data['alinan_miktar'],data['birim_fiyat'],data['tedarikci_id'],data['satis_id'],data['urun_id'],data['satilan_adet']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@gelir_gider_bp.route('/gelir_gider/sil/<int:kayit_id>',methods=['POST'])
def gelir_gider_sil(kayit_id):
    try:
        gelir_gider_bl.gelir_gider_sil(kayit_id)
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})
    