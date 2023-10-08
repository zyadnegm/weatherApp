import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/Cubits/weather_Cubit/weather_States.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherCubit extends Cubit<Weather_States>{
  WeatherCubit(this.weatherService) : super(WeatherInit());
  WeatherService weatherService;
  WeatherModel ?weatherModel;
  String ?cityname;

  void getWeather({required String cityName}) async{
    emit(WeatherLoading());
   try{
     weatherModel= await weatherService.getWeather(cityName: cityName);
     emit(WeatherSucsses());
   }
   on Exception catch(e){
     emit(WeatherFaluire());
    }


  }

}