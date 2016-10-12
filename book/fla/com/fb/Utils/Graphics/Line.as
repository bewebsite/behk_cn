
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.Graphics.Line
    {
        function Line () {
        }
        static function drawSolid(mc, x1, y1, x2, y2, c, a, clear) {
            if (clear) {
                mc.clear();
            }
            mc.moveTo(x1, y1);
            mc.beginFill(c, a);
            mc.lineTo(x2, y1);
            mc.lineTo(x2, y2);
            mc.lineTo(x1, y2);
            mc.lineTo(x1, y1);
            mc.endFill();
        }
    }
