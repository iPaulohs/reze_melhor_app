import 'package:reze_melhor/domain/entities/biblia.dart';
import 'package:reze_melhor/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxService {
  late final Store _store;
  
Future<void> initialize() async {
  final appDir = await getApplicationDocumentsDirectory();
  final path = '${appDir.path}/objectbox';
  _store = await openStore(directory: path);
}
  
  Store get store => _store;
  Box<Versiculo> get versiculoBox => _store.box<Versiculo>();
  Box<Biblia> get bibliaBox => _store.box<Biblia>();
  Box<Testamento> get testamentoBox => _store.box<Testamento>();
  Box<Capitulo> get capituloBox => _store.box<Capitulo>();
  Box<Livro> get livroBox => _store.box<Livro>();
}