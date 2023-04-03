import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:newsapppro/helper/data.dart';
import 'package:newsapppro/helper/news.dart';
import 'package:newsapppro/models/article_model.dart';
import 'package:newsapppro/models/category_model.dart';
import 'package:newsapppro/views/article_view.dart';
import 'package:newsapppro/views/categories_news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  var newslist;

  List<CategoryModel> categories = <CategoryModel>[];
  List<Article> articles = <Article>[];

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }

  void getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // theme: ThemeData(
      //   primaryColor: Colors.white,
      // ),
      appBar: AppBar(
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text(
            "Daily",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
          ),
          Text(
            "News",
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
          ),
        ]),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),

      // body: _loading
      //     ? Center(
      //         child: Container(
      //           child: CircularProgressIndicator(),
      //         ),
      //       )
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Container(
                height: 70,
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CategoryTile(
                        imageUrl: categories[index].imageUrl,
                        categoryName: categories[index].categoryName);
                  },
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(top: 8),
                  child: ListView.builder(
                    itemCount: articles.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BlogTile(
                        imageUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        url: articles[index].url,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // body: SafeArea(
      //   child: _loading
      //       ? Center(
      //           child: CircularProgressIndicator(),
      //         )
      //       : SingleChildScrollView(
      //           child: Container(
      //             child: Column(
      //               children: <Widget>[
      //                 /// Categories
      //                 Container(
      //                   padding: EdgeInsets.symmetric(horizontal: 16),
      //                   height: 70,
      //                   child: ListView.builder(
      //                       scrollDirection: Axis.horizontal,
      //                       itemCount: categories.length,
      //                       itemBuilder: (context, index) {
      //                         return CategoryCard(
      //                           imageAssetUrl: categories[index].imageAssetUrl,
      //                           categoryName: categories[index].categorieName,
      //                         );
      //                       }),
      //                 ),

      //                 /// News Article
      //                 Container(
      //                   margin: EdgeInsets.only(top: 16),
      //                   child: ListView.builder(
      //                       itemCount: newslist.length,
      //                       shrinkWrap: true,
      //                       physics: ClampingScrollPhysics(),
      //                       itemBuilder: (context, index) {
      //                         return NewsTile(
      //                           imgUrl: newslist[index].urlToImage ?? "",
      //                           title: newslist[index].title ?? "",
      //                           desc: newslist[index].description ?? "",
      //                           content: newslist[index].content ?? "",
      //                           posturl: newslist[index].articleUrl ?? "",
      //                         );
      //                       }),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      // ),
    );
  }
}

// class CategoryCard extends StatelessWidget {
//   final String imageAssetUrl, categoryName;

//   CategoryCard({this.imageAssetUrl, this.categoryName});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CategoryNews(
//                       newsCategory: categoryName.toLowerCase(),
//                     )));
//       },
//       child: Container(
//         margin: EdgeInsets.only(right: 14),
//         child: Stack(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(5),
//               child: CachedNetworkImage(
//                 imageUrl: imageAssetUrl,
//                 height: 60,
//                 width: 120,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               height: 60,
//               width: 120,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: Colors.black26),
//               child: Text(
//                 categoryName,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;

  const CategoryTile(
      {super.key, required this.imageUrl, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      newsCategory: categoryName.toString().toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 120,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Text(
              categoryName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          )
        ]),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  BlogTile(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ArticleView(posturl: url)));
      },
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                desc,
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
