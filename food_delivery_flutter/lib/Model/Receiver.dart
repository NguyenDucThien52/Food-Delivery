class Receiver{
  int receiver_id;
  String receiver_name;
  String receiver_phone;

  Receiver({required this.receiver_id, required this.receiver_name, required this.receiver_phone});

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
        receiver_id: json['receiver_id'],
        receiver_name: json['receiver_name'],
        receiver_phone: json['receiver_phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiver_id': receiver_id,
      'receiver_name': receiver_name,
      'receiver_phone': receiver_phone,
    };
  }

  factory Receiver.toJson(Map<String, dynamic> json) {
    return Receiver(
        receiver_id: json['receiver_id'],
        receiver_name: json['receiver_name'],
        receiver_phone: json['receiver_phone'],
    );
  }
}