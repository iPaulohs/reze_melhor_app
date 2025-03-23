import 'dart:convert';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:reze_melhor/application/services/obj_box_service.dart';
import 'package:reze_melhor/domain/entities/biblia.dart';
import 'package:reze_melhor/objectbox.g.dart';

class LoadBiblia {
  final objectBoxService = Get.find<ObjectBoxService>();

  Future<void> salvarJsonNoStore(String jsonString) async {
    try {
      final Map<String, dynamic> bibliaMap = jsonDecode(jsonString);
      final boxBiblia = objectBoxService.bibliaBox;
      final boxTestamento = objectBoxService.testamentoBox;
      final boxLivro = objectBoxService.livroBox;
      final boxCapitulo = objectBoxService.capituloBox;
      final boxVersiculo = objectBoxService.versiculoBox;

      for (var testamentoName in bibliaMap.keys) {
        final testamento = Testamento(nome: testamentoName);

        for (var livroName in bibliaMap[testamentoName].keys) {
          final livroData = bibliaMap[testamentoName][livroName];
          final livro = Livro(nome: livroName);

          final capituloList = <Capitulo>[];

          for (var capituloData in livroData) {
            final capitulo = Capitulo(numero: capituloData["capitulo"]);

            final versiculosList = <Versiculo>[];

            for (var versiculoData in capituloData["versiculos"]) {
              final versiculo = Versiculo(
                numero: versiculoData["numero"],
                conteudo: versiculoData["texto"],
              );
              versiculosList.add(versiculo);
            }

            boxVersiculo.putMany(versiculosList);
            capitulo.versiculos.addAll(versiculosList);
            capituloList.add(capitulo);
          }

          livro.capitulos.addAll(capituloList);
          boxCapitulo.putMany(capituloList);
          boxLivro.put(livro);

          testamento.livros.add(livro);
        }

        final biblia = boxBiblia.query(Biblia_.id.equals(0)).build().findFirst(); 
        if (biblia == null) {
          final novoBiblia = Biblia();
          if (testamentoName == "Antigo") {
            novoBiblia.velhoTestamento.target = testamento;
          } else if (testamentoName == "Novo") {
            novoBiblia.novoTestamento.target = testamento;
          }
          boxBiblia.put(novoBiblia);
        } else {
          if (testamentoName == "Antigo") {
            biblia.velhoTestamento.target = testamento;
          } else if (testamentoName == "Novo") {
            biblia.novoTestamento.target = testamento;
          }
          boxBiblia.put(biblia);
        }

        boxTestamento.put(testamento);
      }

      // Verificação
      Logger().i("Registros no Testamento: ${boxTestamento.count()}");
      Logger().i("Registros no Livro: ${boxLivro.count()}");
      Logger().i("Registros no Capítulo: ${boxCapitulo.count()}");
      Logger().i("Registros no Versículo: ${boxVersiculo.count()}");
      Logger().i("Bíblia salva com sucesso!");
    } catch (e) {
      Logger().e("Erro ao salvar Bíblia: $e");
    }
  }
}
