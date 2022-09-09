// import 'dart:convert';

// import 'package:collection/collection.dart';

// class Metadata {
//   int? pricePerDid;
//   int? purchasedUsers;
//   String? version;

//   Metadata({this.pricePerDid, this.purchasedUsers, this.version});

//   @override
//   String toString() {
//     return 'Metadata(pricePerDid: $pricePerDid, purchasedUsers: $purchasedUsers, version: $version)';
//   }

//   factory Metadata.fromMap(Map<String, dynamic> data) => Metadata(
//         pricePerDid: data['price_per_did'] as int,
//         purchasedUsers: data['purchased_users'] as int?,
//         version: data['version'] as String?,
//       );

//   Map<String, dynamic> toMap() => {
//         'price_per_did': pricePerDid,
//         'purchased_users': purchasedUsers,
//         'version': version,
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [Metadata].
//   factory Metadata.fromJson(String data) {
//     return Metadata.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [Metadata] to a JSON string.
//   String toJson() => json.encode(toMap());

//   Metadata copyWith({
//     int? pricePerDid,
//     int? purchasedUsers,
//     String? version,
//   }) {
//     return Metadata(
//       pricePerDid: pricePerDid ?? this.pricePerDid,
//       purchasedUsers: purchasedUsers ?? this.purchasedUsers,
//       version: version ?? this.version,
//     );
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(other, this)) return true;
//     if (other is! Metadata) return false;
//     final mapEquals = const DeepCollectionEquality().equals;
//     return mapEquals(other.toMap(), toMap());
//   }

//   @override
//   int get hashCode =>
//       pricePerDid.hashCode ^ purchasedUsers.hashCode ^ version.hashCode;
// }
