import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:newsapplication/models/Article.dart';


class Api{
final String apiKey="fa0501a1ac8d43f691892bf01a76d1f3";
 Future<List<Article>>fetchArticles() async {

 var url=Uri .parse('https://newsapi.org/v2/top-headlines?country=eg&apiKey=$apiKey');
 List<Article>listArticle=[];
var response=await http.get(url);

if (response.statusCode==200){

 var responsebody=jsonDecode(response.body)["articles"];

print(responsebody);
for(var u in responsebody){
 Article x=Article(u["title"],u ["description"],u ["url"], u["urlToImage"]);
listArticle.add(x);
}
print("listadd---->$listArticle");
return listArticle;
}
return listArticle;  
}

Future<List<Article>>fetchArticlesByCategory(String category) async {

 var url=Uri .parse('https://newsapi.org/v2/top-headlines?country=eg&category=$category&apiKey=$apiKey');
 List<Article>listArticle=[];
 var response=await http.get(url);

 if (response.statusCode==200){

  var responsebody=jsonDecode(response.body)["articles"];

  print(responsebody);
  for(var u in responsebody){
   Article x=Article(u["title"],u ["description"],u ["url"], u["urlToImage"]);
   listArticle.add(x);
  }
  print("listadd---->$listArticle");
  return listArticle;
 }
 return listArticle;
}








}