import 'package:objectbox/objectbox.dart';

@Entity()
class Novena {
  Novena({required this.uid, required this.titulo, required this.subtitulo});

  @Id()
  int id = 0;
  final String uid;
  final String titulo;
  final String subtitulo;
  final dias = ToMany<DiaNovena>();
}

@Entity()
class DiaNovena {
  DiaNovena({required this.uid, required this.diaNovena, required this.conteudo});

  @Id()
  int id = 0;
  final String uid;
  final int diaNovena;
  final String conteudo;
}
