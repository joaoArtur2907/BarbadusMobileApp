import 'dart:ffi';

class Produto {
  final int? id;
  final String nome;
  final String imagem;
  final String descricao;
  final Double preco;

  Produto({
    this.id,
    required this.nome,
    required this.imagem,
    required this.descricao,
    required this.preco,
});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'imagem': imagem,
      'descricao': descricao,
      'preco': preco
    };
  }

  factory Produto.fromMap(Map<String, dynamic> map){
    return Produto(
      id: map['id'],
      nome: map['nome'],
      imagem: map['imagem'],
      descricao: map['descricao'],
      preco: map['preco'],
    );
  }

}