import 'package:bloc/bloc.dart';
import 'package:eshtri/models/single_product/single_product_model_states.dart';
import 'package:eshtri/shared/components/constants/constants.dart';
import 'package:eshtri/shared/components/toast.dart';
import 'package:eshtri/shared/network/end_points.dart';
import 'package:eshtri/shared/network/remote/dio_helper.dart';

class SingleProductModel extends Cubit<SingleProductModelStates> {
  late final dynamic id;
  late final dynamic name;
  late final dynamic imageUrl;
  late final dynamic price;
  late final dynamic oldPrice;
  late final dynamic discount;
  late final List<dynamic> images;
  late final String description;
  late bool inFavorites;
  late bool inCart;

  SingleProductModel() : super(SingleProductModelInitialState());

  SingleProductModel fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    imageUrl = json['image'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    description = json['description'];
    images = json['images'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
    return this;
  }

  SingleProductModel copy() {
    return this;
  }

  Future<void> toggleFavoriteStates() async {
    inFavorites = !inFavorites;
    emit(SingleProductModelChangeFavoriteState());
    try {
      final response = await DioHelper.postRequest(
          path: kSetFavoriteStatusEndpoint, data: {'product_id': id}, token: userAccessToken);
      if (!response.data['status']) {
        inFavorites = !inFavorites;
        toast(toastMsg: response.data['message'].toString());
        emit(SingleProductModelChangeFavoriteState());
      }
    } catch (error) {
      inFavorites = !inFavorites;
      print(error.toString());
      toast(toastMsg: 'Something Went Wrong!');
      emit(SingleProductModelChangeFavoriteState());
    }
  }
}
