class PlaceModel {
  final int id;
  final String name;
  final String image;
  final String address;
  final String city;
  final String country;
  final int rating;
  final int price;
  final String createBy;
  final String createAt;
  final String updateBy;
  final String updateAt;

  PlaceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
    required this.city,
    required this.country,
    required this.rating,
    required this.price,
    required this.createBy,
    required this.createAt,
    required this.updateBy,
    required this.updateAt,
  });
}
