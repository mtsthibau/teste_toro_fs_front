import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/Ativo.dart';
import 'model/Conta.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste Toro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Cotações'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class AtivosList {
  final List<Ativo> ativos;

  AtivosList({
    this.ativos,
  });
}



Future<List<Ativo>> loadAtivos() async{

  createAccount();

  final response = await http.get('http://192.168.5.38:3333/ativos');

  if (response.statusCode == 200) {
    List responseJson = json.decode(response.body);
    return responseJson.map((i) => new Ativo.fromJson(i)).toList();
  } else {
    throw Exception('Falha ao obter ativos');
  }
}

Future<Conta> createAccount() async{

  Map data = {
    'saldo': 0.01,
    'ativos':[]
  };

  final response = await
  http.post('http://192.168.5.38:3333/cadastro',
    headers: {"Content-Type": "application/json"},
    body: json.encode(data),
  );

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    return new Conta.fromJson(jsonResponse);
  } else {
    throw Exception('Falha ao cadastrar conta');
  }
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List<Ativo>> ativos;

  @override
  void initState() {
    super.initState();
    ativos = loadAtivos();
    print(ativos);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),

      ),
      body: Center(
        child: FutureBuilder<List<Ativo>>(
          future: ativos,
          builder: (context, snapshot) {
            List<Ativo> ativosObj = snapshot.data ?? [];
            return ListView.builder(
                itemCount: ativosObj.length,
                itemBuilder: (context, index) {
                  Ativo ativoObj = ativosObj[index];
                  return new ListTile(
                    title: new Text(ativoObj.nome),
                    trailing: new Text(ativoObj.valor.toString()),
                    onTap: () {
                      //Navigator.push(context,
                          //new MaterialPageRoute(builder: (context) => new MyHomePage()));
                    },
                  );
                });
          },
        ),
    )
    );
  }
}
