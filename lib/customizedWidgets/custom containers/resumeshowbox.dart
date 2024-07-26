import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:getwidget/components/loader/gf_loader.dart';
import 'package:getwidget/types/gf_loader_type.dart';
import 'package:resume_maker/DataBAseOperations/resumedatamanaging.dart';
import 'package:resume_maker/MainPages/foundationpages/editing_page.dart';
import 'package:resume_maker/MainPages/foundationpages/first_page.dart';
import 'package:resume_maker/MainPages/previewpage/previewpage.dart';

Widget recentcontainer(screenWidth, screenHeight, Function fetchdata) {
  int? itemcount = ressumes?.length;
  return SingleChildScrollView(
    child: SizedBox(
      width: screenWidth * .7,
      height: screenHeight * .4,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(255, 194, 194, 194),
            ),
            width: 400,
            height: 400,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10),
            child: Text(
              'Ressumes',
              style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          ressumes == null
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: CachedNetworkImage(
                      height: screenHeight * .2,
                      fit: BoxFit.cover,
                      imageUrl: 
                      'https://img.freepik.com/free-vector/empty-concept-illustration_114360-1233.jpg?w=826&t=st=1697326294~exp=1697326894~hmac=1714022541e14290d46401eafa01f32da8d3bd87d7ec105801b06589cd75ab04'
                      ,
                      placeholder: (context, url) => const GFLoader(
                          type: GFLoaderType.android,
                          loaderColorOne: Colors.black),
                      errorWidget: (context, url, error) => const Icon(Icons.error)
                      ),
                ))
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: itemcount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                      //  const Icon(Icons.error),
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: InkWell(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                            width: 80,
                            height: 100,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Icon(
                                      Icons.description_rounded,
                                      color: fourthcolor,
                                      size: 80,
                                    ),
                                    Positioned(
                                      right: -10,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.edit_square,
                                          color:
                                              Color.fromARGB(255, 218, 63, 49),
                                          shadows: [
                                            Shadow(
                                                color: Colors.black,
                                                blurRadius: 1)
                                          ],
                                          size: 25,
                                        ),
                                        onPressed: () {
                                          onPressingEdit(context, index);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Name:${ressumes?[index].personal[0]}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )),
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Animate(
                                  effects: const [ShakeEffect()],
                                  child: AlertDialog(
                                    backgroundColor: Colors.white,
                                    title: Text(
                                        'Ressume: ${ressumes?[index].personal[0]}'),
                                    content:
                                        const Text('Are you sure to delete'),
                                    actions: [
                                      TextButton(
                                        child: const Text('No'),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      // TextButton(
                                      //   child: const Text('Edit',
                                      //       style:
                                      //           TextStyle(color: Colors.green)),
                                      //   onPressed: () {
                                      //     Navigator.pop(context);
                                      //     onPressingEdit(context, index);
                                      //   },
                                      // ),
                                      TextButton(
                                        child: const Text(
                                          'Delete',
                                          // style: TextStyle(color: Colors.red),
                                        ),
                                        onPressed: () {
                                          onDeletePressed(context, index);
                                          fetchdata();
                                        },
                                      )
                                    ],
                                  ),
                                );
                              });
                        },
                        onTap: () {
                          try{
                            if (kDebugMode) {
                              print('currentresume id: $currentRessumeId currrentindex : $index ');
                            }
                          currentRessumeId = ressumes?[index].ressumeid;
                          fetchResume();
                            if (kDebugMode) {
                              print(' After fetching ressumes, currentresume id: $currentRessumeId currrentindex : $index ');
                            }
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return const PreviewPage();
                          }));
                        }
                        catch(e){
                          if (kDebugMode) {
                            print('$e');
                          }
                          return ;
                        }
                        },
                      ),
                    );
                  },
                )
        ],
      ),
    ),
  );
}

void onPressingEdit(context, int index) {
  currentRessumeId = ressumes?[index].ressumeid;
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditingPage(),
      ));
  fetchResume();
}

void onDeletePressed(BuildContext context, int index) {
  currentRessumeId = ressumes?[index].ressumeid;
  deleteResume();
  fetchresumes(fetchdaatatemp);
  currentRessume = null;

  Navigator.pop(context);
}

fetchdaatatemp() {
  
}
