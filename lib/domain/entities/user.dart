import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  User({
    required this.uid,
    required this.provedorUid,
    required this.name,
    required this.surname,
    required this.email,
    required this.provedorAutenticacao,
    required this.sexo,
    required this.provedorId
  });

  @Id() 
  int id = 0;

  final String uid;
  final String provedorId;
  final String? surname;
  final String email;
  final String name;
  final String provedorUid;
  final String provedorAutenticacao;
  final String? sexo;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'surname': surname,
      'email': email,
      'provedorIf': provedorUid,
      'provedorAutenticacao': provedorAutenticacao,
      'sexo': sexo
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'],
      name: map['nome'],
      surname: map['surname'],
      email: map['email'],
      provedorUid: map['provedorId'],
      provedorAutenticacao: map['provedorAutenticacao'],
      sexo: map['sexo'],
      provedorId: map["provedorId"]
    );
  }
}

