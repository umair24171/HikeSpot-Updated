import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_model.g.dart';
part 'card_model.freezed.dart';


@freezed
class CardModel with _$CardModel{
  const factory CardModel({
    @Default("") String emailAddress,
    @Default("") String cardNumber,
    @Default("") String cardHolderName,
    @Default("") String cardExpiryDate,
    @Default("") String cardCvv,
    @Default("") String cardType,
    @Default("") String country,
    @Default("") String zipCode,
  }) = _CardModel;

  factory CardModel.fromJson(Map<String, dynamic> json) => _$CardModelFromJson(json);
}