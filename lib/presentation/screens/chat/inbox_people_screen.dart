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
        'avatar': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-gF3E1ORnxI67Txoj7mTKrDkqBPvURi0owvqRZf8iGDn0Kki3UmDBrsNLW_UHToaq1J8&usqp=CAU',
        'item': 'Dell Gaming G15 5510',
        'itemPicture': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjefFODtEBb6DmzzXDGw1nktatDmcRnaUbFRzOfWb4ouztBjVSxa9YYA0XKpbezu8oTLw&usqp=CAU',
      },
      {
        'nameSurname': 'Mohamad Mawaldi',
        'avatar': 'https://scontent.fist1-2.fna.fbcdn.net/v/t1.6435-9/34963391_253710871847063_8827530971633942528_n.jpg?_nc_cat=111&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=Dg579ocdXKQAX-eIXyA&_nc_oc=AQl4DUoKMkmb5j-n57SGDB2M5hNPSDB-wUkXCQ3uL7nP0gIyr7refZrCzD5Cyt94wTA&_nc_ht=scontent.fist1-2.fna&oh=00_AT_ttVcY_7yC2Idtikq-ANZk7nQeZcr8umtM6xALpK7wVg&oe=61E33039',
        'item': 'Sennheiser Hd 201',
        'itemPicture': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvKCH6AAiHfsKT0Wbfxop_qq1cr17FLLe4Hw&usqp=CAU',
      },
      {
        'nameSurname': 'İrem Gençoğlu',
        'avatar': 'https://assets.puzzlefactory.pl/puzzle/308/511/thumb.jpg',
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
