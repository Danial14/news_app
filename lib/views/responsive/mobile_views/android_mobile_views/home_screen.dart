import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/constants/constants.dart';
import 'package:news_app/models/news_headlines_model.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

import 'categories.dart';
import 'news_details.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newsFuture;
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, (){
      newsFuture = Provider.of<NewsViewModel>(context, listen: false);
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("News", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              return CategoryScreen();
            }));
          },
          icon: Image.asset(Constants.IMAGE_PATH + "category_icon.png",
          width: 25,
            height: 25,
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(itemBuilder: (ctx){
            return <PopupMenuItem>[
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await newsFuture.fetchBbcHeadlinesNews();
                },
                child: Container(height: 35,width: size.width,child: Text("BBC", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await newsFuture.fetchAlJazeeraHeadlinesNews();
                },
                child: Container(width: size.width,height: 35,child: Text("Al Jazeera", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await newsFuture.fetchCnnHeadlinesNews();
                },
                child: Container(height: 35,width: size.width,child: Text("CNN", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await newsFuture.fetchIndependentHeadlinesNews();
                },
                child: Container(height: 35,width: size.width,child: Text("Independent", style: TextStyle(color: Colors.black))),
              )),
              PopupMenuItem(child: InkWell(
                onTap: () async{
                  Navigator.of(context).pop();
                  await newsFuture.fetchReutersHeadlinesNews();
                },
                child: Container(height: 35,width: size.width,child: Text("Reuters", style: TextStyle(color: Colors.black),)),
              ))
            ];
          })
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
               if(orientation == Orientation.portrait){
                 print("Orientation ${orientation.name}");
                 return Container(
                width: size.width,
                height: size.height,
                child: FutureBuilder<bool>(
                  future: newsFuture.fetchInitialHeadlinesNews("bbc-news"),
                  builder: (ctx, snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                      return SpinKitCircle(
                        size: 40,
                        color: Colors.blue,
                      );
                    }
                    else{
                      return Consumer<NewsViewModel>(
                        builder: (context, news, ch) {
                          var data = news.getHeadlines;
                          print("news length: ${data.articles!.length}");
                          List verticalList = data.articles!.sublist((data.articles!.length / 2).toInt());
                          return Column(
                            children: <Widget>[Expanded(
                              flex: 3,
                              child: ListView.builder(itemBuilder: (ctx, position){
                                return InkWell(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                      return NewsDetails(data.articles![position]);
                                    }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: size.width * 0.6,
                                          height: size.height * 0.6,
                                          padding: EdgeInsets.symmetric(horizontal: size.height * .02),
                                          child: data.articles![position].urlToImage != null ? ClipRRect(
                                            child: CachedNetworkImage(imageUrl: data.articles![position].urlToImage,
                                            fit: BoxFit.cover,
                                              placeholder: (ctx, st){
                                              return SpinKitCircle(color: Colors.blue,);
                                              },
                                              errorWidget: (ctx, str, obj){
                                              return Icon(Icons.error, color: Colors.red,);
                                              },
                                            ),
                                            borderRadius: BorderRadius.circular(15),
                                          ) : Center(child: Text("404 Image not found", style: GoogleFonts.italiana(fontSize: 24, fontWeight: FontWeight.w600),)),
                                        ),
                                        Positioned(bottom: 2,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: Container(
                                            width: size.width * 0.5,
                                            height: size.height * 0.10,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(child: Padding(child: SingleChildScrollView(
                                                  child: Text(data.articles![position].title!,
                                                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                                                  ),
                                                ),
                                                padding: EdgeInsets.only(left: 16, top: 5),
                                                ),
                                                flex: 1,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(top: 30),
                                                    child: ListTile(
                                                      leading: Text(data.articles![position].source!.name,style: TextStyle(color: Colors.blue),),
                                                      trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.now())),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                              scrollDirection: Axis.horizontal,
                                itemCount: (data.articles!.length / 2).toInt(),
                              ),
                            ),
                              SizedBox(height: 5,),
                              Expanded(flex: 2,
                              child: ListView.builder(itemBuilder: (ctx, position){
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: InkWell(
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (ctx){
                                              return NewsDetails(data.articles![position]);
                                            }
                                          ));
                                          },
                                        child: Container(
                                          height: size.height * 0.3,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: verticalList[position].urlToImage != null ? CachedNetworkImage(imageUrl: verticalList[position].urlToImage,
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
                                        flex: 3,
                                      ),
                                      SizedBox(width: 5,),
                                      Expanded(child: Container(
                                        height: size.height * 0.3,
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 8,
                                              child: Text(verticalList[position].title!,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18
                                                ),
                                              ),
                                            ),
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
                                                  Expanded(child: Container(alignment: Alignment.centerRight,child: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(verticalList[position].publishedAt!)))))
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
                                itemCount: verticalList.length,
                              ),
                              )
                          ],
                          );
                        }
                      );
                    }
                  },
                ),
              );
               }
               else{
                 print("Orientation ${orientation.name}");
                 return Container(
                   width: size.width,
                   height: size.height,
                   child: FutureBuilder<bool>(
                     future: newsFuture.fetchInitialHeadlinesNews("bbc-news"),
                     builder: (ctx, snapshot){
                       if(snapshot.connectionState == ConnectionState.waiting || !snapshot.data!){
                         return SpinKitCircle(
                           size: 40,
                           color: Colors.blue,
                         );
                       }
                       else{
                         return Consumer<NewsViewModel>(
                             builder: (context, news, ch) {
                               var data = news.getHeadlines;
                               print("news length: ${data.articles!.length}");
                               List verticalList = data.articles!.sublist((data.articles!.length / 2).toInt());
                               return Column(
                                 children: <Widget>[Expanded(
                                   flex: 2,
                                   child: ListView.builder(itemBuilder: (ctx, position){
                                     return InkWell(
                                       onTap: (){
                                         Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                           return NewsDetails(data.articles![position]);
                                         }));
                                       },
                                       child: Container(
                                         decoration: BoxDecoration(),
                                         child: Stack(
                                           alignment: Alignment.center,
                                           children: <Widget>[
                                             Container(
                                               width: size.width,
                                               height: size.height * 0.6,
                                               padding: EdgeInsets.symmetric(horizontal: size.height * .02),
                                               child: data.articles![position].urlToImage != null ? ClipRRect(
                                                 child: CachedNetworkImage(imageUrl: data.articles![position].urlToImage,
                                                   fit: BoxFit.cover,
                                                   placeholder: (ctx, st){
                                                     return SpinKitCircle(color: Colors.blue,);
                                                   },
                                                   errorWidget: (ctx, str, obj){
                                                     return Icon(Icons.error, color: Colors.red,);
                                                   },
                                                 ),
                                                 borderRadius: BorderRadius.circular(15),
                                               ) : Center(child: Text("404 Image not found", style: GoogleFonts.italiana(fontSize: 24, fontWeight: FontWeight.w600),)),
                                             ),
                                             Positioned(bottom: 2,
                                               child: Card(
                                                 shape: RoundedRectangleBorder(
                                                     borderRadius: BorderRadius.circular(15)
                                                 ),
                                                 child: Container(
                                                   width: size.width * 0.8,
                                                   height: size.height * 0.20,
                                                   child: Column(
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: <Widget>[
                                                       Expanded(child: Padding(child: SingleChildScrollView(
                                                         child: Text(data.articles![position].title!,
                                                           style: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
                                                         ),
                                                       ),
                                                         padding: EdgeInsets.only(left: 16, top: 5),
                                                       ),
                                                         flex: 1,
                                                       ),
                                                       Expanded(
                                                         flex: 1,
                                                         child: Padding(
                                                           padding: EdgeInsets.only(top: 30),
                                                           child: ListTile(
                                                             leading: Text(data.articles![position].source!.name,style: TextStyle(color: Colors.blue),),
                                                             trailing: Text(DateFormat.yMMMd("en_US").format(DateTime.now())),
                                                           ),
                                                         ),
                                                       )
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             )
                                           ],
                                         ),
                                       ),
                                     );
                                   },
                                     scrollDirection: Axis.horizontal,
                                     itemCount: (data.articles!.length / 2).toInt(),
                                   ),
                                 ),
                                   SizedBox(height: 5,),
                                   Expanded(flex: 2,
                                     child: ListView.builder(itemBuilder: (ctx, position){
                                       return Padding(
                                         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                         child: Row(
                                           children: <Widget>[
                                             Expanded(child: InkWell(
                                               onTap: (){
                                                 Navigator.of(context).push(MaterialPageRoute(
                                                     builder: (ctx){
                                                       return NewsDetails(data.articles![position]);
                                                     }
                                                 ));
                                               },
                                               child: Container(
                                                 height: size.height * 0.3,
                                                 child: ClipRRect(
                                                   borderRadius: BorderRadius.circular(15),
                                                   child: verticalList[position].urlToImage != null ? CachedNetworkImage(imageUrl: verticalList[position].urlToImage,
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
                                               flex: 3,
                                             ),
                                             SizedBox(width: 5,),
                                             Expanded(child: Container(
                                               height: size.height * 0.3,
                                               child: Column(
                                                 children: <Widget>[
                                                   Expanded(
                                                     flex: 8,
                                                     child: Text(verticalList[position].title!,
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
                                                         Expanded(child: Container(alignment: Alignment.centerRight,child: Text(DateFormat.yMMMd("en_US").format(DateTime.parse(verticalList[position].publishedAt!)))))
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
                                       itemCount: verticalList.length,
                                     ),
                                   )
                                 ],
                               );
                             }
                         );
                       }
                     },
                   ),
                 );
               }
        }
      )
    );
  }
}
