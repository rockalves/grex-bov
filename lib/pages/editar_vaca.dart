

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/modelo/inseminacao.dart';
import 'package:untitled2/pages/rebanho.dart';

import '../modelo/Cria.dart';
import '../modelo/Id.dart';

import '../modelo/Vaca.dart';
import '../modelo/Vacina.dart';
import '../utils/AjudaVaca.dart';
import 'Dados.dart';

class EditarVaca extends StatefulWidget {
  const EditarVaca({Key? key}) : super(key: key);

  @override
  State<EditarVaca> createState() => _EditarVacaState();
}

class _EditarVacaState extends State<EditarVaca> {
  AjudaVaca _db = AjudaVaca();
  Vaca v = Dados.vacasEdit[0];
String auxRaca = "";
String? valor;
  DateTime? _dateTime;
  String auxTime = "";
  String auxImg = "";
  ImagePicker imagePicker = ImagePicker();
  TextEditingController nome = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController data = TextEditingController();
String auxAltNome = "";

  File? imagem;
  AjudaVaca rec = AjudaVaca();

  List<String> racas = ["Holandesa", "Jersey", "Pardo Suiço", "Gir", "Girolanda", "Guzerá", "Sindi"];

  List<Id> ids = <Id>[];
  List<Vacina> vacinas = <Vacina>[];
  List<Inseminacao> inseminacaos = <Inseminacao>[];

  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    auxAltNome = v.nome;
    nome.text = v.nome;
    numero.text = v.numero;
    auxTime = v.dateTime;
    auxRaca = v.raca;
    auxImg = v.imagem;
    return Scaffold(
      backgroundColor: Color(0xFFB0D6D9),
      appBar: AppBar(
        backgroundColor: Color(0xB30A3638),
        automaticallyImplyLeading: false,
        title: Align(
          child: Text(
            'Editar',
            style: TextStyle(fontSize: 50),
          ),
        ),
      ),

      body: SingleChildScrollView(

        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(

                        alignment: Alignment.center,

                        child: Column(
                          children: [

                            Stack(
                              children: [
                                Container(

                                  child: CircleAvatar(

                                    radius: 71,
                                    backgroundColor: Color(0xB30A3638),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFF94AB9A),

                                      radius: 65,
                                      backgroundImage: imagem == null ? FileImage(File(v.imagem)) : FileImage(imagem!),

                                    ),
                                  ),
                                ),
                                Positioned( top: 92, left: 74,
                                  child: RawMaterialButton(

                                    fillColor: Color(0xFF92CFD3),
                                    child: Icon(Icons.add_a_photo),
                                    padding: EdgeInsets.all(10),
                                    shape: CircleBorder(),
                                    onPressed: (){
                                      _pegarImagem();
                                    },

                                  ),
                                ),
                              ],
                            ),

                          ],
                        )),
                    SizedBox(
                      height: 50,
                    ),
                    TextField(
                      controller: nome,

                      cursorColor: Colors.black,
                      decoration: InputDecoration(

                          labelText: "Nome da vaca",
                          labelStyle:
                          TextStyle(color: Colors.black, fontSize: 20),
                          hintText: "Ex: Mimosa",


                          hintStyle:
                          TextStyle(color: Colors.black, fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Color(0xB30A3638)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Color(0xFF0C5756)),
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    TextField(
                      controller: numero,
                      keyboardType: TextInputType.number,

                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          label: (Text("Número de vaca")),

                          labelStyle:
                          TextStyle(color: Colors.black, fontSize: 20),
                          hintText: "Ex: 16",
                          hintStyle:
                          TextStyle(color: Colors.black, fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Color(0xB30A3638)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Color(0xFF0C5756)),
                            borderRadius: BorderRadius.circular(15),
                          )),
                    ),
                    SizedBox(
                      height: 30,
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
                          items: racas
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

                              valor = newValue!;

                            });
                          },
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: 380,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          side:
                          BorderSide(width: 3, color: Color(0xB30A3638)),
                        ),
                        icon: Icon(Icons.calendar_month,
                            size: 30, color: Colors.black),
                        label: Text(
                          _dateTime == null
                              ? '${v.dateTime}'
                              : DateFormat('dd/MM/yy').format(_dateTime!),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        onPressed: () {
                          showDatePicker(
                            helpText:
                            "Selecione a Nova Data de Nascimento da Vaca",
                            cancelText: "Calcelar",
                            confirmText: "Confirmar",
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3022),
                          ).then((date) {
                            setState(() {
                              _dateTime = date;
                             auxTime =  DateFormat('dd/MM/yy').format(_dateTime!).toString();
                            });
                          });

                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "VOLTAR",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF098799),
                            fixedSize: const Size(100, 50),
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)))),
                    TextButton(
                        onPressed: () {
                         if (valor != null){
                           auxRaca = valor!;
                         }
                         if (imagem != null){
                           auxImg = imagem.toString();
                         }
                         Vaca ver = Vaca(nome.text, numero.text , auxRaca, auxTime, auxImg.replaceAll("File: '", "").replaceAll("'", ""));




                          editarVaca(ver);

                          //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Rebanho()),(Route<dynamic> route) => false);




                        },
                        child: Text(
                          "SALVAR",
                          style: TextStyle(color: Colors.black),
                        ),
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF098799),
                            fixedSize: const Size(100, 50),
                            primary: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)))),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  pegarCamera() async{

    var imagemTemporaria = await imagePicker.getImage(source: ImageSource.camera);



    if (imagemTemporaria != null){
      setState((){

        imagem = File(imagemTemporaria.path);

      });

    }

  }
  editarVaca(Vaca ver) async {

    List vacasRec = await rec.listarVacas();


    List<Id> vTemp = <Id>[];

    for (var x in vacasRec) {
      Id vac = Id.deMapParaModel(x);

      vTemp.add(vac);

    }
    setState(() {
      ids = vTemp;
print(ids[0].nomeVacaId);

    });
   for (var x in ids){
      if (x.nomeVacaId == v.nome){
        List inseminacao = await rec.listarVacas();
        List vacina = await rec.listarVacas();
        for (var y in inseminacao){
          Inseminacao i = Inseminacao.deMapParaModel(y);
          if (i.nomeVac == v.nome){
            inseminacaos.add(i);
          }
        }
        for (var y in vacina){
          Vacina va = Vacina.deMapParaModel(y);
          if (va.nomeVaca == v.nome){
            vacinas.add(va);
          }
        }

        Cria c = Cria(nome.text, "1");
        _db.alterarInseminacao(inseminacaos[0], x.nomeVacaId);
        _db.alterarCria(c, auxAltNome);
        _db.alterarVaca(ver, x.id_vaca);

        Dados.vacas.clear();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Rebanho()));
      }
    }
  }
  void _pegarImagem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          backgroundColor: Color(0xFFFFFFFF),
          title: Text("Pegar imagem"),
          content: Container(

              height: 50,
              width: 380,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                          Color(0xFF098799),
                          fixedSize: const Size(
                              80, 30),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  15))),
                    onPressed: (){
                      pegarCamera();
                      Navigator.pop(context);
                    },
                      child: Text("FOTO")),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor:
                          Color(0xFF098799),
                          fixedSize: const Size(
                              80, 30),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  15))),
                      onPressed: (){
                        pegarGaleria();
                        Navigator.pop(context);
                      },
                      child: Text("GALERIA")),
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
              child: Text("Cancelar"),
            ),

          ],
        );
      },
    );
  }
  pegarGaleria() async{
    final PickedFile? imagemTemporaria = await imagePicker.getImage(source: ImageSource.gallery);
    if (imagemTemporaria != null){
      setState((){

        imagem = File( imagemTemporaria.path);

      });

    }
  }


}

