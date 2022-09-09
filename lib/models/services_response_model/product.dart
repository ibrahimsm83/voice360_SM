import 'dart:convert';

import 'package:collection/collection.dart';

import 'metadata.dart';

class Product {
  double? cost;
  double? price;
  // Metadata? metadata;
  String? productKey;
  bool? autoProvision;
  String? description;
  String? itemType;
  String? name;
  String? currency;
  String? category;
  String? productImage;
  bool? dependsOnServiceAddress;
  int? pk;
  bool? disabled;
  String? productType;

  Product({
    this.cost,
    this.price,
    // this.metadata,
    this.productKey,
    this.autoProvision,
    this.description,
    this.itemType,
    this.name,
    this.currency,
    this.category,
    this.productImage,
    this.dependsOnServiceAddress,
    this.pk,
    this.disabled,
    this.productType,
  });

  @override
  String toString() {
    return 'Product(cost: $cost, price: $price, productKey: $productKey, autoProvision: $autoProvision, description: $description, itemType: $itemType, name: $name, currency: $currency, category: $category, productImage: $productImage, dependsOnServiceAddress: $dependsOnServiceAddress, pk: $pk, disabled: $disabled, productType: $productType)';
  }

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        cost: data['cost'] as double?,
        price: data['price'] as double?,
        // metadata: data['metadata'] == null
        //     ? null
        //     : Metadata.fromMap(data['metadata'] as Map<String, dynamic>),
        productKey: data['product_key'] as String?,
        autoProvision: data['auto_provision'] as bool?,
        description: data['description'] as String?,
        itemType: data['item_type'] as String?,
        name: data['name'] as String?,
        currency: data['currency'] as String?,
        category: data['category'] as String?,
        productImage: data['product_image'] as String?,
        dependsOnServiceAddress: data['depends_on_service_address'] as bool?,
        pk: data['pk'] as int?,
        disabled: data['disabled'] as bool?,
        productType: data['product_type'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'cost': cost,
        'price': price,
        // 'metadata': metadata?.toMap(),
        'product_key': productKey,
        'auto_provision': autoProvision,
        'description': description,
        'item_type': itemType,
        'name': name,
        'currency': currency,
        'category': category,
        'product_image': productImage,
        'depends_on_service_address': dependsOnServiceAddress,
        'pk': pk,
        'disabled': disabled,
        'product_type': productType,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());

  Product copyWith({
    double? cost,
    double? price,
    // Metadata? metadata,
    String? productKey,
    bool? autoProvision,
    String? description,
    String? itemType,
    String? name,
    String? currency,
    String? category,
    String? productImage,
    bool? dependsOnServiceAddress,
    int? pk,
    bool? disabled,
    String? productType,
  }) {
    return Product(
      cost: cost ?? this.cost,
      price: price ?? this.price,
      // metadata: metadata ?? this.metadata,
      productKey: productKey ?? this.productKey,
      autoProvision: autoProvision ?? this.autoProvision,
      description: description ?? this.description,
      itemType: itemType ?? this.itemType,
      name: name ?? this.name,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      productImage: productImage ?? this.productImage,
      dependsOnServiceAddress:
          dependsOnServiceAddress ?? this.dependsOnServiceAddress,
      pk: pk ?? this.pk,
      disabled: disabled ?? this.disabled,
      productType: productType ?? this.productType,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Product) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      cost.hashCode ^
      price.hashCode ^
      // metadata.hashCode ^
      productKey.hashCode ^
      autoProvision.hashCode ^
      description.hashCode ^
      itemType.hashCode ^
      name.hashCode ^
      currency.hashCode ^
      category.hashCode ^
      productImage.hashCode ^
      dependsOnServiceAddress.hashCode ^
      pk.hashCode ^
      disabled.hashCode ^
      productType.hashCode;
}
