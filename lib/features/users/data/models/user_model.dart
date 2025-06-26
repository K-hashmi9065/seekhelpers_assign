import 'package:equatable/equatable.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  const UserModel({
    super.id,
    required super.name,
    required super.email,
    required super.phone,
    super.username,
    super.website,
    AddressModel? address,
    CompanyModel? company,
  }) : super(address: address, company: company);

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    name: json['name'],
    email: json['email'],
    phone: json['phone'],
    username: json['username'],
    website: json['website'],
    address: json['address'] != null
        ? AddressModel.fromJson(json['address'])
        : null,
    company: json['company'] != null
        ? CompanyModel.fromJson(json['company'])
        : null,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'username': username,
    'website': website,
    'address': (address as AddressModel?)?.toJson(),
    'company': (company as CompanyModel?)?.toJson(),
  };

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
    id: entity.id,
    name: entity.name,
    email: entity.email,
    phone: entity.phone,
    username: entity.username,
    website: entity.website,
    address: entity.address != null
        ? AddressModel.fromEntity(entity.address!)
        : null,
    company: entity.company != null
        ? CompanyModel.fromEntity(entity.company!)
        : null,
  );

  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    email: email,
    phone: phone,
    username: username,
    website: website,
    address: address is AddressModel
        ? (address as AddressModel).toEntity()
        : address,
    company: company is CompanyModel
        ? (company as CompanyModel).toEntity()
        : company,
  );

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    username,
    website,
    address,
    company,
  ];
}

class AddressModel extends AddressEntity with EquatableMixin {
  const AddressModel({
    super.street,
    super.suite,
    super.city,
    super.zipcode,
    GeoModel? geo,
  }) : super(geo: geo);

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    street: json['street'],
    suite: json['suite'],
    city: json['city'],
    zipcode: json['zipcode'],
    geo: json['geo'] != null ? GeoModel.fromJson(json['geo']) : null,
  );

  Map<String, dynamic> toJson() => {
    'street': street,
    'suite': suite,
    'city': city,
    'zipcode': zipcode,
    'geo': (geo as GeoModel?)?.toJson(),
  };

  factory AddressModel.fromEntity(AddressEntity entity) => AddressModel(
    street: entity.street,
    suite: entity.suite,
    city: entity.city,
    zipcode: entity.zipcode,
    geo: entity.geo != null ? GeoModel.fromEntity(entity.geo!) : null,
  );

  AddressEntity toEntity() => AddressEntity(
    street: street,
    suite: suite,
    city: city,
    zipcode: zipcode,
    geo: geo is GeoModel ? (geo as GeoModel).toEntity() : geo,
  );

  @override
  List<Object?> get props => [street, suite, city, zipcode, geo];
}

class CompanyModel extends CompanyEntity with EquatableMixin {
  const CompanyModel({super.name, super.catchPhrase, super.bs});

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
    name: json['name'],
    catchPhrase: json['catchPhrase'],
    bs: json['bs'],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'catchPhrase': catchPhrase,
    'bs': bs,
  };

  factory CompanyModel.fromEntity(CompanyEntity entity) => CompanyModel(
    name: entity.name,
    catchPhrase: entity.catchPhrase,
    bs: entity.bs,
  );

  CompanyEntity toEntity() =>
      CompanyEntity(name: name, catchPhrase: catchPhrase, bs: bs);

  @override
  List<Object?> get props => [name, catchPhrase, bs];
}

class GeoModel extends GeoEntity with EquatableMixin {
  const GeoModel({super.lat, super.lng});

  factory GeoModel.fromJson(Map<String, dynamic> json) =>
      GeoModel(lat: json['lat'], lng: json['lng']);

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  factory GeoModel.fromEntity(GeoEntity entity) =>
      GeoModel(lat: entity.lat, lng: entity.lng);

  GeoEntity toEntity() => GeoEntity(lat: lat, lng: lng);

  @override
  List<Object?> get props => [lat, lng];
}

// AddressModel, GeoModel, CompanyModel: similar pattern, extending their respective entities and implementing Equatable.
