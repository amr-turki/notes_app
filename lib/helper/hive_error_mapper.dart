String mapHiveExceptionToMessage(dynamic error) {
  final errorString = error.toString().toLowerCase();

  if (errorString.contains('box not open') || errorString.contains('closed')) {
    return 'Unable to access notes. The local database is not open.';
  } else if (errorString.contains('hive') || errorString.contains('database')) {
    return 'A database error occurred while accessing your notes.';
  } else if (error is FormatException || errorString.contains('type cast')) {
    return 'Corrupted data format detected in saved notes.';
  } else {
    return 'An unexpected error occurred. Please try again later.';
  }
}
