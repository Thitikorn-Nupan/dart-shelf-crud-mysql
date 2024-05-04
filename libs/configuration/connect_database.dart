import 'package:dotenv/dotenv.dart';
import 'package:mysql_client/mysql_client.dart';

import '../log/logging.dart';

/**
  ConnectDatabase class it uses for connect and close connect
  Meaning when you call await initialMysqlConnect()
  You can use MySQLConnection mysql (it works for active to mysql)
*/
class ConnectDatabase {
  var logObj;
  /*
      *************************************************************************
      i found the way for initial attribute at the first time it can be null (no use {?,!})
      using late keyword !!!
      *************************************************************************
   */
  late MySQLConnection mysql;
  late DotEnv env;

  ConnectDatabase(){
    // set log name only because i set console log on main.dart
    logObj = Logging()
    ..setLogName('libs/configuration/connect_database.dart');
    // connect to .env file
    env = DotEnv(includePlatformEnvironment: true)..load(['env/.env']);
  }

  initialMysqlConnect() async {
    // detailConnect (getter) it has be async/await method
    // so when i use i has to use async/await method too
    // **** this method works for creating connect mysql and start connect ****
    mysql = await detailConnect ;
    await mysql.connect();
    logObj.logger.info('connected database');
  }

  destroyMysqlConnect() async {
    // close() is an async/await method too
    // **** this method works for closing connection ****
    await mysql.close();
    logObj.logger.info('closed database');
  }

  /*
   create connection (Type return you do not set it is still ok)
   and do not need to set async/await on this getter
   but when you use this method you have to use on async/await for use it
   (You will see createConnection() what type it returns)
  */
  Future<MySQLConnection> get detailConnect {
    logObj.logger.info('initial creating mysql connection');
    return  MySQLConnection.createConnection(
        host: env['SQLL_HOST'],
        port: int.parse("${env['SQLL_PORT']}"),
        userName: "${env['SQLL_USERNAME']}",
        password: "${env['SQLL_PASSWORD']}",
        databaseName: "${env['SQLL_DATABASE']}" // optional
    );
  }

}

/*
main () async {
  ConnectDatabase connectDatabase = ConnectDatabase();
  await connectDatabase.initialMysqlConnect();
  await connectDatabase.mysql.execute('select * from employees').then((response) => print(response.rows.elementAt(0).assoc())).catchError((error) => print(error));
  await connectDatabase.destroyMysqlConnect();
}*/
