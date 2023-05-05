// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlaseModel {
    final String userId;
    final String adress;
    final String tittle;
    final String image;
    final String date;
    final String comments;
    final String lat;
    final String lan;

    PlaseModel({
        required this.userId,
        required this.adress,
        required this.tittle,
        required this.image,
        required this.date,
        required this.comments,
        required this.lat,
        required this.lan,
    });

    factory PlaseModel.fromJson(Map<dynamic, dynamic> json) => PlaseModel(
        userId: json["userId"],
        adress: json["adress"],
        tittle: json["tittle"],
        image: json["image"],
        date: json["date"],
        comments: json["comments"],
        lat: json["lat"],
        lan: json["lan"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "adress": adress,
        "tittle": tittle,
        "image": image,
        "date": date,
        "comments": comments,
        "lat": lat,
        "lan": lan,
    };

  PlaseModel copyWith({
    String? userId,
    String? adress,
    String? tittle,
    String? image,
    String? date,
    String? comments,
    String? lat,
    String? lan,
  }) {
    return PlaseModel(
      userId: userId ?? this.userId,
      adress: adress ?? this.adress,
      tittle: tittle ?? this.tittle,
      image: image ?? this.image,
      date: date ?? this.date,
      comments: comments ?? this.comments,
      lat: lat ?? this.lat,
      lan: lan ?? this.lan,
    );
  }
}
