
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.timwalling.TweenDelay extends mx.transitions.Tween
    {
        var _intervalDelayID, _delay;
        function TweenDelay (obj, prop, func, begin, finish, duration, delay, useSeconds) {
            super(obj, prop, func, begin, finish, duration, useSeconds);
            this.delay = (delay);
            delayStart();
        }
        function start() {
        }
        function delayStart() {
            if (delay > 0) {
                _intervalDelayID = setInterval(this, "continueStart", delay);
            } else {
                continueStart();
            }
        }
        function continueStart() {
            clearInterval(_intervalDelayID);
            super.start();
        }
        function set delay(d) {
            _delay = (((d == null) || (d <= 0)) ? 0 : (d * 1000));
            //return(delay);
        }
        function get delay() {
            return(_delay);
        }
    }
