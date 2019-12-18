import 'dart:ffi';

import 'package:teste_toro_full_stack_frontend/model/Ativo.dart';

class Conta {
  final String id;
  final double saldo;
  final List<Ativo> ativos;

  Conta({
    this.id,
    this.saldo,
    this.ativos
  });

  factory Conta.fromJson(Map<String, dynamic> json){
    return Conta(
      id: json['id'],
      saldo: json['saldo'],
      ativos: json['ativos']
    );
  }
}