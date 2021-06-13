import 'package:absolute_solutions/UI/Add_Customer.dart';
import 'package:absolute_solutions/UI/profile3.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiderList extends StatefulWidget {
  @override
  _RiderListState createState() => _RiderListState();
}

class _RiderListState extends State<RiderList> {
  final _firStore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddCustomer()),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Icon(
                Icons.add,
                size: 40,
              )),
            ),
          )),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        brightness: Brightness.light,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: SizedBox(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 110,
            ),
            Text(
              'Customer List',
              style: Theme.of(context).textTheme.title.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _firStore
              .collection('Customers')
              // .orderBy("TimeStamp", descending: true)
              .snapshots(),
          // ignore: missing_return
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot> querySnapshot) {
            if (querySnapshot.hasError) return Center(child: Text('Has Error'));
            if (querySnapshot.connectionState == ConnectionState.waiting) {
              CupertinoActivityIndicator();
            }
            if (querySnapshot.data == null) {
              return Center(
                child: Text('No data Found'),
              );
            }
            if (querySnapshot.data.documents.length == 0) {
              return Center(
                child: Text('No data Found'),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                shrinkWrap: true,
                itemCount: querySnapshot.data.documents.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot myCustomers =
                      querySnapshot.data.documents[index];
                  return InkWell(
                    onTap: () {
                      Get.to(
                        () => ProfileView(
                            phone: myCustomers['PhoneNumber'] ?? 'N/A',
                            address: myCustomers['Address'] ?? 'N/A',
                            image: myCustomers['anotherVehicleImage'] ?? 'N/A',
                            image2: myCustomers['vehicleImage'] ?? 'N/A',
                            Name: myCustomers['CustomerName'] ?? 'N/A',
                            handCash: myCustomers['handCash'] ?? 'N/A',
                            refer: myCustomers['refer'] ?? 'N/A',
                            price: myCustomers['price'] ?? 'N/A',
                            id: myCustomers['customerId'] ?? 'N/A')
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(myCustomers['CustomerName'] ??
                                              'N/A'),
                                          Text('Price: ' +
                                                  myCustomers['price'] ??
                                              'N/A'),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Hand Cash: ' +
                                                  myCustomers['handCash'] ??
                                              'N/A'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey[800],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(myCustomers['Address'] ?? 'N/A'),
                                          Text(myCustomers['PhoneNumber'] ??
                                              'N/A'),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              myCustomers['dropdown'] ?? 'N/A'),
                                          Text(myCustomers['anotherDropdown'] ??
                                              'N/A'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
