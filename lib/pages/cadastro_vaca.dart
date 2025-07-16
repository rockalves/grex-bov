import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled2/modelo/Vaca.dart';
import 'package:untitled2/pages/rebanho.dart';
import 'package:untitled2/utils/AjudaVaca.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CadastroVaca extends StatefulWidget {
  const CadastroVaca({Key? key}) : super(key: key);

  @override
  State<CadastroVaca> createState() => _CadastroVacaState();
}

class _CadastroVacaState extends State<CadastroVaca> {
  List<String> items = ["1", "2", "3", "4"];
  String? select = 'Item 1';
  DateTime? _dateTime;

  ImagePicker imagePicker = ImagePicker();

  File? imagem;
  TextEditingController nome = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController data = TextEditingController();
  AjudaVaca _db = AjudaVaca();
  String? erroNome;
  String? erroNumero;

  String? armImagem;
  String? valor;
  List<String> racas = [
    "Holandesa",
    "Jersey",
    "Pardo Suiço",
    "Gir",
    "Girolanda",
    "Guzerá",
    "Sindi"
  ];

//metodo para salvar dados

  void salvarVaca() {
    setState(() {
      String a = nome.text;
//terminar manipulação do nome...
      Vaca v = Vaca(
          a,
          numero.text,
          valor!,
          DateFormat('dd/MM/yy').format(_dateTime!).toString(),
          imagem.toString().replaceAll("File: '", "").replaceAll("'", ""));
      _db.inserirVaca(v);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB0D6D9),
      appBar: AppBar(
        backgroundColor: Color(0xB30A3638),
        automaticallyImplyLeading: false,
        title: Align(
          child: Text(
            'Cadastro',
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
                                      radius: 68,
                                      backgroundImage: imagem == null
                                          ? null
                                          : FileImage(imagem!),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 92,
                                  left: 74,
                                  child: RawMaterialButton(
                                    fillColor: Color(0xFF92CFD3),
                                    child: Icon(Icons.add_a_photo),
                                    padding: EdgeInsets.all(10),
                                    shape: CircleBorder(),
                                    onPressed: () {
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
                      onChanged: (String text){
                       if (!text.isEmpty){
                         setState((){
                           erroNome = null;
                         });

                      }
                       else{
                         setState((){
                           erroNome = "Informe o nome da vaca";
                         });
                       }
                      },

                      controller: nome,
                      cursorColor: Colors.black,

                      decoration: InputDecoration(
                        border: OutlineInputBorder(

                        ),
                          labelText: 'Nome da Vaca',

                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          hintText: "Ex: Mimosa",
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          errorText: erroNome,

                          enabledBorder: OutlineInputBorder(

                            borderSide: const BorderSide(
                                width: 2, color: Color(0xB30A3638)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(

                            borderSide: const BorderSide(

                                width: 2, color: Color(0xFF0C5756)),
                            borderRadius: BorderRadius.circular(15),
                          )

                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      onChanged: (String text){
                        if (!text.isEmpty){
                          setState((){
                            erroNumero = null;
                          });

                        }
                        else{
                          setState((){
                            erroNumero = "Informe o número da vaca";
                          });
                        }
                      },
                      controller: numero,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,

                      decoration: InputDecoration(
                          border: OutlineInputBorder(

                          ),
                          errorText: erroNumero,
                          labelText: 'Número da Vaca',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          hintText: "Ex: 16",
                          hintStyle:
                              TextStyle(color: Colors.black, fontSize: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Color(0xB30A3638)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: Color(0xFF0C5756)),
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
                          border:
                              Border.all(color: Color(0xFF0C5756), width: 2),
                        ),
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(

                          isExpanded: true,
                          hint: Text(
                            "Selecione a raça",
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
                          side: BorderSide(width: 2, color: Color(0xB30A3638)),
                        ),
                        icon: Icon(Icons.calendar_month,
                            size: 30, color: Colors.black),
                        label: Text(
                          _dateTime == null
                              ? 'Data de Nascimento'
                              : DateFormat('dd/MM/yy').format(_dateTime!),
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        onPressed: () {
                          showDatePicker(
                            helpText: "Selecione a Data de Nascimento da Vaca",
                            cancelText: "Calcelar",
                            confirmText: "Confirmar",
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3022),
                          ).then((date) {
                            setState(() {
                              _dateTime = date;
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
                          /*if (nome.text.length == 0) {

                            Fluttertoast.showToast(
                                msg: "Insira o nome da vaca",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 15);
                          }*/

                          if(nome.text.isEmpty){
                            setState((){
                              erroNome = "Informe o nome da vaca";
                            });


                            return;
                          }

                          if(numero.text.isEmpty){
                            setState((){
                              erroNumero = "Informe o número da vaca";
                            });

                            return;
                          }
                          if (valor == null){
                            Fluttertoast.showToast(
                                msg: "Selecione a raça",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 15);
                            return;
                          }
                          if (_dateTime == null){
                            Fluttertoast.showToast(
                                msg: "Selecione a data de nascimento",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 15);
                          }
                          else {
                            erroNumero = null;
                            erroNome = null;

                            salvarVaca();

                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => Rebanho()),
                                (Route<dynamic> route) => false);
                          }
                          ;
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

  pegarGaleria() async {
    final PickedFile? imagemTemporaria =
        await imagePicker.getImage(source: ImageSource.gallery);
    if (imagemTemporaria != null) {
      setState(() {
        imagem = File(imagemTemporaria.path);
      });
    }
  }

  pegarCamera() async {
    var imagemTemporaria =
        await imagePicker.getImage(source: ImageSource.camera);

    if (imagemTemporaria != null) {
      setState(() {
        imagem = File(imagemTemporaria.path);
      });
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
                          backgroundColor: Color(0xFF098799),
                          fixedSize: const Size(80, 30),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        pegarCamera();
                        Navigator.pop(context);
                      },
                      child: Text("FOTO")),
                  TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF098799),
                          fixedSize: const Size(80, 30),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
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
}
