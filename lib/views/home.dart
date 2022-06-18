

//import 'dart:js';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_api/helper/data.dart';
import 'package:news_api/helper/news.dart';
import 'package:news_api/models/article_model.dart';
import 'package:news_api/models/categori_model.dart';
import 'package:news_api/views/article_view.dart';
import 'package:news_api/views/category_news.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];

  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }
  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading= false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Top", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red
                )),
            Text("Tech",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue
            ),),
            Text("Lines",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
            ),)
          ],
        ),
      ),
      body: _loading?
      Container(
        child: Center(
            child: CircularProgressIndicator()),
      ):
      SingleChildScrollView(
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              ///Categories
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(

                  height: 70,
                  child: ListView.builder(
                    itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName,
                      );
                    },
                  ),
                ),
              ),
              /// Blogs
              Container(
                padding: EdgeInsets.only(top: 16),
                //51.48
                child: ListView.builder(
                    itemCount: articles.length,
                    //scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryTile({required this.imageUrl, required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(category:
        categoryName.toLowerCase(),
        )
        ));

      },
      child: Container(
        margin: EdgeInsets.only(right: 12),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                  imageUrl: imageUrl, width: 120, height: 60,fit: BoxFit.cover)),
            Container(
              alignment: Alignment.center,
              width: 120, height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName,
                  style:
                TextStyle(
                  fontSize: 15,

                  color: Colors.white
                ),),
            )
          ],
        ) ,
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile({required this.imageUrl, required this.title, required this.desc,required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.push(context, MaterialPageRoute
           (builder: (context) => ArticleView(
           blogUrl: url,

         )
         ));
    },

      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(5),
            child: Image.network(imageUrl),),
            SizedBox(height: 8),
            Text(title, style:
              TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Colors.white
              ),),
            SizedBox(height: 8),
            Text(desc,
            style: TextStyle(
              color: Colors.white38
            ),),
          ],
        ),
      ),
    );
  }
}


