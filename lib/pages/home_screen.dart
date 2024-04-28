import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/model/city_weather_model.dart';
import 'package:weather_app/pages/search_text_field.dart';

class HomeScreen extends StatefulWidget {
  final CityWeatherModel? cityWeather;
  const HomeScreen({super.key, this.cityWeather});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CityWeatherModel cityWeather;

  @override
  void initState() {
    super.initState();
    cityWeather = widget.cityWeather!;
  }

  String cityName = 'Abu dhabi';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Weather App",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SearchTextField(
                      callBack: (p0) {
                        setState(() {
                          cityWeather.name = p0.name;
                          cityWeather.country = p0.country;
                          cityWeather.description = p0.description;
                          cityWeather.humidity = p0.humidity;
                          cityWeather.pressure = p0.pressure;
                          cityWeather.temp = p0.temp;
                          cityWeather.tempMax = p0.tempMax;
                          cityWeather.tempMin = p0.tempMin;
                          cityWeather.icon = p0.icon;
                        });
                      },
                    ),

                    // @ Temp Icon
                    cityTempIcon(),
                    // @ City name
                    Text(
                      cityWeather.name,
                      style: const TextStyle(fontSize: 40),
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          elevation: 1.0,
                          color: Colors.blueAccent[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10.0),
                              const Text('Other Information'),
                              rowData(
                                'Descrtiption',
                                cityWeather.description,
                              ),
                              rowData(
                                'Highest Temp',
                                cityWeather.tempMax.toString(),
                              ),
                              rowData(
                                'Lowest Temp',
                                cityWeather.tempMin.toString(),
                              ),
                              rowData(
                                'Preasure',
                                cityWeather.pressure.toString(),
                              ),
                              rowData(
                                'Humidity',
                                cityWeather.humidity.toString(),
                              ),
                              rowData(
                                'Tempreture',
                                cityWeather.temp,
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 30.0),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => Directionality(
        textDirection: TextDirection.ltr,
        child: AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to exit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => SystemNavigator.pop(),
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
    ));
  }

  rowData(String subTitle, String data) {
    return Row(
      children: [
        Expanded(
          child: Text(
            data,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.indigo),
          ),
        ),
        Expanded(
          child: Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(height: 50.0)
      ],
    );
  }

  cityTempIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Row(
                children: [
                  Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                            'http://openweathermap.org/img/wn/${cityWeather.icon}@2x.png'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        'Tempreture:',
                        style: TextStyle(fontSize: 30),
                      ),
                      Text(
                        cityWeather.temp.toString(),
                        style: const TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        // Expanded(
        //   child: Column(
        //     children: [

        //     ],
        //   ),
        // ),
      ],
    );
  }
}
