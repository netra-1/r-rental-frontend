class User {
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? address;
  String? phone;
  String? username;
  String? password;
  String? gender;
  String? profile_img;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.address,
    this.phone,
    this.username,
    this.password,
    this.email,
    this.gender,
    this.profile_img,
  });

  // Converting Json data from server to dart object
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        address: json["address"],
        phone: json["phone"],
        username: json["username"],
        password: json["password"],
        gender: json["gender"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        profile_img: json["profile_img"],
      );

  // Converting dart object to Json data
  Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "address": address,
        "phone": phone,
        "username": username,
        "password": password,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "profile_img": profile_img
      };
}
