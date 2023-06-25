# cross-end blog------small screen mobile flutter terminal

## get started
在运行此项目之前，请确保您已经安装了Flutter SDK。
- First,download dependency
```bash
pub get
```
- Second,run
```bash
flutter run
```
## 项目介绍

此项目为 cross-end blog 小屏端和移动端部分，负责小屏、移动端的渲染展示，作为大屏react渲染端的互补项目，参照了谷歌简约风，给予用户良好的使用体验。

## 项目实现

### 技术选型与相关开发文档

- 应用框架：Flutter

    - Flutter 是一个快速开发高质量、高性能的移动应用框架。Flutter 使用现代化的语言 Dart 开发，其极速的开发和热重载功能使得团队可以高效协作和迭代，同时，Flutter 支持多平台开发，使得我们可以快速开发出高质量的 iOS 和 Android 应用。

- 开发环境：

    - 开发工具：Android Studio，VScode
    - 版本控制工具：Git

- 组件库

    - Cupertino Icons：提供 iOS 风格图标字体库
    - material_design_icons_flutter：提供 Material Design 图标字体库

- 第三方库

    - carousel_slider：实现图片轮播组件
    - cached_network_image：提供网络图片加载工具，可缓存图片
    - flutter_svg：提供 SVG 图片渲染工具
    - markdown_widget：提供 Markdown 渲染 widget
    - flutter_markdown：提供 Markdown 渲染库
    - flutter_highlight：提供代码高亮库
    - url_launcher：提供启动 URL 资源的工具
    - font_awesome_flutter：提供字体图标库，包含超过 5,000 种图标

### 架构设计

- 数据层：负责管理应用程序的数据。包括与服务器的网络通信，本地数据的缓存等。在 Flutter 中，我们可以使用 Dart 具有的异步特性来进行网络请求，并使用 SQLite 或 SharedPreferences 等本地存储库来缓存数据。

- 业务逻辑层：负责管理应用程序的业务逻辑，例如按时间顺序显示会话记录、接收消息并显示通知等处理。

- 视图层：通常是在屏幕上绘制用户界面元素。在博客应用中，我们可以通过使用 Flutter 提供的 Material Design 组件库，实现简单的 UI 布局。包括聊天气泡、头像、键盘等界面元素。

- 交互层：与用户交互的各种操作。例如：点击、滑动手势等交互操作。在 Flutter 中，我们可以通过 GestureDetector 组件来使用这些操作。

### 项目结构

```
cross-end blog:.
├─common
│      constants.dart
│
├─components
│      animated_numeric_text.dart
│      fade_in.dart
│      round_button.dart
│      SliderDialog.dart
│
├─mock
│      home.dart
│
├─models
│      apiProvider.dart
│
├─pages
│  ├─checkIn
│  │      custom_route.dart
│  │      generated_plugin_registrant.dart
│  │      login_screen.dart
│  │      transition_route_observer.dart
│  │
│  ├─detail
│  │      bottomInfo.dart
│  │      detail.dart
│  │      mdToc.dart
│  │      myCatalog.dart
│  │      MyMD.dart
│  │
│  ├─explore
│  │      others.dart
│  │
│  ├─home
│  │      action.dart
│  │      data.dart
│  │      essay.dart
│  │      funList.dart
│  │      head.dart
│  │      home.dart
│  │      postList.dart
│  │      slideShow.dart
│  │
│  ├─person
│  │      login_page.dart
│  │      person.dart
│  │      personlist.dart
│  │      person_edit.dart
│  │      slideView_edit.dart
│  │
│  └─write
│          wr_essay.dart
│
├─services
│      apiInterceptor.dart
│      base.dart
│      checkAPI.dart
│      dio.dart
│      homeAPI.dart
│
└─utils
        APIUtil.dart
        data.txt
        LogUtil.dart
        StrUtil.dart
```

### app演示视频
(压缩过了，不压缩上传不了)
https://github.com/flutter-curriculum-design-team/cross-end_blog/assets/98375546/15f93eda-36cb-4649-9d44-a212cd91edac

