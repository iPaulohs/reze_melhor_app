import 'dart:io';

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
    required this.email,
    required this.password,
  });

  final String nome;
  final String sobrenome;
  final String email;
  final String password;
  final String confirmPassword;
}

class UpdateProfilePictureVm {
  UpdateProfilePictureVm({
    required this.profilePicture,
    required this.pathRef,
    required this.userEmail,
  });

  final File profilePicture;
  final String userEmail;
  final String pathRef;
}
