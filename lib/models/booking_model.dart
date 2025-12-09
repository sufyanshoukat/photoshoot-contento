import 'package:cloud_firestore/cloud_firestore.dart';

enum BookingStatus { pending, confirmed, completed, cancelled }

class BookingModel {
  final String id;
  final String userId;
  final String locationId;
  final String photographerId;
  final DateTime bookingDate;
  final String timeSlot;
  final BookingStatus status;
  final String notes;
  final List<String> imageUrls;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.locationId,
    required this.photographerId,
    required this.bookingDate,
    required this.timeSlot,
    required this.status,
    this.notes = '',
    this.imageUrls = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  String get statusDisplayName {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'locationId': locationId,
      'photographerId': photographerId,
      'bookingDate': Timestamp.fromDate(bookingDate),
      'timeSlot': timeSlot,
      'status': status.name,
      'notes': notes,
      'imageUrls': imageUrls,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      locationId: json['locationId'] ?? '',
      photographerId: json['photographerId'] ?? '',
      bookingDate: (json['bookingDate'] as Timestamp).toDate(),
      timeSlot: json['timeSlot'] ?? '',
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      notes: json['notes'] ?? '',
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  BookingModel copyWith({
    String? id,
    String? userId,
    String? locationId,
    String? photographerId,
    DateTime? bookingDate,
    String? timeSlot,
    BookingStatus? status,
    String? notes,
    List<String>? imageUrls,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      locationId: locationId ?? this.locationId,
      photographerId: photographerId ?? this.photographerId,
      bookingDate: bookingDate ?? this.bookingDate,
      timeSlot: timeSlot ?? this.timeSlot,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      imageUrls: imageUrls ?? this.imageUrls,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class LocationModel {
  final String id;
  final String name;
  final String address;
  final String description;
  final double latitude;
  final double longitude;
  final List<String> imageUrls;
  final List<String> availableTimeSlots;
  final bool isActive;

  LocationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.imageUrls = const [],
    required this.availableTimeSlots,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'imageUrls': imageUrls,
      'availableTimeSlots': availableTimeSlots,
      'isActive': isActive,
    };
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      imageUrls: List<String>.from(json['imageUrls'] ?? []),
      availableTimeSlots: List<String>.from(json['availableTimeSlots'] ?? []),
      isActive: json['isActive'] ?? true,
    );
  }

  static List<LocationModel> getSampleLocations() {
    return [
      LocationModel(
        id: '1',
        name: 'Central Park Studio',
        address: '123 Park Ave, New York, NY',
        description: 'Beautiful outdoor setting with natural lighting',
        latitude: 40.7829,
        longitude: -73.9654,
        imageUrls: [
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4',
          'https://images.unsplash.com/photo-1441974231531-c6227db76b6e',
        ],
        availableTimeSlots: [
          '9:00 AM - 10:00 AM',
          '10:30 AM - 11:30 AM',
          '12:00 PM - 1:00 PM',
          '2:00 PM - 3:00 PM',
          '3:30 PM - 4:30 PM',
          '5:00 PM - 6:00 PM',
        ],
      ),
      LocationModel(
        id: '2',
        name: 'Urban Rooftop',
        address: '456 Sky Tower, Brooklyn, NY',
        description: 'Modern rooftop with city skyline views',
        latitude: 40.6782,
        longitude: -73.9442,
        imageUrls: [
          'https://images.unsplash.com/photo-1519501025264-65ba15a82390',
          'https://images.unsplash.com/photo-1577495508048-b635879837f1',
        ],
        availableTimeSlots: [
          '8:00 AM - 9:00 AM',
          '10:00 AM - 11:00 AM',
          '1:00 PM - 2:00 PM',
          '4:00 PM - 5:00 PM',
          '6:00 PM - 7:00 PM',
        ],
      ),
      LocationModel(
        id: '3',
        name: 'Beach Front Studio',
        address: '789 Ocean Drive, Miami, FL',
        description: 'Seaside location perfect for sunset shoots',
        latitude: 25.7617,
        longitude: -80.1918,
        imageUrls: [
          'https://images.unsplash.com/photo-1505142468610-359e7d316be0',
          'https://images.unsplash.com/photo-1544551763-46a013bb70d5',
        ],
        availableTimeSlots: [
          '6:00 AM - 7:00 AM',
          '7:30 AM - 8:30 AM',
          '4:30 PM - 5:30 PM',
          '6:00 PM - 7:00 PM',
          '7:30 PM - 8:30 PM',
        ],
      ),
    ];
  }
}
