import 'user.dart';

class UserLoginModel {
	String? message;
	User? user;
	String? token;

	UserLoginModel({this.message, this.user, this.token});

	factory UserLoginModel.fromJson(Map<String, dynamic> json) {
		return UserLoginModel(
			message: json['message'] as String?,
			user: json['user'] == null
						? null
						: User.fromJson(json['user'] as Map<String, dynamic>),
			token: json['token'] as String?,
		);
	}



	Map<String, dynamic> toJson() => {
				'message': message,
				'user': user?.toJson(),
				'token': token,
			};
}
