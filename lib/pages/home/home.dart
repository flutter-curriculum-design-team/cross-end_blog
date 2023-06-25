import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_blog/pages/home/action.dart';
import 'package:my_blog/pages/home/head.dart';
import 'package:my_blog/pages/home/postList.dart';
import 'package:my_blog/pages/home/slideShow.dart';
import 'package:my_blog/services/homeAPI.dart';
import 'package:my_blog/pages/home/essay.dart';
import 'dart:math';
import 'package:my_blog/pages/home/data.dart';
import 'package:my_blog/pages/write/wr_essay.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/LogUtil.dart';

class Home extends StatefulWidget {
  bool check = true;

  Home({Key? key, this.check = true}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final HomeAPI homeAPI = HomeAPI();

  bool _isLoading = false;
  
  Map<String, dynamic> _data = {};
  late TabController _tabController;

  late String _id;
  List<String> _tags = []; // 标签列表
  List<dynamic> _slideList = []; // 轮播图列表
  List<Post> _posts = []; // 文章列表

  @override
  void initState() {
    super.initState();
    fetchData().then((_) {
      _tabController = TabController(length: _tags.length, vsync: this);
      setState(() {

      }); // 重新渲染
    });
    print(_slideList);
    print(_slideList.runtimeType);
    print("成功取出tags!!!!!!!!!!!!!!!!!!!!!!");
    SharedPreferences.getInstance().then((prefs) {
      _id = prefs.getString('loginInformationId')!;
      // 在这里可以使用 loginInformationId 值
    });
    print("获得到的id" + _id);
  }

  Future<void> fetchData() async {
    // 离线 测试
    if (_isLoading == false) {
      _tags = ['home', 'Test', 'Ces', 'space', 'entertainment'];
      _posts = generatePosts();
      _id = "2021120053";
      _slideList = [
        "https://www.itying.com/images/flutter/4.png",
        "https://www.itying.com/images/flutter/3.png",
        "https://www.itying.com/images/flutter/2.png",
      ];
    } else {
      var userInfo = await homeAPI.getUserIntialInfo();
      var postPage = await homeAPI.getPostPage();
      setState(() {
        // 加载动态个人信息
        _isLoading = false;
        var labels = userInfo['data']['labels'];
        var slides = userInfo['data']['userInfoDto']['slideVenue'];
        _tags = ['home', ...[for (final entry in labels) entry['title'].toString()], 'space', 'entertainment'];
        _slideList = slides;

        // 加载动态文章信息
        print("转化中");
        _posts = postsFromJson(postPage); // 使用函数转化
        print("转化成功");
        print(_posts[0].image);
        _isLoading = false;
      });
    }
  }

  // 转换函数
  List<Post> postsFromJson(Map<String, dynamic> postPage) {
    final List<dynamic> postsResponse = postPage['data']['records'];
    List<Post> posts = [];
    for (var postJson in postsResponse) {
      Post post = Post.fromJson(postJson);
      posts.add(post);
    }
    return posts;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

//! mock数据，这里展示20条数据
  List<Post> generatePosts() {
    List<Post> fake = [];
    for (int i = 0; i < 20; i++) {
      fake.add(Post(
        title: geneTitle(),
        content: geneContent(),
        author: getAuthor(),
        date: getDate(),
        tag: "${_tags[Random().nextInt(_tags.length)]}",
        image:"https://www.itying.com/images/flutter/${Random().nextInt(5)}.png",
        //! 后面索引是10张图片，这里就用索引
        thume_up_num: Random().nextInt(1000).toString(),
        comments: geneComments(),
        //! 生成10条评论
        id: "$i",
      ));
    }
    return fake;
  }

  //! 生成tabView视图，这里除了首页调用的参数都是随机生成的
  List<Widget> generateTabViews() {
    List<Widget> tabViews = [];
    for (int i = 0; i < _tags.length; i++) {
      if (i == 0) {
        tabViews.add(CustomScrollView(
          slivers: [
            SlideShow(slideList: _slideList,),
            PostList(posts: _posts),
          ],
        ));
        continue;
      }
      if (i >= _tags.length - 2) {
        tabViews.add(CustomScrollView(
          slivers: [
            essayListPage(posts: generatePost_essay(10)),
          ],
        ));
        continue;
      }
      tabViews.add(CustomScrollView(
        slivers: [
          PostList(posts: _posts),
        ],
      ));
    }
    return tabViews;
  }

  
  @override
  Widget build(BuildContext context) {
    // 打印检查主页
    // print(widget.check);

    return _isLoading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          )
        : Scaffold(
            // !原先单页的代码
            // body: CustomScrollView(
            //
            //   slivers: [
            //     Head(tabController: _tabController, tags: _tags),
            //     SlideShow(),
            //     PostList(posts: this.posts),
            //   ],
            // ),
            //! 这里显示的滚动条下的页面，这里可以用head了
            body: CustomScrollView(slivers: [
              Head(
                  tabController: _tabController,
                  tags: _tags,
                  isUser: widget.check),
              SliverFillRemaining(
                child: TabBarView(
                  controller: _tabController,
                  children: generateTabViews(),
                ),
              )
            ]),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // 按钮被按下时执行的操作
                print(_tabController.index);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WritePage()),
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          );
  }
}

