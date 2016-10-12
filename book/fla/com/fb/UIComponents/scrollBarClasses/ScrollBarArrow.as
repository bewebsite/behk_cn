
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.UIComponents.scrollBarClasses.ScrollBarArrow
    {
        var _arrowColorOut, _arrowColorOver, _direction, _clip, _overClip, _outClip, _buttonClip;
        function ScrollBarArrow (clip, direction, arrowColorOut, arrowColorOver) {
            _arrowColorOut = arrowColorOut;
            _arrowColorOver = arrowColorOver;
            _direction = direction;
            _clip = clip;
            _overClip = _clip.createEmptyMovieClip("overClip", 0);
            drawOverClip(_overClip);
            _outClip = _clip.createEmptyMovieClip("outClip", 1);
            drawOutClip(_outClip);
            _buttonClip = _clip.createEmptyMovieClip("button", 3);
            com.fb.Utils.Graphics.Rectangle.drawSolid(_buttonClip, 0, 0, 16, 16, 0, 0);
            _buttonClip.onRollOver = mx.utils.Delegate.create(this, onRollOver);
            _buttonClip.onRollOut = mx.utils.Delegate.create(this, onRollOut);
            _buttonClip.onPress = mx.utils.Delegate.create(this, onPress);
            _buttonClip.onRelease = mx.utils.Delegate.create(this, onRelease);
            _buttonClip.onReleaseOutside = mx.utils.Delegate.create(this, onReleaseOutside);
            _overClip._visible = false;
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function drawOutClip(clip) {
            var _local7 = clip.createEmptyMovieClip("bg", 0);
            com.fb.Utils.Graphics.Rectangle.drawSolid(_local7, 0, 0, 16, 16, _arrowColorOut, 100);
            var _local3 = clip.createEmptyMovieClip("arrow", 1);
            var _local4 = clip.createEmptyMovieClip("shadow", 4);
            switch (_direction) {
                case "right" : 
                    com.fb.Utils.Graphics.Triangle.drawPixelated(_local3, 7, 5, 4, 0, 43);
                    com.fb.Utils.Graphics.Rectangle.drawGradient(_local4, 0, 0, 6, 17, [0, 0], [33, 1], [0, 150], 0, true);
                    _local4._xscale = -100;
                    break;
                case "left" : 
                    com.fb.Utils.Graphics.Triangle.drawPixelated(_local3, 9, 5, 4, 0, 43);
                    _local3._xscale = -100;
                    com.fb.Utils.Graphics.Rectangle.drawGradient(_local4, 16, 0, 5, 17, [0, 0], [25, 1], [0, 150], 0, true);
                    break;
            }
            var _local6 = clip.createEmptyMovieClip("gradient", 2);
            com.fb.Utils.Graphics.Rectangle.drawGradient(_local6, 0, 0, 16, 8, [16777215, 16777215], [68, 40], [0, 255], 90, true);
            var _local5 = clip.createEmptyMovieClip("frame", 3);
            com.fb.Utils.Graphics.Line.drawSolid(_local5, 0, 0, 16, 1, 16777215, 65, true);
            com.fb.Utils.Graphics.Line.drawSolid(_local5, 0, 1, 1, 16, 16777215, 65, false);
        }
        function drawOverClip(clip) {
            var _local7 = clip.createEmptyMovieClip("bg", 0);
            com.fb.Utils.Graphics.Rectangle.drawSolid(_local7, 0, 0, 16, 16, _arrowColorOver, 100);
            var _local3 = clip.createEmptyMovieClip("arrow", 1);
            var _local4 = clip.createEmptyMovieClip("shadow", 4);
            switch (_direction) {
                case "right" : 
                    com.fb.Utils.Graphics.Triangle.drawPixelated(_local3, 7, 5, 4, 0, 80);
                    com.fb.Utils.Graphics.Rectangle.drawGradient(_local4, 0, 0, 6, 17, [0, 0], [33, 1], [0, 150], 0, true);
                    _local4._xscale = -100;
                    break;
                case "left" : 
                    com.fb.Utils.Graphics.Triangle.drawPixelated(_local3, 9, 5, 4, 0, 80);
                    _local3._xscale = -100;
                    com.fb.Utils.Graphics.Rectangle.drawGradient(_local4, 16, 0, 5, 17, [0, 0], [25, 1], [0, 150], 0, true);
                    break;
            }
            var _local6 = clip.createEmptyMovieClip("gradient", 2);
            com.fb.Utils.Graphics.Rectangle.drawGradient(_local6, 0, 0, 16, 8, [16777215, 16777215], [68, 40], [0, 255], 90, true);
            var _local5 = clip.createEmptyMovieClip("frame", 3);
            com.fb.Utils.Graphics.Line.drawSolid(_local5, 0, 0, 16, 1, 16777215, 65, true);
            com.fb.Utils.Graphics.Line.drawSolid(_local5, 0, 1, 1, 16, 16777215, 65, false);
        }
        function onRollOver() {
            _overClip._visible = true;
            _outClip._visible = false;
        }
        function onRollOut() {
            _overClip._visible = false;
            _outClip._visible = true;
        }
        function onPress() {
            dispatchEvent({type:"press", target:this});
        }
        function onRelease() {
            dispatchEvent({type:"release", target:this});
        }
        function onReleaseOutside() {
            dispatchEvent({type:"release", target:this});
        }
    }
