// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handler_service.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$HandlerServiceRouter(HandlerService service) {
  final router = Router();
  router.add(
    'GET',
    r'/ttknpde-v',
    service.testHandlerRote,
  );
  router.mount(
    r'/employee',
    service.employeeService.call,
  );
  router.all(
    r'/<ignored|.*>',
    service.catchHandlerRoute,
  );
  return router;
}
