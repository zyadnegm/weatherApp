import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Cubits/weather_Cubit/WeatherCubit.dart';
import 'package:weather_app/Cubits/weather_Cubit/weather_States.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';


class HomePage extends StatelessWidget {

  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchPage(
                );
              }));
            },
            icon: Icon(Icons.search),
          ),
        ],
        title: Text('Weather App'),
      ),
      body: BlocBuilder<WeatherCubit,Weather_States>(builder: (context, state) {
        if(state is WeatherLoading){
          return Center(child: CircularProgressIndicator(),);
        }
        else if (state is WeatherSucsses){
          weatherData =BlocProvider.of<WeatherCubit>(context).weatherModel;
          return Container(
                 decoration: BoxDecoration(
                     gradient: LinearGradient(
                   colors: [
                     weatherData!.getThemeColor(),
                     weatherData!.getThemeColor()[300]!,
                     weatherData!.getThemeColor()[100]!,
                   ],
                   begin: Alignment.topCenter,
                   end: Alignment.bottomCenter,
                 )),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Spacer(
                       flex: 3,
                     ),
                     Text("${BlocProvider.of<WeatherCubit>(context).cityname}",
                     style: TextStyle(fontWeight: FontWeight.bold,
                     fontSize: 42),),
                     SizedBox(height: 10,),
                     Text(
                       'updated at : ${weatherData!.date.hour.toString()}:${weatherData!.date.minute.toString()}',
                       style: TextStyle(
                         fontSize: 22,
                       ),
                     ),
                     Spacer(),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Image.asset(weatherData!.getImage()),
                         Text(
                           weatherData!.temp.toInt().toString(),
                           style: TextStyle(
                             fontSize: 32,
                             fontWeight: FontWeight.bold,
                           ),
                         ),
                         Column(
                           children: [
                             Text('maxTemp :${weatherData!.maxTemp.toInt()}'),
                             Text('minTemp : ${weatherData!.minTemp.toInt()}'),
                           ],
                         ),
                       ],
                     ),
                     Spacer(),
                     Text(
                       weatherData!.weatherStateName,
                       style: TextStyle(
                         fontSize: 32,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     Spacer(
                       flex: 5,
                     ),
                   ],
                 ),
               );
        }
        else if(state is WeatherFaluire){
          return Center(child: Text("Somthing is wrong"),);
        }
        else{
          return   Center(
             child: Column(
               mainAxisSize: MainAxisSize.min,
               children: [
                 Text(
                   'there is no weather 😔 start',
                   style: TextStyle(
                     fontSize: 30,
                   ),
                 ),
                 Text(
                   'searching now 🔍',
                   style: TextStyle(
                     fontSize: 30,
                   ),
                 )
               ],
             ),
           );

        }


      },)

    );
  }
}
