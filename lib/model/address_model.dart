class AddressModelInfo {
  final String street1;
  final String street2;
  final String city;
  final String state;
  final String country;
  final bool isSameDelivery;

  AddressModelInfo(
      {required this.street1,
      required this.street2,
      required this.city,
      required this.state,
      required this.country,
      required this.isSameDelivery});

  factory AddressModelInfo.fromMap(Map<String, dynamic> map) {
    return new AddressModelInfo(
      street1: map['street1'] as String,
      street2: map['street2'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      country: map['country'] as String,
      isSameDelivery: map['isSameDelivery'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'street1': this.street1,
      'street2': this.street2,
      'city': this.city,
      'state': this.state,
      'country': this.country,
      'isSameDelivery': this.isSameDelivery,
    } as Map<String, dynamic>;
  }
}
