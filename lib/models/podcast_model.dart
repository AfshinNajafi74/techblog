class PodcastModel {
  String? id;
  String? title;
  String? poster;
  String? publisher;
  String? view;
  String? createdAt;

  PodcastModel({required this.id, required this.title, required this.poster, required this.publisher, required this.view,
      required this.createdAt});

  PodcastModel.fromJson(Map<String,dynamic> element){
    id = element["id"];
    title = element["title"];
    poster = element["poster"];
    publisher = element["publisher"];
    view = element["view"];
    createdAt = element["created_at"];
  }

}

// "id": "5",
// "title": "تکچی - قسمت 70 گوگل مورد تایید ما نیست!!!!",
// "poster": "/Techblog/assets/upload/images/podcast/images/tech_chi.jpg",
// "publisher": "سینا جعفری",
// "view": "96",
// "created_at": "۱۴۰۱/۲/۱۶"