
import 'package:sqflite/sqflite.dart';
import 'package:untitled2/modelo/Vaca.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled2/modelo/inseminacao.dart';
import 'dart:io';

import '../modelo/Cria.dart';

import '../modelo/Vacina.dart';

class AjudaVaca {
  String nomeCria = "tabela_crias";
  String situacao = "_situacao";
  String tabelaVacina = "tabela_vacinas";
  String nomeV = "_nomeV";
  String nomeTabela = 'dados_vaca';
  String nomeTabelaRacas = 'racas';
  String nomeTabelaInseminacao = 'inseminacao';
  String id_inseminacao = 'id';
  String id_vacina = "id";
  String dataInseminacao = "_dataInseminacao";
  String nomeVaca = "nomeVaca";
  String nomeVac = "_nomeVac";
  String nomeVacina = "nomeVacina";
  String motivo = "motivo";
  String carencia = "carencia";
  String diaAplicado = "diaAplicado";
  String periodo = "periodo";
  String id_vaca = 'id';
  String id_cria = 'id';
  String id_raca = 'id_raca';
  String nome = 'nome';
  String numero = 'numero';
  String raca = 'raca';
  String dateTime = 'dateTime';
  String imagem = 'imagem';

  //conectar banco
  static late AjudaVaca _ajudaVaca;
  static late Database _database;

  AjudaVaca._createInstance();

  factory AjudaVaca() {
    _ajudaVaca = AjudaVaca._createInstance();

    return _ajudaVaca;
  }

  Future<Database> get database async {
    _database = await inicializaBanco();

    return _database;
  }

  void criaTabelaVacas(Database db, int versao) async {
    await db.execute('CREATE TABLE $nomeTabela ('
        '$id_vaca INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$nome Text,'
        '$numero Text,'
        '$raca Text,'
        '$dateTime Text,'
        '$imagem Text)');
    await db.execute('CREATE TABLE $nomeTabelaRacas ('
        '$id_raca INTEGER PRIMARY KEY AUTOINCREMENT,'
        'raca Text)');
    await db.execute('CREATE TABLE $nomeTabelaInseminacao ('
        '$id_inseminacao INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$nomeVac Text,'
        '$dataInseminacao Text)');
    await db.execute('CREATE TABLE $nomeCria ('
        '$id_cria Text,'
        '$nomeV Text,'
        '$situacao Text)');
    await db.execute('CREATE TABLE $tabelaVacina ('
        '$id_vacina INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$nomeVaca Text,'
        '$nomeVacina Text,'
        '$motivo Text,'
        '$carencia Text,'
        '$periodo Text,'
        '$diaAplicado Text'
        ')');

  }



  Future<Database> inicializaBanco() async {
    Directory pasta = await getApplicationDocumentsDirectory();
    String caminho = pasta.path + 'bd.bd';

    var bancodedados =
        await openDatabase(caminho, version: 1, onCreate: criaTabelaVacas);

    return bancodedados;
  }

//cadastra
  Future<int> inserirVaca(Vaca v) async {
    Database db = await this.database;

    var res = db.insert(nomeTabela, v.toMap());

    return res;
  }
  /*Future<int> inserirRaca(Raca r) async {
    Database db = await this.database;

    var res = db.insert(nomeTabelaRacas, r.toMap());

    return res;
  }*/
  Future<int> inserirCio(Inseminacao i) async {
    Database db = await this.database;

    var res = db.insert(nomeTabelaInseminacao, i.toMap());

    return res;
  }
  Future<int> inserirCria(Cria c) async {
    Database db = await this.database;

    var res = db.insert(nomeCria, c.toMap());

    return res;
  }
  Future<int> inserirVacina(Vacina v) async {
    Database db = await this.database;

    var res = db.insert(tabelaVacina, v.toMap());

    return res;
  }
  listarCria() async {
    Database db = await this.database;
    String sql = "SELECT * FROM $nomeCria";

    List listaCria = await db.rawQuery(sql);

    return listaCria;
  }
  listarVacinas() async {
    Database db = await this.database;
    String sql = "SELECT * FROM $tabelaVacina";

    List listaVacina = await db.rawQuery(sql);

    return listaVacina;
  }
  excluirCria(String nome) async{
    Database db = await this.database;
    return await db.delete(nomeCria, where: "_nomeV = ?", whereArgs: [nome]);

  }
  excluirVacina(String nome) async{
    Database db = await this.database;
    return await db.delete(tabelaVacina, where: "nomeVacina = ?", whereArgs: [nome]);

  }

  excluirInseminacao(String nome) async{
    Database db = await this.database;
    return await db.delete(nomeTabelaInseminacao, where: "_nomeVac = ?", whereArgs: [nome]);

  }

  //Lista
  listarVacas() async {
    Database db = await this.database;
    String sql = "SELECT * FROM $nomeTabela";

    List listaVacas = await db.rawQuery(sql);

    return listaVacas;
  }
  /*listarRacas() async {
    Database db = await this.database;
    String sql = "SELECT * FROM $nomeTabelaRacas";

    List listaRacas = await db.rawQuery(sql);

    return listaRacas;
  }*/
  listarInseminacoes() async {
    Database db = await this.database;
    String sql = "SELECT * FROM $nomeTabelaInseminacao";

    List listaInseminacoes = await db.rawQuery(sql);

    return listaInseminacoes;
  }
  excluirVaca(String nome) async{
    Database db = await this.database;
    return await db.delete(nomeTabela, where: "nome = ?", whereArgs: [nome]);

  }
  alterarVaca(Vaca vaca, int id) async{
    Database db = await this.database;
    return await db.update(nomeTabela, vaca.toMap(), where: "id = ?", whereArgs: [id]);

  }
  alterarInseminacao(Inseminacao i, String nome) async{
    Database db = await this.database;
    return await db.update(nomeTabelaInseminacao, i.toMap(), where: "_nomeVac = ?", whereArgs: [nome]);

  }


  alterarCria(Cria c, String nome) async{
    Database db = await this.database;
    return await db.update(nomeCria, c.toMap(), where: "_nomeV = ?", whereArgs: [nome]);
  }
  alterarVacina(Vacina v, int id) async{
    Database db = await this.database;
    return await db.update(tabelaVacina, v.toMap(), where: "id = ?", whereArgs: [id]);
  }

}
