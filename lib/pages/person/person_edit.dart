
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_blog/pages/person/slideView_edit.dart';

class PersonEditPage extends StatefulWidget {
  @override
  _PersonEditPageState createState() => _PersonEditPageState();
}

class _PersonEditPageState extends State<PersonEditPage> {
  String _avatarUrl = "https://www.itying.com/images/flutter/2.png";
  String _name = 'xingxing';
  String _email = "123456@qq.com";
  String _signature = 'So far all life is written with failure, but this does not prevent me from moving forward';

  late List<File> _imageFiles;


  // _PersonEditPageState(
  //     this._avatarUrl,
  //     this._name,
  //     this._email,
  //     this._signature,
  //     this._imageFiles,
  //     this._items,
  //     this._nameController,
  //     this._emailController,
  //     this._signatureController);

  List<String> _items = [
    "home",
    "spring boot",
    "spring cloud",
    "react",
    "umi.js",
    "H5",
    "flutter",
    "CSS3",
    "Music",
    "Entertainment"
  ];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _signatureController = TextEditingController();


  // 增加列表
  void _addListItem(String item) {
    setState(() {
      _items.add(item);
    });
  }

  // 删除列表
  void _removeListItem(String item) {
    setState(() {
      _items.remove(item);
    });
  }

  // 列表修改界面的AppBar
  AppBar _buildAppBar() {
    return AppBar(
      title: Text('My List'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _addNewItemDialog(context);
          },
        ),
      ],
    );
  }

  // 列表修改界面增加新的列表
  void _addNewItemDialog(BuildContext context) async {
    String? newItemName;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('New Item'),
        content: TextField(
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Item name',
          ),
          onChanged: (value) {
            setState(() {
              newItemName = value;
            });
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(newItemName);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (newItemName != null) {
      _addListItem(newItemName!);
    }
  }

  //! 显示列表修改界面
  Future<void> _showList() async {
    final String result = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: _items.isEmpty
              ? Center(
                  child: Text(
                    'No items',
                    style: TextStyle(fontSize: 30),
                  ),
                )
              : ListView.builder(
                  itemCount: _items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final String item = _items[index];
                    return ListTile(
                      title: Text(item),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _removeListItem(item);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Info'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveProfile();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: FileImage(File(_avatarUrl)),
              radius: 28.0,
            ),
            title: Text('Avatar'),
            subtitle: Text('Your avatar:'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editAvatar(context);
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Name'),
            subtitle: Text('Your name: ${_name}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editName();
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.email),
            title: Text('Email'),
            subtitle: Text('Your email address: ${_email}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editEmail();
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.pending_actions),
            title: Text('Signature'),
            subtitle: Text('Your signature: ${_signature}'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _editSign();
              },
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.list),
            title: Text('Home: List'),
            subtitle: Text('Manage your lists'),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: _showList,
              // child: Text('Show List'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.slideshow),
            title: Text(
              'slideshow',
            ),
            subtitle: Text("you can change your slideshow"),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () async {
                _imageFiles = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SlideViewEdit(imageFiles: _imageFiles)));
                print(_imageFiles);
                print("成功获得数据");
              },
              // child: Text('Show List'),
            ),
          ),

        ],
      ),
    );
  }

  // void _editAvatar() {
  //   // TODO: 实现头像编辑功能
  // }
  // 头像修改界面，调用的下面的类
  Future<void> _editAvatar(BuildContext context) async {
    final image = await showModalBottomSheet<File?>(
      context: context,
      builder: (context) => ChangeAvatarBottomSheet(),
    );

    if (image != null) {
      // 将图片上传到云端等其他逻辑
      setState(() {
        // 更新新头像图片
        _avatarUrl = image.path;
      });
    }
  }



  void _editName() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Name'),
            content: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Enter your name',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _name = _nameController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'),
              ),
            ],
          );
        });
  }

  void _editEmail() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Email Address'),
            content: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Enter your email address',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _email = _emailController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'),
              ),
            ],
          );
        });
  }

  void _editSign() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Update Signature'),
            content: TextFormField(
              controller: _signatureController,
              decoration: const InputDecoration(
                labelText: 'Enter your signature',
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _signature = _signatureController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text('SAVE'),
              ),
            ],
          );
        });
  }

  void _saveProfile() {
    // TODO: 提交表单并更新用户信息


    Navigator.of(context).pop();
  }
}

class ChangeAvatarBottomSheet extends StatefulWidget {
  const ChangeAvatarBottomSheet({Key? key}) : super(key: key);

  @override
  _ChangeAvatarBottomSheetState createState() => _ChangeAvatarBottomSheetState();
}

class _ChangeAvatarBottomSheetState extends State<ChangeAvatarBottomSheet> {
  File? _image;

  Future<void> _getImage(ImageSource source) async {
    final image = await ImagePicker().getImage(
      source: source,
      imageQuality: 50,
      maxWidth: 800,
    );

    if (image != null) {
      setState(() {

        _image = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final primaryColor = theme.primaryColor;
    final textColor = textTheme.bodyText1!.color;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Change Avatar',
            style: textTheme.headline6!.copyWith(color: textColor),
          ),
          SizedBox(height: 16.0),
          GestureDetector(
            onTap: () => _getImage(ImageSource.camera),
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? Icon(Icons.camera_alt, size: 50.0)
                  : null,
            ),
          ),
          SizedBox(height: 8.0),
          GestureDetector(
            onTap: () => _getImage(ImageSource.gallery),
            child: CircleAvatar(
              radius: 50.0,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? Icon(Icons.photo, size: 50.0)
                  : null,
            ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, _image);
            },
            style: ElevatedButton.styleFrom(primary: primaryColor),
            child: Text('Ok'),
          ),
          SizedBox(height: 16.0),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
