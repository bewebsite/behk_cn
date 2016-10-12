
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.Graphics.Triangle
    {
        function Triangle () {
        }
        static function drawPixelated(mc, x, y, length, c, a) {
            mc.clear();
            mc._x = x;
            mc._y = y;
            var _local1 = 0;
            while (_local1 < length) {
                var _local3 = ((length - _local1) * 2) - 1;
                mc.beginFill(c, a);
                mc.moveTo(_local1, _local1);
                mc.lineTo(_local1 + 1, _local1);
                mc.lineTo(_local1 + 1, _local3 + _local1);
                mc.lineTo(_local1, _local3 + _local1);
                mc.lineTo(_local1, _local1);
                mc.endFill();
                _local1++;
            }
        }
    }
