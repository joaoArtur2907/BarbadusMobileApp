  import '../persistance/user_dao.dart';
  import '../model/user.dart';

  class AuthService {
    final UserDao _userDao = UserDao();

    Future<bool> register(User user) async {
      try{
        await _userDao.insertUser(user);
        return true;
      } catch (e) {
        return false;
      }
    }

    Future<User?> login(String email, String senha) async{
      return await _userDao.getUser(email, senha);
    }

    Future<void> criarAdminParaTeste() async {
      final adminExistente = await _userDao.getUser('admin@gmail.com', '12345');
      if (adminExistente == null) {
        final admin = User(
          nome: 'adm',
          email: 'admin@gmail.com',
          senha: '12345',
          isAdmin: true,
        );
        await _userDao.insertUser(admin);
      }
    }



  }

