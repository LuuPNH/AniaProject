import 'package:flutter/material.dart';
import 'package:project_flutter/styles/colors_custom.dart';
import 'package:project_flutter/view_model/user_detail_viewmodel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailUserView extends StatefulWidget {
  final int? id;

  const DetailUserView({Key? key, this.id}) : super(key: key);

  @override
  _DetailUserViewState createState() => _DetailUserViewState(id);
}

class _DetailUserViewState extends State<DetailUserView> {
  final int? id;

  _DetailUserViewState(this.id);

  UserDetailViewModel? userDetailViewModel;

  RefreshController refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      userDetailViewModel!.getUserDetail(id ?? 1);
      refreshController.refreshCompleted();
    });
  }
  @override
  Widget build(BuildContext context) {
    bool _pinned = true;
    bool _snap = false;
    bool _floating = false;
    Size size = MediaQuery.of(context).size;
    userDetailViewModel = UserDetailViewModel(id ?? 1);
    return Scaffold(
      backgroundColor: ColorCustom.mainColor,
      body: FutureBuilder(
        future: userDetailViewModel!.getUserDetail(id ?? 1),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: ColorCustom.btnColor));
          } else {
            return SmartRefresher(
              enablePullDown: true,
              header: const WaterDropHeader(),
              controller: refreshController,
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                      pinned: _pinned,
                      snap: _snap,
                      floating: _floating,
                      backgroundColor: ColorCustom.mainColor,
                      expandedHeight: size.height * 0.3,
                      bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(0.0),
                          child: Transform.translate(
                            offset: const Offset(0, 40),
                            child: CircleAvatar(
                              radius: size.width * 0.2,
                              backgroundImage: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/loading.gif',
                                image: (userDetailViewModel!
                                            .userDetailModel?.avatarUrl ==
                                        null)
                                    ? 'https://scontent.fdad3-4.fna.fbcdn.net/v/t1.6435-9/240705454_1803513209835455_4090103397545536717_n.jpg?_nc_cat=101&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=iDDXCH-Qt-EAX_oCmoM&_nc_ht=scontent.fdad3-4.fna&oh=2d83dbe7ad7c4aee8d56c4b5c5984851&oe=619C1FA9'
                                    : '${userDetailViewModel!.userDetailModel?.avatarUrl}',
                                fit: BoxFit.cover,
                              ).image,
                            ),
                          )),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          'https://picsum.photos/200'))),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3)),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                      colors: [
                                    Colors.black.withOpacity(0.9),
                                    Colors.black.withOpacity(0.0)
                                  ])),
                            )
                          ],
                        ),
                      )),
                  SliverPadding(
                    padding: const EdgeInsets.all(0.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  (userDetailViewModel!.userDetailModel?.login ==
                                          null)
                                      ? 'No name'
                                      : '${userDetailViewModel!.userDetailModel?.login?.toUpperCase()}',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: ColorCustom.btnColor)),
                              Text((userDetailViewModel!.userDetailModel?.location ==
                                  null)
                                  ? 'No name'
                                  : '${userDetailViewModel!.userDetailModel?.location?.toUpperCase()}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal,
                                      color: ColorCustom.btnColor)),
                              const Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Divider(
                                  color: ColorCustom.btnColor,
                                ),
                              ),
                              Container(
                                color: ColorCustom.mainColor,
                                height: size.height * 0.1,
                                width: size.width,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 30, left: 30),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              (userDetailViewModel!.userDetailModel
                                                          ?.followers ==
                                                      null)
                                                  ? 'No name'
                                                  : '${userDetailViewModel!.userDetailModel?.followers?.toString()}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorCustom.btnColor)),
                                          const Text('Followers',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorCustom.btnColor)),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              (userDetailViewModel!.userDetailModel
                                                  ?.following ==
                                                  null)
                                                  ? 'No name'
                                                  : '${userDetailViewModel!.userDetailModel?.following?.toString()}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorCustom.btnColor)),
                                          const Text('Following',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorCustom.btnColor)),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                              (userDetailViewModel!.userDetailModel
                                                  ?.publicRepos ==
                                                  null)
                                                  ? 'No name'
                                                  : '${userDetailViewModel!.userDetailModel?.publicRepos?.toString()}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorCustom.btnColor)),
                                          const Text('Repo',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorCustom.btnColor)),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                                child: Divider(
                                  color: ColorCustom.btnColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
