
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.CopyrightButton
    {
        var _linksClip, _scheduler, _closeScheduler, _background, _mask, _closeButton, _width, _height;
        function CopyrightButton () {
            _linksClip = _root.copyrightTextClip;
            _create();
            _subscribeToStageEvents();
            _subscribeToMouseEvents();
            _scheduler = new com.fb.Utils.FunctionScheduler();
            _closeScheduler = new com.fb.Utils.FunctionScheduler();
        }
        function _subscribeToStageEvents() {
            Stage.addListener(this);
            this.onResize();
        }
        function _subscribeToMouseEvents() {
            Mouse.addListener(this);
        }
        function _create() {
            _createBackgroundShape();
            _createMaskShape();
            _createLinksClip();
            _createCloseButton();
        }
        function _createBackgroundShape() {
            var _local3 = _root.createEmptyMovieClip("copyBackground", _root.getNextHighestDepth());
            _background = new com.fb.graphics.StyleableRectangle(_local3, 0, 0, _collapsedWidth, _collapsedHeight);
            _background.__set__opacity(68);
            _background.__set__cornerRadius(4);
            _background.setCustomCornerRadius(0, "top-left");
            _background.setCustomCornerRadius(0, "bottom-right");
        }
        function _createMaskShape() {
            var _local3 = _root.createEmptyMovieClip("copyMask", _root.getNextHighestDepth());
            _mask = new com.fb.graphics.StyleableRectangle(_local3, 0, 0, _collapsedWidth, _collapsedHeight);
            _mask.__set__cornerRadius(4);
            _mask.setCustomCornerRadius(0, "top-left");
            _mask.setCustomCornerRadius(0, "bottom-right");
        }
        function _createLinksClip() {
            _linksClip._visible = true;
            _linksClip.swapDepths(_root.getNextHighestDepth());
            _linksClip.flippingBookTextField._alpha = 80;
            _linksClip.freeTextField._alpha = 52;
            _linksClip.setMask(_mask.__get__clip());
        }
        function _createCloseButton() {
            var _local3 = _root.createEmptyMovieClip("copyClose", _root.getNextHighestDepth());
            _closeButton = new com.fb.Utils.IconButton("collapseIcon", _local3);
            _closeButton.__set__normalFill(40);
            _closeButton.setSize(21, 21);
            _closeButton.addEventListener("onRelease", mx.utils.Delegate.create(this, onCloseButtonRelease));
        }
        function onResize() {
            _width = Stage.width;
            _height = Stage.height;
            _positionObjects();
        }
        function _positionObjects() {
            if (!_closed) {
                _background.__set__x((_width - _background.__get__width()) - _shiftX);
                _background.__set__y(_shiftY);
                _mask.__set__x(_background.x);
                _mask.__set__y(_background.y);
                _linksClip._x = _background.__get__x() + 7;
                _linksClip._y = _background.__get__y() + 3;
                _closeButton.__set__x((_background.__get__x() + _background.__get__width()) - _closeButton.__get__width());
                _closeButton.__set__y(_background.y);
            } else {
                _closeButton.__set__visible(false);
                _background.hide();
                _mask.hide();
                _linksClip._visible = false;
            }
        }
        function onCloseButtonRelease() {
            if (!_closed) {
                _isAnimating = true;
                _closeScheduler.reset();
                if (_expanded) {
                    _closeScheduler.add(this, "_animateCollapsing", 400);
                }
                _closeScheduler.add(this, "_animateClosing", 400);
                _closeScheduler.start();
            }
        }
        function onBackgroundRollOver() {
            _isAnimating = true;
            _animateExpanding();
        }
        function onBackgroundRollOut() {
            _isAnimating = true;
            _animateCollapsing();
        }
        function onMouseMove() {
            if (_closed || (_isAnimating)) {
                return(undefined);
            }
            var _local2 = _insideBackground();
            if ((!_expanded) && (_local2)) {
                onBackgroundRollOver();
            } else if (_expanded && (!_local2)) {
                onBackgroundRollOut();
            }
        }
        function _insideBackground() {
            var _local4 = _root._xmouse;
            var _local3 = _root._ymouse;
            return((((_local4 >= _background.__get__x()) && (_local4 <= (_background.__get__x() + _background.__get__width()))) && (_local3 >= _background.__get__y())) && (_local3 <= (_background.__get__y() + _background.__get__height())));
        }
        function _animateExpanding() {
            if (!_expanded) {
                _scheduler.reset();
                _scheduler.add(this, "_expandObjects", 400);
                _scheduler.add(this, "_setExpanded", 300);
                _scheduler.start();
            }
        }
        function _expandObjects() {
            var _local2 = 200;
            var _local4 = 200;
            var _local3 = _background.__get__x() - (_expandedWidth - _background.__get__width());
            _background.xTo(_local3, _local2);
            _background.widthTo(_expandedWidth, _local2);
            _background.heightTo(_expandedHeight, _local2, _local4);
            _mask.xTo(_local3, _local2);
            _mask.widthTo(_expandedWidth, _local2);
            _mask.heightTo(_expandedHeight, _local2, _local4);
            new com.timwalling.TweenDelay(_linksClip, "_x", mx.transitions.easing.Regular.easeInOut, _linksClip._x, _local3 + 7, _local2 / 1000, 0, true);
        }
        function _setExpanded() {
            _expanded = true;
            _isAnimating = false;
            _positionObjects();
        }
        function _animateCollapsing() {
            if (_expanded) {
                _scheduler.reset();
                _scheduler.add(this, "_collapseObjects", 400);
                _scheduler.add(this, "_setCollapsed", 300);
                _scheduler.start();
            }
        }
        function _collapseObjects() {
            var _local2 = 200;
            var _local3 = 200;
            var _local4 = (_width - _collapsedWidth) - _shiftX;
            _background.xTo(_local4, _local2, _local3);
            _background.widthTo(_collapsedWidth, _local2, _local3);
            _background.heightTo(_collapsedHeight, _local2);
            _mask.xTo(_local4, _local2, _local3);
            _mask.widthTo(_collapsedWidth, _local2, _local3);
            _mask.heightTo(_collapsedHeight, _local2);
            new com.timwalling.TweenDelay(_linksClip, "_x", mx.transitions.easing.Regular.easeInOut, _linksClip._x, _local4 + 7, _local2 / 1000, _local3 / 1000, true);
        }
        function _setCollapsed() {
            _expanded = false;
            _isAnimating = false;
            _positionObjects();
        }
        function _animateClosing() {
            if (!_closed) {
                _scheduler.reset();
                _scheduler.add(this, "_closeObjects", 400);
                _scheduler.add(this, "_setClosed", 300);
                _scheduler.start();
            }
        }
        function _closeObjects() {
            var _local2 = 200;
            var _local3 = 200;
            _closeButton.__set__visible(false);
            _background.opacityTo(0, _local2, _local3);
            new com.timwalling.TweenDelay(_linksClip, "_alpha", mx.transitions.easing.Regular.easeInOut, _linksClip._alpha, 0, _local2 / 1000, 0, true);
        }
        function _setClosed() {
            _closed = true;
            _isAnimating = false;
            _positionObjects();
        }
        var _collapsedWidth = 98;
        var _collapsedHeight = 21;
        var _expandedWidth = 180;
        var _expandedHeight = 80;
        var _shiftX = 2;
        var _shiftY = 2;
        var _expanded = false;
        var _closed = false;
        var _isAnimating = false;
    }
