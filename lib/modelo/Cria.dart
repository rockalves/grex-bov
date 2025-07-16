



class Cria {
  String _nomeV = "_nomeV";
  String _situacao = "_situacao";

  String get situacao => _situacao;

  set situacao(String value) {
    _situacao = value;
  }

  String get nomeV => _nomeV;

  set nomeV(String value) {
    _nomeV = value;
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['_nomeV'] =_nomeV;
    map['_situacao'] = _situacao;
    return map;
  }
  Cria.deMapParaModel(Map<String, dynamic> map) {
    this._nomeV = map['_nomeV'];
    this._situacao = map['_situacao'];
  }
  Cria(this._nomeV,this._situacao);
}
