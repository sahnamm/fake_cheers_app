import 'package:dio/dio.dart';
import 'package:fake_cheers_app/network/provider/lucky_person_provider.dart';
import 'package:fake_cheers_app/util.dart';

class LuckyPersonRepository {
  final LuckyPersonProvider _provider;
  final Util _util;
  LuckyPersonRepository(this._provider, this._util);

  Future<String> getLuckyPerson() async {
    try {
      int randomInt = _util.getRandomId();
      Response res = await _provider.getLuckyPerson(randomInt);
      if (res.statusCode == 200) {
        final fn = res.data['data']['first_name'];
        final ln = res.data['data']['last_name'];
        return "$fn $ln";
      } else {
        throw Exception('Failed to fetch lucky person');
      }
    } catch (e) {
      throw Exception('Failed to fetch lucky person');
    }
  }
}
