

class Course {
  String? name;
  String? id;
  String? fullPath;
  String? price;

  Course({this.name, this.fullPath , this.id , this.price});
  Map<String, dynamic> toFirebase() {
    return {'name': name, 'fullPath': fullPath, 'id' : id , 'price' : price};
  }

  Course.fromFireStore(Map<String, dynamic>? data) {
    name = data?['name'];
    fullPath = data?['fullPath'];
    id = data?['id'];
    price = data?['price'];
  }

  @override
  bool operator ==(Object other) {
  if (identical(this, other)) return true;
  if (other is! Course) return false;
  return
  name?.toLowerCase() == other.name?.toLowerCase() ;
  }

  @override
  int get hashCode => name!.toLowerCase().hashCode ;

  }


