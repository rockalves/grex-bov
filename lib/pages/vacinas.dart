import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../modelo/Id.dart';
import '../modelo/Vacina.dart';
import '../utils/AjudaVaca.dart';
import 'Dados.dart';

class Vacinas extends StatefulWidget {
  const Vacinas({Key? key}) : super(key: key);

  @override
  State<Vacinas> createState() => _VacinasState();
}

class _VacinasState extends State<Vacinas> {
  List<String> periodos = ["Manhã", "Tarde"];
  String? valor;
  AjudaVaca rec = AjudaVaca();
  List<Id> ids = <Id>[];
  DateTime? _dateTime;
  List<Vacina> vacinas = <Vacina>[];
  TextEditingController nome = TextEditingController();
  TextEditingController motivo = TextEditingController();
  TextEditingController carencia = TextEditingController();
  AjudaVaca _db = AjudaVaca();
  String periodoCarencia = "";
  int cont = 0 ;
  void salvarVacina() {
    setState(() {
//terminar manipulação do nome...
      Vacina v = Vacina(Dados.vacaVac[0], nome.text, motivo.text, carencia.text, valor!,
          DateFormat('dd/MM/yy').format(_dateTime!).toString());
      _db.inserirVacina(v);
    });
  }

  mostraVacina() async {
    List vacinasRec = await _db.listarVacinas();

    List<Vacina> vTemp = <Vacina>[];

    for (var x in vacinasRec) {
      Vacina vac = Vacina.deMapParaModel(x);

      vTemp.add(vac);
    }
    vacinas.clear();
    print(vTemp);
    for (var x in vTemp){
      if (x.nomeVaca == Dados.vacaVac[0]){
        setState(() {
          vacinas.add(x);

        });
      }
    }

  }
  calcData(String a, String b){
   List<String> v  =  a.split("/");
   int dia = int.parse(v[0]);
   int mes = int.parse(v[1]);
   int ano = int.parse(v[2]);
   int temp = int.parse(b);
   dia += temp;
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
   periodoCarencia = dia.toString() + "/";
   periodoCarencia += mes.toString() + "/";
   periodoCarencia += ano.toString();
   return periodoCarencia;
  }
  calcPeriodo(String a){
    if (a == "Manhã"){
      a = "Tarde";
    }
    else{
      a = "Manhã";
    }
    return a;
  }
  void exibirTelaConf(String vacina) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Excluir vaca"),
            content: Text("Tem certeza que deseja excluir essa vaca?"),
            backgroundColor: Colors.white,
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar")),
              TextButton(
                  onPressed: () {
                    removerVacina(vacina);

                    Navigator.pop(context);
                  },
                  child: Text("Sim"))
            ],
          );
        });
  }
  void removerVacina(String vacina) async {
    await _db.excluirVacina(vacina);
    mostraVacina();
  }

  @override
  void initState() {
    super.initState();
    mostraVacina();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xB30A3638),
        automaticallyImplyLeading: true,
        title: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Text(
            'Vacinas',
            style: TextStyle(fontSize: 45),
          ),
        ),
      ),
      body: Column(
        children: [

          Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
                child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xffAAC7C4),
                ),
                margin: const EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(12),
                width: double.infinity,
                child: Column(
                    children: [
                  Text(
                    "Vaca: ${Dados.vacaVac[0]}",
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nº: ${Dados.vacaVac[1]}",
                    style: const TextStyle(
                      fontFamily: 'Times New Roman',
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  ),
                ]),
              )
            ])),
          ),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1),
                color: Color(0xffAAC7C4),
              ),
              margin: const EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(12),
              width: double.infinity,
              child: Column(
                  children: [
                    Text(
                      "Situação das vacinas",
                      style: const TextStyle(
                        fontFamily: 'Times New Roman',
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ]
              )
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: vacinas.length,
                itemBuilder: (context, index) {
                  final Vacina vaci = vacinas[index];
                  return Container(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                          child: Column(children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xffAAC7C4),
                          ),
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.all(12),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Text(
                                "Nome: ${vaci.nomeVacina}",
                                style: const TextStyle(
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Motivo: ${vaci.motivo}",
                                style: const TextStyle(
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Carência: ${vaci.carencia} dias",
                                style: const TextStyle(
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Periodo: ${vaci.periodo}",
                                style: const TextStyle(
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Aplicado em: ${vaci.diaAplicado}",
                                style: const TextStyle(
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Carência acaba em: ${calcData(vaci.diaAplicado, vaci.carencia)}",
                                style: const TextStyle(
                                  fontFamily: 'Times New Roman',
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                color: Colors.black,
                                width: double.infinity,
                                height: 1,
                              ),

                              Row(

                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _exibirDialogoEdita(vaci);

                                    },

                                    icon: Icon(Icons.edit_note_sharp,
                                        size: 30, color: Color(0xFF000000)),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      exibirTelaConf(vaci.nomeVacina);
                                    },
                                    icon: Icon(Icons.delete,
                                        size: 25, color: Color(0xFFE34D43)),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ])));
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exibirDialogoCadastro();
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xFF098799),
      ),
    );
  }

  void _exibirDialogoCadastro() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          alignment: Alignment.center,
          title: Text("Cadastro Vacina"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: nome,
                  decoration: InputDecoration(
                    labelText: 'Nome da vacina',
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      //Colors.black,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFF000000),
                        //Color(0xB37FA7A9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFF000000)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: motivo,
                  decoration: InputDecoration(
                    labelText: 'Motivo',
                    hintText: "Ex: Mastite",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      //Colors.black,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFF000000),
                        //Color(0xB37FA7A9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFF000000)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: carencia,
                  decoration: InputDecoration(
                    labelText: 'Carencia',
                    hintText: "Ex: 7 dias",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      //Colors.black,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFF000000),
                        //Color(0xB37FA7A9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Color(0xFF000000)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF0C5756), width: 2),
                    ),
                    alignment: Alignment.centerLeft,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        "Selecione o periodo",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      value: valor,
                      dropdownColor: Color(0xFFFFFFFF),
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: Color(0xFF000000), fontSize: 17),
                      items: periodos
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          Navigator.pop(context);
                          valor = newValue!;
                          _exibirDialogoCadastro();
                        });
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 380,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(width: 2, color: Color(0xB30A3638)),
                    ),
                    icon: Icon(Icons.calendar_month,
                        size: 30, color: Colors.black),
                    label: Text(
                      _dateTime == null
                          ? 'Data'
                          : DateFormat('dd/MM/yy').format(_dateTime!),
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onPressed: () {
                      showDatePicker(
                        helpText: "Selecione a Data de aplicação da Vacina",
                        cancelText: "Calcelar",
                        confirmText: "Confirmar",
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime.now(),
                      ).then((date) {
                        setState(() {
                          Navigator.pop(context);
                          _dateTime = date;
                          _exibirDialogoCadastro();
                        });
                      });
                    },
                  ),
                ),
              ],
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
                setState(() {
                  salvarVacina();
                  mostraVacina();
                  nome.clear();
                  motivo.clear();
                  carencia.clear();
                  _dateTime = null;
                });

                Navigator.pop(context);
              },
              child: Text("Salvar"),
            ),
          ],
        );
      },
    );
  }
  void _exibirDialogoEdita(Vacina v) {
    if (nome.text != v.nomeVacina){
      nome.text = v.nomeVacina;
    }
    if (motivo.text != v.motivo){
      motivo.text = v.motivo;
    }
    if (carencia.text != v.carencia){
      carencia.text = v.carencia;
    }






    String auxData = v.diaAplicado;
    String periodo = v.periodo;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFFFFFFF),
          alignment: Alignment.center,
          title: Text("Editar Vacina"),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                TextField(
                  controller: nome,
                  decoration: InputDecoration(
                    labelText: 'Nome da vacina',
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      //Colors.black,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFF000000),
                        //Color(0xB37FA7A9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 2, color: Color(0xFF000000)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: motivo,
                  decoration: InputDecoration(
                    labelText: 'Motivo',
                    hintText: "Ex: Mastite",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      //Colors.black,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFF000000),
                        //Color(0xB37FA7A9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 2, color: Color(0xFF000000)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: carencia,
                  decoration: InputDecoration(
                    labelText: 'Carencia',
                    hintText: "Ex: 7 dias",
                    hintStyle: TextStyle(color: Colors.black, fontSize: 20),
                    labelStyle: TextStyle(
                      color: Color(0xFF000000),
                      //Colors.black,
                      fontSize: 17,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xFF000000),
                        //Color(0xB37FA7A9),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                      const BorderSide(width: 2, color: Color(0xFF000000)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF0C5756), width: 2),
                    ),
                    alignment: Alignment.centerLeft,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        "Selecione o periodo",
                        style: TextStyle(fontSize: 17, color: Colors.black),
                      ),
                      value: valor,
                      dropdownColor: Color(0xFFFFFFFF),
                      icon: const Icon(Icons.keyboard_arrow_down_sharp),
                      elevation: 16,
                      style: const TextStyle(
                          color: Color(0xFF000000), fontSize: 17),
                      items: periodos
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 20),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          Navigator.pop(context);
                          valor = newValue!;
                          _exibirDialogoEdita(v);
                        });
                      },
                    )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 380,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(width: 2, color: Color(0xB30A3638)),
                    ),
                    icon: Icon(Icons.calendar_month,
                        size: 30, color: Colors.black),
                    label: Text(
                      _dateTime == null
                          ? '${v.diaAplicado}'
                          : DateFormat('dd/MM/yy').format(_dateTime!),
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    onPressed: () {
                      showDatePicker(
                        helpText: "Selecione a Data de aplicação da Vacina",
                        cancelText: "Calcelar",
                        confirmText: "Confirmar",
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime.now(),
                      ).then((date) {
                        setState(() {
                          Navigator.pop(context);
                          _dateTime = date;
                          _exibirDialogoEdita(v);
                        });
                      });
                    },
                  ),
                ),
              ],
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
                setState(() {
                  if (_dateTime != null){
                    auxData = DateFormat('dd/MM/yy').format(_dateTime!).toString();
                  }
                  Vacina edita = Vacina(Dados.vacaVac[0],nome.text, motivo.text, carencia.text, valor!,  auxData);
                  editarVacina(edita);
                  nome.clear();
                  motivo.clear();

                  carencia.clear();
                  _dateTime = null;
                });

                Navigator.pop(context);
              },
              child: Text("Editar"),
            ),
          ],
        );
      },
    );
  }
  editarVacina(Vacina v) async {
    List vacicRec = await rec.listarVacas();


    List<Id> vTemp = <Id>[];

    for (var x in vacicRec) {
      Id vac = Id.deMapParaModel(x);

      vTemp.add(vac);

    }
    ids.clear();
    setState(() {
      ids = vTemp;
      //print(ids[0].nomeVacaId);

    });
    for (var x in ids){
      if (x.nomeVacaId == v.nomeVaca){
        _db.alterarVacina(v, x.id_vaca);
      }
    }


    mostraVacina();
  }
}
