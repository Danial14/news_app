import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../view_model/categories_view_model.dart';

class MediumTabletLargeMobileCategory extends StatefulWidget {
  const MediumTabletLargeMobileCategory({super.key});

  @override
  State<MediumTabletLargeMobileCategory> createState() => _MediumTabletLargeMobileCategoryState();
}

class _MediumTabletLargeMobileCategoryState extends State<MediumTabletLargeMobileCategory> {
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
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<ValueNotifier<bool>> _changeColorList = [];
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
      body: OrientationBuilder(
          builder: (context, orientation) {
            if(orientation == Orientation.landscape){
              return SafeArea(
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      SizedBox(height: 5,),
                      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (ctx, position){
                        _changeColorList.add(ValueNotifier<bool>(false));
                        return ValueListenableBuilder(valueListenable: _changeColorList[position], builder: (ctx, value, wid){
                          if(value){
                            return Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: ButtonTheme(
                                height: 10,
                                child: ElevatedButton(onPressed: (){
                                  _changeColorList[position].value = false;
                                }, child: Text(Constants.CATEGORIES[position], style: TextStyle(color: Colors.white),),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      backgroundColor: Colors.blue
                                  ),
                                ),
                              ),
                            );
                          }
                          else{
                            return Padding(
                              padding: EdgeInsets.only(right: 5,
                                  left: 5
                              ),
                              child: ButtonTheme(
                                height: 10,
                                child: ElevatedButton(onPressed: () async{
                                  _changeColorList.forEach((element) {
                                    if(element.value){
                                      element.value = false;
                                    }
                                  });
                                  _changeColorList[position].value = true;
                                  switch(Constants.CATEGORIES[position]){
                                    case Constants.TECHNOLOGY:
                                      await newsFuture.fetchTechnologyCategoryNews();
                                      break;
                                    case Constants.SPORTS:
                                      await newsFuture.fetchSportsCategoryNews();
                                      break;
                                    case Constants.GENERAL:
                                      await newsFuture.fetchGeneralCategoryNews();
                                      break;
                                    case Constants.BUSINESS:
                                      await newsFuture.fetchBusinessCategoryNews();
                                      break;
                                    case Constants.HEALTH:
                                      await newsFuture.fetchHealthCategoryNews();
                                      break;
                                    case Constants.ENTERTAINMENT:
                                      await newsFuture.fetchEntertainmentCategoryNews();
                                      break;
                                    case Constants.SCIENCE:
                                      await newsFuture.fetchScienceCategoryNews();
                                      break;
                                  }
                                }, child: Text(Constants.CATEGORIES[position], style: TextStyle(color: Colors.white),),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      backgroundColor: Colors.grey
                                  ),
                                ),
                              ),
                            );
                          }
                        });

                      },
                        itemCount: Constants.CATEGORIES.length,
                      ),
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        flex: 6,
                        child: FutureBuilder<bool>(
                            future: newsFuture.fetchInitialBusinessNews(),
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
                                      child: GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 1,
                                            childAspectRatio: 2
                                        ),
                                        itemBuilder: (ctx, position){
                                          return InkWell(
                                            onTap: (){
                                              /*Navigator.of(context).push(RouteUtil.createRoute(ExtraLargeWebDetailView(data.articles![position].title!,
                                                    data.articles![position].description!,
                                                    data.articles![position].source!.name,
                                                    DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                                    data.articles![position].urlToImage,
                                                    Constants.ROUTE_CATEGORY
                                                )));*/
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8),
                                              child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 5,
                                                      child: Container(
                                                        width: size.width,
                                                        alignment: Alignment.center,
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
                                                      child: Padding(padding: EdgeInsets.only(left: 6),child: Wrap(
                                                          children: [Text(data.articles![position].title!,
                                                            style: GoogleFonts.poppins(
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 16
                                                            ),
                                                          ),]
                                                      )),
                                                    ),
                                                    SizedBox(height: 5,),
                                                    ListTile(contentPadding: EdgeInsets.only(left: 3),leading: FittedBox(
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
                                                    )
                                                  ]
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: data.articles!.length,
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            else{
              return SafeArea(
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5,),
                      Expanded(child: ListView.builder(scrollDirection: Axis.horizontal,itemBuilder: (ctx, position){
                        _changeColorList.add(ValueNotifier<bool>(false));
                        return ValueListenableBuilder(valueListenable: _changeColorList[position], builder: (ctx, value, wid){
                          if(value){
                            return Padding(
                              padding: EdgeInsets.only(right: 5, left: 5),
                              child: ButtonTheme(
                                height: 10,
                                child: ElevatedButton(onPressed: (){
                                  _changeColorList[position].value = false;
                                }, child: Text(Constants.CATEGORIES[position], style: TextStyle(color: Colors.white),),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      backgroundColor: Colors.blue
                                  ),
                                ),
                              ),
                            );
                          }
                          else{
                            return Padding(
                              padding: EdgeInsets.only(right: 5,
                                  left: 5
                              ),
                              child: ButtonTheme(
                                height: 10,
                                child: ElevatedButton(onPressed: () async{
                                  _changeColorList.forEach((element) {
                                    if(element.value){
                                      element.value = false;
                                    }
                                  });
                                  _changeColorList[position].value = true;
                                  switch(Constants.CATEGORIES[position]){
                                    case Constants.TECHNOLOGY:
                                      await newsFuture.fetchTechnologyCategoryNews();
                                      break;
                                    case Constants.SPORTS:
                                      await newsFuture.fetchSportsCategoryNews();
                                      break;
                                    case Constants.GENERAL:
                                      await newsFuture.fetchGeneralCategoryNews();
                                      break;
                                    case Constants.BUSINESS:
                                      await newsFuture.fetchBusinessCategoryNews();
                                      break;
                                    case Constants.HEALTH:
                                      await newsFuture.fetchHealthCategoryNews();
                                      break;
                                    case Constants.ENTERTAINMENT:
                                      await newsFuture.fetchEntertainmentCategoryNews();
                                      break;
                                    case Constants.SCIENCE:
                                      await newsFuture.fetchScienceCategoryNews();
                                      break;
                                  }
                                }, child: Text(Constants.CATEGORIES[position], style: TextStyle(color: Colors.white),),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(15)
                                      ),
                                      backgroundColor: Colors.grey
                                  ),
                                ),
                              ),
                            );
                          }
                        });

                      },
                        itemCount: Constants.CATEGORIES.length,
                      ),
                      ),
                      SizedBox(height: 15,),
                      Expanded(
                        flex: 14,
                        child: Container(
                          width: size.width,
                          child: FutureBuilder<bool>(
                            future: newsFuture.fetchInitialBusinessNews(),
                            builder: (ctx, snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                                return SpinKitCircle(
                                  size: 40,
                                  color: Colors.blue,
                                );
                              }
                              else{
                                return Consumer<CategoriesViewModel>(
                                    builder: (context, news, ch) {
                                      var data = news.getCategoriesHeadLines;
                                      return ListView.builder(itemBuilder: (ctx, position){
                                        return Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(flex: 3,child: Container(
                                                height: size.height * 0.3,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(15),
                                                  child: data.articles![position].urlToImage != null ? CachedNetworkImage(imageUrl: data.articles![position].urlToImage,
                                                    fit: BoxFit.cover,
                                                    placeholder: (ctx, st){
                                                      return SpinKitCircle(color: Colors.blue,);
                                                    },
                                                    errorWidget: (ctx, st, ob){
                                                      return Icon(Icons.error, color: Colors.red,);
                                                    },
                                                  ) :
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
                                                height: size.height * 0.3,
                                                child: Column(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 8,
                                                      child: Text(data.articles![position].title!,
                                                        style: GoogleFonts.poppins(
                                                            fontWeight: FontWeight.w600,
                                                            fontSize: 18
                                                        ),
                                                      ),
                                                    ),
                                                    /*ListTile(
                                                        leading: Text(data.articles![position].source!.id!,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!))),
                                                        minLeadingWidth: 30,
                                                      )*/
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(child: FittedBox(
                                                            child: Text(data.articles![position].source!.name,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight: FontWeight.w700
                                                              ),
                                                            ),
                                                            fit: BoxFit.contain,
                                                            alignment: Alignment.centerLeft,
                                                          ),
                                                            //flex: 2,
                                                          ),
                                                          //SizedBox(width: 5,),
                                                          Expanded(child: Container(alignment: Alignment.centerRight,child: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)))))
                                                        ],
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      ),
                                                    )
                                                  ],
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      )
                    ],
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
