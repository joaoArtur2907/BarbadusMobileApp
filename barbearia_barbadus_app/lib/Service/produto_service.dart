import '../persistance/produto_dao.dart';
import '../model/produto.dart';

class ProdutoService {
  final ProdutoDao _produtoDao = ProdutoDao();

  Future<bool> registerProduto(Produto produto) async {
    try {
      await _produtoDao.insertProduto(produto);
      return true;
    } catch (e) {
      print('Erro ao registrar produto: $e');
      return false;
    }
  }

  Future<List<Produto>> getProdutos() async {
    return await _produtoDao.getAllProdutos();
  }
}