
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.IconButton
    {
        var _iconSymbolId, _clip, _buttonClip, _iconClip;
        function IconButton (iconSymbolId, parentClip) {
            _iconSymbolId = iconSymbolId;
            _clip = parentClip;
            _create();
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function get visible() {
            return(_clip._visible);
        }
        function set visible(isVisible) {
            _clip._visible = isVisible;
            //return(visible);
        }
        function get freeze() {
            return(_freeze);
        }
        function set freeze(needToFreeze) {
            _freeze = needToFreeze;
            _buttonClip.enabled = !_freeze;
            //return(freeze);
        }
        function get alpha() {
            return(_clip._alpha);
        }
        function set alpha(newAlpha) {
            _clip._alpha = newAlpha;
            //return(alpha);
        }
        function alphaTo(targetAlpha, msec_duration, msec_delay) {
            new com.timwalling.TweenDelay(this, "alpha", mx.transitions.easing.Regular.easeInOut, alpha, targetAlpha, msec_duration / 1000, msec_delay / 1000, true);
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
        function get enabled() {
            return(_enabled);
        }
        function set enabled(isEnabled) {
            _enabled = isEnabled;
            _stylizeButton();
            //return(enabled);
        }
        function get useHandCursor() {
            return(_useHandCursor);
        }
        function set useHandCursor(use) {
            _useHandCursor = use;
            _stylizeButton();
            //return(useHandCursor);
        }
        function get normalFill() {
            return(_normalFill);
        }
        function set normalFill(newFill) {
            _normalFill = newFill;
            _stylizeButton();
            //return(normalFill);
        }
        function get disabledFill() {
            return(_disabledFill);
        }
        function set disabledFill(newFill) {
            _disabledFill = newFill;
            _stylizeButton();
            //return(disabledFill);
        }
        function get rollOverFill() {
            return(_rollOverFill);
        }
        function set rollOverFill(newFill) {
            _rollOverFill = newFill;
            _stylizeButton();
            //return(rollOverFill);
        }
        function _create() {
            _createButton();
            _createIcon();
            _stylizeButton();
        }
        function _createButton() {
            _buttonClip = _clip.createEmptyMovieClip("button", _clip.getNextHighestDepth());
            _buttonClip.lineStyle(0, 0, 0);
            _buttonClip.moveTo(0, 0);
            _buttonClip.beginFill(16711680, 100);
            _buttonClip.lineTo(_width, 0);
            _buttonClip.lineTo(_width, _height);
            _buttonClip.lineTo(0, _height);
            _buttonClip.lineTo(0, 0);
            _buttonClip.endFill();
            _buttonClip._alpha = 0;
            _buttonClip.onRollOver = mx.utils.Delegate.create(this, onRollOver);
            _buttonClip.onRollOut = mx.utils.Delegate.create(this, onRollOut);
            _buttonClip.onPress = mx.utils.Delegate.create(this, onPress);
            _buttonClip.onRelease = mx.utils.Delegate.create(this, onRelease);
            _buttonClip.onReleaseOutside = mx.utils.Delegate.create(this, onReleaseOutside);
        }
        function _createIcon() {
            _iconClip = _clip.attachMovie(_iconSymbolId, "icon", _clip.getNextHighestDepth());
            _iconClip._x = Math.round((_width / 2) - (_iconClip._width / 2));
            _iconClip._y = Math.round((_height / 2) - (_iconClip._height / 2));
        }
        function _positionObjects() {
            _buttonClip._width = _width;
            _buttonClip._height = _height;
            _iconClip._x = Math.round((_width / 2) - (_iconClip._width / 2));
            _iconClip._y = Math.round((_height / 2) - (_iconClip._height / 2));
        }
        function _stylizeButton() {
            if (_freeze) {
                return(undefined);
            }
            if (_enabled && (_useHandCursor)) {
                _buttonClip.useHandCursor = true;
            } else if ((!_enabled) || (!_useHandCursor)) {
                _buttonClip.useHandCursor = false;
            }
            if (_enabled && (!_mouseOver)) {
                _iconClip._alpha = _normalFill;
            } else if (_enabled && (_mouseOver)) {
                _iconClip._alpha = _rollOverFill;
            } else {
                _iconClip._alpha = _disabledFill;
            }
        }
        function onRollOver() {
            if (_enabled) {
                _mouseOver = true;
                _stylizeButton();
                dispatchEvent({type:"onRollOver", target:this});
            }
        }
        function onRollOut() {
            if (_enabled) {
                _mouseOver = false;
                _stylizeButton();
                dispatchEvent({type:"onRollOut", target:this});
            }
        }
        function onPress() {
            if (_enabled) {
                dispatchEvent({type:"onPress", target:this});
            }
        }
        function onRelease() {
            if (_enabled) {
                dispatchEvent({type:"onRelease", target:this});
            }
        }
        function onReleaseOutside() {
            if (_enabled) {
                _mouseOver = false;
                _stylizeButton();
                dispatchEvent({type:"onReleaseOutside", target:this});
            }
        }
        var _enabled = true;
        var _useHandCursor = true;
        var _mouseOver = false;
        var _freeze = false;
        var _width = 16;
        var _height = 16;
        var _normalFill = 60;
        var _disabledFill = 20;
        var _rollOverFill = 100;
    }
