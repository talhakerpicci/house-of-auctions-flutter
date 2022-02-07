import 'package:flutter/material.dart';

class ChatMessage {
  final String messageContent;
  final String messageType;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
  });
}

class ChatDetailScreen extends StatelessWidget {
  final Map personData;
  const ChatDetailScreen({
    Key? key,
    required this.personData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final messages = <ChatMessage>[
      ChatMessage(messageContent: 'Hello, Talha', messageType: 'receiver'),
      ChatMessage(messageContent: 'Can you send me your address?', messageType: 'receiver'),
      ChatMessage(
          messageContent: 'Hey ${(personData['nameSurname'] as String).split(' ')[0]}, sure thing',
          messageType: 'sender'),
      ChatMessage(messageContent: 'Saatköy Köyü,26, 53740, Findikli/Istanbul, Turkey', messageType: 'sender'),
      ChatMessage(
          messageContent: 'Cool. Thanks! Will pick up the item if you are available today.', messageType: 'receiver'),
      ChatMessage(messageContent: 'Yes you can come and pick up it today, im free.', messageType: 'sender'),
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                SizedBox(
                  height: 40,
                  width: 40,
                  child: ClipOval(
                    child: Image.network(
                      personData['avatar'],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        personData['nameSurname'],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Online',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: messages[index].messageType == 'receiver' ? Alignment.topLeft : Alignment.topRight,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: messages[index].messageType == 'receiver' ? Colors.grey.shade200 : Colors.blue[200],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      messages[index].messageContent,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Write message...',
                        hintStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: Colors.blue,
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
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
