import 'package:hive_flutter/adapters.dart';
import 'package:nilelon/features/auth/domain/model/user_model.dart';
import 'package:nilelon/features/categories/domain/model/result.dart';
import 'package:nilelon/features/product/domain/models/add_product/add_product_model.dart';
import 'package:nilelon/features/product/domain/models/product_data/draft_product_model.dart';

class HiveKeys {
  // static const String product = 'product';
  static const String draftProduct = 'productData';
  static const String connectionId = 'connectionId';
  static const String varients = 'varient';
  static const String trans = 'varient';
  static const String tempVarients = 'tempVarient';
  static const String email = 'email';
  static const String shopFor = 'ShopFor';
  static const String isArabic = 'isArabic';
  static const String skipOnboarding = 'skipOnboarding';
  static const String isStore = 'isStore';
  static const String token = 'apiToken';
  static const String clientToken = 'clientToken';
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
    Hive.registerAdapter(AddProductModelAdapter());
    Hive.registerAdapter(SizeModelAdapter());
    Hive.registerAdapter(DraftProductModelAdapter());
    Hive.registerAdapter(CategoryModelAdapter());
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

  static Future<void> set<T>(String key, T value) async {
    box.put(key, value);
  }

  static Future<void> remove(String key) async {
    box.delete(key);
  }

  static Future<void> clear() async {
    box.clear();
  }
}
