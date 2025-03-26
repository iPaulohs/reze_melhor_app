import 'package:objectbox/objectbox.dart';

@Entity()
class Oracao {
  Oracao({
    required this.uid,
    required this.titulo,
    required this.subtitulo,
    required this.conteudo,
  });

  @Id()
  int id = 0;
  final String uid;
  final String titulo;
  final String? subtitulo;
  final String conteudo;
}
