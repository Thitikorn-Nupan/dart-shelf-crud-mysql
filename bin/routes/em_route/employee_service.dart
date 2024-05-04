import 'dart:convert';
import 'package:mysql_client/exception.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../../../libs/entity/employee.dart';
import '../../../libs/log/logging.dart';
import '../../../libs/repository/entity_repo.dart';
import '../../../libs/service/dao_service.dart';


part 'employee_service.g.dart';
class EmployeeService {

  late EntityRepo<Employee> entityRepo;
  var logObj;
  //  time is importance
  EmployeeService()  {
    entityRepo = DaoService();
    // i have to connect database first then do another thing
    entityRepo.initialMysqlConnect(); // work!! not clear why it dont need to set await
    logObj = Logging()
      ..setLogName('bin/routes/em_route/employee_service.dart');

  }


  // so this is a good way i think
  @Route.get('/destroy-connect')
  Response destroyMysqlConnect(Request request) {
    entityRepo.destroyMysqlConnect();
    return Response.ok(
        jsonEncode({
          'accepted': 202, 'data': true
        }),
        headers: {'Content-type': 'application/json'}
    );
  }

  @Route.get('/reads')
  Future<Response> retrieveAllEmployees(Request request) async {
    try {
      List<Employee> employees = await entityRepo.reads();
      return Response.ok(
          jsonEncode({
            'accepted': 202, 'data': employees
          }),
          headers: {'Content-type': 'application/json'}
      );
    } on MySQLClientException catch (e) {
      return Response.ok(
          jsonEncode({
            'ok': 200, 'data': e.message
          }),
          headers: {'Content-type': 'application/json'}
      );
    }
  }

  @Route.get('/read/<eid>')
  Future<Response> retrieveEmployee(Request request,String eid) async{
    Employee employee = await entityRepo.read(eid);
    return Response.ok(
        jsonEncode({
          'ok': 200, 'data': employee
        }),
        headers: {'Content-type': 'application/json'}
    );
  }

  @Route.post('/create') // if use async method must set response type to be Future type
  Future<Response>  addEmployee(Request request) async {
    // await request.readAsString() returns like json body (it's String)
    // i have to map it then convert to object (for using)
    Map mapFromJsonBody = jsonDecode(await request.readAsString());
    // logObj.logger.info("mapFromJsonBody stores $mapFromJsonBody"); // {eid: E006, firstname: Aj, lastname: Styles, position: Spring & Spring Boot Developer, active: true, salary: 60500.0}
    Employee employee = Employee(
        mapFromJsonBody["eid"],
        mapFromJsonBody["firstname"],
        mapFromJsonBody["lastname"],
        mapFromJsonBody["position"],
        mapFromJsonBody["active"],
        mapFromJsonBody["salary"]
    );
    bool create = await entityRepo.create(employee);
    Map<String,int> status = Map();
    if (create) {
      status['created'] = 201;
    } else {
      status['ok'] = 200;
    }
    return Response.ok(
        jsonEncode({
          '${status.keys.elementAt(0)}': status.values.elementAt(0), 'data': create
        }),
        headers: {'Content-type': 'application/json'}
    );
  }

  @Route.put('/update/<eid>') // if use async method must set response type to be Future type
  Future<Response>  editEmployee(Request request,String eid) async {
    Map mapFromJsonBody = jsonDecode(await request.readAsString());
    // logObj.logger.info("mapFromJsonBody stores $mapFromJsonBody"); // {eid: E006, firstname: Aj, lastname: Styles, position: Spring & Spring Boot Developer, active: true, salary: 60500.0}
    Employee employee = Employee(
        "",
        mapFromJsonBody["firstname"],
        mapFromJsonBody["lastname"],
        mapFromJsonBody["position"],
        mapFromJsonBody["active"],
        mapFromJsonBody["salary"]
    );
    bool update = await entityRepo.update(employee,eid);
    Map<String,int> status = Map();
    if (update) {
      status['accepted'] = 202;
    } else {
      status['ok'] = 200;
    }
    return Response.ok(
        jsonEncode({
          '${status.keys.elementAt(0)}': status.values.elementAt(0), 'data': update
        }),
        headers: {'Content-type': 'application/json'}
    );
  }

  @Route.delete('/delete/<eid>')
  Future<Response> removeEmployee(Request request,String eid) async{
    bool delete = await entityRepo.delete(eid);
    return Response.ok(
        jsonEncode({
          'ok': 200, 'data': delete
        }),
        headers: {'Content-type': 'application/json'}
    );
  }

  @Route.all('/<ignored|.*>')
  Response catchEmployeeServiceRoute(Request request) => Response.notFound(jsonEncode({'ok': 200, 'data': 'not allowed content'}), headers: {'Content-type': 'application/json'});

  // The generated function _$HandlerRoutTestRouter can be used to expose a [Router] for this object.
  // for get route_demo to handler ***** Note update api must update dart run build_runner build command again
  Router get router => _$EmployeeServiceRouter(this);

}