import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType { text, audio, image, video}
enum MessageStatus { not_sent, not_view, viewed}

class ChatMessage {
  final String text, sendBy, imgUrl;
  final MessageType messageType;
  final MessageStatus messageStatus;
  final  Timestamp ts;

  ChatMessage({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.sendBy,
    required this.ts,
    required this.imgUrl,
  });
}

// List demoChatMessages = [
//   ChatMessage(
//     text: "Flow",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "New Starts",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_sent,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.audio,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "",
//     messageType: ChatMessageType.video,
//     messageStatus: MessageStatus.viewed,
//     isSender: true,
//   ),
//   ChatMessage(
//     text: "Error happend",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_sent,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Yowai Boku dakara",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.viewed,
//     isSender: false,
//   ),
//   ChatMessage(
//     text: "Your Song",
//     messageType: ChatMessageType.text,
//     messageStatus: MessageStatus.not_view,
//     isSender: true,
//   ),
//
// ];