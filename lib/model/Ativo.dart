import 'dart:ffi';

class Ativo {
  //final int id;
  final String nome;
  final double valor;

  Ativo({
    //this.id,
    this.nome,
    this.valor
  });

  factory Ativo.fromJson(Map<String, dynamic> json){
    return new Ativo(
        nome: json['nome'],
        valor: json['valor']
    );
  }
}