***REMOVED***

class SearchBar extends StatefulWidget {
***REMOVED***
  _SearchBarState createState() => _SearchBarState();
***REMOVED***

class _SearchBarState extends State<SearchBar> {
***REMOVED***
***REMOVED***
    return Padding(
      padding: EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            borderRadius: BorderRadius.all((Radius.circular(20)))
***REMOVED***
        child: TextField(
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey[300],
***REMOVED***
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(color: Colors.white,),
***REMOVED***
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white,),
              borderRadius: BorderRadius.circular(5.0),
***REMOVED***
            hintText: "E.g: Carol Stanton, yoga",
            prefixIcon: Icon(
              Icons.search,
              color: Colors.blueGrey[300],
***REMOVED***
            hintStyle: TextStyle(
              fontSize: 15.0,
              color: Colors.blueGrey[300],
***REMOVED***
***REMOVED***
          maxLines: 1,
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***