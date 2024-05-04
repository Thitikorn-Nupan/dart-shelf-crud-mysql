abstract class EntityRepo<T> {
  Future<List<T>> reads();
  Future<T> read(String pk);
  Future<bool> create(T obj);
  Future<bool> delete(String pk);
  Future<bool> update(T obj,String pk);
  /*
     no need to set Future type because both method it is no return
     both methods below it works the same thing on connect_database.dart
  */
  // if you want to set return type you can
  Future<void> initialMysqlConnect();
  Future<void> destroyMysqlConnect();
}

/*
main() async {
  EntityRepo<Employee> entityRepo = DaoService();
  await entityRepo.initialMysqlConnect();
  List<Employee> employees = await entityRepo.reads();
  print(employees);
  await entityRepo.destroyMysqlConnect();
}*/
