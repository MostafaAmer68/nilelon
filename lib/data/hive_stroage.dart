import 'package:hive_flutter/adapters.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
import 'package:nilelon/features/product/domain/models/product_data/product_data.dart';
import 'package:nilelon/features/store_flow/choose_category/choose_category_model/result.dart';

class HiveKeys {
  // static const String product = 'product';
  static const String productData = 'productData';
  static const String varients = 'varient';
  static const String email = 'email';
  static const String shopFor = 'ShopFor';
  static const String isArabic = 'isArabic';
  static const String skipOnboarding = 'skipOnboarding';
  static const String isStore = 'isStore';
  static const String token = 'apiToken';
  static const String userId = 'idToken';
  static const String name = 'name';
  static const String role = 'role';
  static const String categories = 'categories';
  static const String userModel = 'userModel';

  // static const String languageCode = 'language_code';
  // static const String themeCode = 'theme_code';
  // static const String isDark = 'isDark';
  // static String firbaseToken= 'firbaseToken';
}

class HiveStorage {
  static late Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(VariantAdapter());
    Hive.registerAdapter(ProductModelAdapter());
    Hive.registerAdapter(SizeModelAdapter());
    Hive.registerAdapter(ProductDataAdapter());
    Hive.registerAdapter(ResultAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(CustomerModelAdapter());
    Hive.registerAdapter(StoreModelAdapter());
    Hive.registerAdapter(BaseUserDataAdapter());

    box = await Hive.openBox('myBox');
  }

  static T get<T extends dynamic>(String key) {
    try {
      return box.get(key, defaultValue: null);
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> set(String key, dynamic value) async {
    box.put(key, value);
  }

  static Future<void> remove(String key) async {
    box.delete(key);
  }

  static Future<void> clear() async {
    box.clear();
  }
}
