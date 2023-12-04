from flask import Flask, jsonify, request, render_template, make_response
from flask_cors import CORS, cross_origin
from flask_sqlalchemy import SQLAlchemy
from flask_marshmallow import Marshmallow
from dotenv import load_dotenv, find_dotenv
load_dotenv(find_dotenv())
import datetime

import os

SQLALCHEMY_DATABASE_URI = os.getenv("SQLALCHEMY_DATABASE_URI")



app = Flask(__name__)
CORS(app)


###localhost app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://user:password@ip/dbname'
###external 
app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False


""" if __name__ == '__main__':
    app.debug = True
    app.run() """


db = SQLAlchemy(app)
ma = Marshmallow(app)



class Revisores(db.Model):
    IdRevisor = db.Column(db.Integer, primary_key=True)
    NombreRevisor = db.Column(db.String(100))

    def __init__(self, IdRevisor, NombreRevisor):
        self.IdRevisor = IdRevisor
        self.NombreRevisor = NombreRevisor

class Inspectores(db.Model):
    IdInspector = db.Column(db.Integer, primary_key=True)
    IdRevisor = db.Column(db.Integer, db.ForeignKey(Revisores.IdRevisor), primary_key=False)
    NombreInspector = db.Column(db.String(100))

    def __init__(self, IdInspector, IdRevisor, NombreInspector):
        self.IdInspector = IdInspector
        self.IdRevisor = IdRevisor
        self.NombreInspector = NombreInspector

class Obras(db.Model):
    IdObra = db.Column(db.Integer, primary_key=True)
    IdRevisor = db.Column(db.Integer, db.ForeignKey(Revisores.IdRevisor), primary_key=False)
    NombreObra = db.Column(db.String(200))
    Codificacion = db.Column(db.String(50))
    FechaContrato = db.Column(db.Date)
    FechaInicio = db.Column(db.Date)
    PlazoDias = db.Column(db.Integer)
    IdInspector = db.Column(db.Integer, db.ForeignKey(Inspectores.IdInspector), primary_key=False)
    FechaFin = db.Column(db.Date)
    Prorroga = db.Column(db.Date)

    def __init__(self, IdObra, IdRevisor, NombreObra, Codificacion, FechaContrato, FechaInicio, PlazoDias, IdInspector, FechaFin, Prorroga):
        self.IdObra = IdObra
        self.IdRevisor = IdRevisor
        self.NombreObra = NombreObra
        self.Codificacion = Codificacion
        self.FechaContrato = FechaContrato
        self.FechaInicio = FechaInicio
        self.PlazoDias = PlazoDias
        self.IdInspector = IdInspector
        self.FechaFin = FechaFin
        self.Prorroga = Prorroga

class Certificados(db.Model):
    IdCertificado = db.Column(db.Integer, primary_key=True)
    # IdRevisor = db.Column(db.Integer, db.ForeignKey(Revisores.IdRevisor), primary_key=False) <- no es necesario porque toda obra tiene solo uno y en todo caso puede obtenerse de alli con un get join etc.
    IdObra = db.Column(db.Integer, db.ForeignKey(Obras.IdObra), primary_key=False)
    FechaDePresentacion = db.Column(db.Date)

    def __init__(self, IdCertificado, IdObra, FechaDePresentacion):
        self.IdCertificado = IdCertificado
        self.IdObra = IdObra
        self.FechaDePresentacion = FechaDePresentacion

class RevisorSchema(ma.Schema):
    class Meta:
        fields = ('IdRevisor', 'NombreRevisor')

revisor_schema = RevisorSchema()
revisores_schema = RevisorSchema(many=True)

class InspectorSchema(ma.Schema):
    class Meta:
        fields = ('IdInspector', 'IdRevisor', 'NombreInspector')

inspector_schema = InspectorSchema()
inspectores_schema = InspectorSchema(many=True)


class ObraSchema(ma.Schema):
    class Meta:
        fields = ('IdObra', 'IdRevisor', 'NombreObra', 'Codificacion', 'FechaContrato', 'FechaInicio', 'PlazoDias', 'IdInspector', 'FechaFin', 'Prorroga')

obra_schema = ObraSchema()
obras_schema = ObraSchema(many=True)

class CertificadoSchema(ma.Schema):
    class Meta:
        fields = ('IdCertificado', 'IdObra', 'FechaDePresentacion')

certificado_schema = CertificadoSchema()
certificados_schema = CertificadoSchema(many=True)

@app.route('/')
def hello():
    return render_template('index.html', utc_dt=datetime.datetime.utcnow())

@app.route('/revisores')
def revisores():
    return render_template('revisores.html')

@app.route('/inspectores')
def inspectores():
    return render_template('inspectores.html')

@app.route('/obras')
def obras():
    all_obras_by_codificacion = Obras.query.order_by(Obras.Codificacion).all()
    results = obras_schema.dump(all_obras_by_codificacion)

    all_revisores = Revisores.query.all()
    revisores_results = revisores_schema.dump(all_revisores)
    return render_template('obras.html', json_de_obras=results, json_de_revisores=revisores_results)

@app.route('/certificados')
def certificados():
    return render_template('certificados.html')




@app.route('/get/revisores', methods = ['GET'])
def get_revisores():
    all_revisores_by_IdRevisor = Revisores.query.order_by(Revisores.IdRevisor).all()
    results = revisores_schema.dump(all_revisores_by_IdRevisor)
    return jsonify(results)

@app.route('/get/inspectores', methods = ['GET'])
def get_inspectores():
    all_inspectores_by_nombreInspector = Inspectores.query.order_by(Inspectores.NombreInspector).all()
    results = inspectores_schema.dump(all_inspectores_by_nombreInspector)
    return jsonify(results)

@app.route('/get/obras', methods = ['GET'])
def get_obras():
    all_obras_by_codificacion = Obras.query.order_by(Obras.Codificacion).all()
    results = obras_schema.dump(all_obras_by_codificacion)
    return jsonify(results)

@app.route('/get/certificados', methods = ['GET'])
def get_certificados():
    all_certificados_by_obra = Certificados.query.order_by(Certificados.IdObra).all()
    results = certificados_schema.dump(all_certificados_by_obra)
    return jsonify(results)

""" método general ejemplo:
@app.route('/get', methods = ['GET'])
def get_films():
    all_films = Films.query.all()
    results = films_schema.dump(all_films)
    return jsonify(results) """

""" método de búsqueda por "contiene"
@app.route('/adv-get/<field>/<contains>', methods = ['GET'])
def get_TablaABuscar_by_campoARevisar_contains(field, contains):
    all_TablaABuscar_contains = TablaABuscar.query.filter(getattr(TablaABuscar,field).contains(contains)).order_by(TablaABuscar.columnaParaOrdenar).all()
    results = TablaABuscar_schema.dump(all_TablaABuscar_contains)
    return jsonify(results)
 """

""" metodo de busqueda de registro especifico -caso columna 'id'
@app.route('/get/<id>', methods = ['GET'])
def post_details(id):
    registro = registros.query.get(id)
    return registro_schema.jsonify(registro)
 """


### métodos de creación de registros (POST)

@app.route('/add-revisor', methods = ['POST'])
def add_revisor():
    IdRevisor = request.json['IdRevisor']
    NombreRevisor = request.json['NombreRevisor']

    revisores = Revisores(IdRevisor, NombreRevisor)
    db.session.add(revisores)
    db.session.commit()
    return revisor_schema.jsonify(revisores)

@app.route('/add-inspector', methods = ['POST'])
def add_inspector():
    IdInspector = request.json['IdInspector']
    IdRevisor = request.json['IdRevisor']
    NombreInspector = request.json['NombreInspector']

    inspectores = Inspectores(IdInspector, IdRevisor, NombreInspector)
    db.session.add(inspectores)
    db.session.commit()
    return inspector_schema.jsonify(inspectores)

@app.route('/add-obra', methods = ['POST'])
def add_obra():
    IdObra = request.json['IdObra']
    IdRevisor = request.json['IdRevisor']
    NombreObra = request.json['NombreObra']
    Codificacion = request.json['Codificacion']
    FechaContrato = request.json['FechaContrato']
    FechaInicio = request.json['FechaInicio']
    PlazoDias = request.json['PlazoDias']
    IdInspector = request.json['IdInspector']
    FechaFin = request.json['FechaFin']
    Prorroga = request.json['Prorroga']

    obras = Obras(IdObra, IdRevisor, NombreObra, Codificacion, FechaContrato, FechaInicio, PlazoDias, IdInspector, FechaFin, Prorroga)
    db.session.add(obras)
    db.session.commit()
    return obra_schema.jsonify(obras)    

@app.route('/add-certificado', methods = ['POST'])
def add_certificado():
    IdCertificado = request.json['IdCertificado']
    IdObra = request.json['IdObra']
    FechaDePresentacion = request.json['FechaDePresentacion']

    certificados = Certificados(IdCertificado, IdObra, FechaDePresentacion)
    db.session.add(certificados)
    db.session.commit()
    return certificado_schema.jsonify(certificados)


""" 
@app.route('/update/<id>', methods = ['PUT'])
def update_registro(id):
        registro = Registros.query.get(id)
        columnax = request.json['columnax']
        columnay = request.json['columnay']
        columnaz = request.json['columnaz']

        registro.columnax = columnax
        registro.columnay = columnay
        registro.columnaz = columnaz

        db.session.commit()
        return registro_schema.jsonify(registro)

@app.route('/delete/<id>', methods = ['DELETE'])
def registro_delete(id):
    registro = Registros.query.get(id)
    db.session.delete(registro)
    db.session.commit()

    return registro_schema.jsonify(registro) """