import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapplication/Services/Api.dart';
import 'package:newsapplication/Services/Fun.dart';
import 'package:newsapplication/wigdetes/CategoriesButton.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';

import '../constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _openLink(String Link) async {
    var urllink = Link;
    if (await canLaunch(urllink)) {
      await launch(urllink);
    } else {
      await launch(urllink);
    }
  }
Api api=Api();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGround,
      body: Column(
        children: [
          Container(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
              child: Text(
                "Choose News Categories ",
                style: TextStyle(color: textColor, fontSize: fontbigger),
              ),
            ),
          ),
          Container(
            height: 60,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  CategoriesButton(
                    textCategories: "General",
                    colorButtom: blue,
                    categories: "general",
                  ),
                  CategoriesButton(
                    textCategories: "Science",
                    colorButtom: yellow,
                    categories: "science",
                  ),
                  CategoriesButton(
                    textCategories: "Health",
                    colorButtom: red,
                    categories: "health",
                  ),
                  CategoriesButton(
                    textCategories: "Business",
                    colorButtom: green,
                    categories: "business",
                  ),
                  CategoriesButton(
                    textCategories: "Sports",
                    colorButtom: orangeDark,
                    categories: "sports",
                  ),
                  CategoriesButton(
                    textCategories: "Entertainment",
                    colorButtom: blue,
                    categories: "entertainment",
                  ),
                  CategoriesButton(
                    textCategories: "Technology",
                    colorButtom: orangeLight,
                    categories: "technology",
                  ),

                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 10),
            child: Text(
              "General News ",
              style: TextStyle(color: textColor, fontSize: fontLarge),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: FutureBuilder(
    future: api.fetchArticles(),


     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if (snapshot.data==null){
        return Center(
        child: CircularProgressIndicator(
        backgroundColor: yellow,
        ),
        );
    }
      else{
        return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context,i){
          return  GestureDetector(
          onTap: () {
          Fun.openLink("${snapshot.data[i].url}");

          },
          child: Card(
          color: Colors.white,
          child: Container(
          child: Row(
          children: [
          Expanded(
          flex: 80,
          child: Container(
          color: Colors.white,
          child: Column(
          children: [
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
         (snapshot.data[i].urlToImage==null)?"https://img.freepik.com/free-vector/404-error-web-template-isometric-style_23-2147799304.jpg?size=338&ext=jpg":snapshot.data[i].urlToImage,
          fit: BoxFit.fitWidth,
          ),
          ),

          Text(
          "${snapshot.data[i].title}",
    style: TextStyle(
    fontSize: fontSubTitle,
    fontWeight: FontWeight.w800),
    textAlign: TextAlign.center,
    ),


    ],
    ),
    ),
    ),
    Container(


    child: Column(

    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    Container(
    color: Colors.blue,

    padding: EdgeInsets.symmetric(vertical: 30),
    child: IconButton(


    onPressed: () {

    Fun.shareLink('${snapshot.data[i].url}');

    },

    icon: Icon(Icons.share,)),
    ),
    Container(
    color: Colors.tealAccent,


    padding: EdgeInsets.symmetric(vertical: 30),
    child: IconButton(
    onPressed: () {
    Fun.copyLink('${snapshot.data[i].url}');
    final snackBar= SnackBar(content: Text('copied to Clipboard'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    },
    icon: Icon(Icons.copy)),
    ),
    ],
    ),
    ),

    ],
    ),
    ),
    ),
    );
    });
    }
    },
                ),
              ),
            ),

        ],
      ),
    );
  }
}
