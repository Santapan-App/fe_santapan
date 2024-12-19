class AddressModel {
  bool? status;
  String? message;
  List<AddressData>? data; // Directly handle data as a list

  AddressModel({this.status, this.message, this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    status = json['success']; // Align with "success" in the JSON
    message = json['message'];
    if (json['data'] != null) {
      data = <AddressData>[];
      json['data'].forEach((v) {
        data!.add(AddressData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressData {
  int? id;
  String? label;
  String? address;
  String? name;
  String? phone;
  String? notes;

  AddressData({this.id, this.label, this.address, this.name, this.phone, this.notes});

  AddressData.fromJson(Map<String, dynamic> json) {
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
