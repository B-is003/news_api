import 'package:flutter/material.dart';
import 'package:news_api/helper/news.dart';
import 'package:news_api/models/article_model.dart';

import 'article_view.dart';
class CategoryNews extends StatefulWidget {


  final String category;
  CategoryNews({required this.category});


  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  getCategorieNews() async{
    CategoryNewsClass newsClass = CategoryNewsClass ();
    await newsClass.getNews(widget.category);
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
          child: Column(
            children: [
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
