// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoriteCarsTable extends FavoriteCars
    with TableInfo<$FavoriteCarsTable, FavoriteCar> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteCarsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _carIdMeta = const VerificationMeta('carId');
  @override
  late final GeneratedColumn<String> carId = GeneratedColumn<String>(
    'car_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [carId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_cars';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteCar> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('car_id')) {
      context.handle(
        _carIdMeta,
        carId.isAcceptableOrUnknown(data['car_id']!, _carIdMeta),
      );
    } else if (isInserting) {
      context.missing(_carIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {carId};
  @override
  FavoriteCar map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteCar(
      carId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}car_id'],
      )!,
    );
  }

  @override
  $FavoriteCarsTable createAlias(String alias) {
    return $FavoriteCarsTable(attachedDatabase, alias);
  }
}

class FavoriteCar extends DataClass implements Insertable<FavoriteCar> {
  final String carId;
  const FavoriteCar({required this.carId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['car_id'] = Variable<String>(carId);
    return map;
  }

  FavoriteCarsCompanion toCompanion(bool nullToAbsent) {
    return FavoriteCarsCompanion(carId: Value(carId));
  }

  factory FavoriteCar.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteCar(carId: serializer.fromJson<String>(json['carId']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'carId': serializer.toJson<String>(carId)};
  }

  FavoriteCar copyWith({String? carId}) =>
      FavoriteCar(carId: carId ?? this.carId);
  FavoriteCar copyWithCompanion(FavoriteCarsCompanion data) {
    return FavoriteCar(
      carId: data.carId.present ? data.carId.value : this.carId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCar(')
          ..write('carId: $carId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => carId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteCar && other.carId == this.carId);
}

class FavoriteCarsCompanion extends UpdateCompanion<FavoriteCar> {
  final Value<String> carId;
  final Value<int> rowid;
  const FavoriteCarsCompanion({
    this.carId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FavoriteCarsCompanion.insert({
    required String carId,
    this.rowid = const Value.absent(),
  }) : carId = Value(carId);
  static Insertable<FavoriteCar> custom({
    Expression<String>? carId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (carId != null) 'car_id': carId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FavoriteCarsCompanion copyWith({Value<String>? carId, Value<int>? rowid}) {
    return FavoriteCarsCompanion(
      carId: carId ?? this.carId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (carId.present) {
      map['car_id'] = Variable<String>(carId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteCarsCompanion(')
          ..write('carId: $carId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CartEntriesTable extends CartEntries
    with TableInfo<$CartEntriesTable, CartEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemNameMeta = const VerificationMeta(
    'itemName',
  );
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
    'item_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemDescriptionMeta = const VerificationMeta(
    'itemDescription',
  );
  @override
  late final GeneratedColumn<String> itemDescription = GeneratedColumn<String>(
    'item_description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemPriceMeta = const VerificationMeta(
    'itemPrice',
  );
  @override
  late final GeneratedColumn<double> itemPrice = GeneratedColumn<double>(
    'item_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemImageUrlMeta = const VerificationMeta(
    'itemImageUrl',
  );
  @override
  late final GeneratedColumn<String> itemImageUrl = GeneratedColumn<String>(
    'item_image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restaurantIdMeta = const VerificationMeta(
    'restaurantId',
  );
  @override
  late final GeneratedColumn<String> restaurantId = GeneratedColumn<String>(
    'restaurant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restaurantNameMeta = const VerificationMeta(
    'restaurantName',
  );
  @override
  late final GeneratedColumn<String> restaurantName = GeneratedColumn<String>(
    'restaurant_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rentalDaysMeta = const VerificationMeta(
    'rentalDays',
  );
  @override
  late final GeneratedColumn<int> rentalDays = GeneratedColumn<int>(
    'rental_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _withInsuranceMeta = const VerificationMeta(
    'withInsurance',
  );
  @override
  late final GeneratedColumn<bool> withInsurance = GeneratedColumn<bool>(
    'with_insurance',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("with_insurance" IN (0, 1))',
    ),
  );
  static const VerificationMeta _withDriverMeta = const VerificationMeta(
    'withDriver',
  );
  @override
  late final GeneratedColumn<bool> withDriver = GeneratedColumn<bool>(
    'with_driver',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("with_driver" IN (0, 1))',
    ),
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    itemName,
    itemDescription,
    itemPrice,
    itemImageUrl,
    restaurantId,
    restaurantName,
    quantity,
    rentalDays,
    withInsurance,
    withDriver,
    totalPrice,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_name')) {
      context.handle(
        _itemNameMeta,
        itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta),
      );
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('item_description')) {
      context.handle(
        _itemDescriptionMeta,
        itemDescription.isAcceptableOrUnknown(
          data['item_description']!,
          _itemDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itemDescriptionMeta);
    }
    if (data.containsKey('item_price')) {
      context.handle(
        _itemPriceMeta,
        itemPrice.isAcceptableOrUnknown(data['item_price']!, _itemPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_itemPriceMeta);
    }
    if (data.containsKey('item_image_url')) {
      context.handle(
        _itemImageUrlMeta,
        itemImageUrl.isAcceptableOrUnknown(
          data['item_image_url']!,
          _itemImageUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itemImageUrlMeta);
    }
    if (data.containsKey('restaurant_id')) {
      context.handle(
        _restaurantIdMeta,
        restaurantId.isAcceptableOrUnknown(
          data['restaurant_id']!,
          _restaurantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
    if (data.containsKey('restaurant_name')) {
      context.handle(
        _restaurantNameMeta,
        restaurantName.isAcceptableOrUnknown(
          data['restaurant_name']!,
          _restaurantNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('rental_days')) {
      context.handle(
        _rentalDaysMeta,
        rentalDays.isAcceptableOrUnknown(data['rental_days']!, _rentalDaysMeta),
      );
    } else if (isInserting) {
      context.missing(_rentalDaysMeta);
    }
    if (data.containsKey('with_insurance')) {
      context.handle(
        _withInsuranceMeta,
        withInsurance.isAcceptableOrUnknown(
          data['with_insurance']!,
          _withInsuranceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_withInsuranceMeta);
    }
    if (data.containsKey('with_driver')) {
      context.handle(
        _withDriverMeta,
        withDriver.isAcceptableOrUnknown(data['with_driver']!, _withDriverMeta),
      );
    } else if (isInserting) {
      context.missing(_withDriverMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemName};
  @override
  CartEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartEntry(
      itemName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_name'],
      )!,
      itemDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_description'],
      )!,
      itemPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}item_price'],
      )!,
      itemImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_image_url'],
      )!,
      restaurantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restaurant_id'],
      )!,
      restaurantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restaurant_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      rentalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rental_days'],
      )!,
      withInsurance: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}with_insurance'],
      )!,
      withDriver: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}with_driver'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
    );
  }

  @override
  $CartEntriesTable createAlias(String alias) {
    return $CartEntriesTable(attachedDatabase, alias);
  }
}

class CartEntry extends DataClass implements Insertable<CartEntry> {
  final String itemName;
  final String itemDescription;
  final double itemPrice;
  final String itemImageUrl;
  final String restaurantId;
  final String restaurantName;
  final int quantity;
  final int rentalDays;
  final bool withInsurance;
  final bool withDriver;
  final double totalPrice;
  const CartEntry({
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemImageUrl,
    required this.restaurantId,
    required this.restaurantName,
    required this.quantity,
    required this.rentalDays,
    required this.withInsurance,
    required this.withDriver,
    required this.totalPrice,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_name'] = Variable<String>(itemName);
    map['item_description'] = Variable<String>(itemDescription);
    map['item_price'] = Variable<double>(itemPrice);
    map['item_image_url'] = Variable<String>(itemImageUrl);
    map['restaurant_id'] = Variable<String>(restaurantId);
    map['restaurant_name'] = Variable<String>(restaurantName);
    map['quantity'] = Variable<int>(quantity);
    map['rental_days'] = Variable<int>(rentalDays);
    map['with_insurance'] = Variable<bool>(withInsurance);
    map['with_driver'] = Variable<bool>(withDriver);
    map['total_price'] = Variable<double>(totalPrice);
    return map;
  }

  CartEntriesCompanion toCompanion(bool nullToAbsent) {
    return CartEntriesCompanion(
      itemName: Value(itemName),
      itemDescription: Value(itemDescription),
      itemPrice: Value(itemPrice),
      itemImageUrl: Value(itemImageUrl),
      restaurantId: Value(restaurantId),
      restaurantName: Value(restaurantName),
      quantity: Value(quantity),
      rentalDays: Value(rentalDays),
      withInsurance: Value(withInsurance),
      withDriver: Value(withDriver),
      totalPrice: Value(totalPrice),
    );
  }

  factory CartEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartEntry(
      itemName: serializer.fromJson<String>(json['itemName']),
      itemDescription: serializer.fromJson<String>(json['itemDescription']),
      itemPrice: serializer.fromJson<double>(json['itemPrice']),
      itemImageUrl: serializer.fromJson<String>(json['itemImageUrl']),
      restaurantId: serializer.fromJson<String>(json['restaurantId']),
      restaurantName: serializer.fromJson<String>(json['restaurantName']),
      quantity: serializer.fromJson<int>(json['quantity']),
      rentalDays: serializer.fromJson<int>(json['rentalDays']),
      withInsurance: serializer.fromJson<bool>(json['withInsurance']),
      withDriver: serializer.fromJson<bool>(json['withDriver']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemName': serializer.toJson<String>(itemName),
      'itemDescription': serializer.toJson<String>(itemDescription),
      'itemPrice': serializer.toJson<double>(itemPrice),
      'itemImageUrl': serializer.toJson<String>(itemImageUrl),
      'restaurantId': serializer.toJson<String>(restaurantId),
      'restaurantName': serializer.toJson<String>(restaurantName),
      'quantity': serializer.toJson<int>(quantity),
      'rentalDays': serializer.toJson<int>(rentalDays),
      'withInsurance': serializer.toJson<bool>(withInsurance),
      'withDriver': serializer.toJson<bool>(withDriver),
      'totalPrice': serializer.toJson<double>(totalPrice),
    };
  }

  CartEntry copyWith({
    String? itemName,
    String? itemDescription,
    double? itemPrice,
    String? itemImageUrl,
    String? restaurantId,
    String? restaurantName,
    int? quantity,
    int? rentalDays,
    bool? withInsurance,
    bool? withDriver,
    double? totalPrice,
  }) => CartEntry(
    itemName: itemName ?? this.itemName,
    itemDescription: itemDescription ?? this.itemDescription,
    itemPrice: itemPrice ?? this.itemPrice,
    itemImageUrl: itemImageUrl ?? this.itemImageUrl,
    restaurantId: restaurantId ?? this.restaurantId,
    restaurantName: restaurantName ?? this.restaurantName,
    quantity: quantity ?? this.quantity,
    rentalDays: rentalDays ?? this.rentalDays,
    withInsurance: withInsurance ?? this.withInsurance,
    withDriver: withDriver ?? this.withDriver,
    totalPrice: totalPrice ?? this.totalPrice,
  );
  CartEntry copyWithCompanion(CartEntriesCompanion data) {
    return CartEntry(
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      itemDescription: data.itemDescription.present
          ? data.itemDescription.value
          : this.itemDescription,
      itemPrice: data.itemPrice.present ? data.itemPrice.value : this.itemPrice,
      itemImageUrl: data.itemImageUrl.present
          ? data.itemImageUrl.value
          : this.itemImageUrl,
      restaurantId: data.restaurantId.present
          ? data.restaurantId.value
          : this.restaurantId,
      restaurantName: data.restaurantName.present
          ? data.restaurantName.value
          : this.restaurantName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      rentalDays: data.rentalDays.present
          ? data.rentalDays.value
          : this.rentalDays,
      withInsurance: data.withInsurance.present
          ? data.withInsurance.value
          : this.withInsurance,
      withDriver: data.withDriver.present
          ? data.withDriver.value
          : this.withDriver,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartEntry(')
          ..write('itemName: $itemName, ')
          ..write('itemDescription: $itemDescription, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('itemImageUrl: $itemImageUrl, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('restaurantName: $restaurantName, ')
          ..write('quantity: $quantity, ')
          ..write('rentalDays: $rentalDays, ')
          ..write('withInsurance: $withInsurance, ')
          ..write('withDriver: $withDriver, ')
          ..write('totalPrice: $totalPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    itemName,
    itemDescription,
    itemPrice,
    itemImageUrl,
    restaurantId,
    restaurantName,
    quantity,
    rentalDays,
    withInsurance,
    withDriver,
    totalPrice,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartEntry &&
          other.itemName == this.itemName &&
          other.itemDescription == this.itemDescription &&
          other.itemPrice == this.itemPrice &&
          other.itemImageUrl == this.itemImageUrl &&
          other.restaurantId == this.restaurantId &&
          other.restaurantName == this.restaurantName &&
          other.quantity == this.quantity &&
          other.rentalDays == this.rentalDays &&
          other.withInsurance == this.withInsurance &&
          other.withDriver == this.withDriver &&
          other.totalPrice == this.totalPrice);
}

class CartEntriesCompanion extends UpdateCompanion<CartEntry> {
  final Value<String> itemName;
  final Value<String> itemDescription;
  final Value<double> itemPrice;
  final Value<String> itemImageUrl;
  final Value<String> restaurantId;
  final Value<String> restaurantName;
  final Value<int> quantity;
  final Value<int> rentalDays;
  final Value<bool> withInsurance;
  final Value<bool> withDriver;
  final Value<double> totalPrice;
  final Value<int> rowid;
  const CartEntriesCompanion({
    this.itemName = const Value.absent(),
    this.itemDescription = const Value.absent(),
    this.itemPrice = const Value.absent(),
    this.itemImageUrl = const Value.absent(),
    this.restaurantId = const Value.absent(),
    this.restaurantName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.rentalDays = const Value.absent(),
    this.withInsurance = const Value.absent(),
    this.withDriver = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CartEntriesCompanion.insert({
    required String itemName,
    required String itemDescription,
    required double itemPrice,
    required String itemImageUrl,
    required String restaurantId,
    required String restaurantName,
    required int quantity,
    required int rentalDays,
    required bool withInsurance,
    required bool withDriver,
    required double totalPrice,
    this.rowid = const Value.absent(),
  }) : itemName = Value(itemName),
       itemDescription = Value(itemDescription),
       itemPrice = Value(itemPrice),
       itemImageUrl = Value(itemImageUrl),
       restaurantId = Value(restaurantId),
       restaurantName = Value(restaurantName),
       quantity = Value(quantity),
       rentalDays = Value(rentalDays),
       withInsurance = Value(withInsurance),
       withDriver = Value(withDriver),
       totalPrice = Value(totalPrice);
  static Insertable<CartEntry> custom({
    Expression<String>? itemName,
    Expression<String>? itemDescription,
    Expression<double>? itemPrice,
    Expression<String>? itemImageUrl,
    Expression<String>? restaurantId,
    Expression<String>? restaurantName,
    Expression<int>? quantity,
    Expression<int>? rentalDays,
    Expression<bool>? withInsurance,
    Expression<bool>? withDriver,
    Expression<double>? totalPrice,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemName != null) 'item_name': itemName,
      if (itemDescription != null) 'item_description': itemDescription,
      if (itemPrice != null) 'item_price': itemPrice,
      if (itemImageUrl != null) 'item_image_url': itemImageUrl,
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (restaurantName != null) 'restaurant_name': restaurantName,
      if (quantity != null) 'quantity': quantity,
      if (rentalDays != null) 'rental_days': rentalDays,
      if (withInsurance != null) 'with_insurance': withInsurance,
      if (withDriver != null) 'with_driver': withDriver,
      if (totalPrice != null) 'total_price': totalPrice,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CartEntriesCompanion copyWith({
    Value<String>? itemName,
    Value<String>? itemDescription,
    Value<double>? itemPrice,
    Value<String>? itemImageUrl,
    Value<String>? restaurantId,
    Value<String>? restaurantName,
    Value<int>? quantity,
    Value<int>? rentalDays,
    Value<bool>? withInsurance,
    Value<bool>? withDriver,
    Value<double>? totalPrice,
    Value<int>? rowid,
  }) {
    return CartEntriesCompanion(
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      itemPrice: itemPrice ?? this.itemPrice,
      itemImageUrl: itemImageUrl ?? this.itemImageUrl,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      quantity: quantity ?? this.quantity,
      rentalDays: rentalDays ?? this.rentalDays,
      withInsurance: withInsurance ?? this.withInsurance,
      withDriver: withDriver ?? this.withDriver,
      totalPrice: totalPrice ?? this.totalPrice,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (itemDescription.present) {
      map['item_description'] = Variable<String>(itemDescription.value);
    }
    if (itemPrice.present) {
      map['item_price'] = Variable<double>(itemPrice.value);
    }
    if (itemImageUrl.present) {
      map['item_image_url'] = Variable<String>(itemImageUrl.value);
    }
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<String>(restaurantId.value);
    }
    if (restaurantName.present) {
      map['restaurant_name'] = Variable<String>(restaurantName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (rentalDays.present) {
      map['rental_days'] = Variable<int>(rentalDays.value);
    }
    if (withInsurance.present) {
      map['with_insurance'] = Variable<bool>(withInsurance.value);
    }
    if (withDriver.present) {
      map['with_driver'] = Variable<bool>(withDriver.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartEntriesCompanion(')
          ..write('itemName: $itemName, ')
          ..write('itemDescription: $itemDescription, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('itemImageUrl: $itemImageUrl, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('restaurantName: $restaurantName, ')
          ..write('quantity: $quantity, ')
          ..write('rentalDays: $rentalDays, ')
          ..write('withInsurance: $withInsurance, ')
          ..write('withDriver: $withDriver, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrdersTable extends Orders with TableInfo<$OrdersTable, Order> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restaurantIdMeta = const VerificationMeta(
    'restaurantId',
  );
  @override
  late final GeneratedColumn<String> restaurantId = GeneratedColumn<String>(
    'restaurant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restaurantNameMeta = const VerificationMeta(
    'restaurantName',
  );
  @override
  late final GeneratedColumn<String> restaurantName = GeneratedColumn<String>(
    'restaurant_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientNameMeta = const VerificationMeta(
    'recipientName',
  );
  @override
  late final GeneratedColumn<String> recipientName = GeneratedColumn<String>(
    'recipient_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fulfillmentMeta = const VerificationMeta(
    'fulfillment',
  );
  @override
  late final GeneratedColumn<String> fulfillment = GeneratedColumn<String>(
    'fulfillment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateTimeMillisMeta = const VerificationMeta(
    'dateTimeMillis',
  );
  @override
  late final GeneratedColumn<int> dateTimeMillis = GeneratedColumn<int>(
    'date_time_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMillisMeta = const VerificationMeta(
    'createdAtMillis',
  );
  @override
  late final GeneratedColumn<int> createdAtMillis = GeneratedColumn<int>(
    'created_at_millis',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveryAddressMeta = const VerificationMeta(
    'deliveryAddress',
  );
  @override
  late final GeneratedColumn<String> deliveryAddress = GeneratedColumn<String>(
    'delivery_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    restaurantId,
    restaurantName,
    recipientName,
    fulfillment,
    dateTimeMillis,
    createdAtMillis,
    deliveryAddress,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Order> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('restaurant_id')) {
      context.handle(
        _restaurantIdMeta,
        restaurantId.isAcceptableOrUnknown(
          data['restaurant_id']!,
          _restaurantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
    if (data.containsKey('restaurant_name')) {
      context.handle(
        _restaurantNameMeta,
        restaurantName.isAcceptableOrUnknown(
          data['restaurant_name']!,
          _restaurantNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_restaurantNameMeta);
    }
    if (data.containsKey('recipient_name')) {
      context.handle(
        _recipientNameMeta,
        recipientName.isAcceptableOrUnknown(
          data['recipient_name']!,
          _recipientNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recipientNameMeta);
    }
    if (data.containsKey('fulfillment')) {
      context.handle(
        _fulfillmentMeta,
        fulfillment.isAcceptableOrUnknown(
          data['fulfillment']!,
          _fulfillmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fulfillmentMeta);
    }
    if (data.containsKey('date_time_millis')) {
      context.handle(
        _dateTimeMillisMeta,
        dateTimeMillis.isAcceptableOrUnknown(
          data['date_time_millis']!,
          _dateTimeMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateTimeMillisMeta);
    }
    if (data.containsKey('created_at_millis')) {
      context.handle(
        _createdAtMillisMeta,
        createdAtMillis.isAcceptableOrUnknown(
          data['created_at_millis']!,
          _createdAtMillisMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtMillisMeta);
    }
    if (data.containsKey('delivery_address')) {
      context.handle(
        _deliveryAddressMeta,
        deliveryAddress.isAcceptableOrUnknown(
          data['delivery_address']!,
          _deliveryAddressMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Order map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Order(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      restaurantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restaurant_id'],
      )!,
      restaurantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}restaurant_name'],
      )!,
      recipientName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_name'],
      )!,
      fulfillment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fulfillment'],
      )!,
      dateTimeMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}date_time_millis'],
      )!,
      createdAtMillis: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}created_at_millis'],
      )!,
      deliveryAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}delivery_address'],
      ),
    );
  }

  @override
  $OrdersTable createAlias(String alias) {
    return $OrdersTable(attachedDatabase, alias);
  }
}

class Order extends DataClass implements Insertable<Order> {
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String recipientName;
  final String fulfillment;
  final int dateTimeMillis;
  final int createdAtMillis;
  final String? deliveryAddress;
  const Order({
    required this.id,
    required this.restaurantId,
    required this.restaurantName,
    required this.recipientName,
    required this.fulfillment,
    required this.dateTimeMillis,
    required this.createdAtMillis,
    this.deliveryAddress,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['restaurant_id'] = Variable<String>(restaurantId);
    map['restaurant_name'] = Variable<String>(restaurantName);
    map['recipient_name'] = Variable<String>(recipientName);
    map['fulfillment'] = Variable<String>(fulfillment);
    map['date_time_millis'] = Variable<int>(dateTimeMillis);
    map['created_at_millis'] = Variable<int>(createdAtMillis);
    if (!nullToAbsent || deliveryAddress != null) {
      map['delivery_address'] = Variable<String>(deliveryAddress);
    }
    return map;
  }

  OrdersCompanion toCompanion(bool nullToAbsent) {
    return OrdersCompanion(
      id: Value(id),
      restaurantId: Value(restaurantId),
      restaurantName: Value(restaurantName),
      recipientName: Value(recipientName),
      fulfillment: Value(fulfillment),
      dateTimeMillis: Value(dateTimeMillis),
      createdAtMillis: Value(createdAtMillis),
      deliveryAddress: deliveryAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryAddress),
    );
  }

  factory Order.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Order(
      id: serializer.fromJson<String>(json['id']),
      restaurantId: serializer.fromJson<String>(json['restaurantId']),
      restaurantName: serializer.fromJson<String>(json['restaurantName']),
      recipientName: serializer.fromJson<String>(json['recipientName']),
      fulfillment: serializer.fromJson<String>(json['fulfillment']),
      dateTimeMillis: serializer.fromJson<int>(json['dateTimeMillis']),
      createdAtMillis: serializer.fromJson<int>(json['createdAtMillis']),
      deliveryAddress: serializer.fromJson<String?>(json['deliveryAddress']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'restaurantId': serializer.toJson<String>(restaurantId),
      'restaurantName': serializer.toJson<String>(restaurantName),
      'recipientName': serializer.toJson<String>(recipientName),
      'fulfillment': serializer.toJson<String>(fulfillment),
      'dateTimeMillis': serializer.toJson<int>(dateTimeMillis),
      'createdAtMillis': serializer.toJson<int>(createdAtMillis),
      'deliveryAddress': serializer.toJson<String?>(deliveryAddress),
    };
  }

  Order copyWith({
    String? id,
    String? restaurantId,
    String? restaurantName,
    String? recipientName,
    String? fulfillment,
    int? dateTimeMillis,
    int? createdAtMillis,
    Value<String?> deliveryAddress = const Value.absent(),
  }) => Order(
    id: id ?? this.id,
    restaurantId: restaurantId ?? this.restaurantId,
    restaurantName: restaurantName ?? this.restaurantName,
    recipientName: recipientName ?? this.recipientName,
    fulfillment: fulfillment ?? this.fulfillment,
    dateTimeMillis: dateTimeMillis ?? this.dateTimeMillis,
    createdAtMillis: createdAtMillis ?? this.createdAtMillis,
    deliveryAddress: deliveryAddress.present
        ? deliveryAddress.value
        : this.deliveryAddress,
  );
  Order copyWithCompanion(OrdersCompanion data) {
    return Order(
      id: data.id.present ? data.id.value : this.id,
      restaurantId: data.restaurantId.present
          ? data.restaurantId.value
          : this.restaurantId,
      restaurantName: data.restaurantName.present
          ? data.restaurantName.value
          : this.restaurantName,
      recipientName: data.recipientName.present
          ? data.recipientName.value
          : this.recipientName,
      fulfillment: data.fulfillment.present
          ? data.fulfillment.value
          : this.fulfillment,
      dateTimeMillis: data.dateTimeMillis.present
          ? data.dateTimeMillis.value
          : this.dateTimeMillis,
      createdAtMillis: data.createdAtMillis.present
          ? data.createdAtMillis.value
          : this.createdAtMillis,
      deliveryAddress: data.deliveryAddress.present
          ? data.deliveryAddress.value
          : this.deliveryAddress,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Order(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('restaurantName: $restaurantName, ')
          ..write('recipientName: $recipientName, ')
          ..write('fulfillment: $fulfillment, ')
          ..write('dateTimeMillis: $dateTimeMillis, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('deliveryAddress: $deliveryAddress')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    restaurantId,
    restaurantName,
    recipientName,
    fulfillment,
    dateTimeMillis,
    createdAtMillis,
    deliveryAddress,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Order &&
          other.id == this.id &&
          other.restaurantId == this.restaurantId &&
          other.restaurantName == this.restaurantName &&
          other.recipientName == this.recipientName &&
          other.fulfillment == this.fulfillment &&
          other.dateTimeMillis == this.dateTimeMillis &&
          other.createdAtMillis == this.createdAtMillis &&
          other.deliveryAddress == this.deliveryAddress);
}

class OrdersCompanion extends UpdateCompanion<Order> {
  final Value<String> id;
  final Value<String> restaurantId;
  final Value<String> restaurantName;
  final Value<String> recipientName;
  final Value<String> fulfillment;
  final Value<int> dateTimeMillis;
  final Value<int> createdAtMillis;
  final Value<String?> deliveryAddress;
  final Value<int> rowid;
  const OrdersCompanion({
    this.id = const Value.absent(),
    this.restaurantId = const Value.absent(),
    this.restaurantName = const Value.absent(),
    this.recipientName = const Value.absent(),
    this.fulfillment = const Value.absent(),
    this.dateTimeMillis = const Value.absent(),
    this.createdAtMillis = const Value.absent(),
    this.deliveryAddress = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OrdersCompanion.insert({
    required String id,
    required String restaurantId,
    required String restaurantName,
    required String recipientName,
    required String fulfillment,
    required int dateTimeMillis,
    required int createdAtMillis,
    this.deliveryAddress = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       restaurantId = Value(restaurantId),
       restaurantName = Value(restaurantName),
       recipientName = Value(recipientName),
       fulfillment = Value(fulfillment),
       dateTimeMillis = Value(dateTimeMillis),
       createdAtMillis = Value(createdAtMillis);
  static Insertable<Order> custom({
    Expression<String>? id,
    Expression<String>? restaurantId,
    Expression<String>? restaurantName,
    Expression<String>? recipientName,
    Expression<String>? fulfillment,
    Expression<int>? dateTimeMillis,
    Expression<int>? createdAtMillis,
    Expression<String>? deliveryAddress,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (restaurantName != null) 'restaurant_name': restaurantName,
      if (recipientName != null) 'recipient_name': recipientName,
      if (fulfillment != null) 'fulfillment': fulfillment,
      if (dateTimeMillis != null) 'date_time_millis': dateTimeMillis,
      if (createdAtMillis != null) 'created_at_millis': createdAtMillis,
      if (deliveryAddress != null) 'delivery_address': deliveryAddress,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? restaurantId,
    Value<String>? restaurantName,
    Value<String>? recipientName,
    Value<String>? fulfillment,
    Value<int>? dateTimeMillis,
    Value<int>? createdAtMillis,
    Value<String?>? deliveryAddress,
    Value<int>? rowid,
  }) {
    return OrdersCompanion(
      id: id ?? this.id,
      restaurantId: restaurantId ?? this.restaurantId,
      restaurantName: restaurantName ?? this.restaurantName,
      recipientName: recipientName ?? this.recipientName,
      fulfillment: fulfillment ?? this.fulfillment,
      dateTimeMillis: dateTimeMillis ?? this.dateTimeMillis,
      createdAtMillis: createdAtMillis ?? this.createdAtMillis,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<String>(restaurantId.value);
    }
    if (restaurantName.present) {
      map['restaurant_name'] = Variable<String>(restaurantName.value);
    }
    if (recipientName.present) {
      map['recipient_name'] = Variable<String>(recipientName.value);
    }
    if (fulfillment.present) {
      map['fulfillment'] = Variable<String>(fulfillment.value);
    }
    if (dateTimeMillis.present) {
      map['date_time_millis'] = Variable<int>(dateTimeMillis.value);
    }
    if (createdAtMillis.present) {
      map['created_at_millis'] = Variable<int>(createdAtMillis.value);
    }
    if (deliveryAddress.present) {
      map['delivery_address'] = Variable<String>(deliveryAddress.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdersCompanion(')
          ..write('id: $id, ')
          ..write('restaurantId: $restaurantId, ')
          ..write('restaurantName: $restaurantName, ')
          ..write('recipientName: $recipientName, ')
          ..write('fulfillment: $fulfillment, ')
          ..write('dateTimeMillis: $dateTimeMillis, ')
          ..write('createdAtMillis: $createdAtMillis, ')
          ..write('deliveryAddress: $deliveryAddress, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OrderItemsTable extends OrderItems
    with TableInfo<$OrderItemsTable, OrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<int> localId = GeneratedColumn<int>(
    'local_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _orderIdMeta = const VerificationMeta(
    'orderId',
  );
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
    'order_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES orders (id)',
    ),
  );
  static const VerificationMeta _itemNameMeta = const VerificationMeta(
    'itemName',
  );
  @override
  late final GeneratedColumn<String> itemName = GeneratedColumn<String>(
    'item_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemDescriptionMeta = const VerificationMeta(
    'itemDescription',
  );
  @override
  late final GeneratedColumn<String> itemDescription = GeneratedColumn<String>(
    'item_description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemPriceMeta = const VerificationMeta(
    'itemPrice',
  );
  @override
  late final GeneratedColumn<double> itemPrice = GeneratedColumn<double>(
    'item_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemImageUrlMeta = const VerificationMeta(
    'itemImageUrl',
  );
  @override
  late final GeneratedColumn<String> itemImageUrl = GeneratedColumn<String>(
    'item_image_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    localId,
    orderId,
    itemName,
    itemDescription,
    itemPrice,
    itemImageUrl,
    quantity,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<OrderItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    }
    if (data.containsKey('order_id')) {
      context.handle(
        _orderIdMeta,
        orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('item_name')) {
      context.handle(
        _itemNameMeta,
        itemName.isAcceptableOrUnknown(data['item_name']!, _itemNameMeta),
      );
    } else if (isInserting) {
      context.missing(_itemNameMeta);
    }
    if (data.containsKey('item_description')) {
      context.handle(
        _itemDescriptionMeta,
        itemDescription.isAcceptableOrUnknown(
          data['item_description']!,
          _itemDescriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itemDescriptionMeta);
    }
    if (data.containsKey('item_price')) {
      context.handle(
        _itemPriceMeta,
        itemPrice.isAcceptableOrUnknown(data['item_price']!, _itemPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_itemPriceMeta);
    }
    if (data.containsKey('item_image_url')) {
      context.handle(
        _itemImageUrlMeta,
        itemImageUrl.isAcceptableOrUnknown(
          data['item_image_url']!,
          _itemImageUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itemImageUrlMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {localId};
  @override
  OrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderItem(
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}local_id'],
      )!,
      orderId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}order_id'],
      )!,
      itemName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_name'],
      )!,
      itemDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_description'],
      )!,
      itemPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}item_price'],
      )!,
      itemImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_image_url'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
    );
  }

  @override
  $OrderItemsTable createAlias(String alias) {
    return $OrderItemsTable(attachedDatabase, alias);
  }
}

class OrderItem extends DataClass implements Insertable<OrderItem> {
  final int localId;
  final String orderId;
  final String itemName;
  final String itemDescription;
  final double itemPrice;
  final String itemImageUrl;
  final int quantity;
  const OrderItem({
    required this.localId,
    required this.orderId,
    required this.itemName,
    required this.itemDescription,
    required this.itemPrice,
    required this.itemImageUrl,
    required this.quantity,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['local_id'] = Variable<int>(localId);
    map['order_id'] = Variable<String>(orderId);
    map['item_name'] = Variable<String>(itemName);
    map['item_description'] = Variable<String>(itemDescription);
    map['item_price'] = Variable<double>(itemPrice);
    map['item_image_url'] = Variable<String>(itemImageUrl);
    map['quantity'] = Variable<int>(quantity);
    return map;
  }

  OrderItemsCompanion toCompanion(bool nullToAbsent) {
    return OrderItemsCompanion(
      localId: Value(localId),
      orderId: Value(orderId),
      itemName: Value(itemName),
      itemDescription: Value(itemDescription),
      itemPrice: Value(itemPrice),
      itemImageUrl: Value(itemImageUrl),
      quantity: Value(quantity),
    );
  }

  factory OrderItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderItem(
      localId: serializer.fromJson<int>(json['localId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      itemName: serializer.fromJson<String>(json['itemName']),
      itemDescription: serializer.fromJson<String>(json['itemDescription']),
      itemPrice: serializer.fromJson<double>(json['itemPrice']),
      itemImageUrl: serializer.fromJson<String>(json['itemImageUrl']),
      quantity: serializer.fromJson<int>(json['quantity']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'localId': serializer.toJson<int>(localId),
      'orderId': serializer.toJson<String>(orderId),
      'itemName': serializer.toJson<String>(itemName),
      'itemDescription': serializer.toJson<String>(itemDescription),
      'itemPrice': serializer.toJson<double>(itemPrice),
      'itemImageUrl': serializer.toJson<String>(itemImageUrl),
      'quantity': serializer.toJson<int>(quantity),
    };
  }

  OrderItem copyWith({
    int? localId,
    String? orderId,
    String? itemName,
    String? itemDescription,
    double? itemPrice,
    String? itemImageUrl,
    int? quantity,
  }) => OrderItem(
    localId: localId ?? this.localId,
    orderId: orderId ?? this.orderId,
    itemName: itemName ?? this.itemName,
    itemDescription: itemDescription ?? this.itemDescription,
    itemPrice: itemPrice ?? this.itemPrice,
    itemImageUrl: itemImageUrl ?? this.itemImageUrl,
    quantity: quantity ?? this.quantity,
  );
  OrderItem copyWithCompanion(OrderItemsCompanion data) {
    return OrderItem(
      localId: data.localId.present ? data.localId.value : this.localId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      itemName: data.itemName.present ? data.itemName.value : this.itemName,
      itemDescription: data.itemDescription.present
          ? data.itemDescription.value
          : this.itemDescription,
      itemPrice: data.itemPrice.present ? data.itemPrice.value : this.itemPrice,
      itemImageUrl: data.itemImageUrl.present
          ? data.itemImageUrl.value
          : this.itemImageUrl,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderItem(')
          ..write('localId: $localId, ')
          ..write('orderId: $orderId, ')
          ..write('itemName: $itemName, ')
          ..write('itemDescription: $itemDescription, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('itemImageUrl: $itemImageUrl, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    localId,
    orderId,
    itemName,
    itemDescription,
    itemPrice,
    itemImageUrl,
    quantity,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderItem &&
          other.localId == this.localId &&
          other.orderId == this.orderId &&
          other.itemName == this.itemName &&
          other.itemDescription == this.itemDescription &&
          other.itemPrice == this.itemPrice &&
          other.itemImageUrl == this.itemImageUrl &&
          other.quantity == this.quantity);
}

class OrderItemsCompanion extends UpdateCompanion<OrderItem> {
  final Value<int> localId;
  final Value<String> orderId;
  final Value<String> itemName;
  final Value<String> itemDescription;
  final Value<double> itemPrice;
  final Value<String> itemImageUrl;
  final Value<int> quantity;
  const OrderItemsCompanion({
    this.localId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.itemName = const Value.absent(),
    this.itemDescription = const Value.absent(),
    this.itemPrice = const Value.absent(),
    this.itemImageUrl = const Value.absent(),
    this.quantity = const Value.absent(),
  });
  OrderItemsCompanion.insert({
    this.localId = const Value.absent(),
    required String orderId,
    required String itemName,
    required String itemDescription,
    required double itemPrice,
    required String itemImageUrl,
    required int quantity,
  }) : orderId = Value(orderId),
       itemName = Value(itemName),
       itemDescription = Value(itemDescription),
       itemPrice = Value(itemPrice),
       itemImageUrl = Value(itemImageUrl),
       quantity = Value(quantity);
  static Insertable<OrderItem> custom({
    Expression<int>? localId,
    Expression<String>? orderId,
    Expression<String>? itemName,
    Expression<String>? itemDescription,
    Expression<double>? itemPrice,
    Expression<String>? itemImageUrl,
    Expression<int>? quantity,
  }) {
    return RawValuesInsertable({
      if (localId != null) 'local_id': localId,
      if (orderId != null) 'order_id': orderId,
      if (itemName != null) 'item_name': itemName,
      if (itemDescription != null) 'item_description': itemDescription,
      if (itemPrice != null) 'item_price': itemPrice,
      if (itemImageUrl != null) 'item_image_url': itemImageUrl,
      if (quantity != null) 'quantity': quantity,
    });
  }

  OrderItemsCompanion copyWith({
    Value<int>? localId,
    Value<String>? orderId,
    Value<String>? itemName,
    Value<String>? itemDescription,
    Value<double>? itemPrice,
    Value<String>? itemImageUrl,
    Value<int>? quantity,
  }) {
    return OrderItemsCompanion(
      localId: localId ?? this.localId,
      orderId: orderId ?? this.orderId,
      itemName: itemName ?? this.itemName,
      itemDescription: itemDescription ?? this.itemDescription,
      itemPrice: itemPrice ?? this.itemPrice,
      itemImageUrl: itemImageUrl ?? this.itemImageUrl,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (localId.present) {
      map['local_id'] = Variable<int>(localId.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (itemName.present) {
      map['item_name'] = Variable<String>(itemName.value);
    }
    if (itemDescription.present) {
      map['item_description'] = Variable<String>(itemDescription.value);
    }
    if (itemPrice.present) {
      map['item_price'] = Variable<double>(itemPrice.value);
    }
    if (itemImageUrl.present) {
      map['item_image_url'] = Variable<String>(itemImageUrl.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderItemsCompanion(')
          ..write('localId: $localId, ')
          ..write('orderId: $orderId, ')
          ..write('itemName: $itemName, ')
          ..write('itemDescription: $itemDescription, ')
          ..write('itemPrice: $itemPrice, ')
          ..write('itemImageUrl: $itemImageUrl, ')
          ..write('quantity: $quantity')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteCarsTable favoriteCars = $FavoriteCarsTable(this);
  late final $CartEntriesTable cartEntries = $CartEntriesTable(this);
  late final $OrdersTable orders = $OrdersTable(this);
  late final $OrderItemsTable orderItems = $OrderItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    favoriteCars,
    cartEntries,
    orders,
    orderItems,
  ];
}

typedef $$FavoriteCarsTableCreateCompanionBuilder =
    FavoriteCarsCompanion Function({required String carId, Value<int> rowid});
typedef $$FavoriteCarsTableUpdateCompanionBuilder =
    FavoriteCarsCompanion Function({Value<String> carId, Value<int> rowid});

class $$FavoriteCarsTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteCarsTable> {
  $$FavoriteCarsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get carId => $composableBuilder(
    column: $table.carId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteCarsTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteCarsTable> {
  $$FavoriteCarsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get carId => $composableBuilder(
    column: $table.carId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteCarsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteCarsTable> {
  $$FavoriteCarsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get carId =>
      $composableBuilder(column: $table.carId, builder: (column) => column);
}

class $$FavoriteCarsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteCarsTable,
          FavoriteCar,
          $$FavoriteCarsTableFilterComposer,
          $$FavoriteCarsTableOrderingComposer,
          $$FavoriteCarsTableAnnotationComposer,
          $$FavoriteCarsTableCreateCompanionBuilder,
          $$FavoriteCarsTableUpdateCompanionBuilder,
          (
            FavoriteCar,
            BaseReferences<_$AppDatabase, $FavoriteCarsTable, FavoriteCar>,
          ),
          FavoriteCar,
          PrefetchHooks Function()
        > {
  $$FavoriteCarsTableTableManager(_$AppDatabase db, $FavoriteCarsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteCarsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteCarsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteCarsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> carId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FavoriteCarsCompanion(carId: carId, rowid: rowid),
          createCompanionCallback:
              ({
                required String carId,
                Value<int> rowid = const Value.absent(),
              }) => FavoriteCarsCompanion.insert(carId: carId, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteCarsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteCarsTable,
      FavoriteCar,
      $$FavoriteCarsTableFilterComposer,
      $$FavoriteCarsTableOrderingComposer,
      $$FavoriteCarsTableAnnotationComposer,
      $$FavoriteCarsTableCreateCompanionBuilder,
      $$FavoriteCarsTableUpdateCompanionBuilder,
      (
        FavoriteCar,
        BaseReferences<_$AppDatabase, $FavoriteCarsTable, FavoriteCar>,
      ),
      FavoriteCar,
      PrefetchHooks Function()
    >;
typedef $$CartEntriesTableCreateCompanionBuilder =
    CartEntriesCompanion Function({
      required String itemName,
      required String itemDescription,
      required double itemPrice,
      required String itemImageUrl,
      required String restaurantId,
      required String restaurantName,
      required int quantity,
      required int rentalDays,
      required bool withInsurance,
      required bool withDriver,
      required double totalPrice,
      Value<int> rowid,
    });
typedef $$CartEntriesTableUpdateCompanionBuilder =
    CartEntriesCompanion Function({
      Value<String> itemName,
      Value<String> itemDescription,
      Value<double> itemPrice,
      Value<String> itemImageUrl,
      Value<String> restaurantId,
      Value<String> restaurantName,
      Value<int> quantity,
      Value<int> rentalDays,
      Value<bool> withInsurance,
      Value<bool> withDriver,
      Value<double> totalPrice,
      Value<int> rowid,
    });

class $$CartEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CartEntriesTable> {
  $$CartEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemDescription => $composableBuilder(
    column: $table.itemDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get itemPrice => $composableBuilder(
    column: $table.itemPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemImageUrl => $composableBuilder(
    column: $table.itemImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rentalDays => $composableBuilder(
    column: $table.rentalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get withInsurance => $composableBuilder(
    column: $table.withInsurance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get withDriver => $composableBuilder(
    column: $table.withDriver,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CartEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CartEntriesTable> {
  $$CartEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemDescription => $composableBuilder(
    column: $table.itemDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get itemPrice => $composableBuilder(
    column: $table.itemPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemImageUrl => $composableBuilder(
    column: $table.itemImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rentalDays => $composableBuilder(
    column: $table.rentalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get withInsurance => $composableBuilder(
    column: $table.withInsurance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get withDriver => $composableBuilder(
    column: $table.withDriver,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartEntriesTable> {
  $$CartEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<String> get itemDescription => $composableBuilder(
    column: $table.itemDescription,
    builder: (column) => column,
  );

  GeneratedColumn<double> get itemPrice =>
      $composableBuilder(column: $table.itemPrice, builder: (column) => column);

  GeneratedColumn<String> get itemImageUrl => $composableBuilder(
    column: $table.itemImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get rentalDays => $composableBuilder(
    column: $table.rentalDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get withInsurance => $composableBuilder(
    column: $table.withInsurance,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get withDriver => $composableBuilder(
    column: $table.withDriver,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );
}

class $$CartEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartEntriesTable,
          CartEntry,
          $$CartEntriesTableFilterComposer,
          $$CartEntriesTableOrderingComposer,
          $$CartEntriesTableAnnotationComposer,
          $$CartEntriesTableCreateCompanionBuilder,
          $$CartEntriesTableUpdateCompanionBuilder,
          (
            CartEntry,
            BaseReferences<_$AppDatabase, $CartEntriesTable, CartEntry>,
          ),
          CartEntry,
          PrefetchHooks Function()
        > {
  $$CartEntriesTableTableManager(_$AppDatabase db, $CartEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> itemName = const Value.absent(),
                Value<String> itemDescription = const Value.absent(),
                Value<double> itemPrice = const Value.absent(),
                Value<String> itemImageUrl = const Value.absent(),
                Value<String> restaurantId = const Value.absent(),
                Value<String> restaurantName = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> rentalDays = const Value.absent(),
                Value<bool> withInsurance = const Value.absent(),
                Value<bool> withDriver = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CartEntriesCompanion(
                itemName: itemName,
                itemDescription: itemDescription,
                itemPrice: itemPrice,
                itemImageUrl: itemImageUrl,
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                quantity: quantity,
                rentalDays: rentalDays,
                withInsurance: withInsurance,
                withDriver: withDriver,
                totalPrice: totalPrice,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String itemName,
                required String itemDescription,
                required double itemPrice,
                required String itemImageUrl,
                required String restaurantId,
                required String restaurantName,
                required int quantity,
                required int rentalDays,
                required bool withInsurance,
                required bool withDriver,
                required double totalPrice,
                Value<int> rowid = const Value.absent(),
              }) => CartEntriesCompanion.insert(
                itemName: itemName,
                itemDescription: itemDescription,
                itemPrice: itemPrice,
                itemImageUrl: itemImageUrl,
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                quantity: quantity,
                rentalDays: rentalDays,
                withInsurance: withInsurance,
                withDriver: withDriver,
                totalPrice: totalPrice,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CartEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartEntriesTable,
      CartEntry,
      $$CartEntriesTableFilterComposer,
      $$CartEntriesTableOrderingComposer,
      $$CartEntriesTableAnnotationComposer,
      $$CartEntriesTableCreateCompanionBuilder,
      $$CartEntriesTableUpdateCompanionBuilder,
      (CartEntry, BaseReferences<_$AppDatabase, $CartEntriesTable, CartEntry>),
      CartEntry,
      PrefetchHooks Function()
    >;
typedef $$OrdersTableCreateCompanionBuilder =
    OrdersCompanion Function({
      required String id,
      required String restaurantId,
      required String restaurantName,
      required String recipientName,
      required String fulfillment,
      required int dateTimeMillis,
      required int createdAtMillis,
      Value<String?> deliveryAddress,
      Value<int> rowid,
    });
typedef $$OrdersTableUpdateCompanionBuilder =
    OrdersCompanion Function({
      Value<String> id,
      Value<String> restaurantId,
      Value<String> restaurantName,
      Value<String> recipientName,
      Value<String> fulfillment,
      Value<int> dateTimeMillis,
      Value<int> createdAtMillis,
      Value<String?> deliveryAddress,
      Value<int> rowid,
    });

final class $$OrdersTableReferences
    extends BaseReferences<_$AppDatabase, $OrdersTable, Order> {
  $$OrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrderItemsTable, List<OrderItem>>
  _orderItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.orderItems,
    aliasName: $_aliasNameGenerator(db.orders.id, db.orderItems.orderId),
  );

  $$OrderItemsTableProcessedTableManager get orderItemsRefs {
    final manager = $$OrderItemsTableTableManager(
      $_db,
      $_db.orderItems,
    ).filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_orderItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdersTableFilterComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipientName => $composableBuilder(
    column: $table.recipientName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fulfillment => $composableBuilder(
    column: $table.fulfillment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dateTimeMillis => $composableBuilder(
    column: $table.dateTimeMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deliveryAddress => $composableBuilder(
    column: $table.deliveryAddress,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> orderItemsRefs(
    Expression<bool> Function($$OrderItemsTableFilterComposer f) f,
  ) {
    final $$OrderItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableFilterComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipientName => $composableBuilder(
    column: $table.recipientName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fulfillment => $composableBuilder(
    column: $table.fulfillment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dateTimeMillis => $composableBuilder(
    column: $table.dateTimeMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deliveryAddress => $composableBuilder(
    column: $table.deliveryAddress,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdersTable> {
  $$OrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get restaurantId => $composableBuilder(
    column: $table.restaurantId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get restaurantName => $composableBuilder(
    column: $table.restaurantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recipientName => $composableBuilder(
    column: $table.recipientName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fulfillment => $composableBuilder(
    column: $table.fulfillment,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dateTimeMillis => $composableBuilder(
    column: $table.dateTimeMillis,
    builder: (column) => column,
  );

  GeneratedColumn<int> get createdAtMillis => $composableBuilder(
    column: $table.createdAtMillis,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deliveryAddress => $composableBuilder(
    column: $table.deliveryAddress,
    builder: (column) => column,
  );

  Expression<T> orderItemsRefs<T extends Object>(
    Expression<T> Function($$OrderItemsTableAnnotationComposer a) f,
  ) {
    final $$OrderItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.orderItems,
      getReferencedColumn: (t) => t.orderId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrderItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.orderItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdersTable,
          Order,
          $$OrdersTableFilterComposer,
          $$OrdersTableOrderingComposer,
          $$OrdersTableAnnotationComposer,
          $$OrdersTableCreateCompanionBuilder,
          $$OrdersTableUpdateCompanionBuilder,
          (Order, $$OrdersTableReferences),
          Order,
          PrefetchHooks Function({bool orderItemsRefs})
        > {
  $$OrdersTableTableManager(_$AppDatabase db, $OrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> restaurantId = const Value.absent(),
                Value<String> restaurantName = const Value.absent(),
                Value<String> recipientName = const Value.absent(),
                Value<String> fulfillment = const Value.absent(),
                Value<int> dateTimeMillis = const Value.absent(),
                Value<int> createdAtMillis = const Value.absent(),
                Value<String?> deliveryAddress = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrdersCompanion(
                id: id,
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                recipientName: recipientName,
                fulfillment: fulfillment,
                dateTimeMillis: dateTimeMillis,
                createdAtMillis: createdAtMillis,
                deliveryAddress: deliveryAddress,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String restaurantId,
                required String restaurantName,
                required String recipientName,
                required String fulfillment,
                required int dateTimeMillis,
                required int createdAtMillis,
                Value<String?> deliveryAddress = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OrdersCompanion.insert(
                id: id,
                restaurantId: restaurantId,
                restaurantName: restaurantName,
                recipientName: recipientName,
                fulfillment: fulfillment,
                dateTimeMillis: dateTimeMillis,
                createdAtMillis: createdAtMillis,
                deliveryAddress: deliveryAddress,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$OrdersTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({orderItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (orderItemsRefs) db.orderItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (orderItemsRefs)
                    await $_getPrefetchedData<Order, $OrdersTable, OrderItem>(
                      currentTable: table,
                      referencedTable: $$OrdersTableReferences
                          ._orderItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$OrdersTableReferences(db, table, p0).orderItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.orderId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$OrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdersTable,
      Order,
      $$OrdersTableFilterComposer,
      $$OrdersTableOrderingComposer,
      $$OrdersTableAnnotationComposer,
      $$OrdersTableCreateCompanionBuilder,
      $$OrdersTableUpdateCompanionBuilder,
      (Order, $$OrdersTableReferences),
      Order,
      PrefetchHooks Function({bool orderItemsRefs})
    >;
typedef $$OrderItemsTableCreateCompanionBuilder =
    OrderItemsCompanion Function({
      Value<int> localId,
      required String orderId,
      required String itemName,
      required String itemDescription,
      required double itemPrice,
      required String itemImageUrl,
      required int quantity,
    });
typedef $$OrderItemsTableUpdateCompanionBuilder =
    OrderItemsCompanion Function({
      Value<int> localId,
      Value<String> orderId,
      Value<String> itemName,
      Value<String> itemDescription,
      Value<double> itemPrice,
      Value<String> itemImageUrl,
      Value<int> quantity,
    });

final class $$OrderItemsTableReferences
    extends BaseReferences<_$AppDatabase, $OrderItemsTable, OrderItem> {
  $$OrderItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdersTable _orderIdTable(_$AppDatabase db) => db.orders.createAlias(
    $_aliasNameGenerator(db.orderItems.orderId, db.orders.id),
  );

  $$OrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$OrdersTableTableManager(
      $_db,
      $_db.orders,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemDescription => $composableBuilder(
    column: $table.itemDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get itemPrice => $composableBuilder(
    column: $table.itemPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemImageUrl => $composableBuilder(
    column: $table.itemImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdersTableFilterComposer get orderId {
    final $$OrdersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableFilterComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemName => $composableBuilder(
    column: $table.itemName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemDescription => $composableBuilder(
    column: $table.itemDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get itemPrice => $composableBuilder(
    column: $table.itemPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemImageUrl => $composableBuilder(
    column: $table.itemImageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdersTableOrderingComposer get orderId {
    final $$OrdersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableOrderingComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderItemsTable> {
  $$OrderItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<String> get itemName =>
      $composableBuilder(column: $table.itemName, builder: (column) => column);

  GeneratedColumn<String> get itemDescription => $composableBuilder(
    column: $table.itemDescription,
    builder: (column) => column,
  );

  GeneratedColumn<double> get itemPrice =>
      $composableBuilder(column: $table.itemPrice, builder: (column) => column);

  GeneratedColumn<String> get itemImageUrl => $composableBuilder(
    column: $table.itemImageUrl,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  $$OrdersTableAnnotationComposer get orderId {
    final $$OrdersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.orderId,
      referencedTable: $db.orders,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdersTableAnnotationComposer(
            $db: $db,
            $table: $db.orders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrderItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrderItemsTable,
          OrderItem,
          $$OrderItemsTableFilterComposer,
          $$OrderItemsTableOrderingComposer,
          $$OrderItemsTableAnnotationComposer,
          $$OrderItemsTableCreateCompanionBuilder,
          $$OrderItemsTableUpdateCompanionBuilder,
          (OrderItem, $$OrderItemsTableReferences),
          OrderItem,
          PrefetchHooks Function({bool orderId})
        > {
  $$OrderItemsTableTableManager(_$AppDatabase db, $OrderItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                Value<String> orderId = const Value.absent(),
                Value<String> itemName = const Value.absent(),
                Value<String> itemDescription = const Value.absent(),
                Value<double> itemPrice = const Value.absent(),
                Value<String> itemImageUrl = const Value.absent(),
                Value<int> quantity = const Value.absent(),
              }) => OrderItemsCompanion(
                localId: localId,
                orderId: orderId,
                itemName: itemName,
                itemDescription: itemDescription,
                itemPrice: itemPrice,
                itemImageUrl: itemImageUrl,
                quantity: quantity,
              ),
          createCompanionCallback:
              ({
                Value<int> localId = const Value.absent(),
                required String orderId,
                required String itemName,
                required String itemDescription,
                required double itemPrice,
                required String itemImageUrl,
                required int quantity,
              }) => OrderItemsCompanion.insert(
                localId: localId,
                orderId: orderId,
                itemName: itemName,
                itemDescription: itemDescription,
                itemPrice: itemPrice,
                itemImageUrl: itemImageUrl,
                quantity: quantity,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OrderItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (orderId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.orderId,
                                referencedTable: $$OrderItemsTableReferences
                                    ._orderIdTable(db),
                                referencedColumn: $$OrderItemsTableReferences
                                    ._orderIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OrderItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrderItemsTable,
      OrderItem,
      $$OrderItemsTableFilterComposer,
      $$OrderItemsTableOrderingComposer,
      $$OrderItemsTableAnnotationComposer,
      $$OrderItemsTableCreateCompanionBuilder,
      $$OrderItemsTableUpdateCompanionBuilder,
      (OrderItem, $$OrderItemsTableReferences),
      OrderItem,
      PrefetchHooks Function({bool orderId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteCarsTableTableManager get favoriteCars =>
      $$FavoriteCarsTableTableManager(_db, _db.favoriteCars);
  $$CartEntriesTableTableManager get cartEntries =>
      $$CartEntriesTableTableManager(_db, _db.cartEntries);
  $$OrdersTableTableManager get orders =>
      $$OrdersTableTableManager(_db, _db.orders);
  $$OrderItemsTableTableManager get orderItems =>
      $$OrderItemsTableTableManager(_db, _db.orderItems);
}
