class UserEntity {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String? username;
  final String? website;
  final AddressEntity? address;
  final CompanyEntity? company;

  const UserEntity({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.username,
    this.website,
    this.address,
    this.company,
  });
}

class AddressEntity {
  final String? street, suite, city, zipcode;
  final GeoEntity? geo;
  const AddressEntity({this.street, this.suite, this.city, this.zipcode, this.geo});
}

class GeoEntity {
  final String? lat, lng;
  const GeoEntity({this.lat, this.lng});
}

class CompanyEntity {
  final String? name, catchPhrase, bs;
  const CompanyEntity({this.name, this.catchPhrase, this.bs});
}