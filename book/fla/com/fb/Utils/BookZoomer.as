
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.BookZoomer
    {
        var _book, _clip, _preloader, _verticalBar, _horizontalBar, _originalBookWidth, _originalBookHeight, _originalBookX, _originalBookY, _zoomPath, _zoomImageWidth, _zoomImageHeight, _zoomOnClick, _oldStageWidth, _oldStageHeight, _isOverStage, _savedFlipOnClick, _savedAutoFlip, _zoomNavigationData;
        function BookZoomer (bookInstance, parentClip) {
            _book = bookInstance;
            _clip = parentClip;
            _subscribeToBookEvents();
            _createScrollBars();
            _createPreloader();
            _subscribeToStageEvents();
            _subscribeToMouseEvents();
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function get zoomEnabled() {
            return(_zoomEnabled);
        }
        function set zoomEnabled(isEnabled) {
            _zoomEnabled = isEnabled;
            //return(zoomEnabled);
        }
        function getLargePageURL(pageNumber) {
            var _local2 = _book.getPageLink(pageNumber);
            var _local3 = _local2.URL;
            return(_constructZoomURL(_local3, pageNumber));
        }
        function zoomIn(dx, dy) {
            if (((!_isAnimating) && (!_zoomedIn)) && (_zoomEnabled)) {
                if (dx == undefined) {
                    dx = 0;
                }
                if (dy == undefined) {
                    dy = 0;
                }
                _animateZoomingIn(dx, dy);
                dispatchEvent({type:"onStartZoomingIn"});
            }
        }
        function zoomOut() {
            if (((!_isAnimating) && (_zoomedIn)) && (_zoomEnabled)) {
                _unloadZoomContent();
                _animateZoomingOut();
                _preloader.zoomOut();
                dispatchEvent({type:"onStartZoomingOut"});
            }
        }
        function onWheelScroll(delta) {
            if (_zoomedIn && (!_isAnimating)) {
                _book.y = _book.y + (delta * 5);
                _repositionBook(0, 0);
                _updateScrollbars();
            }
        }
        function get stageWidth() {
            if (verticalBarRequired) {
                return(Stage.width - _verticalBar.__get__height());
            } else {
                return(Stage.width);
            }
        }
        function get stageHeight() {
            if (horizontalBarRequired) {
                return(Stage.height - _horizontalBar.__get__height());
            } else {
                return(Stage.height);
            }
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
        function get originalBookX() {
            return(_originalBookX);
        }
        function set originalBookX(newX) {
            _originalBookX = newX;
            //return(originalBookX);
        }
        function get originalBookY() {
            return(_originalBookY);
        }
        function set originalBookY(newY) {
            _originalBookY = newY;
            //return(originalBookY);
        }
        function get zoomPath() {
            return(_zoomPath);
        }
        function set zoomPath(newPath) {
            _zoomPath = newPath;
            //return(zoomPath);
        }
        function get zoomImageWidth() {
            return(_zoomImageWidth);
        }
        function set zoomImageWidth(newWidth) {
            _zoomImageWidth = newWidth;
            //return(zoomImageWidth);
        }
        function get zoomImageHeight() {
            return(_zoomImageHeight);
        }
        function set zoomImageHeight(newHeight) {
            _zoomImageHeight = newHeight;
            //return(zoomImageHeight);
        }
        function get zoomOnClick() {
            return(_zoomOnClick);
        }
        function set zoomOnClick(zoom) {
            _zoomOnClick = zoom;
            //return(zoomOnClick);
        }
        function get zoomUIColor() {
            return(_zoomUIColor);
        }
        function set zoomUIColor(newColor) {
            _zoomUIColor = newColor;
            _horizontalBar.__set__mainColor(_zoomUIColor);
            _verticalBar.__set__mainColor(_zoomUIColor);
            //return(zoomUIColor);
        }
        function get zoomedIn() {
            return(_zoomedIn);
        }
        function _subscribeToStageEvents() {
            Stage.addListener(this);
        }
        function _subscribeToMouseEvents() {
            Mouse.addListener(this);
        }
        function onResize() {
            if (_oldStageWidth == undefined) {
                _oldStageWidth = Stage.width;
            }
            if (_oldStageHeight == undefined) {
                _oldStageHeight = Stage.height;
            }
            _showScrollbars();
            _repositionBook(Stage.width - _oldStageWidth, Stage.height - _oldStageHeight);
            _positionScrollBars();
            _oldStageWidth = Stage.width;
            _oldStageHeight = Stage.height;
            _preloader.__set__x(Math.round((Stage.width / 2) - (_preloader.__get__width() / 2)));
            _preloader.__set__y(Math.round((Stage.height / 2) - (_preloader.__get__height() / 2)));
        }
        function onMouseMove() {
            var _local3 = {x:_root._xmouse, y:_root._ymouse};
            _clip.globalToLocal(_local3);
            var _local4 = (((_local3.x > 0) && (_local3.x < stageWidth)) && (_local3.y > 0)) && (_local3.y < stageHeight);
            if (_isOverStage != _local4) {
                _isOverStage = _local4;
                if (_isOverStage) {
                    dispatchEvent({type:"onZoomStageOver"});
                } else {
                    dispatchEvent({type:"onZoomStageOut"});
                }
            }
            if (_isDragging) {
                _updateScrollbars();
            }
        }
        function onMouseWheel(delta) {
            onWheelScroll(delta);
        }
        function _createPreloader() {
            var _local2 = _clip.createEmptyMovieClip("preloader", _clip.getNextHighestDepth());
            _preloader = new com.fb.Utils.ZoomPagesPreloader(_local2, _book);
            _preloader.__set__x(Math.round((Stage.width / 2) - (_preloader.__get__width() / 2)));
            _preloader.__set__y(Math.round((Stage.height / 2) - (_preloader.__get__height() / 2)));
        }
        function _createScrollBars() {
            var _local2 = _clip.createEmptyMovieClip("verticalBar", _clip.getNextHighestDepth());
            _verticalBar = new com.fb.UIComponents.ScrollBar(_local2, false);
            _verticalBar.addEventListener("change", mx.utils.Delegate.create(this, _onVerticalBarChanged));
            _verticalBar.__set__mainColor(_zoomUIColor);
            var _local3 = _clip.createEmptyMovieClip("horizontalBar", _clip.getNextHighestDepth());
            _horizontalBar = new com.fb.UIComponents.ScrollBar(_local3, true);
            _horizontalBar.addEventListener("change", mx.utils.Delegate.create(this, _onHorizontalBarChanged));
            _horizontalBar.__set__mainColor(_zoomUIColor);
            _verticalBar.__set__x(Stage.width - _verticalBar.__get__height());
            _verticalBar.__set__y(0);
            _horizontalBar.__set__x(0);
            _horizontalBar.__set__y(Stage.height - _horizontalBar.__get__height());
            _hideScrollbars();
        }
        function _onVerticalBarChanged(eventObject) {
            if (_zoomedIn && (!_isAnimating)) {
                var _local2 = _getDragBounds();
                _book.__set__y(_local2.minY + (((100 - eventObject.normedPosition) * (_local2.maxY - _local2.minY)) / 100));
            }
        }
        function _onHorizontalBarChanged(eventObject) {
            if (_zoomedIn && (!_isAnimating)) {
                var _local2 = _getDragBounds();
                _book.__set__x(_local2.minX + (((100 - eventObject.normedPosition) * (_local2.maxX - _local2.minX)) / 100));
            }
        }
        function _animateZoomingIn(dx, dy) {
            var _local6 = ((_zoomImageWidth * 2) / _originalBookWidth) * dx;
            var _local7 = (_zoomImageHeight / _originalBookHeight) * dy;
            var _local3 = ((stageWidth / 2) - _local6) - _zoomImageWidth;
            var _local2 = ((stageHeight / 2) - _local7) - (_zoomImageHeight / 2);
            var _local5 = _adjustBookPosition(_local3, _local2, _local6, _local7);
            _local3 = _local5.x;
            _local2 = _local5.y;
            var _local9 = _zoomImageWidth * 2;
            var _local8 = _zoomImageHeight;
            var _local12 = new com.timwalling.TweenDelay(_book, "x", mx.transitions.easing.Regular.easeInOut, _originalBookX, _local3, _zoomingInDuration / 1000, 0, true);
            var _local11 = new com.timwalling.TweenDelay(_book, "y", mx.transitions.easing.Regular.easeInOut, _originalBookY, _local2, _zoomingInDuration / 1000, 0, true);
            var _local10 = new com.timwalling.TweenDelay(_book, "width", mx.transitions.easing.Regular.easeInOut, _originalBookWidth, _local9, _zoomingInDuration / 1000, 0, true);
            var _local4 = new com.timwalling.TweenDelay(_book, "height", mx.transitions.easing.Regular.easeInOut, _originalBookHeight, _local8, _zoomingInDuration / 1000, 0, true);
            _local4.onMotionFinished = mx.utils.Delegate.create(this, onZoomingInAnimationFinished);
            _local4.onMotionChanged = mx.utils.Delegate.create(this, onZoomingInAnimationChanged);
            _enableAnimationState();
            _isAnimating = true;
            _positionScrollBars();
            _showScrollbars();
        }
        function _animateZoomingOut() {
            var _local5 = new com.timwalling.TweenDelay(_book, "x", mx.transitions.easing.Regular.easeInOut, _book.__get__x(), _originalBookX, _zoomingInDuration / 1000, 0.1, true);
            var _local4 = new com.timwalling.TweenDelay(_book, "y", mx.transitions.easing.Regular.easeInOut, _book.__get__y(), _originalBookY, _zoomingInDuration / 1000, 0.1, true);
            var _local3 = new com.timwalling.TweenDelay(_book, "width", mx.transitions.easing.Regular.easeInOut, _book.__get__width(), _originalBookWidth, _zoomingInDuration / 1000, 0.1, true);
            var _local2 = new com.timwalling.TweenDelay(_book, "height", mx.transitions.easing.Regular.easeInOut, _book.__get__height(), _originalBookHeight, _zoomingInDuration / 1000, 0.1, true);
            _local2.onMotionFinished = mx.utils.Delegate.create(this, onZoomingOutAnimationFinished);
            _local2.onMotionChanged = mx.utils.Delegate.create(this, onZoomingOutAnimationChanged);
            _isAnimating = true;
        }
        function _enableAnimationState() {
            _savedFlipOnClick = _book.flipOnClick;
            _savedAutoFlip = _book.autoFlipSize;
            _book.__set__flipOnClick(false);
            _book.__set__autoFlipSize(0);
        }
        function _disableAnimationState() {
            _book.__set__flipOnClick(_savedFlipOnClick);
            _book.__set__autoFlipSize(_savedAutoFlip);
        }
        function onZoomingInAnimationFinished() {
            _isAnimating = false;
            _zoomedIn = true;
            _book.__set__zoomedIn(true);
            _loadZoomContent();
            dispatchEvent({type:"onFinishZoomingIn"});
        }
        function onZoomingInAnimationChanged() {
            _updateScrollbars();
        }
        function onZoomingOutAnimationChanged() {
            _updateScrollbars();
        }
        function _updateScrollbars() {
            var _local2 = _book.__get__height();
            var _local4 = (((_book.__get__leftPageNumber() == undefined) || (_book.__get__rightPageNumber() == undefined)) ? (_book.__get__width() / 2) : (_book.__get__width()));
            var _local3 = _book.__get__x();
            if (_book.__get__leftPageNumber() == undefined) {
                _local3 = _local3 + (_book.__get__width() / 2);
            }
            if (_local2 > stageHeight) {
                _verticalBar.update(_local2, (stageHeight / 2) - _book.__get__y(), stageHeight);
            }
            if (_local4 > stageWidth) {
                _horizontalBar.update(_local4, (stageWidth / 2) - _local3, stageWidth);
            }
        }
        function onZoomingOutAnimationFinished() {
            _isAnimating = false;
            _zoomedIn = false;
            _book.__set__zoomedIn(false);
            _disableAnimationState();
            _hideScrollbars();
            if (_isZoomingOutForNavigation) {
                _isZoomingOutForNavigation = false;
                switch (_zoomNavigationData.functionName) {
                    case "flipForward" : 
                        _book.flipForward();
                        break;
                    case "flipBack" : 
                        _book.flipBack();
                        break;
                    case "flipGotoPage" : 
                        _book.flipGotoPage(_zoomNavigationData.targetPage);
                        break;
                    case "gotoPage" : 
                        _book.gotoPage(_zoomNavigationData.targetPage);
                        break;
                    case "directGotoPage" : 
                        _book.directGotoPage(_zoomNavigationData.targetPage);
                        break;
                }
            }
            dispatchEvent({type:"onFinishZoomingOut"});
        }
        function _onDoubleClick(eventObject) {
            if ((!_zoomedIn) && (_zoomOnClick)) {
                var _local5 = 0;
                var _local4 = 0;
                var _local3 = {x:_root._xmouse, y:_root._ymouse};
                _book.__get__componentClip().globalToLocal(_local3);
                zoomIn(_local3.x, _local3.y);
            } else if (_zoomOnClick) {
                zoomOut();
            }
        }
        function _onClick(eventObject) {
            _tryDragging();
        }
        function _onRelease(eventObject) {
            _stopDragging();
        }
        function _onZoomNavigationCall(eventObject) {
            if (_zoomedIn && (!_isAnimating)) {
                zoomOut();
                _zoomNavigationData = eventObject;
                _isZoomingOutForNavigation = true;
            }
        }
        function _onPageLoad(eventObject) {
            if (_zoomEnabled) {
                var _local2 = _book.getPageLink(eventObject.pageNumber);
                if (_local2.params.zoom == undefined) {
                    _local2.params.zoom = _constructZoomURL(_local2.URL, _local2.pageNumber);
                }
            }
        }
        function _onPutPage(eventObject) {
            if (_zoomEnabled) {
                var _local2 = _book.getPageLink(_book.__get__leftPageNumber());
                if (_local2.params.zoom == undefined) {
                    _local2.params.zoom = _constructZoomURL(_local2.URL, _local2.pageNumber);
                }
                _local2 = _book.getPageLink(_book.__get__rightPageNumber());
                if (_local2.params.zoom == undefined) {
                    _local2.params.zoom = _constructZoomURL(_local2.URL, _local2.pageNumber);
                }
            }
        }
        function _constructZoomURL(pageURL, pageNumber) {
            var _local3 = pageURL.lastIndexOf("/");
            if (_local3 == -1) {
                _local3 = pageURL.lastIndexOf("\\");
            }
            if (_local3 == -1) {
                _local3 = 0;
            }
            var _local6 = ((_local3 == 0) ? (pageURL.substr(_local3)) : (pageURL.substr(_local3 + 1)));
            var _local5 = _zoomPath + _local6;
            if ((_root.zoomPagesSet[0] != "") && (_root.zoomPagesSet[0] != undefined)) {
                _local5 = _root.zoomPagesSet[pageNumber];
            }
            return(_local5);
        }
        function _subscribeToBookEvents() {
            _book.addEventListener("onDoubleClick", mx.utils.Delegate.create(this, _onDoubleClick));
            _book.addEventListener("onStartPageHold", mx.utils.Delegate.create(this, _onClick));
            _book.addEventListener("onRelease", mx.utils.Delegate.create(this, _onRelease));
            _book.addEventListener("zoomNavigationCall", mx.utils.Delegate.create(this, _onZoomNavigationCall));
            _book.addEventListener("onPageLoad", mx.utils.Delegate.create(this, _onPageLoad));
            _book.addEventListener("onPutPage", mx.utils.Delegate.create(this, _onPutPage));
            _book.addEventListener("onZoomContentLoadInit", mx.utils.Delegate.create(this, _onZoomContentLoadInit));
            _book.addEventListener("onZoomContentLoadProgress", mx.utils.Delegate.create(this, _onZoomContentLoadProgress));
            _book.addEventListener("onZoomContentLoadComplete", mx.utils.Delegate.create(this, _onZoomContentLoadComplete));
        }
        function _positionScrollBars() {
            if (_zoomedIn) {
                _updateScrollbars();
            } else {
                _verticalBar.update(stageHeight, 0, stageHeight);
                _horizontalBar.update(stageWidth, 0, stageWidth);
            }
            _verticalBar.__set__x(Stage.width - _verticalBar.__get__height());
            _verticalBar.__set__y(0);
            _horizontalBar.__set__x(0);
            _horizontalBar.__set__y(Stage.height - _horizontalBar.__get__height());
        }
        function _showScrollbars() {
            if (_zoomedIn || (_isAnimating)) {
                if (verticalBarRequired) {
                    _verticalBar.show();
                } else {
                    _verticalBar.hide();
                }
                if (horizontalBarRequired) {
                    _horizontalBar.show();
                } else {
                    _horizontalBar.hide();
                }
            }
        }
        function get verticalBarRequired() {
            return(_zoomImageHeight > Stage.height);
        }
        function get horizontalBarRequired() {
            var _local2 = (((_book.__get__leftPageNumber() == undefined) || (_book.__get__rightPageNumber() == undefined)) ? (_zoomImageWidth) : (2 * _zoomImageWidth));
            return(_local2 > Stage.width);
        }
        function _hideScrollbars() {
            _verticalBar.hide();
            _horizontalBar.hide();
        }
        function _adjustBookPosition(x, y, xCorrection, yCorrection) {
            var _local2 = _getDragBounds();
            var _local8 = (((_book.__get__leftPageNumber() == undefined) || (_book.__get__rightPageNumber() == undefined)) ? (_zoomImageWidth) : (2 * _zoomImageWidth));
            var _local5 = _zoomImageHeight;
            var _local4 = _local8 < stageWidth;
            var _local3 = _local5 < stageHeight;
            if ((x > _local2.maxX) && (!_local4)) {
                x = _local2.maxX;
            }
            if ((x < _local2.minX) && (!_local4)) {
                x = _local2.minX;
            }
            if ((y > _local2.maxY) && (!_local3)) {
                y = _local2.maxY;
            }
            if ((y < _local2.minY) && (!_local3)) {
                y = _local2.minY;
            }
            var _local7 = _book.__get__leftPageNumber() == undefined;
            var _local6 = _book.__get__rightPageNumber() == undefined;
            if (_local4) {
                x = x + xCorrection;
                if (_local7) {
                    x = x - ((_originalBookWidth / 4) * ((_zoomImageWidth * 2) / _originalBookWidth));
                } else if (_local6) {
                    x = x - (((-_originalBookWidth) / 4) * ((_zoomImageWidth * 2) / _originalBookWidth));
                }
            }
            if (_local3) {
                y = y + yCorrection;
            }
            return({x:x, y:y});
        }
        function _getDragBounds() {
            var _local5 = stageWidth - (2 * _zoomImageWidth);
            var _local4 = stageHeight - _zoomImageHeight;
            var _local3 = 0;
            var _local2 = 0;
            if (_book.__get__leftPageNumber() == undefined) {
                _local3 = -_zoomImageWidth;
            }
            if (_book.__get__rightPageNumber() == undefined) {
                _local5 = stageWidth - _zoomImageWidth;
            }
            return({minX:_local5, minY:_local4, maxX:_local3, maxY:_local2});
        }
        function _repositionBook(dx, dy) {
            if (_zoomedIn) {
                var _local4 = _book.__get__x() + (dx / 2);
                var _local3 = _book.__get__y() + (dy / 2);
                var _local2 = _getDragBounds();
                var _local8 = (((_book.__get__leftPageNumber() == undefined) || (_book.__get__rightPageNumber() == undefined)) ? (_zoomImageWidth) : (2 * _zoomImageWidth));
                var _local7 = _zoomImageHeight;
                var _local6 = _local8 < stageWidth;
                var _local5 = _local7 < stageHeight;
                if ((_local4 > _local2.maxX) && (!_local6)) {
                    _local4 = _local2.maxX;
                }
                if ((_local4 < _local2.minX) && (!_local6)) {
                    _local4 = _local2.minX;
                }
                if ((_local3 > _local2.maxY) && (!_local5)) {
                    _local3 = _local2.maxY;
                }
                if ((_local3 < _local2.minY) && (!_local5)) {
                    _local3 = _local2.minY;
                }
                _book.__set__x(_local4);
                _book.__set__y(_local3);
            }
        }
        function _tryDragging() {
            if (_zoomedIn && (!_isAnimating)) {
                var _local2 = _getDragBounds();
                var _local4 = (((_book.__get__leftPageNumber() == undefined) || (_book.__get__rightPageNumber() == undefined)) ? (_book.__get__width() / 2) : (_book.__get__width()));
                var _local3 = _book.__get__height();
                if (_local4 < stageWidth) {
                    _local2.minX = (_local2.maxX = _book.x);
                }
                if (_local3 < stageHeight) {
                    _local2.minY = (_local2.maxY = _book.y);
                }
                _book.__get__clip().startDrag(false, _local2.minX, _local2.minY, _local2.maxX, _local2.maxY);
                _isDragging = true;
                dispatchEvent({type:"onStartZoomDrag"});
            }
        }
        function _stopDragging() {
            if (_isDragging) {
                _book.__get__clip().stopDrag();
                _isDragging = false;
                dispatchEvent({type:"onFinishZoomDrag"});
            }
        }
        function _loadZoomContent() {
            _book.loadLargePages();
        }
        function _unloadZoomContent() {
            _book.unloadLargePages();
        }
        function _onZoomContentLoadInit(eventObject) {
            _preloader.onLoadInit(eventObject.pageClip);
        }
        function _onZoomContentLoadProgress(eventObject) {
            _preloader.onLoadProgress(eventObject.pageClip, eventObject.progress);
        }
        function _onZoomContentLoadComplete(eventObject) {
            _preloader.onLoadComplete(eventObject.pageClip, eventObject.zoomPageClip, eventObject.cache);
        }
        var _zoomEnabled = true;
        var _zoomUIColor = 9412262;
        var _zoomedIn = false;
        var _isAnimating = false;
        var _isDragging = false;
        var _isZoomingOutForNavigation = false;
        var _zoomingInDuration = 500;
    }
