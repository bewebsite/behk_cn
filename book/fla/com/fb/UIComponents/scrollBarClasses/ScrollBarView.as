
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.UIComponents.scrollBarClasses.ScrollBarView
    {
        var _clip, _horizontal, __get__width, _handle, __get__handleWidth, __get__handlePosition, _backArrowClip, _stripColor1, _stripColor2, _arrowColorOut, _arrowColorOver, _handleColorOut, _handleColorOver, _stripButtonClip, _stripClip, _frontArrowClip, _frontArrow, _backArrow, _handleClip, _arrowInterval;
        function ScrollBarView (clip, horizontal) {
            _clip = clip;
            _horizontal = horizontal;
            if (!_horizontal) {
                _clip._rotation = 90;
                _clip._yscale = -100;
            }
            _getColors();
            _createChildren();
            _positionElements();
            _clip.onMouseMove = mx.utils.Delegate.create(this, onMouseMove);
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function get height() {
            if (_horizontal) {
                return(_clip._height);
            } else {
                return(_clip._width);
            }
        }
        function get mainColor() {
            return(_mainColor);
        }
        function set mainColor(color) {
            _mainColor = color;
            _getColors();
            _createChildren();
            _positionElements();
            //return(mainColor);
        }
        function get buttonStep() {
            return(_buttonStep);
        }
        function set buttonStep(step) {
            _buttonStep = step;
            //return(buttonStep);
        }
        function set width(width) {
            _barLength = Math.round(width);
            _createChildren();
            //return(__get__width());
        }
        function set handleWidth(width) {
            _handle.__set__width(Math.round(width));
            //return(__get__handleWidth());
        }
        function set handlePosition(position) {
            _handlePosition = position;
            if (_handlePosition > 100) {
                _handlePosition = 100;
            } else if (_handlePosition < 0) {
                _handlePosition = 0;
            }
            _positionElements();
            //return(__get__handlePosition());
        }
        function get realWidth() {
            return(_barLength - (2 * _backArrowClip));
        }
        function _getColors() {
            _stripColor1 = com.fb.Utils.Graphics.ColorFunctions.changeBrightness(_mainColor, -20);
            _stripColor2 = _mainColor;
            _arrowColorOut = com.fb.Utils.Graphics.ColorFunctions.changeBrightness(_mainColor, 14);
            _arrowColorOut = com.fb.Utils.Graphics.ColorFunctions.changeSaturation(_arrowColorOut, -5);
            _arrowColorOver = com.fb.Utils.Graphics.ColorFunctions.changeBrightness(_arrowColorOut, 7);
            _arrowColorOver = com.fb.Utils.Graphics.ColorFunctions.changeSaturation(_arrowColorOver, -4);
            _handleColorOut = com.fb.Utils.Graphics.ColorFunctions.changeBrightness(_mainColor, 14);
            _handleColorOut = com.fb.Utils.Graphics.ColorFunctions.changeSaturation(_handleColorOut, -5);
            _handleColorOver = com.fb.Utils.Graphics.ColorFunctions.changeBrightness(_mainColor, 26);
            _handleColorOver = com.fb.Utils.Graphics.ColorFunctions.changeSaturation(_handleColorOver, -12);
            _handleColorOver = com.fb.Utils.Graphics.ColorFunctions.changeHue(_handleColorOver, -6);
        }
        function _createChildren() {
            _stripButtonClip = _clip.createEmptyMovieClip("strip", 0);
            _stripButtonClip.onPress = mx.utils.Delegate.create(this, onStripPress);
            _stripButtonClip.useHandCursor = false;
            _stripClip = _clip.createEmptyMovieClip("strip", 1);
            _drawStrip();
            _frontArrowClip = _clip.createEmptyMovieClip("frontArrow", 3);
            _frontArrow = new com.fb.UIComponents.scrollBarClasses.ScrollBarArrow(_frontArrowClip, "right", _arrowColorOut, _arrowColorOver);
            _frontArrow.addEventListener("press", this);
            _frontArrow.addEventListener("release", this);
            _backArrowClip = _clip.createEmptyMovieClip("backArrow", 4);
            _backArrow = new com.fb.UIComponents.scrollBarClasses.ScrollBarArrow(_backArrowClip, "left", _arrowColorOut, _arrowColorOver);
            _backArrow.addEventListener("press", this);
            _backArrow.addEventListener("release", this);
            _handleClip = _clip.createEmptyMovieClip("handle", 2);
            _handle = new com.fb.UIComponents.scrollBarClasses.ScrollBarHandle(_handleClip, _handleColorOut, _handleColorOver);
            _handle.addEventListener("handlePress", this);
            _handle.addEventListener("handleRelease", this);
            _positionElements();
        }
        function _positionElements() {
            _frontArrowClip._x = (_barLength - _frontArrowClip._width) + 5;
            _frontArrowClip._y = 1;
            _backArrowClip._x = 1;
            _backArrowClip._y = 1;
            _handleClip._y = 1;
            var _local4 = (_backArrowClip._x + _backArrowClip._width) - 4;
            var _local3 = _frontArrowClip._width - 16;
            var _local2 = _local4 + (_handleClip._width / 2);
            var _local5 = (_barLength - _local3) - (_handleClip._width / 2);
            _handleClip._x = Math.round((_local2 + ((_handlePosition * (_local5 - _local2)) / 100)) - (_handleClip._width / 2));
        }
        function _drawStrip() {
            com.fb.Utils.Graphics.Rectangle.drawGradient(_stripClip, 0, 0, _barLength, _barHeight, [_stripColor1, _stripColor2], [100, 100], [0, 200], 90, true);
            com.fb.Utils.Graphics.Rectangle.drawSolid(_stripButtonClip, 0, 0, _barLength, _barHeight, 0, 100);
        }
        function press(evt) {
            var _local2 = evt.target == _backArrow;
            emulateButtonPress(_local2);
            _arrowInterval = setInterval(this, "startArrowEmulation", 300, _local2);
        }
        function startArrowEmulation(backButton) {
            clearInterval(_arrowInterval);
            _arrowInterval = setInterval(this, "emulateButtonPress", 100, backButton);
        }
        function release(evt) {
            clearInterval(_arrowInterval);
        }
        function emulateButtonPress(backButton) {
            if (backButton) {
                _handleClip._x = _handleClip._x - _buttonStep;
                if (_handleClip._x < 18) {
                    _handleClip._x = 18;
                }
            } else {
                _handleClip._x = _handleClip._x + _buttonStep;
                if (_handleClip._x > ((_barLength - _handle.__get__width()) - 18)) {
                    _handleClip._x = (_barLength - _handle.__get__width()) - 18;
                }
            }
            _recalculateHandlePosition();
        }
        function handlePress(evt) {
            _handle.startDrag(false, _backArrowClip._width - 3, 1, ((_barLength - _backArrowClip._width) - _handleClip._width) + 15, 1);
            _dragging = true;
        }
        function handleRelease(evt) {
            _handle.stopDrag();
            _dragging = false;
        }
        function onMouseMove() {
            if (_dragging) {
                _recalculateHandlePosition();
            }
        }
        function _recalculateHandlePosition() {
            _handlePosition = Math.round((100 * (_handleClip._x - 18)) / ((_barLength - _handle.__get__width()) - 36));
            dispatchEvent({type:"onChange", normedPosition:_handlePosition});
        }
        function onStripPress() {
            var _local2 = _clip._xmouse;
            _handleClip._x = _local2 - Math.round(_handleClip._width / 2);
            if (_handleClip._x < 18) {
                _handleClip._x = 18;
            } else if (_handleClip._x > ((_barLength - _handle.__get__width()) - 18)) {
                _handleClip._x = (_barLength - _handle.__get__width()) - 18;
            }
            _recalculateHandlePosition();
        }
        var _barLength = 200;
        var _barHeight = 18;
        var _mainColor = 9412262;
        var _handlePosition = 0;
        var _dragging = false;
        var _buttonStep = 10;
    }
