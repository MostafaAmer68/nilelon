import 'package:dio/dio.dart';
import 'package:nilelon/service/network/end_point.dart';
import 'package:retrofit/retrofit.dart';

part 'category_services.g.dart';

@RestApi(baseUrl: EndPoint.baseUrl)
abstract class CategoryServices {
  factory CategoryServices(Dio dio) = _CategoryServices;

  @POST(EndPoint.categoriesUrl)
  Future<HttpResponse> fetchCategories();
}
