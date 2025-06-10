String mapToString(Map<String, dynamic> errorMap) {
  if (errorMap.isEmpty) return "No errors found.";

  // Extract all messages from all fields
  final allMessages =
      errorMap.values.expand((value) {
        if (value is List) return value;
        return [value];
      }).toList();

  if (allMessages.isEmpty) return "An unknown error occurred.";

  return allMessages.join(", ");
}
