***REMOVED***
***REMOVED***

class AddNewRecording extends StatefulWidget {
***REMOVED***
  _AddNewRecordingState createState() => _AddNewRecordingState();
***REMOVED***

class _AddNewRecordingState extends State<AddNewRecording> {
  String dropdownValue = 'LiveStream';
***REMOVED***
***REMOVED***
***REMOVED***
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.black87])),
        child: Column(
          children: [
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
  ***REMOVED***
  ***REMOVED***width: 10),
                IconButton(
                  onPressed: () {***REMOVED***,
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
    ***REMOVED***
  ***REMOVED***,
  ***REMOVED***width: 20),
                Text(
                    "Add a new session",
***REMOVED***
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontSize: 32
    ***REMOVED***,
  ***REMOVED***,

  ***REMOVED***
***REMOVED***
            SizedBox(height: 20),
            Container(
  ***REMOVED***
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.grey[700],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2.0,
                    spreadRadius: 10.0,
                    offset: Offset(2.0, 2.0), // shadow direction: bottom right
    ***REMOVED***
***REMOVED***
***REMOVED***,
              height: 500,
              width: 300,
    ***REMOVED***
    ***REMOVED***
    ***REMOVED***
                    mainAxisAlignment: MainAxisAlignment.center,
        ***REMOVED***
***REMOVED***"Session Type:",
  ***REMOVED***
***REMOVED***
                        fontStyle: FontStyle.italic
        ***REMOVED***,),
***REMOVED***width: 20),
                      DropdownButton<String>(
                        dropdownColor: Colors.grey,
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward,
                        color: Colors.black,),
                        iconSize: 24,
                        elevation: 16,
    ***REMOVED***color: Colors.black),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
          ***REMOVED***,
                        onChanged: (String newValue) {
                    ***REMOVED***
                            dropdownValue = newValue;
                          ***REMOVED***);
                        ***REMOVED***,
                        items: <String>['LiveStream', 'Video Recording']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
        ***REMOVED***value),
                      ***REMOVED***
                        ***REMOVED***).toList(),
        ***REMOVED***,
    ***REMOVED***
    ***REMOVED***,
***REMOVED***
***REMOVED***,
***REMOVED***
            SizedBox(height: 40),
            SizedBox(
              height: 60,
              width: 120,
              child: FloatingActionButton(
                elevation: 20,
                child: Container(
                  child: Text("Submit",
***REMOVED***
                    fontSize: 18
    ***REMOVED***,),
  ***REMOVED***,
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
  ***REMOVED***,
                onPressed: () {***REMOVED***,
***REMOVED***,
            )
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***
