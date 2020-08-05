import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName( String searchField ) {
    return Firestore.instance
        .collection('Catergory')
        .where('catergorysearchkey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

}


class SearchServiceSub {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('SubCatergory')
        .where('subcatergorysearchkey',
        isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
