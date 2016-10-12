
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.ZoomPagesPreloader
    {
        var _clip, _book, _preloader, _background;
        function ZoomPagesPreloader (parentClip, bookInstance) {
            _clip = parentClip;
            _book = bookInstance;
            _create();
            _clip._visible = false;
        }
        function onLoadInit(pageClip) {
            _cancelled = false;
            if (!_alreadyLoading) {
                _progress = 0;
                _leftPageProgress = 0;
                _rightPageProgress = 0;
                _preloader.setProgress(0);
                _animateOpen();
                _alreadyLoading = true;
            }
        }
        function onLoadProgress(pageClip, progress) {
            if (pageClip.isLeftPage) {
                _leftPageProgress = progress;
            } else {
                _rightPageProgress = progress;
            }
            _preloader.progressTo(_getEntireProgress(), 300, this);
        }
        function onLoadComplete(pageClip, zoomPageClip, cache) {
            if (pageClip.isLeftPage) {
                _leftPageProgress = 100;
            } else {
                _rightPageProgress = 100;
            }
        }
        function zoomOut() {
            _cancelled = true;
            _alreadyLoading = false;
            _animateClose();
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
        function get height() {
            return(_height);
        }
        function _updateProgress(progress) {
            _progress = progress;
            if ((_progress == 100) && (_bothLoaded())) {
                _alreadyLoading = false;
                _animateClose();
            }
        }
        function _bothLoaded() {
            return(((_leftPageProgress == 100) || (_book.__get__leftPageNumber() == undefined)) && ((_rightPageProgress == 100) || (_book.__get__rightPageNumber() == undefined)));
        }
        function _getEntireProgress() {
            if ((_book.__get__leftPageNumber() != undefined) && (_book.__get__rightPageNumber() != undefined)) {
                return((_leftPageProgress + _rightPageProgress) / 2);
            } else if (_book.__get__leftPageNumber() == undefined) {
                return(_rightPageProgress);
            } else if (_book.__get__rightPageNumber() == undefined) {
                return(_leftPageProgress);
            }
        }
        function _create() {
            _createBackground();
            _createPreloader();
        }
        function _createBackground() {
            var _local2 = _clip.createEmptyMovieClip("background", _clip.getNextHighestDepth());
            _background = new com.fb.graphics.StyleableRectangle(_local2, 0, 0, _width, _height);
            _background.__set__fill(70);
            _background.__set__cornerRadius(4);
        }
        function _createPreloader() {
            _preloader = _clip.attachMovie("PrintPreloaderClip", "preloader", _clip.getNextHighestDepth());
            _preloader._x = Math.round((_width / 2) - 70);
            _preloader._y = Math.round((_height / 2) - 6);
        }
        function _animateOpen() {
            if (_isAnimating) {
                return(undefined);
            }
            _isAnimating = true;
            _clip._visible = true;
            _clip._alpha = 0;
            var _local2 = new com.timwalling.TweenDelay(_clip, "_alpha", mx.transitions.easing.Regular.easeInOut, 0, 100, 0.2, 0, true);
            _local2.onMotionFinished = mx.utils.Delegate.create(this, _onOpenMotionFinished);
        }
        function _animateClose() {
            if (_isAnimating) {
                return(undefined);
            }
            _isAnimating = true;
            var _local2 = new com.timwalling.TweenDelay(_clip, "_alpha", mx.transitions.easing.Regular.easeInOut, 100, 0, 0.2, 0.3, true);
            _local2.onMotionFinished = mx.utils.Delegate.create(this, _onCloseMotionFinished);
        }
        function _onCloseMotionFinished() {
            _isAnimating = false;
            _preloader.animate = false;
            _clip._visible = false;
            if (!_cancelled) {
                _book.showZoomPages();
            }
        }
        function _onOpenMotionFinished() {
            _isAnimating = false;
            _preloader.animate = true;
        }
        var _width = 170;
        var _height = 40;
        var _progress = 0;
        var _leftPageProgress = 0;
        var _rightPageProgress = 0;
        var _alreadyLoading = false;
        var _cancelled = false;
        var _isAnimating = false;
    }
