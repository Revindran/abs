import 'package:absolute_solutions/Model/getCustomeModel.dart';
import 'package:absolute_solutions/Model/login_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ApiService {
  Future<LoginModel> login(LoginModel loginRequest) async {
    String url = "https://clients.tech4lyf.com/absolutesolutions/login";

    final response = await http.post(url, body: loginRequest.toJson());
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to Load data");
    }
  }
}

class API_Manager {
  Future<GetCustomerModel> getCustomers() async {
    var client = http.Client();
    var customerModel;

    try {
      var response = await client.get('https://clients.tech4lyf.com/absolutesolutions/getCustomers.php');
      if (response.statusCode == 200) {
        var jsonString = response.body;
      // print(jsonString);
        var  jsonMap = json.decode(jsonString);
       // print(jsonMap);

        customerModel = GetCustomerModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return customerModel;
    }

    return customerModel;
  }




}
