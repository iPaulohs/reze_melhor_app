import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:reze_melhor/application/services/object_box_service.dart';
import 'package:reze_melhor/domain/entities/biblia.dart';
import 'package:reze_melhor/objectbox.g.dart';

class LoadBiblia {
  final objectBoxService = Get.find<ObjectBoxService>();

  Future<void> carregarEBaixarBiblia() async {
    try {
      final jsonString = await baixarJsonDaBiblia();
      if (jsonString != null) {
        await salvarJsonNoStore(jsonString);
      } else {
        Logger().e("JSON da Bíblia está nulo");
      }
    } catch (e) {
      Logger().e("Erro geral ao carregar Bíblia: $e");
    }
  }

  Future<String?> baixarJsonDaBiblia() async {
    try {
      final ref = FirebaseStorage.instance.ref("arquivos/biblia.json");
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/biblia.json');

      await ref.writeToFile(file);
      return await file.readAsString();
    } on FirebaseException catch (e) {
      Logger().e("Erro ao baixar arquivo do Firebase: ${e.message}");
      return null;
    }
  }

  Future<void> salvarJsonNoStore(String jsonString) async {
    try {
      final parsedData = await compute(parseBible, jsonString);

      final store = objectBoxService.store;
      final boxBiblia = Box<Biblia>(store);
      final boxTestamento = Box<Testamento>(store);
      final boxLivro = Box<Livro>(store);
      final boxCapitulo = Box<Capitulo>(store);
      final boxVersiculo = Box<Versiculo>(store);

      final bibliaExistente = boxBiblia.query(Biblia_.id.equals(0)).build().findFirst();
      final novaBiblia = bibliaExistente ?? Biblia();

      for (var testamento in parsedData) {
        boxTestamento.put(testamento);

        for (var livro in testamento.livros) {
          boxLivro.put(livro);
          boxCapitulo.putMany(livro.capitulos);

          for (var capitulo in livro.capitulos) {
            boxVersiculo.putMany(capitulo.versiculos);
          }
        }

        if (testamento.nome == "Antigo") {
          novaBiblia.velhoTestamento.target = testamento;
        } else if (testamento.nome == "Novo") {
          novaBiblia.novoTestamento.target = testamento;
        }
      }

      boxBiblia.put(novaBiblia);

      Logger().i("Bíblia salva com sucesso!");
    } catch (e) {
      Logger().e("Erro ao salvar Bíblia: $e");
    }
  }
}

List<Testamento> parseBible(String jsonString) {
  final Map<String, dynamic> bibliaMap = jsonDecode(jsonString);
  final List<Testamento> testamentos = [];

  for (var testamentoName in bibliaMap.keys) {
    final testamento = Testamento(nome: testamentoName);
    final livros = <Livro>[];

    for (var livroName in bibliaMap[testamentoName].keys) {
      final livroData = bibliaMap[testamentoName][livroName];
      final livro = Livro(nome: livroName);
      final capitulos = <Capitulo>[];

      for (var capituloData in livroData) {
        final capitulo = Capitulo(numero: capituloData["capitulo"]);
        final versiculos = <Versiculo>[];

        for (var versiculoData in capituloData["versiculos"]) {
          versiculos.add(
            Versiculo(
              numero: versiculoData["numero"],
              conteudo: versiculoData["texto"],
            ),
          );
        }

        capitulo.versiculos.addAll(versiculos);
        capitulos.add(capitulo);
      }

      livro.capitulos.addAll(capitulos);
      livros.add(livro);
    }

    testamento.livros.addAll(livros);
    testamentos.add(testamento);
  }

  return testamentos;
}
