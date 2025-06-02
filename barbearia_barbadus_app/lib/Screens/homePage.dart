import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'register_page_produto.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});
  @override
  State<homePage> createState() => _HomePageState();
}

class _HomePageState extends State<homePage> {
  // Lista de produtos
  final List<Map<String, dynamic>> produtos = [
    {
      'nome': 'BIO EXTRATUS',
      'imagem': 'lib/Assets/shampoo.png',
      'descricao': 'Shampoo profissional para tratamento capilar intensivo. Contém extrato de babosa e proteínas de trigo que reparam os fios danificados.',
      'preco': 'R\$ 49,90'
    },
    {
      'nome': 'BIO SAHMPOSS',
      'imagem': 'lib/Assets/shampoo.png',
      'descricao': 'Shampoo profissional para tratamento capilar intensivo. Contém extrato de babosa e proteínas de trigo que reparam os fios danificados.',
      'preco': 'R\$ 49,90'
    },
  ];

  // Exibe os produtos function
  void _showProductDetails(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xFFFCFFFC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Imagem
                Container(
                  height: 200,
                  child: Image.asset(
                    produtos[index]['imagem'],
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                // Nome do produto
                Text(
                  produtos[index]['nome'],
                  style: TextStyle(
                    color: Color(0xFF2F2D2E),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                // Preço
                Text(
                  produtos[index]['preco'],
                  style: TextStyle(
                    color: Color(0xFF2F2D2E),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                // Descrição
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    produtos[index]['descricao'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2F2D2E),
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 25),
                // facha
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2F2D2E),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'FECHAR',
                    style: TextStyle(
                      color: Color(0xFFFCFFFC),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2F2D2E),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => RegisterPageProduto()),
          );
        },
        backgroundColor: Color(0xFF09BC8A),
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Título
            Padding(
              padding: EdgeInsets.only(top: 60, bottom: 20),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'PRODUTOS',
                    style: TextStyle(
                      color: Color(0xFFFCFFFC),
                      fontWeight: FontWeight.bold,
                      fontSize: 45,
                    ),
                  ),
                ),
              ),
            ),

            // Grid de produtos
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
                        // Imagem do produto
                        Container(
                          height: 120,
                          padding: EdgeInsets.all(10),
                          child: Image.asset(
                            produtos[index]['imagem'],
                            fit: BoxFit.contain,
                            width: 100,
                            height: 100,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Nome do produto
                        Text(
                          produtos[index]['nome'],
                          style: TextStyle(
                            color: Color(0xFF2F2D2E),
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 10),
                        // Botão Saiba Mais
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
          ],
        ),
      ),
    );
  }
}