class UserData {
  String? id;
  String name;
  String phonenumber;
  String password;

  UserData(this.name, this.phonenumber, this.password, {this.id});

  factory UserData.fromJson(Map map) => UserData(
        map['name'],
        map['phonenumber'],
        map['password'],
        id: map['id'],
      );
}
