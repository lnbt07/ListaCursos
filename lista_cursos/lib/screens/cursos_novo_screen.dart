import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_cursos/models/curso_model.dart';
import 'package:lista_cursos/repository/curso_repository.dart';

class CursosNovoScreen extends StatefulWidget {
  @override
  _CursosNovoScreenState createState() => _CursosNovoScreenState();
}

class _CursosNovoScreenState extends State<CursosNovoScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  CursoModel cursoModel = new CursoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(64, 75, 96, .9),
        title: Text("Novo Curso"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.text_fields),
                      hintText: 'Digite o nome do curso',
                      labelText: 'Nome',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Digite o nome do curso';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cursoModel.nome = value;
                    },
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.monetization_on),
                      hintText: '999',
                      labelText: 'Preço',
                    ),
                    validator: (value) {
                      if ((value.isEmpty) || (int.parse(value) <= 0)) {
                        return 'Digite um preço válido!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cursoModel.preco = int.parse(value);
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    decoration: new InputDecoration(
                      icon: const Icon(Icons.flight_takeoff),
                      hintText: '99.99',
                      labelText: 'Percentual de conclusão',
                    ),
                    validator: (value) {
                      if ((value.isEmpty) || (double.parse(value) <= 0)) {
                        return 'Digite um percentual correto!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      var percent = double.parse(value);
                      cursoModel.percentualConclusao = percent / 100;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  TextFormField(
                    maxLines: 5,
                    decoration: new InputDecoration(
                      alignLabelWithHint: true,
                      icon: const Icon(Icons.description),
                      hintText: 'Conteúdo para o curso',
                      labelText: 'Conteúdo',
                    ),
                    validator: (value) {
                      if ((value.isEmpty)) {
                        return 'Digite o conteúdo do curso!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cursoModel.conteudo = value;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                  DropdownButtonFormField<String>(
                    items:
                        ["Básico", "Intermediário", "Avançado", "Especializado"]
                            .map((label) => DropdownMenuItem(
                                  child: Text(label),
                                  value: label,
                                ))
                            .toList(),
                    decoration: new InputDecoration(
                      alignLabelWithHint: true,
                      icon: const Icon(Icons.score),
                      hintText: 'Selecione o nível',
                      labelText: 'Nível',
                    ),
                    validator: (value) {
                      if ((value == null)) {
                        return 'Selecione o nível do curso!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      cursoModel.nivel = value;
                    },
                    onChanged: (value) {
                      cursoModel.nivel = value;
                    },
                  ),

                  
                  



                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RaisedButton(
                      child: Text("Gravar"),
                      onPressed: () {

                        if (formKey.currentState.validate()) {
                          formKey.currentState.save();
                          //new CursoRepository().Insert(cursoModel);

                          var mensagem = cursoModel.nome + ' cadastrado com sucesso!'; 

                          Navigator.pop(
                            context,
                            mensagem,
                          );

                        } else {
                          scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                'Não foi possível gravar o curso.',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
