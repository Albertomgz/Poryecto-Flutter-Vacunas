import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '127.0.0.1',
      user = 'root',
      password = '123456',
      db = 'pbdvacuna';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);

    return await MySqlConnection.connect(settings);
  }
}
