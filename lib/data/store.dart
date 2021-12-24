import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

class MyStore extends VxStore {
  String myAccountAddress = "";
  late Map<String, dynamic> data = {};
  MyStore(String myAddress) {
    myAccountAddress = myAddress;
  }
}

class UpdateMyStore extends VxMutation<MyStore> {
  late Map<String, dynamic> myData;
  UpdateMyStore(this.myData);
  @override
  perform() => store?.data = myData;
}
