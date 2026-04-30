from flask import Flask, render_template
from routes.satis import satis_bp
from routes.uretim import uretim_bp
from routes.malzemeler import malzemeler_bp
from routes.malzeme_hareketleri import malzemele_hareketleri_bp
import os
 
app = Flask(__name__, 
            template_folder=os.path.join(os.path.dirname(__file__), 'templates'),
            static_folder='static', 
            static_url_path='/static')
 
# Blueprint'leri kaydet
app.register_blueprint(satis_bp)
app.register_blueprint(uretim_bp)
app.register_blueprint(malzemeler_bp)
app.register_blueprint(malzemele_hareketleri_bp)
@app.route('/')
def index():
    return render_template('index.html')
 
if __name__ == '__main__':
    app.run(debug=True)
 