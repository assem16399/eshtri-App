import 'package:eshtri/shared/components/widgets/product_card_item.dart';

class AuthModel {
  late final bool status;
  late final String? message;
  late final UserData? data;

  AuthModel({
    required this.status,
    this.message,
    this.data,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
  AuthModel.copy(AuthModel model) {
    status = model.status;
    message = model.message;
    data = UserData.copy(model.data!);
  }
  AuthModel copyWith({bool? status, UserData? data, String? message}) {
    return AuthModel(
        status: status ?? this.status, message: message ?? this.message, data: data ?? this.data);
  }
}

class UserData {
  late final int? id;
  late final String name;
  late final String email;
  late final String phone;
  late final String image;
  late final int? points;
  late final int? credit;
  late final String? token;

  UserData(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.image,
      this.points,
      this.credit,
      this.token});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
  UserData.copy(UserData model) {
    id = model.id;
    name = model.name;
    email = model.email;
    phone = model.phone;
    image = model.image;
    points = model.points;
    credit = model.credit;
    token = model.token;
  }

  UserData copyWith({
    String? name,
    String? email,
    String? phone,
    String? image,
  }) {
    return UserData(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      token: token,
      credit: credit,
      points: points,
    );
  }
}
