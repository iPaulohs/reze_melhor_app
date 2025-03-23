import 'package:ulid/ulid.dart';

class CreateDocVm {
  CreateDocVm({
    required this.docContent,
    this.collection,
    String? docId,
  }) : docId = docId ?? Ulid().toString();

  final dynamic docContent;
  final String? collection;
   final String docId;
}
