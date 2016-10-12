
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.ZoomHintManager
    {
        var _hint, _book, _zoomer, _centerer;
        function ZoomHintManager (hintInstance, bookInstance, zoomerInstance, centererInstance, enabled) {
            _hintEnabled = enabled;
            _hint = hintInstance;
            _book = bookInstance;
            _zoomer = zoomerInstance;
            _centerer = centererInstance;
            _subscribeToEvents();
        }
        function closeByWindow() {
            _userClosedWindow = true;
            _updateHintWindow();
        }
        function _subscribeToEvents() {
            _hint.addEventListener("onWindowCloseByUser", mx.utils.Delegate.create(this, onWindowCloseByUser));
            _book.addEventListener("onPutPage", mx.utils.Delegate.create(this, onBookPutPage));
            _book.addEventListener("onRollOver", mx.utils.Delegate.create(this, onBookOver));
            _book.addEventListener("onBookOut", mx.utils.Delegate.create(this, onBookOut));
            _centerer.addEventListener("bookPositionChanged", mx.utils.Delegate.create(this, onBookCentered));
            _zoomer.addEventListener("onStartZoomingIn", mx.utils.Delegate.create(this, onZoomingStarted));
        }
        function onBookPutPage() {
            if (!_firstTimePutPage) {
                return(undefined);
            }
            _firstTimePutPage = false;
            _pageWasPut = true;
            _updateHintWindow();
        }
        function onBookOver() {
            _overBook = true;
            _updateHintWindow();
        }
        function onBookOut() {
            _overBook = false;
            _updateHintWindow();
        }
        function onBookCentered() {
            _wasCentered = true;
            _updateHintWindow();
        }
        function onZoomingStarted() {
            _wasZoomed = true;
            _updateHintWindow();
        }
        function onWindowCloseByUser() {
            _userClosedWindow = true;
        }
        function _updateHintWindow() {
            if (_canShow()) {
                _hint.showWindow();
            } else {
                _hint.closeWindow();
            }
        }
        function _canShow() {
            var _local3 = _pageWasPut && (_wasCentered || (!_centerer.__get__centerBook()));
            var _local2 = (_wasZoomed || (_userClosedWindow)) || (!_zoomer.__get__zoomEnabled());
            if ((_local3 && (!_local2)) && (_hintEnabled)) {
                return(_overBook);
            } else {
                return(false);
            }
        }
        var _overBook = false;
        var _pageWasPut = false;
        var _wasCentered = false;
        var _wasZoomed = false;
        var _userClosedWindow = false;
        var _firstTimePutPage = true;
        var _hintEnabled = false;
    }
