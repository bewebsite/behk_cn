
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.robertpenner.easing.Quad
    {
        function Quad () {
        }
        static function easeIn(t, b, c, d) {
            t = t / d;
            return(((c * t) * t) + b);
        }
        static function easeOut(t, b, c, d) {
            t = t / d;
            return((((-c) * t) * (t - 2)) + b);
        }
        static function easeInOut(t, b, c, d) {
            t = t / (d / 2);
            if (t < 1) {
                return((((c / 2) * t) * t) + b);
            }
            t--;
            return((((-c) / 2) * ((t * (t - 2)) - 1)) + b);
        }
    }
