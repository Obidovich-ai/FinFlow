import 'package:flutter/material.dart';

class AIChatScreen extends StatefulWidget {
  @override
  _AIChatScreenState createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final List<Map<String, String>> messages = [
    {"role": "ai", "content": "Salom Azizbek! Men FinFlow AI yordamchisiman. Moliya tahlilingiz bo'yicha qanday savollar bor?"},
    {"role": "user", "content": "Bu oydagi eng katta xarajatimni ko'rsat."},
    {"role": "ai", "content": "Tahlillarga ko'ra, siz ushbu oyda 'Ofis ijarasi' uchun 5,000,000 UZS sarflagansiz. Bu o'tgan oydagidan 5% ko'proq."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0F111A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.cyanAccent.withOpacity(0.2),
              child: Icon(Icons.psychology, color: Colors.cyanAccent),
            ),
            SizedBox(width: 12),
            Text("FinFlow AI", style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
      body: Column(
        children: [
          // Chat ro'yxati
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isAI = messages[index]['role'] == 'ai';
                return _buildMessageBubble(messages[index]['content']!, isAI);
              },
            ),
          ),
          
          // Xabar yozish joyi
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(String content, bool isAI) {
    return Align(
      alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isAI ? Color(0xFF1E2230) : Color(0xFF6366F1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isAI ? Radius.circular(0) : Radius.circular(16),
            bottomRight: isAI ? Radius.circular(16) : Radius.circular(0),
          ),
        ),
        child: Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 15, height: 1.4),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFF1E2230),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Savol bering...",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          CircleAvatar(
            backgroundColor: Color(0xFF6366F1),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white, size: 18),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
