import 'dart:io';
import 'dart:io';
import 'package:absolute_solutions/API/custom_button.dart';
import 'package:absolute_solutions/UI/service_list.dart';
import 'package:absolute_solutions/controllers/LocNotifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddService extends StatefulWidget {
  const AddService({Key key}) : super(key: key);

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _controller = Get.find<LocalNotificationController>();
  var top = FractionalOffset.topCenter;
  var bottom = FractionalOffset.bottomCenter;
  double width = 200.0;
  double widthIcon = 180.0;
  bool _isLoading = false;
  File _vehicleImage1, _vehicleImage2;
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController phonecontroller = new TextEditingController();
  TextEditingController addresscontroller = new TextEditingController();
  TextEditingController partscontroller = new TextEditingController();
  TextEditingController rejectionscontroller = new TextEditingController();
  TextEditingController desccontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController rawcecontroller = new TextEditingController();
  TextEditingController arocecontroller = new TextEditingController();
  TextEditingController hancashcontroller = new TextEditingController();

  FocusNode nameFocus = new FocusNode();
  FocusNode phoneFocus = new FocusNode();
  FocusNode addressFocus = new FocusNode();
  FocusNode referFocus = new FocusNode();
  FocusNode priceFocus = new FocusNode();
  FocusNode HandcashFocus = new FocusNode();

  String dropdownValue = 'Dolphine water purifier Rs. 9000';
  String dropdownValue1 = 'Free water reading checking';
  String selectCamera = 'Camera';
  String selectGallery = 'Gallery';
  String vehicleImageUrl, anotherVehicleImageUrl;

  var list = [
    Colors.lightGreen,
    Colors.redAccent,
  ];

  var raw, aro, result;
  var rawVal, aroVal, resultVal;
  var resultValue;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _vehicleImage1 = image;
      print('Image Path $_vehicleImage1');
    });
  }

  Future uploadPic1() async {
    if (_vehicleImage2 != null && _vehicleImage1 != null) {
      setState(() {
        _isLoading = true;
      });
      String fileName = basename(_vehicleImage1.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_vehicleImage1);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      var url = await taskSnapshot.ref.getDownloadURL();
      vehicleImageUrl = url.toString();
      print("Image uploaded");
      Get.snackbar('Image Uploaded', 'Image Upload Successful',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Select Image', 'Select Image to continue....',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future getResul() {
    rawVal = int.parse(raw);
    aroVal = int.parse(aro);
    setState(() {
      resultVal = ((rawVal - aroVal) / rawVal) * 100;
      resultValue = double.parse((resultVal).toStringAsFixed(3));
      // resultValue = resultValue.round();
    });
  }

  Future uploadPic2() async {
    if (_vehicleImage2 != null && _vehicleImage1 != null) {
      setState(() {
        _isLoading = true;
      });
      String fileName = basename(_vehicleImage2.path);
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(_vehicleImage2);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      var url = await taskSnapshot.ref.getDownloadURL();
      anotherVehicleImageUrl = url.toString();
      print("Profile Picture uploaded");
      Get.snackbar('Profile Picture Uploaded', 'Profile Picture Uploaded',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Select Image', 'Select Image to continue....',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void initState() {
    _controller.configureLocalTimeZone();
    _controller.nextInstanceOf90Days();
    if (rawcecontroller.text == null && arocecontroller.text == null) {
      rejectionscontroller.text = 0 as String;
    } else {
      setState(() {
        String a = rawcecontroller.text;
        String b = arocecontroller
            .text; //_two => TextEditingController of 2nd TextField
        String c = (a + b); //do your calculation
        rejectionscontroller.text = c.toString();
      });
    }

    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        width = 190.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 65.0,
            left: 5,
            child: ClipPath(
              clipper: MyClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 700.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
          ),
          Positioned(
            top: 30.0,
            left: MediaQuery.of(context).size.width - 135.0,
            child: Column(
              children: <Widget>[
                Container(
                  width: 120.0,
                  height: 120.0,
                  child:
                      Image.asset('assets/images/AS.png', color: Colors.white),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 5.0),
                      child: Text(
                        'App',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 40.0,
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '',
                  style: TextStyle(color: Colors.blue, fontSize: 20.0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'Add New',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 5.0),
                      child: Text(
                        'Service',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.blue, fontSize: 15.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: 305.0,
                    child: TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                          labelText: 'Customer name',
                          hintText: 'Enter  name',
                          hintStyle: TextStyle(color: Colors.grey),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: 305.0,
                    child: TextField(
                      controller: phonecontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: 'Enter phone number',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: 305.0,
                    child: TextField(
                      controller: addresscontroller,
                      decoration: InputDecoration(
                          labelText: 'Work Done',
                          hintText: 'Work Done',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: 305.0,
                    child: TextField(
                      controller: partscontroller,
                      decoration: InputDecoration(
                          labelText: 'Parts',
                          hintText: 'Enter Parts',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 2.0), //(x,y)
                              blurRadius: 8.0,
                            ),
                          ],
                        ),
                        width: 148.0,
                        child: TextField(
                          controller: pricecontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Price',
                            hintText: 'Enter Price',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 2.0), //(x,y)
                              blurRadius: 8.0,
                            ),
                          ],
                        ),
                        width: 148.0,
                        child: TextField(
                          controller: hancashcontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Hand cash',
                            hintText: 'Enter Hand cash',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 2.0), //(x,y)
                              blurRadius: 8.0,
                            ),
                          ],
                        ),
                        width: 148.0,
                        child: TextField(
                          onChanged: (String val) {
                            setState(() {
                              raw = val;
                            });
                          },
                          controller: rawcecontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Raw',
                            hintText: 'Enter Raw',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 2.0), //(x,y)
                              blurRadius: 8.0,
                            ),
                          ],
                        ),
                        width: 148.0,
                        child: TextField(
                          onSubmitted: (val) {
                            getResul();
                          },
                          onChanged: (String val) {
                            setState(() {
                              aro = val;
                            });
                          },
                          controller: arocecontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Aro',
                            hintText: 'Enter Aro',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: 305.0,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                          'Rejection Rate = ${resultValue.toString() == null ? '0' : resultValue.toString()}'),
                    ),
                    /*TextField(
                      keyboardType: TextInputType.number,
                      controller: rejectionscontroller,
                      decoration: InputDecoration(
                          labelText: 'Rejection',
                          hintText: 'Enter Rejection',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0))),
                    ),*/
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 2.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    width: 305.0,
                    child: TextField(
                      controller: desccontroller,
                      decoration: InputDecoration(
                          labelText: 'Description',
                          hintText: 'Enter Description',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(22.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10),
                  child: Column(children: [
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                        width: 30,
                        color: Colors.blue,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>[
                        'Dolphine water purifier Rs. 9000',
                        'Nature + water purifier Rs. 9000',
                        'Clean water water purifier Rs. 9000',
                        'Aqua Grand Plus Water Purifier Rs.10800',
                        'Aqua Touch Water Purifier Rs. 9500',
                        'Aqua Pearl Water Purifier Rs.14000',
                        'Aquafresh Water Purifie Rs.11000',
                        'Aqua glance water purifier Rs. 9500',
                        '25 LPH Rs.18000',
                        '50LPH Rs.25000'
                        'none'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue1,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                      underline: Container(
                        height: 2,
                        width: 30,
                        color: Colors.blue,
                      ),
                      onChanged: (String newValue) {
                        setState(() {
                          dropdownValue1 = newValue;
                        });
                      },
                      items: <String>[
                        'Free water reading checking',
                        'INLINE PER-CARBON Rs. 350',
                        'INLINE SEDIMENT Rs. 350',
                        'INLINE POST-CARBON Rs. 350',
                        'S.V 24V (SLX) Rs. 400',
                        'S.V 36V (HERO) Rs. 450',
                        'S.V 48V (HERO) Rs. 550',
                        'ADAPTOR 24V (S.S.E) Rs. 900',
                        'ADAPTOR 36V (S.S.E) Rs.1100',
                        'ADAPTOR 48V (S.S.E) Rs.1400',
                        'FLOAT SWITCH Rs. 150',
                        '10" SPUN (AQUA) Rs. 150',
                        '10"SPUN HOUSING Rs. 400',
                        'MEMBRANE HOUSING Rs. 340',
                        'MEMBRANE (VINTRON)75GPD Rs.1350',
                        'MEMBRANE (HJC)80GPD Rs.1850',
                        'MEMBRANE (DOW)100GPD Rs.2500',
                        'TUBE 1/4 (6mm) Rs.  18',
                        'EL BOW 1/4 Rs.  12',
                        'inline filters change basic Ro   Rs.3200',
                        'inline filters change basic uv   Rs.3500',
                        'none'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 19.0, left: 30),
                  child: CustomButton(
                    text: 'Upload Images',
                    onPressed: () {
                      _uploadVehicleImagePopUp(context);
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 8, right: 40.0),
                  padding: EdgeInsets.only(right: 220),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            width: 60,
                            height: 60,
                            child: _vehicleImage1 != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                          image: FileImage(
                                            _vehicleImage1,
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Text(
                                    'No Image',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _vehicleImage1 = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.backspace,
                                color: Colors.black12,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            width: 60,
                            height: 60,
                            child: _vehicleImage2 != null
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                          image: FileImage(
                                            _vehicleImage2,
                                          ),
                                          fit: BoxFit.cover),
                                    ),
                                  )
                                : Text(
                                    'No Image',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _vehicleImage2 = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.backspace,
                                color: Colors.black12,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Positioned(
                  top: MediaQuery.of(context).size.height / 1.62 + 210.0,
                  left: MediaQuery.of(context).size.width - 192.0,
                  child: Container(
                    width: 120.0,
                    height: 70.0,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _isLoading = true;
                        });
                        uploadPic1().then((value) =>
                            uploadPic2().then((value) => addcustomer()));
                      },
                      elevation: 10,
                      hoverColor: Colors.blueAccent,
                      splashColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.lightBlueAccent,
                                Colors.blueAccent
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Add New",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  _uploadVehicleImagePopUp(BuildContext context) {
    return Alert(
        context: context,
        title: "Choose your options",
        content: StatefulBuilder(
          builder: (context, newSetSate) {
            return Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: null,
                  title: Row(
                    children: [
                      Icon(
                        Icons.camera_alt,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Select Camera")
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => chooseImage(selectCamera, context),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ),
                  width: double.infinity,
                  height: 1.0,
                  color: Colors.grey.shade400,
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 0),
                  leading: null,
                  title: Row(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Select Gallery")
                    ],
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () => chooseImage(selectGallery, context),
                ),
              ],
            );
          },
        ),
        buttons: []).show();
  }

  Future chooseImage(String imageSelection, BuildContext context) async {
    Navigator.pop(context);
    if (imageSelection == selectCamera) {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);

      if (_vehicleImage1 == null) {
        setState(() {
          _vehicleImage1 = image;
          print('Camera Image Path 1 $_vehicleImage1');
        });
      } else {
        setState(() {
          _vehicleImage2 = image;
          print('Camera Image Path 2 $_vehicleImage2');
        });
      }
    } else {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      if (_vehicleImage1 == null) {
        setState(() {
          _vehicleImage1 = image;
          print('Gallery Image Path 1 $_vehicleImage1');
        });
      } else {
        setState(() {
          _vehicleImage2 = image;
          print('Gallery Image Path 2 $_vehicleImage2');
        });
      }
    }
  }

  uploadPhoto() {
    if (_vehicleImage1 == null || _vehicleImage2 == null) {
      Get.snackbar('Please Select Image', 'Please Select Image to upload');
    } else {
      uploadPic1();
      uploadPic2();
    }
  }

  void addCustomerDetails() {
    uploadPhoto();
  }

  Future addcustomer() async {
    if (_vehicleImage2 != null && _vehicleImage1 != null) {
      setState(() {
        _isLoading = true;
      });
      Map<String, dynamic> data = {
        "CustomerName": namecontroller.text,
        "PhoneNumber": phonecontroller.text,
        "Address": addresscontroller.text,
        "timeStamp": DateTime.now(),
        "price": pricecontroller.text,
        "handCash": hancashcontroller.text,
        "parts": partscontroller.text,
        "dropdown": dropdownValue,
        "anotherDropdown": dropdownValue1,
        "vehicleImage": vehicleImageUrl,
        "anotherVehicleImage": anotherVehicleImageUrl,
        "rawValue": rawcecontroller.text,
        "aroValue": arocecontroller.text,
        "rejectionValue": resultVal.toString(),
        "description": desccontroller.text,
      };
      try {
        if (dropdownValue1 == '10" SPUN (AQUA) Rs. 150') {
          _controller.schedule90DaysNotification();
        }
        if (dropdownValue == 'inline filters change basic Ro   Rs.3200' ||
            dropdownValue == 'inline filters change basic uv   Rs.3500') {
          _controller.schedule365DaysNotification();
        }
        await Firestore.instance.collection('Services').add(data).then((value) {
          Get.snackbar('Added Successful', 'Service Added Successfully',
              snackPosition: SnackPosition.BOTTOM);
          _sendSMS();
          Get.offAll(() => ServiceScreen());
        });
      } on Exception catch (e) {
        setState(() {
          _isLoading = false;
        });
        Get.snackbar('Error', e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      Get.snackbar('Select Image', 'Select Image to continue....',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _sendSMS() async {
    try {
      await sendSMS(
          message:
              "Dear ${namecontroller.text} \n Your service has been completed successfully.,",
          recipients: ["${phonecontroller.text}"]);
    } catch (error) {
      print(error.toString());
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0.0, size.height - 60.0);

    var firstControlPoint = new Offset(80.0, size.height);
    var firstEndPoint = new Offset(size.width / 3.5, size.height - 45.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    path.lineTo(size.width - 30.0, size.height / 2);

    var secondControlPoint =
        new Offset(size.width + 15.0, size.height / 2 - 60.0);
    var secondEndPoint = new Offset(140.0, 50.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    var thirdControlPoint = new Offset(50.0, 0.0);
    var thirdEndPoint = new Offset(0.0, 100.0);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
