import 'package:hive_flutter/adapters.dart';
import 'package:nilelon/features/store_flow/add_product/model/add_product/add_product_model.dart';
import 'package:nilelon/features/store_flow/add_product/model/product_data/product_data.dart';
import 'package:nilelon/features/store_flow/choose_category/choose_category_model/result.dart';

class HiveKeys {
  // static const String product = 'product';
  static const String productData = 'productData';
  static const String varients = 'varient';
  static const String shopFor = 'ShopFor';
  static const String isArabic = 'isArabic';
  static const String skipOnboarding = 'skipOnboarding';
  static const String isStore = 'isStore';
  static const String token = 'apiToken';
  static const String idToken = 'idToken';
  static const String name = 'name';
  static const String role = 'role';
  static const String categories = 'categories';

  // static const String languageCode = 'language_code';
  // static const String themeCode = 'theme_code';
  // static const String isDark = 'isDark';
  // static String firbaseToken= 'firbaseToken';
}

class HiveStorage {
  static late Box box;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProductVarieantsAdapter());
    Hive.registerAdapter(AddProductModelAdapter());
    Hive.registerAdapter(AllSizesAdapter());
    Hive.registerAdapter(ProductDataAdapter());
    Hive.registerAdapter(ResultAdapter());

    box = await Hive.openBox('myBox');
  }

  static dynamic get(String key) {
    try {
      return box.get(key, defaultValue: null);
    } catch (e) {
      return null;
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
