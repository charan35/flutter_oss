import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altaoss/admin_leave-module.dart';
import 'package:flutter_altaoss/calandar_activity.dart';
import 'package:flutter_altaoss/careers.dart';
import 'package:flutter_altaoss/emp_directory_list.dart';
import 'package:flutter_altaoss/employee_attendance.dart';
import 'package:flutter_altaoss/employee_list.dart';
import 'package:flutter_altaoss/interviews.dart';
import 'package:flutter_altaoss/login_register.dart';
import 'package:flutter_altaoss/my_pay.dart';
import 'package:flutter_altaoss/my_profile.dart';
import 'package:flutter_altaoss/new_project.dart';
import 'package:flutter_altaoss/our_updates.dart';
import 'package:flutter_altaoss/project_details.dart';
import 'package:flutter_altaoss/rewards.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class DrawerItem {

  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class MainMenu1 extends StatefulWidget {

  MainMenu1({Key key, this.userId,this.depart})
      : super(key: key);


   String userId;
  final String depart;
  //final VoidCallback signOut;
  //MainMenu(this.signOut);

  final drawerItems = [
    new DrawerItem("Settings", Icons.settings),
    new DrawerItem("Reset Password", Icons.lock),
    new DrawerItem("Sign Out", Icons.exit_to_app)
  ];



  @override
  _MainMenu1State createState() => _MainMenu1State();

}
enum ConfirmAction { NO, YES }

class _MainMenu1State extends State<MainMenu1> {

  FirebaseDatabase db=FirebaseDatabase.instance;

  Query query;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;



  int _selectedDrawerIndex = 0;

  _onSelectItem(int index) {
    // setState(() => _selectedDrawerIndex = index);
    switch (index) {
      case 0:
        return new Settings();
      case 1:
        return  showDialog<ConfirmAction>(
          context: context,
          barrierDismissible: false, // user must tap button for close dialog!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Reset Password ?'),
              content: const Text(
                  'Are you sure want to change password.'),
              actions: <Widget>[
                FlatButton(
                  child: const Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop(ConfirmAction.NO);
                  },
                ),
                FlatButton(
                  child: const Text('YES'),
                  onPressed: () async {
                    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

                    await _firebaseAuth.sendPasswordResetEmail(email: email);
                    pr.show();

                    Future.delayed(Duration(seconds: 3)).then((value){
                      pr.hide().whenComplete((){
                        return showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Reset Password'),
                              content: const Text('Reset Link has been sent to the Registered Email'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    });

                  },
                )
              ],
            );
          },
        );

      case 2:
        signOut();
        break;

      default:
        return new Text("Error");
    }

    Navigator.of(context).pop(); // close the drawer
  }

  ToastMessage(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white);
  }
  signOut() async  {
    try{
      await _firebaseAuth.signOut();
      setState(() {
        widget.userId="";

        pr.show();
        Future.delayed(Duration(seconds: 3)).then((value){
          pr.hide().whenComplete((){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>
                  Login(),

              ),
            );
          });
        });
        ToastMessage("User Successfully LoggedOut");
      });
    } catch (e) {
      print(e);
    }
  }

  int currentIndex = 0;
  String selectedIndex = 'TAB: 0';

  String email = "", name = "", id = "",empid = "",imageUrl="",lastname="",middlename="";
  TabController tabController;
  ProgressDialog pr;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getPref();
    query=db.reference().child("Users").orderByChild("userId").equalTo(widget.userId);
    query.once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,values) {

        setState(() {
          email=values["email"];
          name=values["name"];
          empid=values["empid"];
          imageUrl=values["imageURL"];
          lastname=values["lastname"];
          middlename=values["middlename"];


        });

        print("user" + email);
        print("name" + name);
        print("empid"+empid);
        print("middlename"+middlename);
        print("lastname"+lastname);

        print("imageURL"+imageUrl);


      });
    });


  }

  @override
  Widget build(BuildContext context) {


    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    pr.style(
      message: "Loading...!",
      progressWidget: Container(
        padding: EdgeInsets.all(6.0),child: CircularProgressIndicator(),
      ),
      progressTextStyle: TextStyle(
          color:Colors.black,fontSize: 13.0,fontWeight: FontWeight.w400
      ),
      messageTextStyle: TextStyle(color: Colors.black,fontSize: 15.0,fontWeight: FontWeight.w600),
    );
    if((empid!=null) && (email!=null) && (name!=null) && (imageUrl!=null)){


      var drawerOptions = <Widget>[];
      for (var i = 0; i < widget.drawerItems.length; i++) {
        var d = widget.drawerItems[i];
        drawerOptions.add(
            new ListTile(
              leading: new Icon(d.icon),
              title: new Text(d.title),
              selected: i == _selectedDrawerIndex,
              onTap: () => _onSelectItem(i),
            )
        );
      }

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset('assets/images/logo.png',height: 30.0,width: 30.0,fit: BoxFit.contain,),

              Container(padding: const EdgeInsets.all(8.0),child: Text('AltaOSS'),)
            ],
          ),

          /*actions: <Widget>[
            IconButton(
              onPressed: () {
                signOut();
              },
              icon: Icon(Icons.lock_open),
            )
          ],*/
        ),
        drawer: new Drawer(
          child: new Column(
            children: <Widget>[
              new UserAccountsDrawerHeader(

                accountName: middlename==null?new Text(name+" "+lastname):new Text(name+" "+middlename+" "+lastname),

                accountEmail: new Text(email),
                currentAccountPicture: new CircleAvatar(backgroundImage: NetworkImage(imageUrl),),),
              new Text(empid),

              new Column(children: drawerOptions)
            ],
          ),
        ),



        body:
        new Container(
          child: new Column(
            children: <Widget>[
              new Text("Welcome to Admin dashboard",style: TextStyle(fontWeight: FontWeight.normal,fontSize: _width/15, color: Colors.black,),textAlign: TextAlign.center,),
              SizedBox(
                height: 8.0,
              ),
              new Text(empid,style: TextStyle(fontWeight: FontWeight.bold,fontSize: _width/20, color: Colors.lightBlue,),textAlign: TextAlign.center,),
              middlename==null?new Text(name+" "+lastname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: _width/20, color: Colors.lightBlueAccent,),textAlign: TextAlign.center,):new Text(name+" "+middlename+" "+lastname,style: TextStyle(fontWeight: FontWeight.bold,fontSize: _width/20, color: Colors.lightBlueAccent,),textAlign: TextAlign.center,),


              new Expanded(
                child:Container(
                  padding: EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 16),
                  child:  new GridView.count(crossAxisCount: 2,
                    childAspectRatio: .90,
                    //padding: const EdgeInsets.all(4.0),

                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: <Widget>[
                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyProfile(
                            userId: widget.userId,
                          )
                          ),
                        );

                      },
                        color: Colors.white,


                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/profile.jpg'),),
                            new Text("My Profile"),
                          ],
                        ),
                      ),

                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OurUpdates(
                            empid: empid,
                          )
                          ),
                        );

                      },
                        color: Colors.white,


                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/updates.gif'),),
                            new Text("Our Updates"),
                          ],
                        ),
                      ),

                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Careers(
                            empid: empid,
                          )
                          ),
                        );

                      },
                        color: Colors.white,


                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/careers.png'),),
                            new Text("Careers"),
                          ],
                        ),
                      ),

                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => NewProject(
                            empid: empid,
                          )
                          ),
                        );

                      },
                        color: Colors.white,


                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/newproject.png'),),
                            new Text("New Project"),
                          ],
                        ),
                      ),


                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EmployeeAttendance(),
                          ),
                        );
                      },
                        color: Colors.white,

                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/attendance.png'),),
                            new Text("Attendance"),
                          ],
                        ),
                      ),

                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EmployeeDirectory(),
                          ),
                        );
                      },
                        color: Colors.white,

                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/employeeinfo.png'),),
                            new Text("Employee Directory"),
                          ],
                        ),
                      ),
                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalendarActivity()
                          ),
                        );

                      },
                        color: Colors.white,


                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/calen.png'),),
                            new Text("Calendar"),
                          ],
                        ),
                      ),

                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AdminLeaveModule(),
                          ),
                        );
                      },
                        color: Colors.white,

                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/listicon.png'),),
                            new Text("Leave Module"),
                          ],
                        ),
                      ),

                      /////MyPay
                      new FlatButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyPay(empid: empid, fullname: name,)
                          ),
                        );
                      },
                        color: Colors.white,
                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(child:Image.asset('assets/images/mypay.png'),),
                            new Text("MyPay"),
                          ],
                        ),
                      ),

                      new FlatButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ProjectDetails(empid: empid, fullname: name,)
                          ),
                        );
                      },
                        color: Colors.white,
                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.asset('assets/images/details.png'),),
                            new Text("Project Details"),
                          ],
                        ),
                      ),

                      new FlatButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Rewards()
                          ),
                        );
                      },
                        color: Colors.white,
                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.asset('assets/images/rewards.jpg'),),
                            new Text("Rewards"),
                          ],
                        ),
                      ),

                      new FlatButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Interviews()
                          ),
                        );
                      },
                        color: Colors.white,
                        //padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Image.asset('assets/images/rewards.jpg'),),
                            new Text("Interviews"),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

              ),
            ],
          ),
        ),




        /*bottomNavigationBar: BottomNavyBar(
          backgroundColor: Colors.black,
          iconSize: 30.0,
//        iconSize: MediaQuery.of(context).size.height * .60,
          currentIndex: currentIndex,
          onItemSelected: (index) {
            setState(() {
              currentIndex = index;
            });
            selectedIndex = 'TAB: $currentIndex';
//            print(selectedIndex);
            reds(selectedIndex);
          },

          items: [
            BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Color(0xFFf7d426)),
            BottomNavyBarItem(
                icon: Icon(Icons.view_list),
                title: Text('List'),
                activeColor: Color(0xFFf7d426)),
            BottomNavyBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                activeColor: Color(0xFFf7d426)),
          ],
        ),*/
      );

    }
    else{

      return Scaffold(
        appBar: AppBar(
          title: Text('AltaOSS'),
        ),
        body: new Center(
          child:const CircularProgressIndicator(),
        ),
      );    }
  }

  //  Action on Bottom Bar Press
  void reds(selectedIndex) {
//    print(selectedIndex);

    switch (selectedIndex) {
      case "TAB: 0":
        {
          callToast("Tab 0");
        }
        break;

      case "TAB: 1":
        {
          callToast("Tab 1");
        }
        break;

      case "TAB: 2":
        {
          callToast("Tab 2");
        }
        break;
    }
  }

  callToast(String msg) {
    Fluttertoast.showToast(
        msg: "$msg",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}


