import 'package:mysql_client/exception.dart';
import 'package:mysql_client/mysql_client.dart';
import '../configuration/connect_database.dart';
import '../entity/employee.dart';
import '../log/logging.dart';
import '../repository/entity_repo.dart';

part 'sql/command.dart';

/**
    DaoService class it uses for connect and close connect and crud employee table
    Meaning when you call await initialMysqlConnect()
    You can use create,reads,...,delete
 */
class DaoService implements EntityRepo<Employee> {

  late ConnectDatabase connectDatabase;
  late MySQLConnection mysql;
  var logObj;

  DaoService() {
    // *** remember you set up on console log only one!! (Whatever class you want to set)
    connectDatabase = ConnectDatabase();
    logObj = Logging()..setLogName('libs/service/dao_service.dart');
  }

  /*
    Not clear why on employee_service.dart
    can use and work
    it is not using on async/await method
  */
  Future<void> initialMysqlConnect() async {
    // *** line 32 works meaning connectDatabase.mysql (attribute) it is already to use
    await connectDatabase.initialMysqlConnect();
    mysql = await connectDatabase.mysql;
  }

  Future<void> destroyMysqlConnect() async {
    // *** if method it works good, mysql (attribute) can't work
    await connectDatabase.destroyMysqlConnect();
  }

  @override
  Future<Employee> read(String pk) async {
    logObj.logger.info('you called read(pk) async method');
    IResultSet result = await mysql.execute(Command.READ, {'eid': pk});
    // result.rows.elementAt(0).assoc(); // {name: Apple, color: Red, taste: Sweet, price: 299.99}
    if (result.rows.isEmpty) {
      return new Employee('', '', '', '', false, 0.0);
    }
    late Employee employee;
    result.rows.forEach((element) {
      // logObj.logger.info(element.assoc());
      employee = Employee(
          element.colByName('eid').toString(),
          element.colByName('firstname').toString(),
          element.colByName('lastname').toString(),
          element.colByName('position').toString(),
          element.colByName('active').toString() == 1, // if == 1 return ture
          double.parse(element.colByName('salary').toString()));
    });
    // logObj.logger.info(employees);
    return employee;
  }

  @override
  Future<List<Employee>> reads() async {
    logObj.logger.info('you called reads() async method');
    IResultSet result = await mysql.execute(Command.READS);
    List<Employee> employees = [];
    result.rows.forEach((element) {
      // logObj.logger.info(element.assoc());
      employees.add(Employee(
          element.colByName('eid').toString(),
          element.colByName('firstname').toString(),
          element.colByName('lastname').toString(),
          element.colByName('position').toString(),
          element.colByName('active').toString() == 1, // if == 1 return ture
          double.parse(element.colByName('salary').toString())));
    });
    // logObj.logger.info(employees);
    return employees;
  }

  @override
  Future<bool> create(Employee obj) async {
    logObj.logger.info('you called create(employee) async method');
    try {
      await mysql.execute(Command.CREATE, {
        "eid": obj.eid,
        "firstname": obj.firstname,
        "lastname": obj.lastname,
        "position": obj.position,
        "active": obj.active,
        "salary": obj.salary
      });
    } on MySQLServerException catch (e) {
      logObj.logger.info('catch error on create(employee) : ${e.message}');
      return false;
    }
    return true;
  }

  @override
  Future<bool> delete(String pk)async {
    logObj.logger.info('you called delete(pk) async method');
    IResultSet result = await mysql.execute(Command.DELETE, {'eid': pk});
    logObj.logger.info('result.affectedRows.toInt() stores ${result.affectedRows.toInt()}');
    if (result.affectedRows.toInt() > 0) {
      return true;
    }
    return false;
  }

  @override
  Future<bool> update(Employee obj, String pk) async {
    logObj.logger.info('you called update(employee,pk) method async');
    IResultSet result = await mysql.execute(Command.UPDATE, {
      "eid": pk,
      "firstname": obj.firstname,
      "lastname": obj.lastname,
      "position": obj.position,
      "active": obj.active,
      "salary": obj.salary
    });
    if (result.affectedRows.toInt() >= 1) {
      return true;
    }
    return false;
  }


}

/*
main()  async{
  DaoService daoService = DaoService();
  await daoService.initialMysqlConnect();
  daoService.logObj.logger.info(await daoService.read('E002'));
  await daoService.destroyMysqlConnect();
  // print(await daoService.reads());
}*/
