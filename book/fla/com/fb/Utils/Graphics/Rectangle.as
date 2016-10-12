
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.Graphics.Rectangle
    {
        function Rectangle () {
        }
        static function drawSolid(mc, x, y, w, h, c, a) {
            mc.clear();
            mc.moveTo(x, y);
            mc.beginFill(c, a);
            mc.lineTo(x + w, y);
            mc.lineTo(x + w, y + h);
            mc.lineTo(x, y + h);
            mc.lineTo(x, y);
            mc.endFill();
        }
        static function drawGradient(mc, x, y, w, h, colors, alphas, ratios, angle, clear) {
            if (clear) {
                mc.clear();
            }
            mc.moveTo(x, y);
            mc.beginGradientFill("linear", colors, alphas, ratios, {matrixType:"box", x:x, y:y, w:w, h:h, r:(angle / 180) * Math.PI});
            mc.lineTo(x + w, y);
            mc.lineTo(x + w, y + h);
            mc.lineTo(x, y + h);
            mc.lineTo(x, y);
            mc.endFill();
        }
    }
