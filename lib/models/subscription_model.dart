import 'package:cloud_firestore/cloud_firestore.dart';

enum SubscriptionType { monthly, quarterly, yearly }

enum SubscriptionStatus { active, expired, cancelled, pending }

class SubscriptionModel {
  final String id;
  final String userId;
  final SubscriptionType type;
  final SubscriptionStatus status;
  final int totalCredits;
  final int usedCredits;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubscriptionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.totalCredits,
    required this.usedCredits,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  int get remainingCredits => totalCredits - usedCredits;

  bool get isActive =>
      status == SubscriptionStatus.active && DateTime.now().isBefore(endDate);

  String get typeDisplayName {
    switch (type) {
      case SubscriptionType.monthly:
        return 'Monthly';
      case SubscriptionType.quarterly:
        return 'Quarterly';
      case SubscriptionType.yearly:
        return 'Yearly';
    }
  }

  String get statusDisplayName {
    switch (status) {
      case SubscriptionStatus.active:
        return 'Active';
      case SubscriptionStatus.expired:
        return 'Expired';
      case SubscriptionStatus.cancelled:
        return 'Cancelled';
      case SubscriptionStatus.pending:
        return 'Pending';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.name,
      'status': status.name,
      'totalCredits': totalCredits,
      'usedCredits': usedCredits,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'price': price,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      type: SubscriptionType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => SubscriptionType.monthly,
      ),
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SubscriptionStatus.pending,
      ),
      totalCredits: json['totalCredits'] ?? 0,
      usedCredits: json['usedCredits'] ?? 0,
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      price: (json['price'] ?? 0.0).toDouble(),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  SubscriptionModel copyWith({
    String? id,
    String? userId,
    SubscriptionType? type,
    SubscriptionStatus? status,
    int? totalCredits,
    int? usedCredits,
    DateTime? startDate,
    DateTime? endDate,
    double? price,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubscriptionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      status: status ?? this.status,
      totalCredits: totalCredits ?? this.totalCredits,
      usedCredits: usedCredits ?? this.usedCredits,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SubscriptionPlan {
  final SubscriptionType type;
  final String name;
  final String description;
  final int credits;
  final double price;
  final Duration duration;
  final List<String> features;

  SubscriptionPlan({
    required this.type,
    required this.name,
    required this.description,
    required this.credits,
    required this.price,
    required this.duration,
    required this.features,
  });

  static List<SubscriptionPlan> getAvailablePlans() {
    return [
      SubscriptionPlan(
        type: SubscriptionType.monthly,
        name: 'Basic Monthly',
        description: 'Perfect for occasional shoots',
        credits: 5,
        price: 49.99,
        duration: Duration(days: 30),
        features: [
          '5 Photo shoots per month',
          'Basic editing included',
          'Digital gallery access',
          'Email support'
        ],
      ),
      SubscriptionPlan(
        type: SubscriptionType.quarterly,
        name: 'Premium Quarterly',
        description: 'Best value for regular photographers',
        credits: 20,
        price: 139.99,
        duration: Duration(days: 90),
        features: [
          '20 Photo shoots per quarter',
          'Advanced editing included',
          'Digital gallery access',
          'Priority booking',
          'Phone support'
        ],
      ),
      SubscriptionPlan(
        type: SubscriptionType.yearly,
        name: 'Professional Yearly',
        description: 'Ultimate package for professionals',
        credits: 100,
        price: 499.99,
        duration: Duration(days: 365),
        features: [
          '100 Photo shoots per year',
          'Professional editing suite',
          'Digital gallery access',
          'Priority booking',
          '24/7 support',
          'Custom locations',
          'Additional photographer option'
        ],
      ),
    ];
  }
}
