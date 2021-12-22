import 'package:flutter/material.dart';
import 'package:house_of_auctions/infrastructure/core/constants/colors.dart';
import 'package:house_of_auctions/presentation/widgets/chat/item_person_card.dart';

class InboxPeopleScreen extends StatelessWidget {
  const InboxPeopleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final personList = <Map>[
      {
        'nameSurname': 'Talha Kerpiççi',
        'avatar': 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/male/45.png',
        'item': 'Dell Gaming G15 5510',
        'itemPicture': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjefFODtEBb6DmzzXDGw1nktatDmcRnaUbFRzOfWb4ouztBjVSxa9YYA0XKpbezu8oTLw&usqp=CAU',
      },
      {
        'nameSurname': 'Mohamad Mawaldi',
        'avatar': 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/68.png',
        'item': 'Sennheiser Hd 201',
        'itemPicture': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvKCH6AAiHfsKT0Wbfxop_qq1cr17FLLe4Hw&usqp=CAU',
      },
      {
        'nameSurname': 'İrem Gençoğlu',
        'avatar': 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/female/5.png',
        'item': 'Apple iPad 9. Nesil',
        'itemPicture': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhX2z-io1QXdvDDfxS9xwC2RZCbpVqSeqGxA&usqp=CAU',
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chats - All'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tune,
              color: AppColors.darkGrey,
            ),
          ),
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.darkGrey,
            ),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text('Mark all as read'),
                ),
              ];
            },
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: personList.length,
        itemBuilder: (context, index) => ItemPersonCard(
          personData: personList[index],
        ),
      ),
    );
  }
}
