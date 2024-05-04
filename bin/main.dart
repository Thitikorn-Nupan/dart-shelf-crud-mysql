import '../libs/log/logging.dart';
import 'routes/handler_service.dart' show HandlerService;
import 'package:shelf/shelf_io.dart' as shelf_io;

/*
  dart run build_runner build is command Just ,
  remember you run on app folder (dart-shelf-backend-crud-mysql)
  it is not run on your main.dart file
*/
main() async {
  // create object class and set up logging
  /// And remember set log on console should set on main app
  /// Another files set up log name only
  final obj = Logging()
      ..setLogName('bin/main.dart')
      ..setLogConsole();

  HandlerService handlerService = HandlerService();
  await shelf_io.serve(handlerService.handle, 'localhost', 8080)
      .then((response) => {
    obj.logger.info('Server running on localhost:${response.port}')
  }).catchError((onError) => {
    throw onError
  });
}