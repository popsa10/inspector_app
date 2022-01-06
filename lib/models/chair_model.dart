class ChairModel {
  int? id;
  String? title;
  String? desc;
  String? status;
  String? img;
  String? time;

  ChairModel.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    status = json['status'];
    img = json['img'];
    time = json['time'];

  }
}