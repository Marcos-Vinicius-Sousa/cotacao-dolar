import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert' as convert;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

 String _precoDolar = "";
 TextEditingController _dolar = TextEditingController();

  get jsonReponse => null;

void _recuperarPreco() async {

  var url = Uri.https("economia.awesomeapi.com.br/", "json/USD" , {'bid':'{http}'});

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    var dolar = jsonResponse['bid'];
    print('Number of books about http: $dolar.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }

  setState(() {
    _dolar = jsonReponse["bid"];
  });

  print("Resultado: "+ _dolar.toString());}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("imagem/dolar.jpg"),
              fit: BoxFit.cover
          )
        ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(16),
              child: Text("Cotação",
              style: TextStyle(
                fontSize: 50,
                color: Colors.red,
                fontWeight: FontWeight.bold
              ),),),

              Padding(padding: EdgeInsets.symmetric(horizontal: 85, vertical: 5),
                    child: TextFormField(
                        autofocus: false,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10,15,10,15),
                            hintText: "Digite o valor em Real",
                            prefixIcon: Icon(Icons.attach_money),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)))
                    ),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 85, vertical: 5),
                child: TextFormField(
                    autofocus: false,
                    controller: _dolar,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10,15,10,15),
                        hintText: "Digite o valor em Real",
                        prefixIcon: Icon(Icons.attach_money),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)))
                ),
              ),
              Container(
                width: 250,
                height: 45,
                padding: EdgeInsets.symmetric( horizontal:10),
                child: ElevatedButton(
                  child: Text("Calcular", style: TextStyle(
                      fontSize: 20
                  ),),

                  onPressed: () {
                    _recuperarPreco();
                  },

                ),
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}
