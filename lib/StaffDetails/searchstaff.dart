import 'package:admin/StaffDetails/staffDetail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter/material.dart';
import 'package:admin/database/staffdatabase.dart';
import 'package:admin/services/usermanagment.dart';
import 'package:admin/database/user.dart';
import 'package:admin/UserDetail/userDetail.dart';

class StaffSearch extends StatefulWidget {
  final String search;
  StaffSearch({Key key, @required this.search}) : super(key: key);
  @override
  _StaffSearchState createState() => _StaffSearchState(search:search);
}

class _StaffSearchState extends State<StaffSearch> {

  final String search;
  _StaffSearchState({Key key, @required this.search}) ;
  final DatabaseService databaseService = DatabaseService();
  final DatabaseServiceUser databaseServiceUser = DatabaseServiceUser();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [const Color(0xFF185a9d), const Color(0xFF43cea2)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            UserManagment().authorizedAccess(context);
                          },
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                              autofocus: false,
                              style: Theme.of(context)
                                  .textTheme
                                  .display1
                                  .copyWith(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: "search by email",
                                labelStyle: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(color: Colors.white),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                focusColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1.5)),
                              )),
                          suggestionsCallback: (pattern) async {
                            return(search==null)? await databaseService
                                .getSuggestions(pattern):await databaseServiceUser.getSuggestions(pattern);
                          },
                          itemBuilder: (context, suggestion) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(
                                    suggestion['email'],
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                   subtitle: Text(suggestion['fullname']),
                                ),
                                Divider(
                                  color: Colors.grey,
                                )
                              ],
                            );

                          },
                          onSuggestionSelected: (suggestion) {
                            (search==null)?  Navigator.of(context).push(MaterialPageRoute(
                                 builder: (context) => StaffDetail(staffuid:suggestion['uid'])
                             )):Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserDetail(useruid:suggestion['uid'])));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5),
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://www.freeiconspng.com/uploads/user-search-find-icon-33.png",
                          ))),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
