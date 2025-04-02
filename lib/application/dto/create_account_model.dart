class CreateAccountModel {
  CreateAccountModel({
    required this.nome,
    required this.email,
    required this.senha,
    required this.sexo,
    required this.confirmacaoSenha,
    required this.username,
    required this.sobrenome,
  });

  final String nome;
  final String sobrenome;
  final String sexo;
  final String email;
  final String senha;
  final String confirmacaoSenha;
  final String username;
}
