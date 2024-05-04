import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';

import 'em_route/employee_service.dart';

part 'handler_service.g.dart';
class HandlerService {


  @Route.get('/ttknpde-v')
  Response testHandlerRote(Request request) => Response.ok(jsonEncode({'ok': 200, 'data': 'Hello World'}), headers: {'Content-type': 'application/json'});

  @Route.mount('/employee')
  Router get employeeService => EmployeeService().router;

  /// A catch all of the non implemented routing, useful for showing 404 page mean cases http://localhost:8080/5,/sasa, whatever will go this path
  @Route.all('/<ignored|.*>')
  Response catchHandlerRoute(Request request) => Response.notFound(jsonEncode({'ok': 200, 'data': 'not allowed content'}), headers: {'Content-type': 'application/json'});

  Handler get handle => _$HandlerServiceRouter(this).call;

}