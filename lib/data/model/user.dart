class User {
  String? id;
  String? name;
  String? email;

  User({required this.name, required this.email, this.id});

  Map<String, dynamic> toFirebase() {
    return {'name': name, 'email': email, 'id': id};
  }

  User.fromFireStore(Map<String, dynamic>? data) {
    name = data?['name'];
    email = data?['email'];
    id = data?['id'];
  }
}
