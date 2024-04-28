import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/model/city_weather_model.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key, this.cityWeather, required this.callBack});
  final CityWeatherModel? cityWeather;
  final Function(CityWeatherModel) callBack;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool isTextFieldEmpty = true;
  late CityWeatherModel cityWeather;

  TextEditingController controller = TextEditingController(text: '');

  String cityName = 'Abu dhabi';

  Future<void> getDataFromAPI() async {
    try {
      var res = await Dio().get(
          'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=604a5a2d0698e550e7ef5281689d43b5');
      Map<String, dynamic> jsonMapObj = res.data;

      cityWeather = CityWeatherModel.fromMap(jsonMapObj);
      widget.callBack(cityWeather);
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: AlertDialog(
                title: const Text(
                  'City not found',
                  style: TextStyle(fontSize: 18),
                ),
                actions: [
                  ElevatedButton(
                    child: const Text("X"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: size.height * 0.058,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(left: 18, right: 12),
                      child: Icon(Icons.search)),
                  Flexible(
                    child: TextField(
                      controller: controller,
                      onChanged: (value) {
                        setState(() {
                          cityName = controller.text.toLowerCase();
                        });
                      },
                      style: const TextStyle(color: Colors.black54),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search City ",
                          hintStyle: TextStyle(color: Colors.black38)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              getDataFromAPI();
              controller.text = '';
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              margin: const EdgeInsets.only(left: 5),
              height: size.height * 0.056,
              width: size.width * 0.25,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(6.5),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(9),
              ),
              child: const Text("Search"),
            ),
          ),
        ],
      ),
    );
  }
}
