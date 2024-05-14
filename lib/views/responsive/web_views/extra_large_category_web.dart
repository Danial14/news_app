import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/utils/route_util.dart';
import 'package:news_app/views/responsive/web_views/categories_large_view.dart';
import 'package:news_app/views/responsive/web_views/categories_medium_view.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../view_model/categories_view_model.dart';
import 'categories_small_view.dart';
import 'extra_large_detail_web.dart';

class ExtraLargeWebCategory extends StatefulWidget {
  const ExtraLargeWebCategory({super.key});

  @override
  State<ExtraLargeWebCategory> createState() => _ExtraLargeWebCategoryState();
}

class _ExtraLargeWebCategoryState extends State<ExtraLargeWebCategory> {
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
    debugPrint("extralargecategory");
    ScrollController scrollController = ScrollController();
    ScrollController categoryScrollController = ScrollController();
    List<ValueNotifier<bool>> _changeColorList = [];
    return LayoutBuilder(builder: (ctx, constraints){
      if(constraints.maxWidth < 600){
        return CategoriesSmallView();
      }
      else if(constraints.maxWidth >= 600 && constraints.maxWidth < 768){
        return CategoriesMediumView();
      }
      else if(constraints.maxWidth >= 768 && constraints.maxWidth < 992){
        return CategoriesLargeView();
      }
      return Scaffold(
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
                      child: Image.asset("assets/images/move_left.png"),
                      onTap: () {
                        categoryScrollController.animateTo(
                            0, duration: Duration(seconds: 1),
                            curve: Curves.easeInOut);
                      },
                    ),
                      title: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 50,
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
                        child: Image.asset("assets/images/move_right.png"),
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
                                            childAspectRatio: 1.1
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
                                                              fontSize: 15
                                                          ),
                                                        ),
                                                        ]
                                                      )),
                                                    ),
                                                    SizedBox(height: 12,),
                                                    ListTile(contentPadding: EdgeInsets.only(left: 3),leading: FittedBox(
                                                      child: Text(data.articles![position].source!.name,
                                                        style: TextStyle(
                                                            fontSize: 12,
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
                                                    )
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
          )
      );
    });
  }
}
