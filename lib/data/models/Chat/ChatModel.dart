class ChatModel{
  List<ChatItem>? chatList;

  ChatModel({this.chatList});
}

class ChatItem{
  String? message;
  String? username;
  String? room;

  ChatItem({this.message, this.username, this.room});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    data['username'] = username;
    data['room'] = room;
    return data;
  }

  ChatItem.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    username = json['username'];
    room = json['room'];
  }

  @override
  String toString() {
    return 'ChatItem{message: $message, username: $username, room: $room}';
  }
}