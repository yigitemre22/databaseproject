from flask import Blueprint,render_template,request,jsonify
import businesslayer.urun_bl as urun_bl

urun_bp=Blueprint('urun',__name__)

@urun_bp.route('/urun')
def urun_listele():
    urun=urun_bl.urun_listele()
    return render_template('urun.html',urun=urun)

@urun_bp.route('/urun/ekle',methods=['POST'])
def urun_ekle():
    try:
        data=request.get_json()
        urun_bl.urun_ekle(
            data['maliyet'],data['satis_fiyat'],data['stok'],data['notlar']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@urun_bp.route('/urun/guncelle/<int:urun_id>',methods=['POST'])
def urun_guncelle(urun_id):
    try:
        data=request.get_json()
        urun_bl.urun_guncelle(
            urun_id, data['maliyet'],data['satis_fiyat'],data['stok'],data['notlar']
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})

@urun_bp.route('/urun_sil/<int:urun_id>',methods=['POST'])
def urun_sil(urun_id):
    try:
        data=request.get_json()
        urun_bl.urun_sil(
            urun_id
        )
        return jsonify({'success':True})
    except Exception as e:
        return jsonify({'success':False,'message':str(e)})
    