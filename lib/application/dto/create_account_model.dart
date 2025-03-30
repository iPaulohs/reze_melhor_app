import 'dart:io';

class CreateAccountModel {
  CreateAccountModel({
    required this.nome,
    required this.email,
    required this.senha,
    this.sexo,
    required this.confirmacaoSenha,
    required this.username,
    this.sobrenome,
    this.fotoPerfil,
  });

  final String nome;
  final String? sobrenome;
  final String? sexo;
  final String email;
  final String senha;
  final String confirmacaoSenha;
  final String username;
  final File? fotoPerfil;
}
