import 'package:dio/dio.dart';
import 'package:nilelon/core/service/network/end_point.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: EndPoint.baseUrl)
abstract class AuthService {
  factory AuthService(Dio dio) = _AuthService;

  @POST(EndPoint.customerRegisterUrl)
  Future<HttpResponse> customerRegister(@Body() Map<String,dynamic> body);
}
