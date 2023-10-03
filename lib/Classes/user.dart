class User{
  String _username = '';
  String _password = '';
  List<int> _recpies = [];

  User({
    required username,
    required password,
    required recipies,
  }):
      _username = username,
      _password = password,
      _recpies = recipies;

  List<int> get recpies => _recpies;

  set recpies(List<int> value) {
    _recpies = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }
}