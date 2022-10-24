import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:untitled2/modelo/Vaca.dart';
import 'package:untitled2/pages/Dados.dart';
import 'package:untitled2/pages/dadosVaca.dart';
import 'package:untitled2/utils/AjudaVaca.dart';
import 'cadastro_vaca.dart';
import 'editar_vaca.dart';

class Rebanho extends StatefulWidget {
  const Rebanho({Key? key}) : super(key: key);

  @override
  State<Rebanho> createState() => _RebanhoState();
}

class _RebanhoState extends State<Rebanho> {
  DateTime? _dateTime;
  ImagePicker imagePicker = ImagePicker();
  TextEditingController nome = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController data = TextEditingController();
  File? imagemGaleria;
  File? imagemCamera;

  AjudaVaca v = AjudaVaca();
  List<Vaca> vacas = <Vaca>[];


  AjudaVaca _db = AjudaVaca();

  mostraVaca() async {
    List vacasRec = await v.listarVacas();

    print(vacasRec);
    List<Vaca> vTemp = <Vaca>[];

    for (var x in vacasRec) {
      Vaca vac = Vaca.deMapParaModel(x);

      vTemp.add(vac);
    }
    setState(() {
      vacas = vTemp;

      print(vTemp);
    });
  }




  void removerVaca(String vaca) async {
    await _db.excluirVaca(vaca);
    mostraVaca();
  }

  void exibirTelaConf(String vaca) {
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
                    removerVaca(vaca);

                    Navigator.pop(context);
                  },
                  child: Text("Sim"))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    mostraVaca();

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
            'Rebanho',
            style: TextStyle(fontSize: 45
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: vacas.length,
                itemBuilder: (context, index) {
                  final Vaca objVaca = vacas[index];

                  return Card(
                    child: ListTile(
                        onTap: () {
                          Dados.vacas.clear();
                          Dados.vacas.add(objVaca);


                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DadosVaca()));
                        },
                        visualDensity: VisualDensity.standard,
                        title: Text(
                          "${objVaca.nome}",
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text("N°: ${objVaca.numero}",
                            style: TextStyle(fontSize: 17)),
                        leading: Stack(
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xB30A3638),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                    File(objVaca.imagem),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () {
                                Dados.vacasEdit.clear();
                                Dados.vacasEdit.add(objVaca);
                  Navigator.push(
                  context, MaterialPageRoute(builder: (context) => EditarVaca()));
                  },

                              icon: Icon(Icons.edit_note_sharp,
                                  size: 30, color: Color(0xFF1C4A50)),
                            ),
                            IconButton(
                              onPressed: () {
                                exibirTelaConf(objVaca.nome);
                              },
                              icon: Icon(Icons.delete,
                                  size: 25, color: Color(0xFFE34D43)),
                            ),
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CadastroVaca()));
        },
        label: const Icon(
          Icons.add,
          size: 30,
        ),
        backgroundColor: Color(0xFF098799),
      ),
    );
  }


  pegarCamera() async {
    var imagemTemporaria =
        await imagePicker.getImage(source: ImageSource.camera);

    if (imagemTemporaria != null) {
      setState(() {
        imagemCamera = File(imagemTemporaria.path);
      });
    }
  }
}
