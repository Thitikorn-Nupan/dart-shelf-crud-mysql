// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$EmployeeServiceRouter(EmployeeService service) {
  final router = Router();
  router.add(
    'GET',
    r'/destroy-connect',
    service.destroyMysqlConnect,
  );
  router.add(
    'GET',
    r'/reads',
    service.retrieveAllEmployees,
  );
  router.add(
    'GET',
    r'/read/<eid>',
    service.retrieveEmployee,
  );
  router.add(
    'POST',
    r'/create',
    service.addEmployee,
  );
  router.add(
    'PUT',
    r'/update/<eid>',
    service.editEmployee,
  );
  router.add(
    'DELETE',
    r'/delete/<eid>',
    service.removeEmployee,
  );
  router.all(
    r'/<ignored|.*>',
    service.catchEmployeeServiceRoute,
  );
  return router;
}
