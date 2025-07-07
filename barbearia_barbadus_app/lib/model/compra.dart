class Compra {
  final int? id;
  final String nomeComprador;
  final String endereco;
  final double total;

  Compra({
    this.id,
    required this.nomeComprador,
    required this.endereco,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomeComprador': nomeComprador,
      'endereco': endereco,
      'total': total,
    };
  }

  factory Compra.fromMap(Map<String, dynamic> map) {
    return Compra(
      id: map['id'],
      nomeComprador: map['nomeComprador'],
      endereco: map['endereco'],
      total: map['total'],
    );
  }
}
