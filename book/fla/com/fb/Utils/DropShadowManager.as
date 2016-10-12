
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.DropShadowManager
    {
        var _book, _zoomer;
        function DropShadowManager (bookInstance, zoomerInstance) {
            _book = bookInstance;
            _subscribeToBookEvents();
            _zoomer = zoomerInstance;
            _subscribeToZoomerEvents();
        }
        function get dropShadowEnabled() {
            return(_isEnabled);
        }
        function set dropShadowEnabled(isEnabled) {
            _isEnabled = isEnabled;
            _updateBookShadow();
            //return(dropShadowEnabled);
        }
        function get dropShadowHideWhenFlipping() {
            return(_hideWhenFlipping);
        }
        function set dropShadowHideWhenFlipping(hide) {
            _hideWhenFlipping = hide;
            _updateBookShadow();
            //return(dropShadowHideWhenFlipping);
        }
        function set dropShadowOpacity(newOpacity) {
            _dropShadowOpacity = newOpacity;
            if (_dropShadowOpacity > 0) {
                var _local2 = new flash.filters.DropShadowFilter(0, 90, 0, _dropShadowOpacity / 100, 7, 7, 1, 2, false, false, false);
                _book.__get__clip().filters = [_local2];
            } else {
                _book.__get__clip().filters = [];
            }
            //return(dropShadowOpacity);
        }
        function get dropShadowOpacity() {
            return(_dropShadowOpacity);
        }
        function _subscribeToBookEvents() {
            _book.addEventListener("onStartFlip", mx.utils.Delegate.create(this, onBookStartFlip));
            _book.addEventListener("onFlipBack", mx.utils.Delegate.create(this, onBookFlipBack));
            _book.addEventListener("onPutPage", mx.utils.Delegate.create(this, onBookPutPage));
        }
        function _subscribeToZoomerEvents() {
            _zoomer.addEventListener("onStartZoomingIn", mx.utils.Delegate.create(this, onStartZoomingIn));
            _zoomer.addEventListener("onFinishZoomingOut", mx.utils.Delegate.create(this, onFinishZoomingOut));
        }
        function onBookStartFlip(eventObject) {
            _isFlipping = true;
            _updateBookShadow();
        }
        function onBookFlipBack(eventObject) {
            _isFlipping = false;
            _updateBookShadow();
        }
        function onBookPutPage(eventObject) {
            _isFlipping = false;
            _updateBookShadow();
        }
        function onStartZoomingIn(eventObject) {
            _isZooming = true;
            _updateBookShadow();
        }
        function onFinishZoomingOut(eventObject) {
            _isZooming = false;
            _updateBookShadow();
        }
        function _updateBookShadow() {
            if (_shadowTurnedOn) {
                if (_isZooming) {
                    _turnShadowOffQuickly();
                } else if ((!_isEnabled) || (_isFlipping && (_hideWhenFlipping))) {
                    _turnShadowOff();
                }
            } else if (_isEnabled && (!((_hideWhenFlipping && (_isFlipping)) && (!_isZooming)))) {
                _turnShadowOn();
            }
        }
        function _turnShadowOn() {
            _shadowTurnedOn = true;
            _dropShadowOpacityTo(70, 300, 0);
        }
        function _turnShadowOff() {
            _shadowTurnedOn = false;
            _dropShadowOpacityTo(0, 300, 0);
        }
        function _turnShadowOffQuickly() {
            _shadowTurnedOn = false;
            _dropShadowOpacityTo(0, 30, 0);
        }
        function _dropShadowOpacityTo(targetOpacity, duration, delay) {
            new com.timwalling.TweenDelay(this, "dropShadowOpacity", mx.transitions.easing.Regular.easeInOut, _dropShadowOpacity, targetOpacity, duration / 1000, delay / 1000, true);
        }
        var _isEnabled = true;
        var _hideWhenFlipping = true;
        var _isFlipping = false;
        var _isZooming = false;
        var _shadowTurnedOn = false;
        var _dropShadowOpacity = 0;
    }
