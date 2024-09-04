import 'package:equatable/equatable.dart';

class ExternalGoogleModel extends Equatable {
  final String? provider;
  final String? name;
  final String? email;
  final String? photo;

  const ExternalGoogleModel({
    this.provider,
    this.name,
    this.photo,
    this.email,
  });

  factory ExternalGoogleModel.fromJson(Map<String, dynamic> json) {
    return ExternalGoogleModel(
      provider: json['provider'] as String?,
      name: json['name'] as String?,
      photo: json['photo'] as String?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'provider': provider,
        'name': name,
        'photo': photo,
        'email': email,
      };

  @override
  List<Object?> get props => [provider, name, photo,email];
}
