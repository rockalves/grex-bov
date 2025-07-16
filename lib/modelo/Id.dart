class Id {
  late int _id_vaca = 0;
  late String _nomeVacaId = "_nomeVacaId";

  Id( this._nomeVacaId,this._id_vaca);

  String get nomeVacaId => _nomeVacaId;

  set nomeVacaId(String value) {
    _nomeVacaId = value;
  }

  int get id_vaca => _id_vaca;

  set id_vaca(int value) {
    _id_vaca = value;
  }
  Id.deMapParaModel(Map<String, dynamic> map) {
    this._id_vaca = map['id'];
    this._nomeVacaId = map["nome"];


  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['id'] =_id_vaca;
    map['nome'] =_nomeVacaId;
    return map;
  }
}