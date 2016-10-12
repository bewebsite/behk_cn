
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.BookCenterer
    {
        var _book, _originalBookWidth, _originalBookHeight;
        function BookCenterer (bookInstance) {
            _book = bookInstance;
            _subscribeToBookEvents();
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function get centerBook() {
            return(_centerBook);
        }
        function set centerBook(center) {
            _centerBook = center;
            _repositionBook();
            //return(centerBook);
        }
        function get originalBookWidth() {
            return(_originalBookWidth);
        }
        function set originalBookWidth(newWidth) {
            _originalBookWidth = newWidth;
            //return(originalBookWidth);
        }
        function get originalBookHeight() {
            return(_originalBookHeight);
        }
        function set originalBookHeight(newHeight) {
            _originalBookHeight = newHeight;
            //return(originalBookHeight);
        }
        function getCenterPosition() {
            return(_getCenteredBookPosition());
        }
        function _repositionBook(forward) {
            if (_centerBook && (_bookNotCentered(forward))) {
                _animateCentering(forward);
            }
        }
        function _subscribeToBookEvents() {
            _book.addEventListener("onPutPage", mx.utils.Delegate.create(this, _onPutPage));
            _book.addEventListener("onFlipOver", mx.utils.Delegate.create(this, _onFlipOver));
        }
        function _bookNotCentered(forward) {
            return(_book.__get__x() != _getCenteredBookPosition(forward).x);
        }
        function _getCenteredBookPosition(forward) {
            if (forward == undefined) {
                var _local7 = _book.__get__leftPageNumber() != undefined;
                var _local6 = _book.__get__rightPageNumber() != undefined;
            } else {
                var _local3 = _book.__get__leftPageNumber();
                if (_local3 == undefined) {
                    _local3 = 0;
                }
                var _local4 = (forward ? (_local3 + 2) : (_local3 - 2));
                if ((_local4 > _book.__get__totalPages()) || (_local4 < 1)) {
                    _local4 = undefined;
                }
                var _local5 = _book.__get__rightPageNumber();
                if (_local5 == undefined) {
                    _local5 = _book.__get__totalPages() + 1;
                }
                var _local2 = (forward ? (_local5 + 2) : (_local5 - 2));
                if ((_local2 > _book.__get__totalPages()) || (_local2 < 1)) {
                    _local2 = undefined;
                }
                var _local7 = _local4 != undefined;
                var _local6 = _local2 != undefined;
            }
            var _local10 = _book.__get__x();
            if (_local7 && (_local6)) {
                _local10 = (Stage.width / 2) - (_originalBookWidth / 2);
            } else if (_local7) {
                _local10 = (Stage.width / 2) - (_originalBookWidth / 4);
            } else if (_local6) {
                _local10 = (Stage.width / 2) - ((3 * _originalBookWidth) / 4);
            }
            return({x:_local10, y:(Stage.height / 2) - (_originalBookHeight / 2)});
        }
        function _animateCentering(forward) {
            var _local2 = _book.__get__x();
            var _local4 = _getCenteredBookPosition(forward).x;
            var _local3 = new com.timwalling.TweenDelay(_book, "x", mx.transitions.easing.Regular.easeInOut, _local2, _local4, _centeringAnimationDuration / 1000, 0, true);
            _local3.onMotionFinished = mx.utils.Delegate.create(this, _onCenteringAnimationFinished);
        }
        function _onPutPage(eventObject) {
            _repositionBook();
        }
        function _onFlipOver(eventObject) {
            _repositionBook(eventObject.forward);
        }
        function _onCenteringAnimationFinished() {
            dispatchEvent({type:"bookPositionChanged"});
        }
        var _centerBook = false;
        var _centeringAnimationDuration = 200;
    }
