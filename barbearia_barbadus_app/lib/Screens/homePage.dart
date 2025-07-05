import 'package:flutter/material.dart';
import 'package:barbearia_barbadus_app/model/produto.dart';
import 'package:barbearia_barbadus_app/model/user.dart';
import 'package:barbearia_barbadus_app/model/carrinho_item.dart';
import 'package:barbearia_barbadus_app/Screens/register_page_produto.dart';
import 'package:barbearia_barbadus_app/Screens/loginPage.dart';
import 'package:barbearia_barbadus_app/Screens/CarrinhoPage.dart';
import 'package:barbearia_barbadus_app/Service/produto_service.dart';

class homePage extends StatefulWidget {
  final User user;
  const homePage({super.key, required this.user});

  @override
  State<homePage> createState() => _HomePageState();
}

class _HomePageState extends State<homePage> {
  final ProdutoService _produtoService = ProdutoService();
  List<Produto> produtos = [];
  List<CarrinhoItem> carrinho = [];

  @override
  void initState() {
    super.initState();
    loadProdutos();
  }

  Future<void> loadProdutos() async {
    final lista = await _produtoService.getProdutos();
    setState(() {
      produtos = lista;
    });
  }

  void _deleteProduto(int id) async {
    await _produtoService.deleteProduto(id);
    await loadProdutos();
  }

  void _editarProduto(Produto produto) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPageProduto(produtoEdit: produto),
      ),
    );
    await loadProdutos();
  }

  void _showProductDetails(BuildContext context, int index) {
    final produto = produtos[index];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFFCFFFC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  produto.imagem,
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported),
                ),
                SizedBox(height: 20),
                Text(
                  produto.nome,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2F2D2E)),
                ),
                Text(
                  'R\$ ${produto.preco.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(produto.descricao),
                ),
                if (widget.user.isAdmin)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _editarProduto(produto),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          foregroundColor: Colors.black,
                        ),
                        child: Text('Editar'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _deleteProduto(produto.id!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: Text('Excluir'),
                      ),
                    ],
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final existente = carrinho.firstWhere(
                              (item) => item.produto.id == produto.id,
                          orElse: () => CarrinhoItem(produto: produto, quantidade: 0),
                        );

                        if (existente.quantidade == 0) {
                          carrinho.add(CarrinhoItem(produto: produto));
                        } else {
                          existente.quantidade++;
                        }
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Adicionado ao carrinho')),
                      );
                    },
                    child: Text('Adicionar ao Carrinho'),
                  ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2F2D2E)),
                  child: Text('Fechar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _logoff() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2D2E),
      floatingActionButton: widget.user.isAdmin
          ? FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPageProduto()),
          );
          await loadProdutos();
        },
        backgroundColor: Color(0xFF09BC8A),
        child: Icon(Icons.add, color: Colors.white),
      )
          : null,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 60, bottom: 20),
                  child: Text(
                    'PRODUTOS',
                    style: TextStyle(
                      color: Color(0xFFFCFFFC),
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    final produto = produtos[index];
                    return GestureDetector(
                      onTap: () => _showProductDetails(context, index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFCFFFC),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 100,
                              padding: EdgeInsets.all(10),
                              child: Image.network(
                                produto.imagem,
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              produto.nome,
                              style: TextStyle(fontSize: 18, color: Color(0xFF2F2D2E)),
                            ),
                            TextButton(
                              onPressed: () => _showProductDetails(context, index),
                              child: Text(
                                'SAIBA MAIS',
                                style: TextStyle(
                                  color: Color(0xFF2F2D2E),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 90),
              ],
            ),
          ),
          if (!widget.user.isAdmin)
            Positioned(
              right: 10,
              bottom: 80,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF09BC8A),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CarrinhoPage(carrinho: carrinho),
                    ),
                  );
                },
                child: Icon(Icons.shopping_cart),
              ),
            ),
          Positioned(
            right: 10,
            top: 40,
            child: IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: _logoff,
            ),
          ),
        ],
      ),
    );
  }
}
