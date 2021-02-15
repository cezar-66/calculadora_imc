import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  String textInfo = "Informe seus dados";

  void _resetFields() {
    setState(() {
      pesoController.text = "";
      alturaController.text = "";
      textInfo = "Informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double peso = double.parse(pesoController.text);
      double altura = double.parse(alturaController.text) / 100;
      //Peso divido pela altura ao quadrado
      double imc = peso / (altura * altura);

      if (imc < 18.6) {
        textInfo = "Abaixo do Peso (${imc.toStringAsPrecision(4)})";
      } else if (imc > 18.6 && imc < 24.9) {
        textInfo = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if (imc > 24.9 && imc < 29.9) {
        textInfo = "Levemente acima do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc > 29.9 && imc < 34.9) {
        textInfo = "Obesidade Grau I (${imc.toStringAsPrecision(4)})";
      } else if (imc > 34.9 && imc < 39.9) {
        textInfo = "Obesidade Grau II (${imc.toStringAsPrecision(4)})";
      } else if (imc >= 40) {
        textInfo = "Obesidade Grau III (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                _resetFields();
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.person,
                  size: 120,
                  color: Colors.green,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(
                        color: Colors.green,
                      )),
                  controller: pesoController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu Peso";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(
                        color: Colors.green,
                      )),
                  controller: alturaController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira Sua Altura";
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: () {
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  textInfo,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25.0),
                ),
              ],
            ),
          ),
        ));
  }
}
