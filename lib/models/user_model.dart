class UserModel {

  final String name;
  final String email;
  final String gender;
  final int age;


  UserModel({

    required this.name,
    required this.email,
    required this.gender,
    required this.age,

  });



  Map<String,dynamic> toJson(){

    return {

      "name":name,
      "email":email,
      "gender":gender,
      "age":age,

    };

  }



  factory UserModel.fromJson(Map<String,dynamic> json){

    return UserModel(

      name:json["name"] ?? "",

      email:json["email"] ?? "",

      gender:json["gender"] ?? "",

      age:json["age"] ?? 0,

    );

  }

}