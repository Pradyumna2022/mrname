import 'package:get/get.dart';
import '../apiservices/api_services.dart';
import '../model/question_model.dart';
class ProductController extends GetxController{
  var isLoading  = true.obs;
  var productList  = <QuizModel>[].obs;
  // @override
  // void onInit() {
  //   // TODO: implement onInitv
  //   super.onInit();
  //   fetchData();
  //
  // }

  void fetchData()async{
    try{
      isLoading(true);

      var products = await ApiServices.getApi();

      if(products!=null){

        productList.value = products as List<QuizModel>;

      }else{
        print('shfdhsfhsdhfsd');
      }

    }finally{
      isLoading(false);
    }
  }
}