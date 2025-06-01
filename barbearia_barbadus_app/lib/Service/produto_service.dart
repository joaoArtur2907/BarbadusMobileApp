import '../persistance/produto_dao.dart';
import '../model/produto.dart';

class ProdutoService {
  final ProdutoDao _produtoDao = ProdutoDao();

  Future<int> addProduto(Produto produto) async {
    return await _produtoDao.insertProduto(produto);
  }

  Future<List<Produto>> getProdutos() async {
    return await _produtoDao.getAllProdutos();
  }

}