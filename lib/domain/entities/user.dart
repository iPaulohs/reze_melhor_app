import 'package:objectbox/objectbox.dart';

@Entity()
class UserEntity {
  UserEntity({
    required this.provedorUid,
    required this.name,
    required this.surname,
    required this.email,
    required this.provedorAutenticacao,
    required this.sexo,
  });

  @Id() 
  int id = 0;

  final String? surname;
  final String email;
  final String name;
  final String provedorUid;
  final String provedorAutenticacao;
  final String? sexo;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'provedorUid': provedorUid,
      'provedorAutenticacao': provedorAutenticacao,
      'sexo': sexo,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      name: map['nome'],
      surname: map['surname'],
      email: map['email'],
      provedorUid: map['provedorId'],
      provedorAutenticacao: map['provedorAutenticacao'],
      sexo: map['sexo'],
    );
  }
}

