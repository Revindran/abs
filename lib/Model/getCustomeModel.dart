// To parse this JSON data, do
//
//     final getCustomerModel = getCustomerModelFromJson(jsonString);

import 'dart:convert';

GetCustomerModel getCustomerModelFromJson(String str) => GetCustomerModel.fromJson(json.decode(str));

String getCustomerModelToJson(GetCustomerModel data) => json.encode(data.toJson());

class GetCustomerModel {
  GetCustomerModel({
    this.customers,
  });

  List<Customer> customers;

  factory GetCustomerModel.fromJson(Map<String, dynamic> json) => GetCustomerModel(
    customers: List<Customer>.from(json["customers"].map((x) => Customer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
  };
}

class Customer {
  Customer({
    this.cid,
    this.name,
    this.date,
    this.phone,
    this.ref,
    this.location,
    this.address,
    this.machine,
    this.parts,
    this.price,
    this.handcash,
    this.customerPhotoUrl,
    this.machinePhotoUrl,
    this.custid,
  });

  String cid;
  String name;
  String date;
  String phone;
  String ref;
  String location;
  String address;
  String machine;
  String parts;
  String price;
  String handcash;
  String customerPhotoUrl;
  String machinePhotoUrl;
  String custid;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    cid: json["cid"],
    name: json["name"],
    date: json["date"],
    phone: json["phone"],
    ref: json["ref"],
    location: json["location"],
    address: json["address"],
    machine: json["machine"],
    parts: json["parts"],
    price: json["price"],
    handcash: json["handcash"],
    customerPhotoUrl: json["customerPhotoURL"],
    machinePhotoUrl: json["machinePhotoURL"],
    custid: json["custid"],
  );

  Map<String, dynamic> toJson() => {
    "cid": cid,
    "name": name,
    "date": date,
    "phone": phone,
    "ref": ref,
    "location": location,
    "address": address,
    "machine": machine,
    "parts": parts,
    "price": price,
    "handcash": handcash,
    "customerPhotoURL": customerPhotoUrl,
    "machinePhotoURL": machinePhotoUrl,
    "custid": custid,
  };
}
