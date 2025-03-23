import 'package:objectbox/objectbox.dart';

@Entity()
class Biblia {
     Biblia();

    @Id()  int id = 0;
    final velhoTestamento = ToOne<Testamento>();
    final novoTestamento = ToOne<Testamento>();
}

@Entity()
class Testamento {
    Testamento({required this.nome});

    @Id() int id = 0;
    String nome;
    final livros = ToMany<Livro>();
}

@Entity()
class Livro {
    Livro({required this.nome});

    @Id() int id = 0;
    String nome;
    final capitulos = ToMany<Capitulo>();
}

@Entity()
class Capitulo {
    Capitulo({required this.numero});
    
    @Id() int id = 0;
    final int numero;
    final versiculos = ToMany<Versiculo>();
}

@Entity()
class Versiculo {
    Versiculo({required this.numero, required this.conteudo});

    @Id() int id = 0;
    int numero;
    String conteudo;
}

