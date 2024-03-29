import 'package:data_channel/data_channel.dart';
import 'package:dio/dio.dart';
import 'package:house_of_auctions/domain/interfaces/i_items_repository.dart';
import 'package:house_of_auctions/domain/models/core/alert_model.dart';
import 'package:house_of_auctions/domain/models/item/item_model.dart';
import 'package:house_of_auctions/infrastructure/core/modules/api_client/api_client.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IItemsRepository)
class ItemsRepository implements IItemsRepository {
  final ApiClient _apiClient;

  ItemsRepository(this._apiClient);

  @override
  Future<DC<AlertModel, List<ItemModel>>> getItems() async {
    try {
      final response = await _apiClient.get('/get-items');
      final list = response.data as Map;
      final items = (list['items'] as List).map((json) => ItemModel.fromJson(json)).toList();

      return DC.data(items);
    } catch (e) {
      String errorMessage;

      if (e is DioError && e.response != null) {
        errorMessage = (e.response!.data as Map)['message'];
      } else {
        errorMessage = e.toString();
      }

      final _alert = AlertModel(message: errorMessage, type: AlertType.error);

      return DC.error(_alert);
    }
  }

  @override
  Future<DC<AlertModel, ItemModel>> addItem({required ItemModel item}) async {
    try {
      final response = await _apiClient.post('/item', item.toJson());
      final model = ItemModel.fromJson(response.data);

      return DC.data(model);
    } catch (e) {
      String errorMessage;

      if (e is DioError) {
        errorMessage = (e.response!.data as Map)['message'];
      } else {
        errorMessage = e.toString();
      }

      final _alert = AlertModel(message: errorMessage, type: AlertType.error);

      return DC.error(_alert);
    }
  }

  @override
  Future<DC<AlertModel, void>> uplaodPicture({required List<XFile> files, required String location, String? itemId}) async {
    try {
      final formData = FormData.fromMap({
        for (var i = 0; i < files.length; i++) ...{
          'file_$i': await MultipartFile.fromFile(files[i].path, filename: files[i].name),
        },
        'location': location,
        'itemId': itemId,
        'fileCount': files.length,
      });
      /* formData.files.addAll([
        MapEntry("assignment", await MultipartFile.fromFile(file)),
      ]); */

      await _apiClient.post(
        '/upload-image',
        formData,
      );

      return DC.data(null);
    } catch (e) {
      Object errorMessage;

      if (e is DioError && e.response != null) {
        errorMessage = e.response!.data;
      } else {
        errorMessage = e.toString();
      }

      final _alert = AlertModel(message: errorMessage.toString(), type: AlertType.error);

      return DC.error(_alert);
    }
  }
}
