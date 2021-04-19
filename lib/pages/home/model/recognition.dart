class Recognition {
  String? label;
  double? confidence;
  int? index;

  Recognition({this.label, this.confidence, this.index});

  factory Recognition.fromJson(Map<String, dynamic> json) {
    return Recognition(
        label: json['label'] ?? 'Error',
        confidence: json['confidence'] ?? 0.1,
        index: json['index'] ?? 12);
  }
}
