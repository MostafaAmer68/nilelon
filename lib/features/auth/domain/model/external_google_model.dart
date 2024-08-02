import 'package:equatable/equatable.dart';

class ExternalGoogleModel extends Equatable {
  final String? provider;
  final String? idToken;
  final String? connectionId;

  const ExternalGoogleModel({
    this.provider,
    this.idToken,
    this.connectionId,
  });

  factory ExternalGoogleModel.fromJson(Map<String, dynamic> json) {
    return ExternalGoogleModel(
      provider: json['provider'] as String?,
      idToken: json['idToken'] as String?,
      connectionId: json['connectionId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'provider': provider,
        'idToken': idToken,
        'connectionId': connectionId,
      };

  @override
  List<Object?> get props => [provider, idToken, connectionId];
}
