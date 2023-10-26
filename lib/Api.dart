import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:youtube/model/Video.dart';

class Api{

  Future<List<Video>> pesquisar (String pesquisa) async {
    const CHAVE_YOUTUBE_API = "AIzaSyBrQSLDqhY4II3lRaYHkCEW5zfNOQtsGZc";
    const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
    const URL_BASE = "https://www.googleapis.com/youtube/v3/";

   final Uri uri = Uri.parse(
       URL_BASE + "search"
           "?part=snippet"
           "&type=video"
           "&maxResults=20"
           "&order=date"
           "&key=$CHAVE_YOUTUBE_API"
           "&channelId=$ID_CANAL"
           "&q=$pesquisa"
   );

   final response = await http.get(uri);

    if( response.statusCode == 200 ){


      Map<String, dynamic> dadosJson = json.decode( response.body );

      List<Video> videos = dadosJson["items"].map<Video>(
              (map){
            return Video.fromJson(map);
          }
      ).toList();

      return videos;
      }else {

      return[];

    }
  }
}

