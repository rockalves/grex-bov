import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:untitled2/modelo/Cria.dart';
import 'package:untitled2/modelo/inseminacao.dart';
import 'package:untitled2/pages/vacinas.dart';

import '../modelo/Vaca.dart';
import '../utils/AjudaVaca.dart';
import 'Dados.dart';

class DadosVaca extends StatefulWidget {
  const DadosVaca({Key? key}) : super(key: key);

  @override
  State<DadosVaca> createState() => _DadosVacaState();
}

class _DadosVacaState extends State<DadosVaca> {
  String dataEnxertou = "";
  String secar = "";
  String dataParto = "";
  String dataCriar = "";
  String situacaoAtual = "0";
  String dataMostar = "";
  String valor = "Fêmea";
  Vaca v = Dados.vacas[0];
  String nomeV = "";
  AjudaVaca _db = AjudaVaca();
  TextEditingController dataIn = TextEditingController();
  DateTime? _dateTime;
  List<Inseminacao> inseminacaos = <Inseminacao>[];
  List<Cria> crias = <Cria>[];
  String dataConf = "";
  List<String> sexo  = <String> [];

  void salvarCio() {
    setState(() {
      Inseminacao i = Inseminacao(
          nomeV, DateFormat('dd/MM/yy').format(_dateTime!).toString());
      _db.inserirCio(i);
    });
  }

  void salvarCria() {
    setState(() {
      Cria c = Cria(nomeV, situacaoAtual);
      _db.inserirCria(c);
    });
  }

  mostraCria() async {
    List cria = await _db.listarCria();

    List<Cria> vTemp = <Cria>[];

    for (var x in cria) {
      Cria c = Cria.deMapParaModel(x);

      vTemp.add(c);
    }
    setState(() {
      crias = vTemp;
      int s = -1;
      for (var x in crias) {
        s++;
        if (x.nomeV == nomeV) {
          situacaoAtual = x.situacao;
        }
      }
    });
  }

  void removerCria(String cria) async {
    await _db.excluirCria(cria);
    await _db.excluirInseminacao(cria);
    setState(() async {
      situacaoAtual = "0";
      dataMostar = "";
      mostraCio();
      mostraCria();
    });
  }

  void removerIns(String ins) async {
    await _db.excluirInseminacao(ins);
    setState(() async {
      dataMostar = "";
      mostraCio();
    });
  }

  mostraCio() async {
    List cioRec = await _db.listarInseminacoes();

    print(cioRec);
    List<Inseminacao> vTemp = <Inseminacao>[];

    for (var x in cioRec) {
      Inseminacao cio = Inseminacao.deMapParaModel(x);

      vTemp.add(cio);
    }
    setState(() {
      inseminacaos = vTemp;
      int s = -1;
      for (var x in inseminacaos) {
        s++;
        if (x.nomeVac == nomeV) {
          dataMostar = x.inseminacao;

        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nomeV = v.nome;

    mostraCio();
    mostraCria();
  }

  @override
  Widget build(BuildContext context) {
    sexo.clear();
    sexo.add("aaaaa");


    print(sexo);
    DateTime data = DateTime.now();
    int dataAtual = int.parse(DateFormat('yy').format(data).toString());
    List<String> dataVaca = v.dateTime.split("/");
    int dataArrumar = int.parse(dataVaca[dataVaca.length - 1]);
    print(dataArrumar == dataAtual);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120.0),
          // here the desired height
          child: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
            centerTitle: true,
            leading: Padding(
              padding: EdgeInsets.fromLTRB(2, 10, 0, 0),
              child: Stack(
                children: [
                  Container(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xB30A3638),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: FileImage(
                          File(v.imagem),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            backgroundColor: Color(0xB30A3638),
            automaticallyImplyLeading: true,
            title: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Text(
                '${v.nome}',
                style: TextStyle(fontSize: 30),
              ),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "GERAIS",
                ),
                Tab(
                  text: "REPRODUÇÂO",
                ),
                Tab(
                  text: "PRODUÇÂO",
                ),
              ],
              indicatorColor: Colors.white,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text(
                        "Nome: ${v.nome}",
                        style: const TextStyle(
                          fontFamily: 'Times New Roman',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text("Número: ${v.numero}",
                          style: const TextStyle(
                            fontFamily: 'Times New Roman',
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text(
                        "Nascimento: ${v.dateTime}",
                        style: const TextStyle(
                          fontFamily: 'Times New Roman',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text(
                        "Raça: ${v.raca}",
                        style: const TextStyle(
                          fontFamily: 'Times New Roman',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text("Idade: ${dataAtual - dataArrumar} anos",
                          style: const TextStyle(
                            fontFamily: 'Times New Roman',
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF2FA0B0),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      width: 250,
                      child: TextButton(
                          onPressed: () {
                            Dados.vacaVac.clear();
                            Dados.vacaVac.add(v.nome);
                            Dados.vacaVac.add(v.numero);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Vacinas()));
                          },
                          child: Text("VACINAS",
                              style: const TextStyle(
                                fontFamily: 'Times New Roman',
                                color: Colors.black,
                                fontSize: 23,
                              ))),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text(
                        "Partos: ${v.nome}",
                        style: const TextStyle(
                          fontFamily: 'Times New Roman',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text("Filhos: ${v.numero}",
                          style: const TextStyle(
                            fontFamily: 'Times New Roman',
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text(
                        "1º parto: ${v.dateTime}",
                        style: const TextStyle(
                          fontFamily: 'Times New Roman',
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xffAAC7C4),
                      ),
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      child: Text("Ultimo parto: ",
                          style: const TextStyle(
                            fontFamily: 'Times New Roman',
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ),
                    Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Color(0xffAAC7C4),
                        ),
                        margin: const EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text("Situação Atual",
                                style: const TextStyle(
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black,
                                  fontSize: 26,
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            dataMostar == "" && situacaoAtual == "0"
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      color: Color(0xffAAC7C4),
                                    ),
                                    margin: const EdgeInsets.only(bottom: 20),
                                    child: Column(
                                      children: [
                                        Text("Nenhum registro de inseminação",
                                            style: const TextStyle(
                                              fontFamily: 'Times New Roman',
                                              color: Colors.black,
                                              fontSize: 20,
                                            )),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            color: Color(0xFF098799),
                                          ),
                                          child: TextButton(
                                              onPressed: () {
                                                _exibirDialogoData();
                                              },
                                              child: Text("NOVA INSEMINAÇÂO",
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'Times New Roman',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ))),
                                        ),
                                      ],
                                    ))
                                : dataMostar != "" && situacaoAtual == "0"
                                    ? Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Color(0xffAAC7C4),
                                        ),
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        padding: EdgeInsets.all(12),
                                        width: double.infinity,
                                        child: Column(
                                          children: [
                                            Text("Inseminada:  ${dataMostar}",
                                                style: const TextStyle(
                                                  fontFamily: 'Times New Roman',
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text("Enxerta em:  ${calcData()}",
                                                style: const TextStyle(
                                                  fontFamily: 'Times New Roman',
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                )),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _exibirDialogoDataPrenha();

                                                      situacaoAtual = "1";
                                                      salvarCria();
                                                      mostraCria();
                                                    });
                                                  },
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xFF098799),
                                                      fixedSize:
                                                          const Size(80, 30),
                                                      primary: Colors.black,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24))),
                                                  child: const Text(
                                                    'ENXERTOU',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {},
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xFF098799),
                                                      fixedSize:
                                                          const Size(80, 30),
                                                      primary: Colors.black,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24))),
                                                  child: const Text(
                                                    'REPETIU',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    _exibirDialogoCio();
                                                  },
                                                  style: TextButton.styleFrom(
                                                      backgroundColor:
                                                          Color(0xFF098799),
                                                      fixedSize:
                                                          const Size(80, 30),
                                                      primary: Colors.black,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          24))),
                                                  child: const Text(
                                                    'CANCELAR',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    : situacaoAtual == "1"
                                        ? Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Color(0xffAAC7C4),
                                            ),
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Column(
                                              children: [
                                                Text(" A vaca está prenha",
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'Times New Roman',
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    )),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    "Inseminada:  ${dataMostar}",
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'Times New Roman',
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    )),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    "Enxertou em:  ${calcDiaEnxertou()}",
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'Times New Roman',
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    )),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                    "Secar em:  ${calcDataSec()}",
                                                    style: const TextStyle(
                                                      fontFamily:
                                                          'Times New Roman',
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    )),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  "Previsão de parto:  ${prevParto()}",
                                                  style: const TextStyle(
                                                    fontFamily:
                                                        'Times New Roman',
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        _exibirDialogoParto();
                                                      },
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              Color(0xFF098799),
                                                          fixedSize: const Size(
                                                              80, 30),
                                                          primary: Colors.black,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15))),
                                                      child: const Text(
                                                        'PARIU',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {

                                                      },
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              Color(0xFF098799),
                                                          fixedSize: const Size(
                                                              80, 30),
                                                          primary: Colors.black,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15))),
                                                      child: const Text(
                                                        'PERDEU CRIA',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        _exibirDialogoCan();
                                                      },
                                                      style: TextButton.styleFrom(
                                                          backgroundColor:
                                                              Color(0xFF098799),
                                                          fixedSize: const Size(
                                                              80, 30),
                                                          primary: Colors.black,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15))),
                                                      child: const Text(
                                                        'CANCELAR',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ))
                                        : Container(),
                          ],
                        )),
                  ],
                ),
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }

  void _exibirDialogoData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text("Inseminação"),
          content: Container(
            height: 50,
            width: 380,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(width: 2, color: Color(0xB30A3638)),
              ),
              icon: Icon(Icons.calendar_month, size: 30, color: Colors.black),
              label: Text(
                _dateTime == null
                    ? 'Data da Inseminação'
                    : DateFormat('dd/MM/yy').format(_dateTime!),
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onPressed: () {
                showDatePicker(
                  helpText: "Selecione a Data de Inseminação",
                  cancelText: "Calcelar",
                  confirmText: "Confirmar",
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime.now(),
                ).then((date) {
                  setState(() {
                    _dateTime = date;
                    Navigator.pop(context);
                    _exibirDialogoData();
                  });
                });
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                nomeV = v.nome;
                salvarCio();
                mostraCio();

                print(dataMostar);
                Navigator.pop(context);
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }
  void _exibirDialogoDataPrenha() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text("Inseminação"),
          content: Container(
            height: 50,
            width: 380,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                primary: Colors.white,
                side: BorderSide(width: 2, color: Color(0xB30A3638)),
              ),
              icon: Icon(Icons.calendar_month, size: 30, color: Colors.black),
              label: Text(
                _dateTime == null
                    ? 'Confirmação da prenhez'
                    : DateFormat('dd/MM/yy').format(_dateTime!),
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onPressed: () {
                showDatePicker(
                  helpText: "Selecione a Data de prenhez",
                  cancelText: "Calcelar",
                  confirmText: "Confirmar",
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2021),
                  lastDate: DateTime.now(),
                ).then((date) {
                  setState(() {
                    _dateTime = date;
                    Navigator.pop(context);
                    _exibirDialogoDataPrenha();
                  });
                });
              },
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                nomeV = v.nome;
              //  salvarCio();
                //mostraCio();

                print(dataMostar);
                Navigator.pop(context);
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }

  calcData() {
    List<String> v = dataMostar.split("/");
    int dia = int.parse(v[0]);
    int mes = int.parse(v[1]);
    int ano = int.parse(v[2]);
    dia += 21;
    if (dia > 30) {
      mes += 1;
      dia = dia - 30;
    }
    if (mes > 12) {
      mes = mes - 12;
      ano += 1;
    }

    print(dia);
    print(mes);
    print(ano);
    dataConf = dia.toString() + "/";
    dataConf += mes.toString() + "/";
    dataConf += ano.toString();

    return dataConf;
  }

  calcDataSec() {
    List<String> v = dataEnxertou.split("/");
    int dia = int.parse(v[0]);
    int mes = int.parse(v[1]);
    int ano = int.parse(v[2]);
    int mesSecar = mes;
    mesSecar += 7;
    int anoSecar = ano;
    mes += 9;
    if (mes > 12) {
      mes = mes - 12;
      ano += 1;
    }
    if (mesSecar > 12) {
      mesSecar = mesSecar - 12;
      anoSecar += 1;
    }

    secar = dia.toString() + "/";
    secar += mesSecar.toString() + "/";
    secar += anoSecar.toString();
    return secar;
  }

  calcDiaEnxertou() {
    DateTime r = DateTime.now();
    dataEnxertou = DateFormat("dd/MM/yy").format(r).toString();
    print(dataEnxertou);
    return dataEnxertou;
  }

  prevParto() {
    List<String> v = dataEnxertou.split("/");
    int dia = int.parse(v[0]);
    int mes = int.parse(v[1]);
    int ano = int.parse(v[2]);
    int mesSecar = mes;
    mesSecar += 7;
    int anoSecar = ano;
    mes += 9;
    if (mes > 12) {
      mes = mes - 12;
      ano += 1;
    }
    if (mesSecar > 12) {
      mesSecar = mesSecar - 12;
      anoSecar += 1;
    }

    dataParto = dia.toString() + "/";
    dataParto += mes.toString() + "/";
    dataParto += ano.toString();
    secar = dia.toString() + "/";
    secar += mesSecar.toString() + "/";
    secar += anoSecar.toString();
    return dataParto;
  }

  void _exibirDialogoCan() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text("Cancelar gestação"),
          content: Container(
              height: 50,
              width: 380,
              child: Text("Tem certeza que deseja cancelar a gestação?")),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Não"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                setState(() {
                  removerCria(v.nome);
                });

                Navigator.pop(context);
              },
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }

  void _exibirDialogoCio() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text("Cancelar inseminação"),
          content: Container(
              height: 50,
              width: 380,
              child: Text("Tem certeza que deseja cancelar a inseminação?")),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Não"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                setState(() {
                  removerIns(v.nome);
                });

                Navigator.pop(context);
              },
              child: Text("Sim"),
            ),
          ],
        );
      },
    );
  }
  void _exibirDialogoParto() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          title: Text("Dados da gestação"),
          content: Container(
              height: 50,
              width: 380,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),

                      border: Border.all(color: Color(0xFF0C5756), width: 2),
                    ),
                    alignment: Alignment.centerLeft,
                    child: DropdownButton<String>(
                      isExpanded: true,

                      hint: Text("Selecione a raça", style: TextStyle(fontSize: 20, color: Colors.black),),

                      value: valor,
                      dropdownColor: Color(0xFFFFFFFF),
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      elevation: 16,
                      style: const TextStyle(color: Color(0xFF000000), fontSize: 20),

                      onChanged: (String? newValue) {

                        setState(() {
                          valor = newValue!;
                        });
                      },
                      items: sexo
                          .map<DropdownMenuItem<String>>((String value) {

                        return DropdownMenuItem<String>(

                          value: value,
                          child: Text(value),

                        );
                      }).toList(),
                    ),
                  ),
                ],
              )),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Não"),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Color(0xFF000000),
              ),
              onPressed: () {
                setState(() {
                  removerIns(v.nome);
                });

                Navigator.pop(context);
              },
              child: const Text("Sim"),
            ),
          ],
        );
      },
    );
  }
}
