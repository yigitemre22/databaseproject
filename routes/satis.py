from flask import Blueprint, render_template, request, jsonify
import businesslayer.satis_bl as satis_bl

satis_bp = Blueprint('satis', __name__)

@satis_bp.route('/satis')
def satis():
    satislar = satis_bl.satis_listele()
    urunler = satis_bl.urun_listele()
    personeller = satis_bl.personel_listele()
    musteriler = satis_bl.musteri_listele()
    return render_template('satis.html', satislar=satislar, urunler=urunler,
                           personeller=personeller, musteriler=musteriler)

@satis_bp.route('/satis/ekle', methods=['POST'])
def satis_ekle():
    try:
        data = request.get_json()
        satis_bl.satis_ekle(
            data['urun_adi'], data['adet'], data['personel_id'],
            data['fiyat'], data['tarih'], data['musteri_id'], data['urun_id']
        )
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})

@satis_bp.route('/satis/guncelle/<int:satis_id>', methods=['POST'])
def satis_guncelle(satis_id):
    try:
        data = request.get_json()
        satis_bl.satis_guncelle(
            satis_id, data['urun_adi'], data['adet'], data['personel_id'],
            data['fiyat'], data['tarih'], data['musteri_id'], data['urun_id']
        )
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})

@satis_bp.route('/satis/sil/<int:satis_id>', methods=['POST'])
def satis_sil(satis_id):
    try:
        satis_bl.satis_sil(satis_id)
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'message': str(e)})