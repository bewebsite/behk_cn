
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.Icon
    {
        var _iconSymbolId, _clip, _iconClip;
        function Icon (iconSymbolId, parentClip) {
            _iconSymbolId = iconSymbolId;
            _clip = parentClip;
            _create();
        }
        function get x() {
            return(_clip._x);
        }
        function set x(newX) {
            _clip._x = newX;
            //return(x);
        }
        function get y() {
            return(_clip._y);
        }
        function set y(newY) {
            _clip._y = newY;
            //return(y);
        }
        function get width() {
            return(_width);
        }
        function set width(newWidth) {
            _width = newWidth;
            _positionObjects();
            //return(width);
        }
        function get height() {
            return(_height);
        }
        function set height(newHeight) {
            _height = newHeight;
            _positionObjects();
            //return(height);
        }
        function setSize(newWidth, newHeight) {
            _width = newWidth;
            _height = newHeight;
            _positionObjects();
        }
        function _create() {
            _createIcon();
        }
        function _createIcon() {
            _iconClip = _clip.attachMovie(_iconSymbolId, "icon", _clip.getNextHighestDepth());
            _width = _iconClip._width;
            _height = _iconClip._height;
            _iconClip._x = Math.round((_width / 2) - (_iconClip._width / 2));
            _iconClip._y = Math.round((_height / 2) - (_iconClip._height / 2));
        }
        function _positionObjects() {
            _iconClip._x = Math.round((_width / 2) - (_iconClip._width / 2));
            _iconClip._y = Math.round((_height / 2) - (_iconClip._height / 2));
        }
        var _width = 16;
        var _height = 16;
    }
