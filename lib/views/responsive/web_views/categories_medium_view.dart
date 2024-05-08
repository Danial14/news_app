import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/views/responsive/web_views/categories_small_view.dart';
import 'package:news_app/views/responsive/web_views/web_app_drawer.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../utils/route_util.dart';
import '../../../view_model/categories_view_model.dart';
import 'extra_large_category_web.dart';
import 'extra_large_detail_web.dart';

class CategoriesMediumView extends StatefulWidget {
  const CategoriesMediumView({super.key});

  @override
  State<CategoriesMediumView> createState() => _CategoriesMediumViewState();
}

class _CategoriesMediumViewState extends State<CategoriesMediumView> {
  /*GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var newsFuture;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      newsFuture = Provider.of<CategoriesViewModel>(context, listen: false);
      print("fetching categories");
      setState(() {

      });
    });
    super.initState();
  }*/
  CategoriesViewModel? _categoriesViewModel;

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      _categoriesViewModel = Provider.of<CategoriesViewModel>(context, listen: false);
      print("fetching categories");
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    ScrollController categoryScrollController = ScrollController();
    List<ValueNotifier<bool>> _changeColorList = [];
    return LayoutBuilder(builder: (ctx, constraints){
      if(constraints.maxWidth < 600){
        return CategoriesSmallView();
      }
      else {
        return /*Scaffold(
          key: _key,
          drawer: WebAppDrawer(null, newsFuture),
          appBar: AppBar(
            centerTitle: true,
            flexibleSpace: Container(
              margin: EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Color(0xffD9D9D9).withOpacity(1.0),
                      Color(0xffD9D9D9).withOpacity(0.23)
                    ]
                ),
              ),
            ),
            title: Text("News", style: GoogleFonts.poppins(
                fontSize: 24, fontWeight: FontWeight.w700)),
            leading: Padding(
              padding: EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: Image.asset("assets/images/Menu.png"),
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: FutureBuilder<bool>(
                future: newsFuture.fetchInitialBusinessNews(),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.data!) {
                    return SpinKitCircle(
                      size: 40,
                      color: Colors.blue,
                    );
                  }
                  else {
                    return Consumer<CategoriesViewModel>(
                        builder: (context, news, ch) {
                          var data = news.getCategoriesHeadLines;
                          return ListView.builder(itemBuilder: (ctx, position) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Row(
                                children: <Widget>[
                                  Expanded(flex: 3, child: Container(
                                    height: constraints.maxHeight * 0.3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: data.articles![position]
                                          .urlToImage != null
                                          ? CachedNetworkImage(
                                        imageUrl: data.articles![position]
                                            .urlToImage,
                                        fit: BoxFit.cover,
                                        placeholder: (ctx, st) {
                                          return SpinKitCircle(color: Colors
                                              .blue,);
                                        },
                                        errorWidget: (ctx, st, ob) {
                                          return Icon(Icons.error, color: Colors
                                              .red,);
                                        },
                                      )
                                          :
                                      Center(
                                        child: Text(
                                          "Image not found 404",
                                          style: GoogleFonts.italiana(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ),
                                  SizedBox(width: 5,),
                                  Expanded(child: Container(
                                    height: constraints.maxHeight * 0.3,
                                    child: Column(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 8,
                                          child: Text(
                                            data.articles![position].title!,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18
                                            ),
                                          ),
                                        ),
                                        *//*ListTile(
                                                        leading: Text(data.articles![position].source!.id!,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!))),
                                                        minLeadingWidth: 30,
                                                      )*//*
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(child: FittedBox(
                                                child: Text(
                                                  data.articles![position]
                                                      .source!.name,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight
                                                          .w700
                                                  ),
                                                ),
                                                fit: BoxFit.contain,
                                                alignment: Alignment.centerLeft,
                                              ),
                                                //flex: 2,
                                              ),
                                              //SizedBox(width: 5,),
                                              Expanded(child: Container(
                                                  alignment: Alignment
                                                      .centerRight,
                                                  child: Text(
                                                      DateFormat.yMMMd("en_US")
                                                          .format(
                                                          DateTime.parse(data
                                                              .articles![position]
                                                              .publishedAt!)))))
                                            ],
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceEvenly,
                                          ),
                                        )
                                      ],
                                      mainAxisAlignment: MainAxisAlignment
                                          .start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                    ),
                                  ),
                                    flex: 4,
                                  )
                                ],
                              ),
                            );
                          },
                            itemCount: data.articles!.length,
                          );
                        }
                    );
                  }
                },
              ),
            ),
          ),
        );*/
          Scaffold(
            appBar: AppBar(
              centerTitle: true,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Color(0xffD9D9D9).withOpacity(1.0),
                        Color(0xffD9D9D9).withOpacity(0.23)
                      ]
                  ),
                ),
              ),
              title: Text("News", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
            ),
            body: SafeArea(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                    children: [
                      ListTile(leading: InkWell(
                        child: Image.asset("assets/images/move_left.png",width: 40,height: 40,),
                        onTap: () {
                          categoryScrollController.animateTo(
                              0, duration: Duration(seconds: 1),
                              curve: Curves.easeInOut);
                        },
                      ),
                        title: Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 30,
                          child: Scrollbar(
                            controller: categoryScrollController,
                            child: ListView.builder(itemBuilder: (ctx, position){
                              _changeColorList.add(ValueNotifier<bool>(false));
                              return ValueListenableBuilder<bool>(valueListenable: _changeColorList[position],
                                builder: (ctx, value, ch){
                                  if(value){
                                    return Padding(padding: EdgeInsets.only(
                                        right: 25,
                                        left: 25
                                    ),
                                      child: ElevatedButton(
                                        onPressed: (){
                                          _changeColorList[position].value = false;
                                        },
                                        child: Text(Constants.CATEGORIES[position], style: TextStyle(color: Colors.white),),
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            backgroundColor: Colors.blue
                                        ),
                                      ),
                                    );
                                  }
                                  else{
                                    return Padding(padding: EdgeInsets.only(
                                        right: 25,
                                        left: 25
                                    ),
                                      child: ElevatedButton(
                                        onPressed: () async{
                                          _changeColorList.forEach((element) {
                                            if(element.value){
                                              element.value = false;
                                            }
                                          });
                                          _changeColorList[position].value = true;
                                          switch(Constants.CATEGORIES[position]){
                                            case Constants.TECHNOLOGY:
                                              await _categoriesViewModel!.fetchTechnologyCategoryNews();
                                              break;
                                            case Constants.SPORTS:
                                              await _categoriesViewModel!.fetchSportsCategoryNews();
                                              break;
                                            case Constants.GENERAL:
                                              await _categoriesViewModel!.fetchGeneralCategoryNews();
                                              break;
                                            case Constants.BUSINESS:
                                              await _categoriesViewModel!.fetchBusinessCategoryNews();
                                              break;
                                            case Constants.HEALTH:
                                              await _categoriesViewModel!.fetchHealthCategoryNews();
                                              break;
                                            case Constants.ENTERTAINMENT:
                                              await _categoriesViewModel!.fetchEntertainmentCategoryNews();
                                              break;
                                            case Constants.SCIENCE:
                                              await _categoriesViewModel!.fetchScienceCategoryNews();
                                              break;
                                          }
                                        },
                                        child: Text(Constants.CATEGORIES[position], style: TextStyle(color: Colors.white),),
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15)
                                            ),
                                            backgroundColor: Colors.black
                                        ),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                              itemCount: Constants.CATEGORIES.length,
                              scrollDirection: Axis.horizontal,
                              controller: categoryScrollController,
                            ),
                          ),
                        ),
                        trailing: InkWell(
                          onTap: (){
                            categoryScrollController.animateTo(MediaQuery.of(context).size.width * 0.9, duration: Duration(seconds: 1), curve: Curves.easeInOut);
                          },
                          child: Image.asset("assets/images/move_right.png",width: 40,height: 40),
                        ),
                        contentPadding: EdgeInsets.only(top: 10, bottom: 10, right: 6, left: 6),
                      ),
                      Expanded(
                        flex: 2,
                        child: FutureBuilder<bool>(
                            future: _categoriesViewModel!.fetchInitialBusinessNews(),
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                                return SpinKitCircle(
                                  size: 40,
                                  color: Colors.blue,
                                );
                              }
                              else{
                                return Consumer<CategoriesViewModel>(
                                  builder: (ctx, news, ch){
                                    var data = news.getCategoriesHeadLines;
                                    print("news length: ${data.articles!.length}");
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: MediaQuery.of(context).size.height,
                                      child: Scrollbar(
                                        thumbVisibility: true,
                                        controller: scrollController,
                                        child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 2
                                          ),
                                          itemBuilder: (ctx, position){
                                            return InkWell(
                                              onTap: (){
                                                Navigator.of(context).push(RouteUtil.createRoute(ExtraLargeWebDetailView(data.articles![position].title!,
                                                    data.articles![position].description!,
                                                    data.articles![position].source!.name,
                                                    DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                                    data.articles![position].urlToImage,
                                                    Constants.ROUTE_CATEGORY
                                                )));
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 8),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Expanded(
                                                        flex: 5,
                                                        child: Container(
                                                          child: data.articles![position].urlToImage != null ? ClipRRect(
                                                            child: CachedNetworkImage(imageUrl: data.articles![position].urlToImage,
                                                              fit: BoxFit.cover,
                                                              placeholder: (ctx, st){
                                                                return SpinKitCircle(color: Colors.blue,);
                                                              },
                                                              errorWidget: (ctx, str, obj){
                                                                return Image.asset("assets/images/404.png", fit: BoxFit.cover,);
                                                              },
                                                            ),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ) : ClipRRect(child: Image.asset("assets/images/404.png", fit: BoxFit.cover,),
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 3,),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Padding(padding: EdgeInsets.only(left: 3),child: Wrap(
                                                          children: [Text(data.articles![position].title!,
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 9
                                                            ),
                                                          ),]
                                                        )),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      /*ListTile(contentPadding: EdgeInsets.only(left: 3),leading: FittedBox(
                                                        child: Text(data.articles![position].source!.name,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                        ),
                                                        fit: BoxFit.contain,
                                                        alignment: Alignment.centerLeft,
                                                      ),
                                                        trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w700
                                                            )
                                                        ),
                                                      )*/
                                                    ]
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: data.articles!.length,
                                          controller: scrollController,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                        ),
                      ),
                    ]
                ),
              ),
            ),
          );
      }
    });
  }
}
