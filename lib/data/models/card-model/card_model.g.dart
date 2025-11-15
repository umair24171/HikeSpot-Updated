// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardModelImpl _$$CardModelImplFromJson(Map<String, dynamic> json) =>
    _$CardModelImpl(
      emailAddress: json['emailAddress'] as String? ?? "",
      cardNumber: json['cardNumber'] as String? ?? "",
      cardHolderName: json['cardHolderName'] as String? ?? "",
      cardExpiryDate: json['cardExpiryDate'] as String? ?? "",
      cardCvv: json['cardCvv'] as String? ?? "",
      cardType: json['cardType'] as String? ?? "",
      country: json['country'] as String? ?? "",
      zipCode: json['zipCode'] as String? ?? "",
    );

Map<String, dynamic> _$$CardModelImplToJson(_$CardModelImpl instance) =>
    <String, dynamic>{
      'emailAddress': instance.emailAddress,
      'cardNumber': instance.cardNumber,
      'cardHolderName': instance.cardHolderName,
      'cardExpiryDate': instance.cardExpiryDate,
      'cardCvv': instance.cardCvv,
      'cardType': instance.cardType,
      'country': instance.country,
      'zipCode': instance.zipCode,
    };
