// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

typedef OnboardID = String;

class Onboard extends Equatable {
  final OnboardID id;
  final String title;
  final String description;
  final String imageUrl;
  final int order;
  final bool isActive;
  final String? buttonText;

  const Onboard({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.order,
    required this.isActive,
    this.buttonText,
  });

  factory Onboard.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Onboard(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      order: data['order']?.toInt() ?? 0,
      isActive: data['isActive'] ?? true,
      buttonText: data['buttonText'],
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        title,
        description,
        imageUrl,
        order,
        isActive,
        buttonText,
      ];

  Onboard copyWith({
    OnboardID? id,
    String? title,
    String? description,
    String? imageUrl,
    int? order,
    bool? isActive,
    String? buttonText,
  }) {
    return Onboard(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
      buttonText: buttonText ?? this.buttonText,
    );
  }
}
