class CompraItem {
  final int? id;
  final int compraId;
  final String produtoNome;
  final int quantidade;
  final double precoUnitario;

  CompraItem({
    this.id,
    required this.compraId,
    required this.produtoNome,
    required this.quantidade,
    required this.precoUnitario,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'compra_id': compraId,
      'produto_nome': produtoNome,
      'quantidade': quantidade,
      'preco_unitario': precoUnitario,
    };
  }

  factory CompraItem.fromMap(Map<String, dynamic> map) {
    return CompraItem(
      id: map['id'],
      compraId: map['compra_id'],
      produtoNome: map['produto_nome'],
      quantidade: map['quantidade'],
      precoUnitario: map['preco_unitario'],
    );
  }
}
