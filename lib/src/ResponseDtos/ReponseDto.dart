class ReponseDto {
  final dynamic? status;
  final dynamic? data;
  final String? message;

  ReponseDto({required this.status, required this.data, required this.message});

  factory ReponseDto.fromJson(Map<String, dynamic> json) {
    // Check if 'data' is a List or some other type
    dynamic parsedData = json['data'];
    if (parsedData is List) {
      // If 'data' is a List, process it as a List
      parsedData = parsedData.map((e) => Data.fromJson(e)).toList();
    } else {
      // Otherwise, just pass the data as it is
      parsedData = Data.fromJson({'data': parsedData});
    }

    return ReponseDto(
      status: json['status'],
      data: parsedData,  // It could be a List of Data or a single Data object
      message: json['message'],
    );
  }
}

class Data {
  final dynamic data;

  Data({required this.data});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      data: json['data'],
    );
  }
}
