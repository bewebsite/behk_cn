
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.DownloadManager
    {
        var _clip, _fileReference, _titleText, _title, _selection, _preloader, _complete, _downloadURL, _size, _sizeText, _background, _icon, _closeButton, _horizontalDivider, _cancelButton;
        function DownloadManager (parentClip) {
            _clip = parentClip;
            _create();
            _subscribeToStageEvents();
            _clip._visible = false;
            _fileReference = new flash.net.FileReference();
            _fileReference.addListener(this);
        }
        function download() {
            if (enabled) {
                _titleText.__set__text(_title);
                _wasDownloaded = false;
                _selection.__get__clip().useHandCursor = true;
                openWindow();
            }
        }
        function openWindow() {
            _animateOpening();
        }
        function closeWindow() {
            _opened = false;
            _expanded = false;
            _wasDownloaded = false;
            _fileReference.cancel();
            _preloader.setProgress(0);
            _clip._visible = false;
            _selection.__set__gradientToAlpha(0);
            _selection.__set__gradientFromAlpha(100);
            _selection.__set__opacity(0);
            _positionObjects();
        }
        function get downloadComplete() {
            return(_complete);
        }
        function set downloadComplete(newCompleteMsg) {
            _complete = newCompleteMsg;
            //return(downloadComplete);
        }
        function get enabled() {
            return(_downloadURL != undefined);
        }
        function get downloadURL() {
            return(_downloadURL);
        }
        function set downloadURL(newURL) {
            _downloadURL = newURL;
            //return(downloadURL);
        }
        function get downloadTitle() {
            return(_title);
        }
        function set downloadTitle(newTitle) {
            _title = newTitle;
            _titleText.__set__text(_title);
            _positionObjects();
            //return(downloadTitle);
        }
        function get downloadSize() {
            return(_size);
        }
        function set downloadSize(newSize) {
            _size = newSize;
            _sizeText.__set__text(_size);
            _positionObjects();
            //return(downloadSize);
        }
        function _subscribeToStageEvents() {
            Stage.addListener(this);
            this.onResize();
        }
        function onResize() {
            _positionObjects();
        }
        function _create() {
            _createBackground();
            _createSelection();
            _createIcon();
            _createTitleText();
            _createSizeText();
            _createCloseButton();
            _createPreloader();
            _createHorizontalDivider();
            _createCancelButton();
        }
        function _createBackground() {
            var _local2 = _clip.createEmptyMovieClip("background", _clip.getNextHighestDepth());
            _background = new com.fb.graphics.StyleableRectangle(_local2, 0, 0, _width, _height);
            _background.__set__fill(90);
            _background.__set__strokeColor(0);
            _background.__set__strokePosition("outer");
            _background.__set__strokeSize(2);
            _background.__set__cornerRadius(4);
        }
        function _createSelection() {
            var _local5 = _clip.createEmptyMovieClip("selection", _clip.getNextHighestDepth());
            _selection = new com.fb.graphics.StyleableShape(_local5);
            var _local2 = 180;
            var _local4 = 51;
            var _local3 = 24;
            _selection.addPoint(0, 0);
            _selection.addPoint(_local2 - _local3, 0);
            _selection.addPoint(_local2 - _local3, _local3);
            _selection.addPoint(_local2, _local3);
            _selection.addPoint(_local2, _local4, 0);
            _selection.addPoint(0, _local4, 0);
            _selection.draw();
            _selection.__set__fill(15);
            _selection.__set__color(16777215);
            _selection.__set__innerShadowColor(16777215);
            _selection.__set__innerShadowDistance(1);
            _selection.__set__innerShadowSize(0);
            _selection.__set__innerShadowOpacity(20);
            _selection.__set__gradientFromColor(16777215);
            _selection.__set__gradientToColor(16777215);
            _selection.__set__gradientToAlpha(0);
            _selection.__set__gradientOpacity(20);
            _selection.__set__gradientScale(100);
            _selection.__set__cornerRadius(4);
            _selection.__get__clip().onRollOver = mx.utils.Delegate.create(this, onSelectionRollOver);
            _selection.__get__clip().onRollOut = mx.utils.Delegate.create(this, onSelectionRollOut);
            _selection.__get__clip().onPress = mx.utils.Delegate.create(this, onSelectionPress);
            _selection.__get__clip().onRelease = mx.utils.Delegate.create(this, onSelectionRelease);
            _selection.__get__clip().onReleaseOutside = mx.utils.Delegate.create(this, onSelectionReleaseOutside);
            _selection.__set__opacity(0);
        }
        function _createIcon() {
            var _local2 = _clip.createEmptyMovieClip("icon", _clip.getNextHighestDepth());
            _icon = new com.fb.Utils.Icon("downloadHintIcon", _local2);
        }
        function _createTitleText() {
            var _local2 = _clip.createEmptyMovieClip("titleText", _clip.getNextHighestDepth());
            _titleText = new com.fb.graphics.StyleableLabel(_local2, 0, 0, _width, _height);
            _titleText.__set__fontName("Arial");
            _titleText.__set__fontSize(12);
            _titleText.__set__autoSize(true);
            _titleText.__set__text("");
            _titleText.__set__color(16777215);
            _titleText.__set__bold(true);
        }
        function _createSizeText() {
            var _local2 = _clip.createEmptyMovieClip("sizeText", _clip.getNextHighestDepth());
            _sizeText = new com.fb.graphics.StyleableLabel(_local2, 0, 0, _width, _height);
            _sizeText.__set__fontName("Arial");
            _sizeText.__set__fontSize(11);
            _sizeText.__set__autoSize(true);
            _sizeText.__set__text("");
            _sizeText.__set__color(10658466);
        }
        function _createCloseButton() {
            var _local2 = _clip.createEmptyMovieClip("close", _clip.getNextHighestDepth());
            _closeButton = new com.fb.Utils.IconButton("closeIcon", _local2);
            _closeButton.setSize(24, 24);
            _closeButton.addEventListener("onRelease", mx.utils.Delegate.create(this, onCloseButtonRelease));
        }
        function _createPreloader() {
            _preloader = _clip.attachMovie("PrintPreloaderClip", "preloader", _clip.getNextHighestDepth());
            _preloader.animate = true;
        }
        function _createHorizontalDivider() {
            _horizontalDivider = _clip.attachMovie("horDivIcon", "divider", _clip.getNextHighestDepth());
            _horizontalDivider._alpha = 80;
            _horizontalDivider._width = _width;
        }
        function _createCancelButton() {
            var _local2 = _clip.createEmptyMovieClip("cancel", _clip.getNextHighestDepth());
            _cancelButton = new com.fb.Utils.IconButton("cancelIcon", _local2);
            _cancelButton.setSize(13, 13);
            _cancelButton.__set__normalFill(50);
            _cancelButton.addEventListener("onRelease", mx.utils.Delegate.create(this, onCancelButtonRelease));
        }
        function _positionObjects() {
            _clip._x = Math.round((Stage.width / 2) - (_width / 2));
            _clip._y = Math.round((Stage.height / 2) - (_height / 2));
            _icon.__set__x(12);
            _icon.__set__y(10);
            _titleText.__set__x((_icon.__get__x() + _icon.__get__width()) + 10);
            _titleText.__set__y(_icon.y);
            _sizeText.__set__x(_titleText.x);
            _sizeText.__set__y(_titleText.__get__y() + 12);
            _horizontalDivider._x = 0;
            _horizontalDivider._y = 48;
            _preloader._y = 61;
            _preloader._x = 12;
            _cancelButton.__set__x(_preloader._x + 150);
            _cancelButton.__set__y(_preloader._y);
            _closeButton.__set__x(_width - _closeButton.__get__width());
            _closeButton.__set__y(0);
            if (!_expanded) {
                _horizontalDivider._alpha = 0;
                _preloader._alpha = 0;
                _cancelButton.__set__alpha(0);
                _background.__set__height(_collapsedHeight);
            } else {
                _horizontalDivider._alpha = 100;
                _preloader._alpha = 100;
                _cancelButton.__set__alpha(100);
                _background.__set__height(_expandedHeight);
            }
        }
        function onCloseButtonRelease() {
            _smoothCloseWindow();
        }
        function _smoothCloseWindow() {
            if (!_expanded) {
                _animateClosing();
            } else {
                _cancelDownload();
                _animateClosing(600);
            }
        }
        function onCancelButtonRelease() {
            _cancelDownload();
        }
        function _cancelDownload() {
            _fileReference.cancel();
            _animateCollapsing();
        }
        function onSelectionRollOver() {
            if (_expanded || (_wasDownloaded)) {
                return(undefined);
            }
            _selection.opacityTo(100, 200);
        }
        function onSelectionRollOut() {
            if (_expanded || (_wasDownloaded)) {
                return(undefined);
            }
            _selection.opacityTo(0, 200);
        }
        function onSelectionPress() {
            if (_expanded || (_wasDownloaded)) {
                return(undefined);
            }
            _selection.gradientToAlphaTo(100, 100);
            _selection.gradientFromAlphaTo(0, 100);
            _fileReference.download(_downloadURL);
        }
        function onSelectionRelease() {
            if (_expanded || (_wasDownloaded)) {
                return(undefined);
            }
            _selection.gradientToAlphaTo(0, 100);
            _selection.gradientFromAlphaTo(100, 100);
            _animateExpanding();
        }
        function onSelectionReleaseOutside() {
            if (_expanded || (_wasDownloaded)) {
                return(undefined);
            }
            _selection.gradientToAlphaTo(0, 100);
            _selection.gradientFromAlphaTo(100, 100);
            _selection.opacityTo(0, 200, 150);
        }
        function _animateOpening() {
            _clip._visible = true;
            _clip._alpha = 0;
            var _local2 = new com.timwalling.TweenDelay(_clip, "_alpha", mx.transitions.easing.Regular.easeInOut, 0, 100, 0.2, 0, true);
            _local2.onMotionFinished = mx.utils.Delegate.create(this, onOpenMotionFinished);
        }
        function onOpenMotionFinished() {
            _clip._visible = true;
            _opened = true;
        }
        function _animateClosing(msec_delay) {
            if (msec_delay == undefined) {
                msec_delay = 0;
            }
            _clip._visible = true;
            _clip._alpha = 100;
            var _local2 = new com.timwalling.TweenDelay(_clip, "_alpha", mx.transitions.easing.Regular.easeInOut, 100, 0, 0.2, msec_delay / 1000, true);
            _local2.onMotionFinished = mx.utils.Delegate.create(this, onCloseMotionFinished);
        }
        function onCloseMotionFinished() {
            _clip._visible = false;
            _opened = false;
        }
        function _animateExpanding() {
            _expanded = true;
            _background.heightTo(_expandedHeight, 200);
            _horizontalDivider._alpha = 0;
            new com.timwalling.TweenDelay(_horizontalDivider, "_alpha", mx.transitions.easing.Regular.easeInOut, 0, 80, 0.1, 0.1, true);
            _preloader._alpha = 0;
            new com.timwalling.TweenDelay(_preloader, "_alpha", mx.transitions.easing.Regular.easeInOut, 0, 100, 0.1, 0.3, true);
            _cancelButton.__set__alpha(0);
            var _local2 = new com.timwalling.TweenDelay(_cancelButton, "alpha", mx.transitions.easing.Regular.easeInOut, 0, 100, 0.3, 0.4, true);
            _local2.onMotionFinished = mx.utils.Delegate.create(this, onExpandMotionFinished);
        }
        function onExpandMotionFinished() {
            _preloader.animate = true;
        }
        function _animateCollapsing() {
            _expanded = false;
            _cancelButton.__set__alpha(100);
            new com.timwalling.TweenDelay(_cancelButton, "alpha", mx.transitions.easing.Regular.easeInOut, 100, 0, 0.1, 0, true);
            _preloader.animate = false;
            _preloader.progressTo(0, 200);
            new com.timwalling.TweenDelay(_preloader, "_alpha", mx.transitions.easing.Regular.easeInOut, 100, 0, 0.1, 0.2, true);
            _horizontalDivider._alpha = 80;
            new com.timwalling.TweenDelay(_horizontalDivider, "_alpha", mx.transitions.easing.Regular.easeInOut, 80, 0, 0.1, 0.3, true);
            _background.heightTo(_collapsedHeight, 200, 400);
            _selection.opacityTo(0, 200, 500);
        }
        function onProgress(fileRef, bytesLoaded, bytesTotal) {
            var _local2 = Math.round((100 * bytesLoaded) / bytesTotal);
            _preloader.progressTo(_local2, 100);
        }
        function onComplete(fileRef) {
            _animateCollapsing();
            _wasDownloaded = true;
            _selection.__get__clip().useHandCursor = false;
            _titleText.__set__text(_complete);
        }
        function onCancel(fileRef) {
            _animateCollapsing();
        }
        var _opened = false;
        var _expanded = false;
        var _wasDownloaded = false;
        var _width = 180;
        var _height = 80;
        var _expandedHeight = 80;
        var _collapsedHeight = 50;
    }
