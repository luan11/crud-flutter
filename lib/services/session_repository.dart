import 'package:localstorage/localstorage.dart';

class SessionRepository {
  final LocalStorage _storage = LocalStorage('session.json');
  final String _key = 'session.key';

  Future<void> setLoggedUser(dynamic user) async {
    if (await _storage.ready) {
      await _storage.setItem(
        _key,
        user,
      );
    }
  }

  Future<dynamic> getLoggedUser() async {
    if (await _storage.ready) {
      final loggedUser = await _storage.getItem(_key);

      return loggedUser;
    }

    return null;
  }

  Future<void> removeLoggedUser() async {
    if (await _storage.ready) {
      await _storage.deleteItem(_key);
    }
  }
}
