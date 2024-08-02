class BookModel {
  String? id;
  String? title;
  String? subtitle;
  List<dynamic>? authors;
  String? date;
  String? description;
  int? pageCount;
  String? maturityRating;
  String? thumbnail;
  double? price;
  String? priceCurrency;
  String? link;

  BookModel.fromJson(json) {
    id = json["id"];
    title = json["volumeInfo"]["title"];
    subtitle = json["volumeInfo"]["subtitle"];
    authors = json["volumeInfo"]["authors"];
    date = json["volumeInfo"]["publisedDate"];
    description = json["volumeInfo"]["description"];
    pageCount = json["volumeInfo"]["pageCount"];
    maturityRating = json["volumeInfo"]["maturityRating"];
    thumbnail = json["volumeInfo"]["imageLinks"]["thumbnail"];
    price = json["saleInfo"]["listPrice"]?["amount"];
    priceCurrency = json["saleInfo"]["listPrice"]?["currencyCode"];
    link = json["saleInfo"]["buyLink"];
  }
}