class User {
  final int? id;
  final String nome;
  final String email;
  final String senha;
  final bool isAdmin;

  User({
    this.id,
    required this.nome,
    required this.email,
    required this.senha,
    this.isAdmin = false, // valor padrão
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'senha': senha,
      'isAdmin': isAdmin ? 1 : 0, //  bool no banco vira int
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      isAdmin: map['isAdmin'] == 1,
    );
  }
}
