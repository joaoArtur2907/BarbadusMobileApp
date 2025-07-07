import 'package:barbearia_barbadus_app/persistance/compra_dao.dart';
import '../model/compra.dart';

class CompraService {
  final CompraDao _compraDao = CompraDao();

  Future<void> registrarCompra(Compra compra) async {
    await _compraDao.inserirCompra(compra);
  }

  Future<List<Compra>> listarCompras() async {
    return await _compraDao.listarCompras();
  }
}
