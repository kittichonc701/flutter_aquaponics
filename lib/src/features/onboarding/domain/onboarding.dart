import 'package:equatable/equatable.dart';

class Onboarding extends Equatable {
  final String title;
  final String body;
  final String imagePath;

  const Onboarding({
    required this.title,
    required this.body,
    required this.imagePath,
  });

  factory Onboarding.fromJson(Map<String, dynamic> json) {
    return Onboarding(
      title: json['title'] ?? 'Aquaponics',
      body: json['body'] ?? 'Learn about aquaponics systems',
      imagePath: json['imagePath'] ?? 'assets/images/aquaponics_default.jpg',
    );
  }

  @override
  List<Object?> get props => [title, body, imagePath];
}
