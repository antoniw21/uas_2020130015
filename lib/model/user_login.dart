class UserLogin {
  String name = "";
  String email = "";

  String get getName {
    return name;
  }

  set setName(String a) {
    name = a;
  }

  String get getEmail {
    return email;
  }

  set setEmail(String e) {
    email = e;
  }

  void main() {
    UserLogin u = UserLogin();
  }
}
