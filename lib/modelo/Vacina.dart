class Vacina{
  String _nomeVaca = "";

  String get nomeVaca => _nomeVaca;

  set nomeVaca(String value) {
    _nomeVaca = value;
  }

  String _nomeVacina = "";
  String _motivo = "";
  String _diaAplicado = "";
  String _periodo = "";

  Vacina(this._nomeVaca,this._nomeVacina, this._motivo, this._carencia, this._periodo,
       this._diaAplicado);

  String get nomeVacina => _nomeVacina;

  set nomeVacina(String value) {
    _nomeVacina = value;
  }

  String _carencia = "";

  String get motivo => _motivo;

  set motivo(String value) {
    _motivo = value;
  }

  String get diaAplicado => _diaAplicado;

  set diaAplicado(String value) {
    _diaAplicado = value;
  }

  String get periodo => _periodo;

  set periodo(String value) {
    _periodo = value;
  }

  String get carencia => _carencia;

  set carencia(String value) {
    _carencia = value;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['nomeVaca'] =_nomeVaca;
    map['nomeVacina'] =_nomeVacina;
    map['motivo'] = _motivo;
    map['carencia'] = _carencia;
    map['periodo'] = _periodo;
    map['diaAplicado'] = _diaAplicado;

    return map;
  }
  Vacina.deMapParaModel(Map<String, dynamic> map) {
    this._nomeVaca = map['nomeVaca'];
    this._nomeVacina = map['nomeVacina'];
    this._motivo = map['motivo'];
    this._carencia = map['carencia'];
    this._periodo = map['periodo'];
    this._diaAplicado = map['diaAplicado'];
  }
}