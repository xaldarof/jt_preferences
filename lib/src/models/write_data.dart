class WriteData {
  final Map<String, dynamic> map;
  final String updatedKey;

  const WriteData({
    required this.map,
    required this.updatedKey,
  });

  @override
  String toString() {
    return 'WriteData{map: $map, updatedKey: $updatedKey}';
  }
}
