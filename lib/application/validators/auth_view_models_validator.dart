import 'package:lucid_validation/lucid_validation.dart';
import 'package:reze_melhor/application/view_models/auth_view_models.dart';

class LoginWithEmailVmValidator extends LucidValidator<LoginWithEmailVm> {
  LoginWithEmailVmValidator() {
    ruleFor((x) => x.email, key: "email")
        .notEmpty(message: "O email não pode ser vazio.")
        .validEmail(message: "O email não é válido.");

    ruleFor((x) => x.password, key: 'password')
        .notEmpty()
        .minLength(8, message: 'A senha precisa ter, pelo menos, 8 caracteres.')
        .mustHaveLowercase(
          message: "A senha precisa ter, pelo menos, uma letra maiúscula.",
        )
        .mustHaveUppercase(
          message: "A senha precisa ter, pelo menos, uma letra minúscula.",
        );
  }
}

class CreateAccountVmValidator extends LucidValidator<CreateAccountVm> {
  CreateAccountVmValidator() {
    ruleFor((x) => x.nome, key: "nome")
        .notEmpty(message: "O nome não pode ficar vazio.")
        .minLength(3, message: "O nome precisa ter pelo menos, 3 caracteres.");

    ruleFor((x) => x.email, key: "email")
        .notEmpty(message: "O email não pode ser vazio.")
        .validEmail(message: "O email não é válido.");

    ruleFor((x) => x.password, key: 'password')
        .notEmpty()
        .minLength(8, message: 'A senha precisa ter, pelo menos, 8 caracteres.')
        .mustHaveLowercase(
          message: "A senha precisa ter, pelo menos, uma letra maiúscula.",
        )
        .mustHaveUppercase(
          message: "A senha precisa ter, pelo menos, uma letra minúscula.",
        );

    ruleFor(
      (x) => x.confirmPassword,
      key: "confirmPassword",
    ).equalTo((x) => x.password, message: "As senhas não são iguais.");
  }
}

class UpdateProfilePictureVmValidator
    extends LucidValidator<UpdateProfilePictureVm> {
  UpdateProfilePictureVmValidator() {
    ruleFor((x) => x.userEmail, key: "email").notEmpty().validEmail();

    ruleFor((x) => x.pathRef, key: "pathRef").notEmpty();

    ruleFor((x) => x.profilePicture, key: "profilePic").isNotNull();
  }
}
