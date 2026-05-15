from flask import Flask, render_template, request, redirect, url_for, session
from businesslayer import gelir_gider_bl
from routes.satis import satis_bp
from routes.uretim import uretim_bp
from routes.malzemeler import malzemeler_bp
from routes.malzeme_hareketleri import malzemele_hareketleri_bp
from routes.urun import urun_bp
from routes.musteriler import musteriler_bp
from routes.personel import personel_bp
from routes.tedarikci import tedarikci_bp
import businesslayer.kasa_bl as kasa_bl
from db import get_cursor # db.py'den cursor alıyoruz
import os

app = Flask(__name__, 
            template_folder=os.path.join(os.path.dirname(__file__), 'templates'),
            static_folder='static', 
            static_url_path='/static')

# KRİTİK: Session (oturum) için bu anahtar şart. Yoksa giriş yapamazsın.
app.secret_key = 'pastahane_ozel_anahtar_123'

# Blueprint'leri kaydet
app.register_blueprint(satis_bp)
app.register_blueprint(uretim_bp)
app.register_blueprint(malzemeler_bp)
app.register_blueprint(malzemele_hareketleri_bp)
app.register_blueprint(urun_bp)
app.register_blueprint(musteriler_bp)
app.register_blueprint(personel_bp)
app.register_blueprint(tedarikci_bp)



@app.route('/login', methods=['GET', 'POST']) # Bunu ekledik
@app.route('/giris', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username_input = request.form.get('username')
        password_input = request.form.get('password')
        role_type_input = request.form.get('role_type') # Formdan gelen: 'admin' veya 'personel'
        
        cursor = get_cursor()
        try:
            cursor.callproc('sp_GirisYap', [username_input, password_input])
            
            user = None
            for result in cursor.stored_results():
                user = result.fetchone()
            
            # KONTROL NOKTASI: Kullanıcı bulundu mu VE seçtiği rol veritabanındakiyle aynı mı?
            if user and user['rol'] == role_type_input:
                session['loggedin'] = True
                session['username'] = user['kullanici_adi'] 
                session['role'] = user['rol']
                return redirect(url_for('index'))
            
            elif user and user['rol'] != role_type_input:
                # Kullanıcı var ama yanlış giriş kapısını kullanıyor
                hata = "Yönetici hesabıyla Personel girişi yapılamaz!" if user['rol'] == 'admin' else "Personel hesabıyla Yönetici girişi yapılamaz!"
                return render_template('giris.html', error=hata)
            
            else:
                # Kullanıcı hiç bulunamadı
                return render_template('giris.html', error="Kullanıcı adı veya şifre hatalı!")
                
        except Exception as e:
            return render_template('giris.html', error=f"Sistem Hatası: {str(e)}")
        finally:
            cursor.close()

    return render_template('giris.html')

@app.route('/')
def index():
    # Eğer giriş yapılmamışsa login sayfasına zorunlu yönlendir
    if not session.get('loggedin'):
        return redirect(url_for('login'))
    satis_verisi, stok_verisi = gelir_gider_bl.dashboard_verilerini_hazirla()
    return render_template('index.html',son_satislar=satis_verisi, dusuk_stok=stok_verisi) # Ana sayfanızın adı

@app.route('/logout')
def logout():
    # Session içindeki tüm bilgileri temizler
    session.clear()
    # Kullanıcıyı giriş sayfasına geri gönderir
    return redirect(url_for('login'))

@app.route('/kasa')
def kasa():
    if not session.get('loggedin'):
        return redirect(url_for('login'))
    
    cursor = get_cursor()
    try:
        cursor.execute("SELECT * FROM Kasa")  # Kasa tablosundaki tüm verileri çek
        kasa_verileri = cursor.fetchall()  # Verileri al
    except Exception as e:
        return f"Kasa verileri alınırken hata oluştu: {str(e)}"
    finally:
        cursor.close()
    
    return render_template('kasa.html', kasa=kasa_verileri)  # Kasa verilerini template'e gönder


@app.route('/kasa_dashboard')
def kasa_dashboard_view():
    if not session.get('loggedin'):
        return redirect(url_for('login'))
    
    # BL üzerinden prosedür verilerini alıyoruz
    istatistikler = gelir_gider_bl.dashboard_istatistiklerini_hazirla()
    
    return render_template('index.html', 
                           satislar=istatistikler['son_satislar'], 
                           stoklar=istatistikler['dusuk_stok'])


if __name__ == '__main__':
    app.run(debug=True, port=5001, use_reloader=False)