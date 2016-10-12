
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.UIComponents.scrollBarClasses.ScrollBarHandle
    {
        var _clip, _handleColorOut, _handleColorOver, _outClip, _overClip, _buttonClip;
        function ScrollBarHandle (clip, handleColorOut, handleColorOver) {
            _clip = clip;
            _handleColorOut = handleColorOut;
            _handleColorOver = handleColorOver;
            _createChildren();
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function startDrag(lockCenter, x1, y1, x2, y2) {
            _clip.startDrag(lockCenter, x1, y1, x2, y2);
        }
        function stopDrag() {
            _clip.stopDrag();
        }
        function get width() {
            return(_width);
        }
        function set width(width) {
            _width = width;
            _createChildren();
            //return(this.width);
        }
        function _createChildren() {
            _outClip = _clip.createEmptyMovieClip("out", 0);
            _drawOutClip();
            _overClip = _clip.createEmptyMovieClip("over", 1);
            _drawOverClip();
            _overClip._visible = false;
            _buttonClip = _clip.createEmptyMovieClip("button", 2);
            com.fb.Utils.Graphics.Rectangle.drawSolid(_buttonClip, 0, 0, _width, _height, 0, 0);
            _buttonClip.onRollOver = mx.utils.Delegate.create(this, onRollOver);
            _buttonClip.onRollOut = mx.utils.Delegate.create(this, onRollOut);
            _buttonClip.onRelease = mx.utils.Delegate.create(this, onRelease);
            _buttonClip.onReleaseOutside = mx.utils.Delegate.create(this, onReleaseOutside);
            _buttonClip.onPress = mx.utils.Delegate.create(this, onPress);
        }
        function _drawOutClip() {
            var _local5 = _outClip.createEmptyMovieClip("bg", 0);
            com.fb.Utils.Graphics.Rectangle.drawSolid(_local5, 0, 0, _width, _height, _handleColorOut, 100);
            var _local4 = _outClip.createEmptyMovieClip("gradient", 1);
            com.fb.Utils.Graphics.Rectangle.drawGradient(_local4, 0, 0, _width, _height / 2, [16777215, 16777215], [68, 40], [0, 255], 90, true);
            var _local2 = _outClip.createEmptyMovieClip("frame", 2);
            com.fb.Utils.Graphics.Line.drawSolid(_local2, 0, 0, _width, 1, 16777215, 65, true);
            com.fb.Utils.Graphics.Line.drawSolid(_local2, 0, 1, 1, _height, 16777215, 65, false);
            var _local3 = _outClip.createEmptyMovieClip("leftShadow", 3);
            com.fb.Utils.Graphics.Rectangle.drawGradient(_local3, 0, 0, 6, _height, [0, 0], [33, 1], [0, 200], 0, true);
            _local3._xscale = -100;
            var _local6 = _outClip.createEmptyMovieClip("rightShadow", 4);
            com.fb.Utils.Graphics.Rectangle.drawGradient(_local6, _width, 0, 6, _height, [0, 0], [33, 1], [0, 200], 0, true);
            var _local7 = _outClip.createEmptyMovieClip("notch", 5);
            _makeNotch(_local7);
        }
        function _drawOverClip() {
            var _local5 = _overClip.createEmptyMovieClip("bg", 0);
            com.fb.Utils.Graphics.Rectangle.drawSolid(_local5, 0, 0, _width, _height, _handleColorOver, 100);
            var _local4 = _overClip.createEmptyMovieClip("gradient", 1);
            com.fb.Utils.Graphics.Rectangle.drawGradient(_local4, 0, 0, _width, _height / 2, [16777215, 16777215], [68, 40], [0, 255], 90, true);
            var _local2 = _overClip.createEmptyMovieClip("frame", 2);
            com.fb.Utils.Graphics.Line.drawSolid(_local2, 0, 0, _width, 1, 16777215, 65, true);
            com.fb.Utils.Graphics.Line.drawSolid(_local2, 0, 1, 1, _height, 16777215, 65, false);
            var _local3 = _overClip.createEmptyMovieClip("leftShadow", 3);
            com.fb.Utils.Graphics.Rectangle.drawGradient(_local3, 0, 0, 6, _height, [0, 0], [33, 1], [0, 200], 0, true);
            _local3._xscale = -100;
            var _local6 = _overClip.createEmptyMovieClip("rightShadow", 4);
            com.fb.Utils.Graphics.Rectangle.drawGradient(_local6, _width, 0, 6, _height, [0, 0], [33, 1], [0, 200], 0, true);
            var _local7 = _overClip.createEmptyMovieClip("notch", 5);
            _makeNotch(_local7);
        }
        function _makeNotch(clip) {
            var _local4 = 8;
            if (_width <= 5) {
                _local4 = 0;
            } else if (_width <= 10) {
                _local4 = 2;
            } else if (_width <= 20) {
                _local4 = 3;
            }
            var _local2 = 0;
            while (_local2 < _local4) {
                var _local3 = _local2 == 0;
                _oneNotch(clip, _local2 * 2, _local3);
                _local2++;
            }
            clip._x = Math.round((_width / 2) - (clip._width / 2));
            clip._y = Math.round((_height / 2) - (clip._height / 2)) + 1;
        }
        function _oneNotch(clip, x, clear) {
            com.fb.Utils.Graphics.Line.drawSolid(clip, x, 0, x + 1, 7, 16777215, 44, clear);
            com.fb.Utils.Graphics.Line.drawSolid(clip, x + 1, 0, x + 2, 7, 0, 44, false);
        }
        function onRollOver() {
            _overClip._visible = true;
            _outClip._visible = false;
        }
        function onRollOut() {
            _overClip._visible = false;
            _outClip._visible = true;
        }
        function onRelease() {
            dispatchEvent({type:"handleRelease", target:this});
        }
        function onReleaseOutside() {
            dispatchEvent({type:"handleRelease", target:this});
            _overClip._visible = false;
            _outClip._visible = true;
        }
        function onPress() {
            dispatchEvent({type:"handlePress", target:this});
        }
        var _width = 100;
        var _height = 16;
    }
