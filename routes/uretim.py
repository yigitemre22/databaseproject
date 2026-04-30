from flask import Blueprint, render_template, request, jsonify
import businesslayer.uretim_bl as uretim_bl

uretim_bp = Blueprint('uretim', __name__)

@uretim_bp.route('/uretim')
def uretim():
    uretimler = uretim_bl.uretim_listele()
    urunler = uretim_bl.urun_listele()
    malzemeler = uretim_bl.malzeme_listele()
    return render_template('uretim.html', uretimler=uretimler,
                           urunler=urunler, malzemeler=malzemeler)

@uretim_bp.route('/uretim/ekle', methods=['POST'])
def uretim_ekle():
    try:
        data = request.get_json()
        uretim_bl.uretim_ekle(
            data['urun_id'], data['malzeme_id'], data['malzeme_miktar'],
            data['urun_adi'], data['malzeme_adi'], data['uretim_miktari']
        )
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})

@uretim_bp.route('/uretim/guncelle/<int:uretim_id>', methods=['POST'])
def uretim_guncelle(uretim_id):
    try:
        data = request.get_json()
        uretim_bl.uretim_guncelle(
            uretim_id, data['urun_id'], data['malzeme_id'], data['malzeme_miktar'],
            data['urun_adi'], data['malzeme_adi'], data['uretim_miktari']
        )
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})

@uretim_bp.route('/uretim/sil/<int:uretim_id>', methods=['POST'])
def uretim_sil(uretim_id):
    try:
        uretim_bl.uretim_sil(uretim_id)
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})