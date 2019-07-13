import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Image display sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Image display sample'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  List<Image> _listItems = [];

  void setDefaultImages() {
    var defaultImage1 = Image.asset('images/dog.jpg');
    var defaultImage2 = Image.network('https://www.pakutaso.com/shared/img/thumb/TS0529003_TP_V.jpg');

    setState(() {
      _listItems.add(defaultImage1);
      _listItems.add(defaultImage2);
    });
  }

  Future selectGalleryImage() async {
    var pickImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _listItems.add(Image.file(pickImage));
      _listKey.currentState.insertItem(_listItems.length-1);
    });
  }

  _displaySnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  void initState() {
    super.initState();
    _listItems.clear();
    setDefaultImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,

      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: AnimatedList(
        key: _listKey,
        initialItemCount: _listItems.length,
        itemBuilder: (BuildContext context, int index, Animation animation) {
          return _buildItem(_listItems[index], animation);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: selectGalleryImage,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  // Graphics List Item View (Slidable and Animated)
  Widget _buildItem(Image item, Animation animation) {
    return SizeTransition(
      sizeFactor: animation,
      child:  Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          color: Colors.white,
          child: Image(
            image: item.image,
//            image: AssetImage('images/dog.jpg'),
//            image: NetworkImage('https://www.pakutaso.com/shared/img/thumb/TS0529003_TP_V.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () => _displaySnackBar(context, 'Archive'),
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () => _displaySnackBar(context, 'Share'),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'More',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () => _displaySnackBar(context, 'More'),
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            //onTap: () => _displaySnackBar(context, 'Delete'),
            onTap: () {
              var removeIndex = _listItems.indexOf(item);
              _listItems.removeAt(removeIndex);

              AnimatedListRemovedItemBuilder builder = (context, animation) {
                return _buildItem(item, animation);
              };

              _listKey.currentState.removeItem(removeIndex, builder);

              _displaySnackBar(context, 'Delete');
            },
          ),
        ],
      ),

    );
  }

}

