

class Inseminacao{
  String _dataInseminacao = "inseminada";
  late String _nomeVac;

  String get nomeVac => _nomeVac;

  set nomeVac(String value) {
    _nomeVac = value;
  }



  String get inseminacao => _dataInseminacao;

  set inseminacao(String value) {
    _dataInseminacao = value;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['_nomeVac'] =_nomeVac;
    map['_dataInseminacao'] = _dataInseminacao;
    return map;
  }
  Inseminacao.deMapParaModel(Map<String, dynamic> map) {
    this._nomeVac = map['_nomeVac'];
    this._dataInseminacao = map['_dataInseminacao'];
  }
  Inseminacao(this._nomeVac,this._dataInseminacao);
}