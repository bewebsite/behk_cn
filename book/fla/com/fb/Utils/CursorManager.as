
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.CursorManager
    {
        var _book, _zoomer, _clip;
        function CursorManager (bookInstance, zoomerInstance, parentClip) {
            _book = bookInstance;
            _zoomer = zoomerInstance;
            _clip = parentClip;
            _clip._visible = false;
            _subscribeToEvents();
        }
        function get useCustomCursors() {
            return(_useCustomCursors);
        }
        function set useCustomCursors(use) {
            _useCustomCursors = use;
            //return(useCustomCursors);
        }
        function _create() {
        }
        function _subscribeToEvents() {
            _book.addEventListener("onRollOver", mx.utils.Delegate.create(this, onBookRollOver));
            _book.addEventListener("onRollOut", mx.utils.Delegate.create(this, onBookRollOut));
            _book.addEventListener("onPageOver", mx.utils.Delegate.create(this, onPageOver));
            _book.addEventListener("onPageOut", mx.utils.Delegate.create(this, onPageOut));
            _book.addEventListener("onStartPageDrag", mx.utils.Delegate.create(this, onBookStartPageDrag));
            _book.addEventListener("onStopPageDrag", mx.utils.Delegate.create(this, onBookStopPageDrag));
            _zoomer.addEventListener("onStartZoomingIn", mx.utils.Delegate.create(this, onStartZoomingIn));
            _zoomer.addEventListener("onFinishZoomingIn", mx.utils.Delegate.create(this, onFinishZoomingIn));
            _zoomer.addEventListener("onStartZoomingOut", mx.utils.Delegate.create(this, onStartZoomingOut));
            _zoomer.addEventListener("onFinishZoomingOut", mx.utils.Delegate.create(this, onFinishZoomingOut));
            _zoomer.addEventListener("onStartZoomDrag", mx.utils.Delegate.create(this, onStartZoomDrag));
            _zoomer.addEventListener("onFinishZoomDrag", mx.utils.Delegate.create(this, onFinishZoomDrag));
            _zoomer.addEventListener("onZoomStageOver", mx.utils.Delegate.create(this, onZoomStageOver));
            _zoomer.addEventListener("onZoomStageOut", mx.utils.Delegate.create(this, onZoomStageOut));
            Mouse.addListener(this);
        }
        function onBookRollOver() {
            _isOverBook = true;
            _updateCursor();
        }
        function onBookRollOut() {
            _isOverBook = false;
            _updateCursor();
        }
        function onPageOver() {
        }
        function onPageOut() {
        }
        function onBookStartPageDrag(eventObject) {
            _isDragging = true;
            _updateCursor();
        }
        function onBookStopPageDrag(eventObject) {
            _isDragging = false;
            _updateCursor();
        }
        function onStartZoomingIn() {
            _isZoomingIn = true;
            _updateCursor();
        }
        function onFinishZoomingIn() {
            _isZoomingIn = false;
            _isZoomedIn = true;
            _updateCursor();
        }
        function onStartZoomingOut() {
            _isZoomingOut = true;
            _updateCursor();
        }
        function onFinishZoomingOut() {
            _isZoomingOut = false;
            _isZoomedIn = false;
            _updateCursor();
        }
        function onStartZoomDrag() {
            _isDragging = true;
            _updateCursor();
        }
        function onFinishZoomDrag() {
            _isDragging = false;
            _updateCursor();
        }
        function onZoomStageOver() {
            _isOverZoomStage = true;
            _updateCursor();
        }
        function onZoomStageOut() {
            _isOverZoomStage = false;
            _updateCursor();
        }
        function onMouseMove() {
            _clip._x = _clip._parent._xmouse;
            _clip._y = _clip._parent._ymouse;
            if (_clip._visible) {
                updateAfterEvent();
            }
        }
        function _updateCursor() {
            if (_useCustomCursors) {
                if (_isZoomingIn || (_isZoomingOut)) {
                    _showCursor(WAIT_POINTER);
                } else if (_isDragging) {
                    _showCursor(HOLD_POINTER);
                } else if ((!_isZoomedIn) && (_isOverBook)) {
                    _showCursor(HAND_POINTER);
                } else if ((_isZoomedIn && (_isOverZoomStage)) && (_isOverBook)) {
                    _showCursor(HAND_POINTER);
                } else {
                    _showCursor(SYSTEM_POINTER);
                }
            }
        }
        function _showCursor(pointerId) {
            switch (pointerId) {
                case HAND_POINTER : 
                    _clip.attachMovie(pointerId, "pointer", 0);
                    _clip._visible = true;
                    Mouse.hide();
                    break;
                case HOLD_POINTER : 
                    _clip.attachMovie(pointerId, "pointer", 0);
                    _clip._visible = true;
                    Mouse.hide();
                    break;
                case WAIT_POINTER : 
                    _clip.attachMovie(pointerId, "pointer", 0);
                    _clip._visible = true;
                    Mouse.hide();
                    break;
                case SYSTEM_POINTER : 
                    _clip.pointer.removeMovieClip();
                    _clip._visible = false;
                    Mouse.show();
                    break;
            }
        }
        var _useCustomCursors = true;
        var _isOverBook = false;
        var _isZoomingIn = false;
        var _isZoomingOut = false;
        var _isDragging = false;
        var _isZoomedIn = false;
        var _isOverZoomStage = false;
        var HOLD_POINTER = "fb.zoomAndDrag.HoldCursor";
        var HAND_POINTER = "fb.zoomAndDrag.HandCursor";
        var WAIT_POINTER = "fb.zoomAndDrag.HourGlassCursor";
        var SYSTEM_POINTER = "default";
    }
