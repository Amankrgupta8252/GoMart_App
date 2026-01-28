import 'package:get/get.dart';

class SearchKeyboardController extends GetxController {
  var recentSearches = <String>[
    'Flutter Book',
    'Dart Book',
    'Android Book',
    'iOS Book',
    'Firebase Book',
    'React Native Book',
    'Java Book',
    'Kotlin Book',
  ].obs;

  void clearAll() {
    recentSearches.clear();
  }

  void removeItem(int index) {
    recentSearches.removeAt(index);
  }
}
