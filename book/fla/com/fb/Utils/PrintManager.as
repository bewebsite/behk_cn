
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.PrintManager
    {
        var _book, _zoomer, _clip, _scheduler, _preloaderCollapseScheduler, _title, _preloader, _printer, _cancelButton, _horizontalDivider, _background, _menu, _closeButton;
        function PrintManager (bookInstance, zoomerInstance, parentClip) {
            _book = bookInstance;
            _zoomer = zoomerInstance;
            _clip = parentClip;
            _create();
            _subscribeToStageEvents();
            _subscribeToBookEvents();
            _scheduler = new com.fb.Utils.FunctionScheduler();
            _preloaderCollapseScheduler = new com.fb.Utils.FunctionScheduler();
            _clip._visible = false;
        }
        function get alpha() {
            return(_clip._alpha);
        }
        function set alpha(newAlpha) {
            _clip._alpha = newAlpha;
            _clip._visible = newAlpha != 0;
            //return(alpha);
        }
        function get enabled() {
            return(_enabled);
        }
        function set enabled(isEnabled) {
            _enabled = isEnabled;
            if (!_enabled) {
                _closeWindow();
            }
            //return(enabled);
        }
        function get title() {
            return(_titleText);
        }
        function set title(newTitle) {
            _titleText = newTitle;
            _title.__set__text(_titleText);
            //return(title);
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
        function print() {
            if (_enabled) {
                _clip._visible = true;
                _smoothShowWindow();
            }
        }
        function closeWindow() {
            _preloader.progress = 0;
            _printer.cancel();
            _preloader.animate = false;
            _cancelButton.__set__alpha(0);
            _preloader._alpha = 0;
            _horizontalDivider._alpha = 0;
            _background.__set__height(80);
            _menu.__set__freeze(false);
            _clip._visible = false;
        }
        function _subscribeToStageEvents() {
            Stage.addListener(this);
            this.onResize();
        }
        function _subscribeToBookEvents() {
            _book.addEventListener("onPutPage", mx.utils.Delegate.create(this, onBookPutPage));
        }
        function onResize() {
            _positionObjects();
        }
        function _create() {
            _createBackground();
            _createTitle();
            _createCloseButton();
            _createPagesMenu();
            _createPrintUtility();
            _createPreloader();
            _createHorizontalDivider();
            _createCancelButton();
        }
        function _createBackground() {
            var _local2 = _clip.createEmptyMovieClip("background", _clip.getNextHighestDepth());
            _background = new com.fb.graphics.StyleableRectangle(_local2, 0, 0, _width, _height);
            _background.__set__fill(80);
            _background.__set__strokeColor(0);
            _background.__set__strokePosition("outer");
            _background.__set__strokeSize(2);
            _background.__set__cornerRadius(4);
        }
        function _createTitle() {
            var _local2 = _clip.createEmptyMovieClip("title", _clip.getNextHighestDepth());
            _title = new com.fb.graphics.StyleableLabel(_local2, 0, 0, _width, _height);
            _title.__set__fontName("Arial");
            _title.__set__fontSize(12);
            _title.__set__autoSize(true);
            _title.__set__text("");
            _title.__set__color(16777215);
            _title.__set__bold(true);
        }
        function _createCloseButton() {
            var _local2 = _clip.createEmptyMovieClip("close", _clip.getNextHighestDepth());
            _closeButton = new com.fb.Utils.IconButton("closeIcon", _local2);
            _closeButton.setSize(24, 22);
            _closeButton.addEventListener("onRelease", mx.utils.Delegate.create(this, onCloseButtonRelease));
        }
        function _createPagesMenu() {
            var _local2 = _clip.createEmptyMovieClip("menu", _clip.getNextHighestDepth());
            _menu = new com.fb.Utils.PrintPagesMenu(_local2);
            _menu.setSize(180, 40);
            _menu.__set__x(0);
            _menu.__set__y(36);
            _menu.addEventListener("onButtonRelease", mx.utils.Delegate.create(this, onMenuButtonRelease));
            _updatePagesMenu();
        }
        function _createPrintUtility() {
            _printer = new com.fb.Utils.PrintUtility();
            _printer.addEventListener("onLoadProgress", mx.utils.Delegate.create(this, _onLoadProgress));
            _printer.addEventListener("onPrintStart", mx.utils.Delegate.create(this, _onPrintStarted));
            _printer.addEventListener("onCancelledByUser", mx.utils.Delegate.create(this, _onPrintCanceledByUser));
        }
        function _createPreloader() {
            _preloader = _clip.attachMovie("PrintPreloaderClip", "preloader", _clip.getNextHighestDepth());
            _preloader._y = 81;
            _preloader._x = _horizontalPadding;
            _preloader._alpha = 0;
        }
        function _createHorizontalDivider() {
            _horizontalDivider = _clip.attachMovie("horDivIcon", "divider", _clip.getNextHighestDepth());
            _horizontalDivider._x = 0;
            _horizontalDivider._y = 70;
            _horizontalDivider._alpha = 80;
            _horizontalDivider._width = _width;
        }
        function _createCancelButton() {
            var _local2 = _clip.createEmptyMovieClip("cancel", _clip.getNextHighestDepth());
            _cancelButton = new com.fb.Utils.IconButton("cancelIcon", _local2);
            _cancelButton.setSize(13, 13);
            _cancelButton.__set__normalFill(50);
            _cancelButton.__set__x((_preloader._x + 140) + 7);
            _cancelButton.__set__y(_preloader._y);
            _cancelButton.addEventListener("onRelease", mx.utils.Delegate.create(this, onCancelButtonRelease));
            _cancelButton.__set__alpha(0);
        }
        function _positionObjects() {
            x = (Math.round((Stage.width / 2) - (_width / 2)));
            y = (Math.round((Stage.height / 2) - (_height / 2)));
            _title.__set__x(5);
            _title.__set__y(4);
            _closeButton.__set__x(_width - _closeButton.__get__width());
            _closeButton.__set__y(0);
            _menu.__set__x(0);
            _menu.__set__y(29);
            _preloader._y = 81;
            _preloader._x = _horizontalPadding;
            _horizontalDivider._x = 0;
            _horizontalDivider._y = 70;
            _horizontalDivider._width = _width;
            _horizontalDivider._alpha = 0;
        }
        function onCloseButtonRelease() {
            _closeWindow();
        }
        function onCancelButtonRelease() {
            _cancelPrinting();
        }
        function onBookPutPage() {
            _updatePagesMenu();
        }
        function _updatePagesMenu() {
            var _local3 = _book.__get__leftPageNumber() != undefined;
            var _local2 = _book.__get__rightPageNumber() != undefined;
            if (_local3) {
                _menu.__set__leftPageEnabled(true);
            } else {
                _menu.__set__leftPageEnabled(false);
            }
            if (_local2) {
                _menu.__set__rightPageEnabled(true);
            } else {
                _menu.__set__rightPageEnabled(false);
            }
        }
        function onMenuButtonRelease(eventObject) {
            var _local2 = "";
            switch (eventObject["selection"]) {
                case "left" : 
                    _local2 = String(_book.__get__leftPageNumber());
                    _constructPrintURL(_book.__get__leftPageNumber());
                    break;
                case "right" : 
                    _local2 = String(_book.__get__rightPageNumber());
                    _constructPrintURL(_book.__get__rightPageNumber());
                    break;
                case "both" : 
                    _local2 = (_book.__get__leftPageNumber() + ",") + _book.__get__rightPageNumber();
                    _constructPrintURL(_book.__get__leftPageNumber());
                    _constructPrintURL(_book.__get__rightPageNumber());
                    break;
            }
            _scheduler.reset();
            _scheduler.add(this, "_freezeMenu", 0);
            _scheduler.add(this, "_expandPreloaderArea", 250);
            _scheduler.add(this, "_showPreloaderItems", 250);
            _scheduler.add(this, "_startPreloader", 250);
            _scheduler.add(_printer, "print", 0, _local2, _book.__get__componentClip());
            _scheduler.start();
            _preloaderExpanded = true;
        }
        function _constructPrintURL(pageNumber) {
            var _local3 = _zoomer.getLargePageURL(pageNumber);
            if ((_root.printPagesSet[0] != "") && (_root.printPagesSet[0] != undefined)) {
                _local3 = _root.printPagesSet[pageNumber - 1];
            }
            _book.getPageLink(pageNumber).params.print = _local3;
        }
        function _onPrintStarted() {
            _closeWindow();
        }
        function _onLoadProgress(eventObject) {
            if (_preloaderExpanded) {
                var _local2 = Math.round((100 * eventObject.loaded) / eventObject.total);
                _preloader.progressTo(_local2, 100);
            }
        }
        function _onPrintCanceledByUser() {
            _closeWindow();
        }
        function _closeWindow() {
            _scheduler.reset();
            if (_preloaderExpanded) {
                _scheduler.add(this, "_cancelPrinting", 550);
            }
            _scheduler.add(this, "_smoothHideWindow", 200);
            _scheduler.start();
        }
        function _expandPreloaderArea() {
            _background.heightTo(100, 200, 0);
        }
        function _collapsePreloaderArea() {
            _background.heightTo(80, 250, 0);
        }
        function _showPreloaderItems() {
            var _local2 = 200;
            _horizontalDivider._alpha = 0;
            new com.timwalling.TweenDelay(_horizontalDivider, "_alpha", mx.transitions.easing.Regular.easeInOut, _horizontalDivider._alpha, 100, _local2 / 1000, 0, true);
            _preloader._alpha = 0;
            new com.timwalling.TweenDelay(_preloader, "_alpha", mx.transitions.easing.Regular.easeInOut, _preloader._alpha, 100, _local2 / 1000, 0.1, true);
            _cancelButton.__set__alpha(0);
            _cancelButton.alphaTo(100, _local2, 100);
        }
        function _hidePreloaderItems() {
            var _local2 = 200;
            _cancelButton.__set__alpha(100);
            _cancelButton.alphaTo(0, _local2, 0);
            _preloader._alpha = 100;
            new com.timwalling.TweenDelay(_preloader, "_alpha", mx.transitions.easing.Regular.easeInOut, _preloader._alpha, 0, _local2 / 1000, 0, true);
            _horizontalDivider._alpha = 80;
            new com.timwalling.TweenDelay(_horizontalDivider, "_alpha", mx.transitions.easing.Regular.easeInOut, _horizontalDivider._alpha, 0, _local2 / 1000, 0.1, true);
        }
        function _startPreloader() {
            _preloader.animate = true;
        }
        function _stopPreloader() {
            _preloader.animate = false;
        }
        function _freezeMenu() {
            _menu.__set__freeze(true);
        }
        function _restoreMenu() {
            _menu.__set__freeze(false);
        }
        function _cancelLoading() {
            if (_preloader.progress > 0) {
                _preloader.progressTo(0, 200);
            }
            _printer.cancel();
        }
        function _cancelPrinting() {
            _preloaderCollapseScheduler.reset();
            _preloaderCollapseScheduler.add(this, "_cancelLoading", 0);
            _preloaderCollapseScheduler.add(this, "_stopPreloader", 100);
            _preloaderCollapseScheduler.add(this, "_hidePreloaderItems", 200);
            _preloaderCollapseScheduler.add(this, "_collapsePreloaderArea", 250);
            _preloaderCollapseScheduler.add(this, "_restoreMenu", 0);
            _preloaderCollapseScheduler.start();
            _preloaderExpanded = false;
        }
        function _smoothHideWindow() {
            alpha = (100);
            new com.timwalling.TweenDelay(this, "alpha", mx.transitions.easing.Regular.easeInOut, alpha, 0, 0.2, 0, true);
        }
        function _smoothShowWindow() {
            alpha = (0);
            new com.timwalling.TweenDelay(this, "alpha", mx.transitions.easing.Regular.easeInOut, alpha, 100, 0.2, 0, true);
        }
        var _titleText = "Print";
        var _enabled = true;
        var _width = 180;
        var _height = 80;
        var _horizontalPadding = 10;
        var _preloaderExpanded = false;
    }
