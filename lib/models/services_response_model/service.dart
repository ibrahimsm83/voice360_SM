import 'dart:convert';

import 'package:collection/collection.dart';

import 'metadata.dart';
import 'product.dart';

class Services {
  DateTime? dateCreated;
  double? pricePerUnit;
  bool? autoProvision;
  DateTime? reqActivationDate;
  int? productId;
  String? status;
  dynamic disconnectDate;
  int? serviceAddressId;
  int? contractTerms;
  dynamic provisionResult;
  dynamic activationDate;
  int? pk;
  String? prodDescription;
  double? price;
  // Metadata? metadata;
  int? orderItemId;
  int? quantity;
  String? apiId;
  String? provisionStatus;
  int? accountId;
  String? itemType;
  Product? product;

  Services({
    this.dateCreated,
    this.pricePerUnit,
    this.autoProvision,
    this.reqActivationDate,
    this.productId,
    this.status,
    this.disconnectDate,
    this.serviceAddressId,
    this.contractTerms,
    this.provisionResult,
    this.activationDate,
    this.pk,
    this.prodDescription,
    this.price,
    // this.metadata,
    this.orderItemId,
    this.quantity,
    this.apiId,
    this.provisionStatus,
    this.accountId,
    this.itemType,
    this.product,
  });

  @override
  String toString() {
    return 'Services(dateCreated: $dateCreated, pricePerUnit: $pricePerUnit, autoProvision: $autoProvision, reqActivationDate: $reqActivationDate, productId: $productId, status: $status, disconnectDate: $disconnectDate, serviceAddressId: $serviceAddressId, contractTerms: $contractTerms, provisionResult: $provisionResult, activationDate: $activationDate, pk: $pk, prodDescription: $prodDescription, price: $price,  orderItemId: $orderItemId, quantity: $quantity, apiId: $apiId, provisionStatus: $provisionStatus, accountId: $accountId, itemType: $itemType, product: $product)';
  }

  factory Services.fromMap(Map<String, dynamic> data) => Services(
        dateCreated: data['date_created'] == null
            ? null
            : DateTime.parse(data['date_created'] as String),
        pricePerUnit: data['price_per_unit'] as double?,
        autoProvision: data['auto_provision'] as bool?,
        reqActivationDate: data['req_activation_date'] == null
            ? null
            : DateTime.parse(data['req_activation_date'] as String),
        productId: data['product_id'] as int?,
        status: data['status'] as String?,
        disconnectDate: data['disconnect_date'] as dynamic,
        serviceAddressId: data['service_address_id'] as int?,
        contractTerms: data['contract_terms'] as int?,
        provisionResult: data['provision_result'] as dynamic,
        activationDate: data['activation_date'] as dynamic,
        pk: data['pk'] as int?,
        prodDescription: data['prod_description'] as String?,
        price: data['price'] as double?,
        // metadata: data['metadata'] == null
        //     ? null
        //     : Metadata.fromMap(data['metadata'] as Map<String, dynamic>),
        orderItemId: data['order_item_id'] as int?,
        quantity: data['quantity'] as int?,
        apiId: data['api_id'] as String?,
        provisionStatus: data['provision_status'] as String?,
        accountId: data['account_id'] as int?,
        itemType: data['item_type'] as String?,
        product: data['product'] == null
            ? null
            : Product.fromMap(data['product'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'date_created': dateCreated?.toIso8601String(),
        'price_per_unit': pricePerUnit,
        'auto_provision': autoProvision,
        'req_activation_date': reqActivationDate?.toIso8601String(),
        'product_id': productId,
        'status': status,
        'disconnect_date': disconnectDate,
        'service_address_id': serviceAddressId,
        'contract_terms': contractTerms,
        'provision_result': provisionResult,
        'activation_date': activationDate,
        'pk': pk,
        'prod_description': prodDescription,
        'price': price,
        // 'metadata': metadata?.toMap(),
        'order_item_id': orderItemId,
        'quantity': quantity,
        'api_id': apiId,
        'provision_status': provisionStatus,
        'account_id': accountId,
        'item_type': itemType,
        'product': product?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Services].
  factory Services.fromJson(String data) {
    return Services.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Services] to a JSON string.
  String toJson() => json.encode(toMap());

  Services copyWith({
    DateTime? dateCreated,
    double? pricePerUnit,
    bool? autoProvision,
    DateTime? reqActivationDate,
    int? productId,
    String? status,
    dynamic disconnectDate,
    int? serviceAddressId,
    int? contractTerms,
    dynamic provisionResult,
    dynamic activationDate,
    int? pk,
    String? prodDescription,
    double? price,
    // Metadata? metadata,
    int? orderItemId,
    int? quantity,
    String? apiId,
    String? provisionStatus,
    int? accountId,
    String? itemType,
    Product? product,
  }) {
    return Services(
      dateCreated: dateCreated ?? this.dateCreated,
      pricePerUnit: pricePerUnit ?? this.pricePerUnit,
      autoProvision: autoProvision ?? this.autoProvision,
      reqActivationDate: reqActivationDate ?? this.reqActivationDate,
      productId: productId ?? this.productId,
      status: status ?? this.status,
      disconnectDate: disconnectDate ?? this.disconnectDate,
      serviceAddressId: serviceAddressId ?? this.serviceAddressId,
      contractTerms: contractTerms ?? this.contractTerms,
      provisionResult: provisionResult ?? this.provisionResult,
      activationDate: activationDate ?? this.activationDate,
      pk: pk ?? this.pk,
      prodDescription: prodDescription ?? this.prodDescription,
      price: price ?? this.price,
      // metadata: metadata ?? this.metadata,
      orderItemId: orderItemId ?? this.orderItemId,
      quantity: quantity ?? this.quantity,
      apiId: apiId ?? this.apiId,
      provisionStatus: provisionStatus ?? this.provisionStatus,
      accountId: accountId ?? this.accountId,
      itemType: itemType ?? this.itemType,
      product: product ?? this.product,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Services) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      dateCreated.hashCode ^
      pricePerUnit.hashCode ^
      autoProvision.hashCode ^
      reqActivationDate.hashCode ^
      productId.hashCode ^
      status.hashCode ^
      disconnectDate.hashCode ^
      serviceAddressId.hashCode ^
      contractTerms.hashCode ^
      provisionResult.hashCode ^
      activationDate.hashCode ^
      pk.hashCode ^
      prodDescription.hashCode ^
      price.hashCode ^
      // metadata.hashCode ^
      orderItemId.hashCode ^
      quantity.hashCode ^
      apiId.hashCode ^
      provisionStatus.hashCode ^
      accountId.hashCode ^
      itemType.hashCode ^
      product.hashCode;
}
