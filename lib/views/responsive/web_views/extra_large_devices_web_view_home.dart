import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/views/responsive/web_views/web_app_drawer.dart';
import 'package:provider/provider.dart';

import '../../../constants/constants.dart';
import '../../../utils/route_util.dart';
import '../../../view_model/news_view_model.dart';
import 'android_ios_large_tablet_web_view_home.dart';
import 'android_ios_medium_mobile_tablet_web_view_home.dart';
import 'android_ios_small_mobile_web_view_home.dart';
import 'extra_large_category_web.dart';
import 'extra_large_detail_web.dart';
import 'large_devices_web_view_home.dart';

class ExtraLargeDevicesWebViewHome extends StatefulWidget {
  const ExtraLargeDevicesWebViewHome({Key? key}) : super(key: key);

  @override
  State<ExtraLargeDevicesWebViewHome> createState() => _ExtraLargeDevicesWebViewHomeState();
}

class _ExtraLargeDevicesWebViewHomeState extends State<ExtraLargeDevicesWebViewHome> {
  NewsViewModel? _newsViewModel;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if(constraints.maxWidth < 600){
          return AndroidIosSmallMobileWebViewHome();
        }
        else if(constraints.maxWidth >= 600 && constraints.maxWidth < 768){
          return AndroidIosMediumMobileTabletWebViewHome();
        }
        else if(constraints.maxWidth >= 768 && constraints.maxWidth < 992){
          return AndroidIosLargeTabletWebViewHome();
        }
        else if(constraints.maxWidth >= 992 && constraints.maxWidth < 1200){
          return LargeDevicesWebViewHome();
        }
        return Scaffold(
          key: _key,
          drawer: WebAppDrawer(_newsViewModel!),
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
            title: Text("News", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700)),
            leading: Padding(
              padding: EdgeInsets.only(left: 5),
              child: InkWell(
                onTap: (){
                  _key.currentState!.openDrawer();
                },
                child: Image.asset("assets/images/Menu.png"),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pushReplacement(RouteUtil.createRoute(ExtraLargeWebCategory()));
                  },
                  child: Image.asset("assets/images/category_icon.png", width: 40,height: 40,),
                ),
              )
            ],
          ),
          body: SafeArea(
            child: FutureBuilder<bool>(
                future: _newsViewModel!.fetchInitialHeadlinesNews("bbc-news"),
                builder: (ctx, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                    return SpinKitCircle(
                      color: Colors.blue,
                      size: 40,
                    );
                  }
                  else{
                    return Consumer<NewsViewModel>(
                      builder: (ctx, news, ch){
                        var data = news.getHeadlines;
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
                                    /*Navigator.of(context).push(RouteUtil.createRoute(ExtraLargeWebDetailView(data.articles![position].title!,
                                        data.articles![position].description!,
                                        data.articles![position].source!.name,
                                        DateFormat.yMMMd("en_US").format(DateTime.parse(data.articles![position].publishedAt!)),
                                        data.articles![position].urlToImage,
                                        Constants.ROUTE_HOME
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
                                            child: Padding(padding: EdgeInsets.only(left: 3),child: Text(data.articles![position].title!,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 18
                                              ),
                                            )),
                                          ),
                                          SizedBox(height: 12,),
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
        );
      }
    );
  }
}
