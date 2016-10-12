
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.HintWindow
    {
        var _clip, _iconLinkageId, _book, _text, _background, _icon, _textField;
        function HintWindow (parentClip, iconLinkageId, bookInstance) {
            _clip = parentClip;
            _iconLinkageId = iconLinkageId;
            _book = bookInstance;
            _create();
            _subscribeToStageEvents();
            _subscribeToClipEvents();
            _clip._visible = false;
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
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
        function get text() {
            return(_text);
        }
        function set text(newText) {
            _text = newText;
            _updateText();
            //return(text);
        }
        function closeWindow() {
            _clip._visible = false;
        }
        function showWindow() {
            x = (_root._xmouse);
            y = (_root._ymouse);
            _clip._visible = true;
            _positionObjects();
        }
        function _subscribeToStageEvents() {
            Stage.addListener(this);
            this.onResize();
        }
        function _subscribeToClipEvents() {
            _clip.onEnterFrame = mx.utils.Delegate.create(this, onEnterFrame);
        }
        function onResize() {
            _positionObjects();
        }
        function onEnterFrame() {
            if (_clip._visible) {
                var _local4 = _root._xmouse;
                var _local3 = _root._ymouse;
                var _local6 = ((_local4 - x) / 2) - 10;
                var _local5 = ((_local3 - y) / 2) + 10;
                if ((_local4 - _local6) > 1) {
                    x = (Math.round(_local4 - _local6));
                }
                if ((_local3 - _local5) > 1) {
                    y = (Math.round(_local3 - _local5));
                }
            }
        }
        function _create() {
            _createBackground();
            _createIcon();
            _createTextField();
        }
        function _createBackground() {
            var _local2 = _clip.createEmptyMovieClip("background", _clip.getNextHighestDepth());
            _background = new com.fb.graphics.StyleableRectangle(_local2, 0, 0, _width, _height);
            _background.__set__fill(80);
            _background.__set__strokeColor(0);
            _background.__set__strokePosition("outer");
            _background.__set__strokeSize(2);
            _background.__set__cornerRadius(4);
        }
        function _createIcon() {
            var _local2 = _clip.createEmptyMovieClip("icon", _clip.getNextHighestDepth());
            _icon = new com.fb.Utils.Icon(_iconLinkageId, _local2);
        }
        function _createTextField() {
            var _local2 = _clip.createEmptyMovieClip("title", _clip.getNextHighestDepth());
            _textField = new com.fb.graphics.StyleableLabel(_local2, 0, 0, _width, _height);
            _textField.__set__fontName("Arial");
            _textField.__set__fontSize(12);
            _textField.__set__autoSize(false);
            _textField.__set__text("");
            _textField.__set__color(16777215);
            _textField.__set__bold(true);
            _textField.__set__width(85);
            _textField.__set__multiline(true);
            _textField.__set__wordWrap(true);
            _textField.__set__x(50);
            _textField.__set__y(12);
        }
        function _positionObjects() {
            _height = _textField.__get__height() + 23;
            _background.setSize(_width, _height);
            _icon.__set__x(12);
            _icon.__set__y(10);
            _textField.__set__y(10);
        }
        function _updateText() {
            _textField.__set__text(_text);
            _textField.__set__height(_textField.__get__textHeight() + 4);
        }
        var _x = 0;
        var _y = 0;
        var _width = 150;
        var _height = 50;
    }
