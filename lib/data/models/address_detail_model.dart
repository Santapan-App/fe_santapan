class AddressDetailModel {
  bool? status;
  String? message;
  AddressDetailData? data;

  AddressDetailModel({this.status, this.message, this.data});

  AddressDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['success'];
    message = json['message'];
    data = json['data'] != null ? AddressDetailData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddressDetailData {
  int? id;
  String? label;
  String? address;
  String? name;
  String? phone;
  String? notes;

  AddressDetailData({this.id, this.label, this.address, this.name, this.phone, this.notes});

  AddressDetailData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    address = json['address'];
    name = json['name'];
    phone = json['phone'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['address'] = address;
    data['name'] = name;
    data['phone'] = phone;
    data['notes'] = notes;
    return data;
  }
}
