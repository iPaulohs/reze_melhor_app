class LoginWithEmailVm {
  LoginWithEmailVm({required this.email, required this.password});

  final String email;
  final String password;
}

class CreateAccountVm {
  CreateAccountVm({
    required this.nome,
    required this.sobrenome,
    required this.confirmPassword,
    required this.password,
    required this.email,
    required this.sexo
  });

  final String nome;
  final String sobrenome;
  final String email;
  final String password;
  final String confirmPassword;
  final String sexo;
}
