import 'package:fitnessmarketplace/widgets/customsliderthumbcircle.dart';
***REMOVED***


class SliderWidget extends StatefulWidget {
  final double sliderHeight;
  final int min;
  final int max;
  final fullWidth;

  SliderWidget(
      {this.sliderHeight = 48,
        this.max = 10,
        this.min = 0,
        this.fullWidth = false***REMOVED***);

***REMOVED***
  _SliderWidgetState createState() => _SliderWidgetState();
***REMOVED***

class _SliderWidgetState extends State<SliderWidget> {
  double _value = 0;

***REMOVED***
***REMOVED***
    double paddingFactor = .2;

    if (this.widget.fullWidth) paddingFactor = .3;

    return Container(
      width: this.widget.fullWidth
          ? double.infinity
          : (this.widget.sliderHeight) * 5.5,
      height: (this.widget.sliderHeight),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(
          Radius.circular((this.widget.sliderHeight * .3)),
***REMOVED***
        color: Colors.black,
        /*gradient: new LinearGradient(
            colors: [
              const Color(0xFF00c6ff),
              const Color(0xFF0072ff),
***REMOVED***
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 1.00),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
        */
***REMOVED***
      child: Padding(
        padding: EdgeInsets.fromLTRB(this.widget.sliderHeight * paddingFactor,
            2, this.widget.sliderHeight * paddingFactor, 2),
        child: Row(
          children: <Widget>[
            Text(
              '${this.widget.min***REMOVED***',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,

***REMOVED***,
***REMOVED***
            SizedBox(
              width: this.widget.sliderHeight * .1,
***REMOVED***
            Expanded(
              child: Center(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.white.withOpacity(1),
                    inactiveTrackColor: Colors.white.withOpacity(.5),

                    trackHeight: 4.0,
                    thumbShape: CustomSliderThumbCircle(
                      thumbRadius: this.widget.sliderHeight * .4,
                      min: this.widget.min,
                      max: this.widget.max,
      ***REMOVED***,
                    overlayColor: Colors.white.withOpacity(.4),
                    //valueIndicatorColor: Colors.white,
                    activeTickMarkColor: Colors.white,
                    inactiveTickMarkColor: Colors.red.withOpacity(.7),
    ***REMOVED***,
                  child: Slider(
                      value: _value,
                      onChanged: (value) {
                  ***REMOVED***
                          _value = value;
                        ***REMOVED***);
                      ***REMOVED***),
  ***REMOVED***,
***REMOVED***,
***REMOVED***
            SizedBox(
              width: this.widget.sliderHeight * .1,
***REMOVED***
            Text(
              '${this.widget.max***REMOVED***',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: this.widget.sliderHeight * .3,
                fontWeight: FontWeight.w700,
                color: Colors.white,
***REMOVED***,
***REMOVED***
          ],
***REMOVED***
***REMOVED***
***REMOVED***
  ***REMOVED***
***REMOVED***