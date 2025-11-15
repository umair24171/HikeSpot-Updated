// ═══════════════════════════════════════════════════════════════
// PART 1: Add Chat Helper Methods
// ═══════════════════════════════════════════════════════════════

// Add this new file: lib/helper/chat_helper.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:hikespot/app/constants/app_constants.dart';
import 'package:hikespot/core/di/service_locator_imports.dart';
import 'package:hikespot/data/models/auth-model/auth_model.dart';
import 'package:hikespot/pages/chats/data/model/chat/chat_model.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/get_chats_cubit.dart';
import 'package:hikespot/pages/chats/presentation/bloc/cubit/send_message_cubit.dart';
import 'package:hikespot/routes/routes_imports.gr.dart';
import 'package:uuid/uuid.dart';

class ChatHelper {
  static Future<void> openChatWithUser(
    BuildContext context, {
    required String userId,
    required String currentUserId,
  }) async {
    try {
      print("🔍 Looking for chat between $currentUserId and $userId");
      
      // Check if chat already exists
      QuerySnapshot existingChats = await AppConstants.firestore
          .collection("chats")
          .where('participiants', arrayContains: currentUserId)
          .get();
      
      ChatModel? existingChat;
      
      for (var doc in existingChats.docs) {
        ChatModel chat = ChatModel.fromJson(doc.data() as Map<String, dynamic>);
        if (chat.participiants.contains(userId)) {
          existingChat = chat;
          print("✅ Found existing chat: ${chat.chatId}");
          break;
        }
      }
      
      if (existingChat == null) {
        // Create new chat
        print("📝 Creating new chat...");
        String chatId = const Uuid().v4();
        
        ChatModel newChat = ChatModel(
          chatId: chatId,
          participiants: [currentUserId, userId],
          lastMessage: "",
          lastMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
          // unreadCount: 0,
        );
        
        await AppConstants.firestore
            .collection("chats")
            .doc(chatId)
            .set(newChat.toJson());
        
        existingChat = newChat;
        print("✅ Chat created: $chatId");
      }
      
      // Get other user data
      DocumentSnapshot userDoc = await AppConstants.firestore
          .collection("users")
          .doc(userId)
          .get();
      
      AuthModel otherUser = AuthModel.fromJson(
        userDoc.data() as Map<String, dynamic>
      );
      
      // Set chat data in cubits
      final SendMessageCubit sendMessageCubit = Di().sl<SendMessageCubit>();
      final GetChatsCubit getChatsCubit = Di().sl<GetChatsCubit>();
      
      sendMessageCubit.getOtherUserData(otherUser);
      getChatsCubit.getChatData(existingChat);
      
      // Navigate to chat
      if (context.mounted) {
        AutoRouter.of(context).push(const ChatPageRoute());
      }
      
    } catch (e) {
      print("❌ Error opening chat: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error opening chat: $e")),
        );
      }
    }
  }
}
