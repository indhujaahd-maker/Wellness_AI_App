import 'package:flutter/material.dart';
import '../services/ai_service.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController messageController =
      TextEditingController();

  final ScrollController scrollController =
      ScrollController();

  final AIService aiService = AIService();

  List<Map<String, String>> messages = [];

  bool isLoading = false;

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  // --------------------------------------------------
  // Send message to Python AI
  // --------------------------------------------------

  Future<void> sendMessage() async {
    final message = messageController.text.trim();

    if (message.isEmpty || isLoading) {
      return;
    }

    setState(() {
      messages.add({
        'sender': 'user',
        'message': message,
      });

      messageController.clear();

      isLoading = true;
    });

    scrollToBottom();

    try {
      final response = await aiService.sendMessage(message);

      if (!mounted) return;

      setState(() {
        messages.add({
          'sender': 'ai',
          'message': response,
        });

        isLoading = false;
      });

      scrollToBottom();
    } catch (e) {
      if (!mounted) return;

      setState(() {
        messages.add({
          'sender': 'ai',
          'message':
              'I am having trouble connecting right now. Please try again.',
        });

        isLoading = false;
      });

      scrollToBottom();
    }
  }

  // --------------------------------------------------
  // Scroll to latest message
  // --------------------------------------------------

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // --------------------------------------------------
  // Delete conversation
  // --------------------------------------------------

  Future<void> deleteConversation() async {
    final result = await aiService.deleteConversation();

    if (!mounted) return;

    setState(() {
      messages.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(result),
      ),
    );
  }

  // --------------------------------------------------
  // Message bubble
  // --------------------------------------------------

  Widget buildMessageBubble(
    String message,
    bool isUser,
  ) {
    return Align(
      alignment:
          isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 11,
        ),
        constraints: BoxConstraints(
          maxWidth:
              MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? Colors.blueGrey
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: isUser
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AI Wellness Companion',
        ),
        actions: [
          IconButton(
            tooltip: 'Delete conversation',
            icon: const Icon(
              Icons.delete_outline,
            ),
            onPressed: deleteConversation,
          ),
        ],
      ),

      body: Column(
        children: [
          // ------------------------------------------
          // Chat messages
          // ------------------------------------------

          Expanded(
            child: messages.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text(
                        'Hi! 👋\n\n'
                        'I\'m your Wellness AI Companion.\n'
                        'Tell me how you are feeling today.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final message =
                          messages[index];

                      final isUser =
                          message['sender'] ==
                              'user';

                      return buildMessageBubble(
                        message['message'] ?? '',
                        isUser,
                      );
                    },
                  ),
          ),

          // ------------------------------------------
          // AI loading indicator
          // ------------------------------------------

          if (isLoading)
            const Padding(
              padding: EdgeInsets.only(
                left: 15,
                bottom: 8,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: 18,
                      height: 18,
                      child:
                          CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'AI is thinking...',
                    ),
                  ],
                ),
              ),
            ),

          // ------------------------------------------
          // Message input
          // ------------------------------------------

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          messageController,
                      textInputAction:
                          TextInputAction.send,
                      onSubmitted: (_) {
                        sendMessage();
                      },
                      decoration:
                          const InputDecoration(
                        hintText:
                            'Tell me how you feel...',
                        border:
                            OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  IconButton(
                    onPressed:
                        isLoading
                            ? null
                            : sendMessage,
                    icon: const Icon(
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

