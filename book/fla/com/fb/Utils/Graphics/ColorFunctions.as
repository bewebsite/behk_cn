
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.Graphics.ColorFunctions
    {
        function ColorFunctions () {
        }
        static function changeBrightness(hexRGB, brightnessChange) {
            var _local3 = 0;
            var _local2 = 100;
            var _local1 = HexRBGtoObjectHSB(hexRGB);
            _local1.b = _local1.b + brightnessChange;
            if (Number(_local1.b) > _local2) {
                _local1.b = (2 * _local2) - Number(_local1.b);
            } else if (Number(_local1.h) < _local3) {
                _local1.b = (2 * _local3) - Number(_local1.b);
            }
            return(HSBObjecttoRGBHex(_local1));
        }
        static function changeSaturation(hexRGB, saturationChange) {
            var _local3 = 0;
            var _local2 = 100;
            var _local1 = HexRBGtoObjectHSB(hexRGB);
            _local1.s = _local1.s + saturationChange;
            if (Number(_local1.s) > _local2) {
                _local1.s = (2 * _local2) - Number(_local1.s);
            } else if (Number(_local1.h) < _local3) {
                _local1.s = (2 * _local3) - Number(_local1.s);
            }
            return(HSBObjecttoRGBHex(_local1));
        }
        static function changeHue(hexRGB, hueChange) {
            var _local3 = 0;
            var _local2 = 360;
            var _local1 = HexRBGtoObjectHSB(hexRGB);
            _local1.h = _local1.h + hueChange;
            if (Number(_local1.h) > _local2) {
                _local1.h = (2 * _local2) - Number(_local1.h);
            } else if (Number(_local1.h) < _local3) {
                _local1.h = (2 * _local3) - Number(_local1.h);
            }
            return(HSBObjecttoRGBHex(_local1));
        }
        static function HSBObjecttoRGBHex(hsbObject) {
            var _local1 = HSBObjecttoRGBObject(hsbObject);
            return(ObjectRGBtoHEXRGB(_local1));
        }
        static function HSBObjecttoRGBObject(HSBObject) {
            var _local9;
            var _local10;
            var _local8;
            var _local3 = Math.round(HSBObject.h);
            var _local6 = Math.round((HSBObject.s * 255) / 100);
            var _local5 = Math.round((HSBObject.b * 255) / 100);
            if (_local6 == 0) {
                _local8 = _local5;
                _local10 = _local8;
                _local9 = _local10;
            } else {
                var _local2 = _local5;
                var _local1 = ((255 - _local6) * _local5) / 255;
                var _local4 = ((_local2 - _local1) * (_local3 % 60)) / 60;
                if (_local3 == 360) {
                    _local3 = 0;
                }
                if (_local3 < 60) {
                    _local9 = _local2;
                    _local8 = _local1;
                    _local10 = _local1 + _local4;
                } else if (_local3 < 120) {
                    _local10 = _local2;
                    _local8 = _local1;
                    _local9 = _local2 - _local4;
                } else if (_local3 < 180) {
                    _local10 = _local2;
                    _local9 = _local1;
                    _local8 = _local1 + _local4;
                } else if (_local3 < 240) {
                    _local8 = _local2;
                    _local9 = _local1;
                    _local10 = _local2 - _local4;
                } else if (_local3 < 300) {
                    _local8 = _local2;
                    _local10 = _local1;
                    _local9 = _local1 + _local4;
                } else if (_local3 < 360) {
                    _local9 = _local2;
                    _local10 = _local1;
                    _local8 = _local2 - _local4;
                } else {
                    _local9 = 0;
                    _local10 = 0;
                    _local8 = 0;
                }
            }
            return({r:_local9, g:_local10, b:_local8});
        }
        static function HexRBGtoObjectHSB(RGBColor) {
            var _local2 = HexRGBtoObjectRGB(RGBColor);
            var _local1 = RGBObjecttoHSBObject(_local2);
            return(_local1);
        }
        static function HexRGBtoObjectRGB(hexValue) {
            var _local1 = (isNaN(hexValue) ? (parseInt(hexValue, 16)) : (hexValue));
            var _local4 = _local1 >> 16;
            var _local5 = (_local1 ^ (_local4 << 16)) >> 8;
            var _local3 = (_local1 ^ (_local4 << 16)) ^ (_local5 << 8);
            return({r:_local4, g:_local5, b:_local3});
        }
        static function ObjectRGBtoHEXRGB(RGBColor) {
            var _local3 = Number(RGBColor.r);
            var _local4 = Number(RGBColor.g);
            var _local2 = Number(RGBColor.b);
            return(((_local3 << 16) | (_local4 << 8)) | _local2);
        }
        static function RGBObjecttoHSBObject(rgb) {
            var _local3 = rgb.r;
            var _local1 = rgb.g;
            var _local2 = rgb.b;
            var _local4 = new Object();
            _local4.b = Math.max(Math.max(_local3, _local1), _local2);
            var _local6 = Math.min(Math.min(_local3, _local1), _local2);
            _local4.s = ((_local4.b <= 0) ? 0 : (Math.round((100 * (_local4.b - _local6)) / _local4.b)));
            _local4.b = Math.round((_local4.b / 255) * 100);
            _local4.h = 0;
            if ((_local3 == _local1) && (_local1 == _local2)) {
                _local4.h = 0;
            } else if ((_local3 >= _local1) && (_local1 >= _local2)) {
                _local4.h = (60 * (_local1 - _local2)) / (_local3 - _local2);
            } else if ((_local1 >= _local3) && (_local3 >= _local2)) {
                _local4.h = 60 + ((60 * (_local1 - _local3)) / (_local1 - _local2));
            } else if ((_local1 >= _local2) && (_local2 >= _local3)) {
                _local4.h = 120 + ((60 * (_local2 - _local3)) / (_local1 - _local3));
            } else if ((_local2 >= _local1) && (_local1 >= _local3)) {
                _local4.h = 180 + ((60 * (_local2 - _local1)) / (_local2 - _local3));
            } else if ((_local2 >= _local3) && (_local3 >= _local1)) {
                _local4.h = 240 + ((60 * (_local3 - _local1)) / (_local2 - _local1));
            } else if ((_local3 >= _local2) && (_local2 >= _local1)) {
                _local4.h = 300 + ((60 * (_local3 - _local2)) / (_local3 - _local1));
            } else {
                _local4.h = 0;
            }
            _local4.h = Math.round(_local4.h);
            return(_local4);
        }
    }
