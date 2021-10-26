import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_flutter/styles/colors_custom.dart';
import 'package:project_flutter/view/detail_user.dart';
import 'package:project_flutter/view_model/list_user_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.red),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ListUserViewModel listUserViewModel = ListUserViewModel();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      listUserViewModel.getUser();
      refreshController.refreshCompleted();
    });
  }

  @override
  void initState() {
    listUserViewModel.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorCustom.titleColor,
          title: const Center(
              child: Text("User List",
                  style: TextStyle(
                      color: ColorCustom.text,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic))),
        ),
        body: FutureBuilder(
          future: listUserViewModel.getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator(color: ColorCustom.btnColor));
            } else {
              return SmartRefresher(
                enablePullDown: true,
                header: const WaterDropHeader(),
                controller: refreshController,
                onRefresh: _onRefresh,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: listUserViewModel.users?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: InkWell(
                          onTap: () {
                            UserViewModel? userViewModel =
                                listUserViewModel.users?[index];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailUserView(
                                      id: userViewModel?.userModel?.id)),
                            );
                          },
                          child: Container(
                            height: size.height * 0.1,
                            width: size.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: size.width * 0.1,
                                  backgroundImage: FadeInImage.assetNetwork(
                                    placeholder: 'assets/images/loading.gif',
                                    image: (listUserViewModel.users?[index]
                                                .userModel?.avatarUrl ==
                                            null)
                                        ? 'https://scontent.fdad3-4.fna.fbcdn.net/v/t1.6435-9/240705454_1803513209835455_4090103397545536717_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=iDDXCH-Qt-EAX_oCmoM&_nc_ht=scontent.fdad3-4.fna&oh=2d83dbe7ad7c4aee8d56c4b5c5984851&oe=619C1FA9'
                                        : '${listUserViewModel.users![index].userModel!.avatarUrl}',
                                    fit: BoxFit.cover,
                                  ).image,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          listUserViewModel.users?[index]
                                                      .userModel?.login ==
                                                  null
                                              ? '[No name]'
                                              : '${listUserViewModel.users![index].userModel!.login}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          listUserViewModel.users?[index]
                                                      .userModel?.login ==
                                                  null
                                              ? '[No name]'
                                              : '${listUserViewModel.users![index].userModel!.htmlUrl}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }
          },
        ));
  }
}
