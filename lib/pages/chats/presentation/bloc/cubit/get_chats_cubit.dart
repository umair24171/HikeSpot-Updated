import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hikespot/utils/enums.dart';
import 'package:uuid/uuid.dart';
import '../../../../../app/constants/app_constants.dart';
import '../../../../../blocs/cubits/auth_cubit.dart';
import '../../../../../core/di/service_locator_imports.dart';
import '../../../../../data/models/auth-model/auth_model.dart';
import '../../../data/model/chat/chat_model.dart';
import '../../../domain/usecase/get_chats_usecase.dart';

part '../state/get_chats_state.dart';

class GetChatsCubit extends Cubit<GetChatsState> {
  final GetChatsUsecase getChatsUsecase;
  GetChatsCubit(this.getChatsUsecase) : super(GetChatsInitial());

  List<ChatModel> chats = [];
  String otherUserId = "NBthfPLZDHNLj";
  ChatModel chatData = ChatModel();
  ChatType chatType = ChatType.driverChat;
  List<String> participiants = [];
  List<ChatModel> searchingChats = [];
  bool isSearching = false;

  /// get the chats users data
  List<AuthModel> users = [];
  // get user
  getChatUser(AuthModel user) {
    emit(GetChatsLoading());
    users.add(user);
    emit(GetChatsLoaded());
  }

  // get chat type
  getChatType(ChatType chatType) {
    emit(GetChatsLoading());
    this.chatType = chatType;
    emit(GetChatsLoaded());
  }

  // get the chat data from tap on the chat
  getChatData(ChatModel chatData) {
    emit(GetChatsLoading());
    this.chatData = chatData;
    emit(GetChatsLoaded());
  }

  /// get the chats
  getChatsLocal(List<ChatModel> chats) {
    emit(GetChatsLoading());
    chats.sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));
    this.chats = chats.where((element) => element.participiants.length != 1).toList();
    emit(GetChatsLoaded());
  }

  // get the other user id
  getOtherUserId(String otherUserId) {
    emit(GetChatsLoading());
    this.otherUserId = otherUserId;
    emit(GetChatsLoaded());
  }

  // add the participiants
  addParticipiants(String participiant) {
    emit(GetChatsLoading());
    if (participiants.contains(participiant)) {
      participiants.remove(participiant);
    } else {
      participiants.add(participiant);
    }
    emit(GetChatsLoaded());
  }

  // get chats from the database
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatsDb() {
    return getChatsUsecase.getChats();
  }

  ChatModel get addChatData => ChatModel(
        chatId: chatType == ChatType.chatSupport
            ? Di().sl<AuthCubit>().authData.uid
            : const Uuid().v4(),
        participiants: participiants,
        lastMessage: "",
        chatType: chatType.name,
        createdAt: DateTime.now().microsecondsSinceEpoch.toString(),
        lastMessageSenderId: "",
        lastMessageTime: "",
        chatAdmin: Di().sl<AuthCubit>().authData.uid,
        chatImage: Di().sl<AuthCubit>().authData.imageUrl,
        chatName: "${Di().sl<AuthCubit>().authData.username} Group",
      );

  // add chat data to the database
  addChatDataDb() async {
    emit(GetChatsLoading());
    participiants.add(Di().sl<AuthCubit>().authData.uid);
    getChatData(addChatData);
    emit(GetChatsLoaded());
    var result = await getChatsUsecase.addChat(addChatData);
    result.fold((l) {
      emit(GetChatsError());
    }, (r) {
      participiants = [];
      emit(GetChatsLoaded());
    });
  }

  // get chat user data
  Stream<DocumentSnapshot<Map<String, dynamic>>> getChatUserData(
      String userId) {
    var data = AppConstants.firestore
        .collection(AppConstants.usersKey)
        .doc(userId)
        .snapshots();
    return data;
  }

  /// search the chats
  searchChatsToggle() {
    emit(GetChatsLoading());
    isSearching = !isSearching;
    emit(GetChatsLoaded());
  }

  List<ChatModel> searchChats(String query) {
    emit(GetChatsLoading());
    isSearching = true;
    // search the data in the chats and user list
    searchingChats = chats
        .where((element) => element.chatName.toLowerCase().contains(query))
        .toList();

    emit(GetChatsLoaded());
    return searchingChats;
  }

  /// get the unread message stream
  Stream<QuerySnapshot<Map<String, dynamic>>> getUnreadMessageStream(
      String chatId) {
    return AppConstants.firestore
        .collection(AppConstants.chatsKey)
        .doc(chatId)
        .collection(AppConstants.messagesKey)
        .where('read', isEqualTo: "")
        .where('senderId', isNotEqualTo: Di().sl<AuthCubit>().authData.uid)
        .snapshots();
  }

  ///update the message read status
  updateMessageReadStatus(String messageId) async {
    emit(GetChatsLoading());
    await AppConstants.firestore
        .collection(AppConstants.chatsKey)
        .doc(chatData.chatId)
        .collection(AppConstants.messagesKey)
        .doc(messageId)
        .update({
      'read': DateTime.now().microsecondsSinceEpoch.toString(),
    });
  }

  ChatModel get supportChatData => ChatModel(
        chatId: const Uuid().v4(),
        participiants: participiants,
        lastMessage: "",
        chatType: ChatType.chatSupport.name,
        createdAt: DateTime.now().microsecondsSinceEpoch.toString(),
        lastMessageSenderId: "",
        lastMessageTime: "",
        chatAdmin: Di().sl<AuthCubit>().authData.uid,
        chatImage: Di().sl<AuthCubit>().authData.imageUrl,
        chatName: "${Di().sl<AuthCubit>().authData.username} Group",
      );
}
