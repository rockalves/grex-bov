class Vaca {
  late String _nome;
  late String _numero;
  late String _dateTime;
  late String _raca;

  String get raca => _raca;

  set raca(String value) {
    _raca = value;
  }

  late String _imagem;

  String get imagem => _imagem;

  set imagem(String value) {
    _imagem = value;
  }

  String get dateTime => _dateTime;

  set dateTime(String value) {
    _dateTime = value;
  }

  Vaca(this._nome, this._numero, this._raca, this._dateTime, this._imagem);

  get nome => this._nome;

  set nome(value) => this._nome = value;

  get numero => this._numero;

  set numero(value) => this._numero = value;

  //Model map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['nome'] = _nome;
    map['numero'] = _numero;
    map['raca'] = _raca;
    map['dateTime'] = _dateTime;

    map['imagem'] = _imagem;
    return map;
  }

// Map model

  Vaca.deMapParaModel(Map<String, dynamic> map) {
    this._nome = map['nome'];

    this._numero = map['numero'];
    this._raca = map['raca'];
    this._dateTime = map['dateTime'];

    this._imagem = map['imagem'];
  }
}
