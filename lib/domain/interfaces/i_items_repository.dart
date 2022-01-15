import 'package:data_channel/data_channel.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/item/item_model.dart';
import 'package:image_picker/image_picker.dart';

abstract class IItemsRepository {
  Future<DC<AlertModel, List<ItemModel>>> getItems();
  Future<DC<AlertModel, ItemModel>> addItem({required ItemModel item});
  Future<DC<AlertModel, void>> uplaodPicture({required List<XFile> files, required String location, String? itemId});
}
