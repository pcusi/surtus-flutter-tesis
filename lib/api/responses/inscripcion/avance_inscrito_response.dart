class AvanceInscritoResponse {
  int avance;

  AvanceInscritoResponse({this.avance});

  factory AvanceInscritoResponse.fromJson(Map<String, dynamic> json) {
    return AvanceInscritoResponse(
      avance: json['avance']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "avance": this.avance
    };
  }

}