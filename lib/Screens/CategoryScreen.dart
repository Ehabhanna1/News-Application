import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:newsapplication/Services/Api.dart';
import 'package:newsapplication/Services/Fun.dart';
import 'package:newsapplication/wigdetes/CategoriesButton.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:clipboard/clipboard.dart';

import '../constant.dart';


class CategoryScreen extends StatefulWidget {

  String category;

  CategoryScreen(this.category);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGround,
        body: Column(
          children: [

            Container(

              padding: EdgeInsets.only(top: 30,),
              child: ListTile(
                title: Text("${widget.category} News Categories",
                  style: TextStyle(color: textColor, fontSize: fontLarge),),
                leading: IconButton(onPressed: () {
                  Navigator.pop(context);
                },

                  icon: Icon(Icons.arrow_back_ios, color: textColor,),
                ),


              ),
            ),


        Expanded(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: FutureBuilder(
              future: api.fetchArticlesByCategory(widget.category),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return GestureDetector(
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
                                              (snapshot.data[i].urlToImage ==
                                                  null)
                                                  ? "https://img.freepik.com/free-vector/404-error-web-template-isometric-style_23-2147799304.jpg?size=338&ext=jpg"
                                                  : snapshot.data[i].urlToImage,
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
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceAround,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .center,
                                      children: [
                                        Container(
                                          color: Colors.blue,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30),
                                          child: IconButton(

                                              onPressed: () {
                                                Fun.shareLink(
                                                    "${snapshot.data[i].url}");
                                              },
                                              icon: Icon(Icons.share)),
                                        ),
                                        Container(
                                          color: Colors.tealAccent,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 30),
                                          child: IconButton(
                                              onPressed: () {
                                                Fun.copyLink(
                                                    "${snapshot.data[i].url}");
                                                final snackBar = SnackBar(
                                                    content: Text(
                                                        'copied to Clipboard'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
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
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: yellow,
                    ),
                  );
                }
              },),


    ),
        ),
],
        ),
    );
  }
}
