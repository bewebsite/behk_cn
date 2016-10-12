
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.SWFObject
    {
        var _clip, _functionQueue, _book, _zoomer, _printer, _downloader, _zoomHintManager, _bookCenterer, _cursorManager, _dropShadowManager, _background, _zoomHint, _copyButton;
        function SWFObject (parentClip) {
            _clip = parentClip;
            _functionQueue = new Array();
            _configureStage();
            _create();
        }
        function flipForward() {
            _book.flipForward();
        }
        function flipBack() {
            _book.flipBack();
        }
        function flipGotoPage(pageNumber) {
            _book.flipGotoPage(pageNumber);
        }
        function zoomIn() {
            var _local2 = _getClickShift();
            _zoomer.zoomIn(_local2.dx, _local2.dy);
        }
        function zoomOut() {
            _zoomer.zoomOut();
        }
        function get zoomedIn() {
            return(_zoomer.__get__zoomedIn());
        }
        function get totalPages() {
            return(_book.__get__totalPages());
        }
        function print() {
            _closeAllWindows();
            _printer.print();
        }
        function download() {
            _closeAllWindows();
            _downloader.download();
        }
        function onWheelScroll(delta) {
            _zoomer.onWheelScroll(delta);
            _flipBookByWheel(delta);
        }
        function _closeAllWindows() {
            if (_printer.__get__enabled()) {
                _printer.closeWindow();
            }
            if (_downloader.__get__enabled()) {
                _downloader.closeWindow();
            }
            _zoomHintManager.closeByWindow();
        }
        function _configureStage() {
            Stage.scaleMode = "noScale";
            Stage.align = "TL";
            Stage.addListener(this);
        }
        function _create() {
            _createEnterFrameClip();
            _createBackground();
            _createBook();
            _createCenterer();
            _createZoomer();
            _createCursorManager();
            _createDropShadowManager();
            _createPrintManager();
            _createDownloadManager();
            _createZoomHint();
            _createCopyrightButton();
            _positionObjects();
        }
        function _createEnterFrameClip() {
        }
        function onEnterFrame() {
            while (_functionQueue.length > 0) {
                var _local2 = _functionQueue.pop();
                switch (_local2.functionName) {
                    case "zoomIn" : 
                        _zoomer.zoomIn(_local2.dx, _local2.dy);
                        break;
                    case "zoomOut" : 
                        _zoomer.zoomOut();
                        break;
                }
            }
        }
        function _createBook() {
            var _local2 = _clip.createEmptyMovieClip("book", _clip.getNextHighestDepth());
            _book = new com.fb.Utils.BookWrapper(_local2);
            _processBookJSSettings();
            _subscribeToBookEvents();
            _book.create();
        }
        function _createZoomer() {
            var _local2 = _clip.createEmptyMovieClip("zoomer", _clip.getNextHighestDepth());
            _zoomer = new com.fb.Utils.BookZoomer(_book, _local2);
            _processZoomJSSettings();
        }
        function _createCenterer() {
            _bookCenterer = new com.fb.Utils.BookCenterer(_book);
            _bookCenterer.addEventListener("bookPositionChanged", mx.utils.Delegate.create(this, _onBookPositionChanged));
            _processCentererJSSettings();
        }
        function _createCursorManager() {
            var _local2 = _clip.createEmptyMovieClip("cursor", _clip.getNextHighestDepth());
            _cursorManager = new com.fb.Utils.CursorManager(_book, _zoomer, _local2);
            _processCursorsJSSettings();
        }
        function _createDropShadowManager() {
            _dropShadowManager = new com.fb.Utils.DropShadowManager(_book, _zoomer);
            _processDropShadowJSSettings();
        }
        function _createBackground() {
            var _local2 = _clip.createEmptyMovieClip("background", _clip.getNextHighestDepth());
            _background = new com.fb.Utils.BookBackground(_local2);
            _processBackgroundJSSettings();
        }
        function _createPrintManager() {
            var _local2 = _clip.createEmptyMovieClip("printer", _clip.getNextHighestDepth());
            _printer = new com.fb.Utils.PrintManager(_book, _zoomer, _local2);
            _processPrintJSSettings();
        }
        function _createDownloadManager() {
            var _local2 = _clip.createEmptyMovieClip("downloader", _clip.getNextHighestDepth());
            _downloader = new com.fb.Utils.DownloadManager(_local2);
            _processDownloadJSSettings();
        }
        function _createZoomHint() {
            if (!_root.zoomOnClick) {
                return(undefined);
            }
            var _local3 = _clip.createEmptyMovieClip("zoomHint", _clip.getNextHighestDepth());
            _zoomHint = new com.fb.Utils.HintWindow(_local3, "zoomHintIcon", _book);
            _zoomHint.setSize(140, 50);
            _processZoomHintJSSettings();
            _zoomHintManager = new com.fb.Utils.ZoomHintManager(_zoomHint, _book, _zoomer, _bookCenterer, _root.zoomHintEnabled);
        }
        function _createCopyrightButton() {
            if (_root.showCopyrightPanel) {
                _copyButton = new com.fb.Utils.CopyrightButton();
            }
        }
        function onResize() {
            _positionObjects();
        }
        function _positionObjects() {
            var _local2 = _bookCenterer.getCenterPosition();
            if (!_zoomer.__get__zoomedIn()) {
                _book.__set__x(_local2.x);
                _book.__set__y(_local2.y);
            }
            _zoomer.__set__originalBookX(_local2.x);
            _zoomer.__set__originalBookY(_local2.y);
        }
        function _processBookJSSettings() {
            if (_root.pagesSet != undefined) {
                var _local3 = 0;
                while (_local3 < _root.pagesSet.length) {
                    _book.addPage(_root.pagesSet[_local3]);
                    _local3++;
                }
            }
            if (_root.extXML != undefined) {
                _book.__set__extXML(_root.extXML);
            }
            if (_root.bookWidth != undefined) {
                _book.__set__width(_root.bookWidth);
            }
            if (_root.bookHeight != undefined) {
                _book.__set__height(_root.bookHeight);
            }
            if (_root.scaleContent != undefined) {
                _book.__set__scaleContent(_root.scaleContent);
            }
            if (_root.preserveProportions != undefined) {
                _book.__set__preserveProportions(_root.preserveProportions);
            }
            if (_root.centerContent != undefined) {
                _book.__set__centerContent(_root.centerContent);
            }
            if (_root.hardcover != undefined) {
                _book.__set__hardcover(_root.hardcover);
            }
            if (_root.hardcoverThickness != undefined) {
                _book.__set__hardcoverThickness(_root.hardcoverThickness);
            }
            if (_root.hardcoverEdgeColor != undefined) {
                _book.__set__hardcoverEdgeColor(_root.hardcoverEdgeColor);
            }
            if (_root.highlightHardcover != undefined) {
                _book.__set__highlightHardcover(_root.highlightHardcover);
            }
            if (_root.frameWidth != undefined) {
                _book.__set__frameWidth(_root.frameWidth);
            }
            if (_root.frameColor != undefined) {
                _book.__set__frameColor(_root.frameColor);
            }
            if (_root.frameAlpha != undefined) {
                _book.__set__frameAlpha(_root.frameAlpha);
            }
            if (_root.firstPageNumber != undefined) {
                _book.__set__firstPageNumber(_root.firstPageNumber);
            }
            if (_root.autoFlipSize != undefined) {
                _book.__set__autoFlipSize(_root.autoFlipSize);
            }
            if (_root.navigationFlipOffset != undefined) {
                _book.__set__navigationFlipOffset(_root.navigationFlipOffset);
            }
            if (_root.alwaysOpened != undefined) {
                _book.__set__alwaysOpened(_root.alwaysOpened);
            }
            if (_root.flipOnClick != undefined) {
                _book.__set__flipOnClick(_root.flipOnClick);
            }
            if (_root.handOverCorner != undefined) {
                _book.__set__handOverCorner(_root.handOverCorner);
            }
            if (_root.handOverPage != undefined) {
                _book.__set__handOverPage(_root.handOverPage);
            }
            if (_root.staticShadowsType != undefined) {
                _book.__set__staticShadowsType(_root.staticShadowsType);
            }
            if (_root.staticShadowsDepth != undefined) {
                _book.__set__staticShadowsDepth(_root.staticShadowsDepth);
            }
            if (_root.staticShadowsLightColor != undefined) {
                _book.__set__staticShadowsLightColor(_root.staticShadowsLightColor);
            }
            if (_root.staticShadowsDarkColor != undefined) {
                _book.__set__staticShadowsDarkColor(_root.staticShadowsDarkColor);
            }
            if (_root.dynamicShadowsDepth != undefined) {
                _book.__set__dynamicShadowsDepth(_root.dynamicShadowsDepth);
            }
            if (_root.dynamicShadowsLightColor != undefined) {
                _book.__set__dynamicShadowsLightColor(_root.dynamicShadowsLightColor);
            }
            if (_root.dynamicShadowsDarkColor != undefined) {
                _book.__set__dynamicShadowsDarkColor(_root.dynamicShadowsDarkColor);
            }
            if (_root.moveSpeed != undefined) {
                _book.__set__moveSpeed(_root.moveSpeed);
            }
            if (_root.closeSpeed != undefined) {
                _book.__set__closeSpeed(_root.closeSpeed);
            }
            if (_root.gotoSpeed != undefined) {
                _book.__set__gotoSpeed(_root.gotoSpeed);
            }
            if (_root.rigidPageSpeed != undefined) {
                _book.__set__rigidPageSpeed(_root.rigidPageSpeed);
            }
            if (_root.flipSound != undefined) {
                _book.__set__flipSound(_root.flipSound);
            }
            if (_root.hardcoverSound != undefined) {
                _book.__set__hardcoverSound(_root.hardcoverSound);
            }
            if (_root.preloaderType != undefined) {
                _book.__set__preloaderType(_root.preloaderType);
            }
            if (_root.pageBackgroundColor != undefined) {
                _book.__set__pageBackgroundColor(_root.pageBackgroundColor);
            }
            if (_root.loadOnDemand != undefined) {
                _book.__set__loadOnDemand(_root.loadOnDemand);
            }
            if (_root.allowPagesUnload != undefined) {
                _book.__set__allowPagesUnload(_root.allowPagesUnload);
            }
            if (_root.showUnderlyingPages != undefined) {
                _book.__set__showUnderlyingPages(_root.showUnderlyingPages);
            }
            if (_root.playOnDemand != undefined) {
                _book.__set__playOnDemand(_root.playOnDemand);
            }
            if (_root.freezeOnFlip != undefined) {
                _book.__set__freezeOnFlip(_root.freezeOnFlip);
            }
            if (_root.darkPages != undefined) {
                _book.__set__darkPages(_root.darkPages);
            }
            if (_root.smoothPages != undefined) {
                _book.__set__smoothPages(_root.smoothPages);
            }
            if (_root.rigidPages != undefined) {
                _book.__set__rigidPages(_root.rigidPages);
            }
            if (_root.flipCornerStyle != undefined) {
                _book.__set__flipCornerStyle(_root.flipCornerStyle);
            }
            if (_root.flipCornerPosition != undefined) {
                _book.__set__flipCornerPosition(_root.flipCornerPosition);
            }
            if (_root.flipCornerAmount != undefined) {
                _book.__set__flipCornerAmount(_root.flipCornerAmount);
            }
            if (_root.flipCornerAngle != undefined) {
                _book.__set__flipCornerAngle(_root.flipCornerAngle);
            }
            if (_root.flipCornerRelease != undefined) {
                _book.__set__flipCornerRelease(_root.flipCornerRelease);
            }
            if (_root.flipCornerVibrate != undefined) {
                _book.__set__flipCornerVibrate(_root.flipCornerVibrate);
            }
            if (_root.flipCornerPlaySound != undefined) {
                _book.__set__flipCornerPlaySound(_root.flipCornerPlaySound);
            }
        }
        function _processZoomJSSettings() {
            if (_root.zoomEnabled != undefined) {
                _zoomer.__set__zoomEnabled(_root.zoomEnabled);
            }
            if (_root.zoomPath != undefined) {
                _zoomer.__set__zoomPath(_root.zoomPath);
            }
            if (_root.zoomImageWidth != undefined) {
                _zoomer.__set__zoomImageWidth(_root.zoomImageWidth);
            }
            if (_root.zoomImageHeight != undefined) {
                _zoomer.__set__zoomImageHeight(_root.zoomImageHeight);
            }
            if (_root.zoomOnClick != undefined) {
                _zoomer.__set__zoomOnClick(_root.zoomOnClick);
            }
            if (_root.zoomUIColor != undefined) {
                _zoomer.__set__zoomUIColor(_root.zoomUIColor);
            }
            _zoomer.__set__originalBookWidth(_book.width);
            _zoomer.__set__originalBookHeight(_book.height);
        }
        function _processCentererJSSettings() {
            if (_root.centerBook != undefined) {
                _bookCenterer.__set__centerBook(_root.centerBook);
            }
            _bookCenterer.__set__originalBookWidth(_book.width);
            _bookCenterer.__set__originalBookHeight(_book.height);
        }
        function _processCursorsJSSettings() {
            if (_root.useCustomCursors != undefined) {
                _cursorManager.__set__useCustomCursors(_root.useCustomCursors);
            }
        }
        function _processDropShadowJSSettings() {
            if (_root.dropShadowEnabled != undefined) {
                _dropShadowManager.__set__dropShadowEnabled(_root.dropShadowEnabled);
            }
            if (_root.dropShadowHideWhenFlipping != undefined) {
                _dropShadowManager.__set__dropShadowHideWhenFlipping(_root.dropShadowHideWhenFlipping);
            }
        }
        function _processBackgroundJSSettings() {
            if (_root.backgroundImage != undefined) {
                _background.__set__backgroundImage(_root.backgroundImage);
            }
            if (_root.backgroundImagePlacement != undefined) {
                _background.__set__backgroundImagePlacement(_root.backgroundImagePlacement);
            }
        }
        function _processPrintJSSettings() {
            if (_root.printTitle != undefined) {
                _printer.__set__title(_root.printTitle);
            }
            if (_root.printEnabled != undefined) {
                _printer.__set__enabled(_root.printEnabled);
            }
        }
        function _processDownloadJSSettings() {
            if ((_root.downloadURL != undefined) && (_root.downloadURL != "")) {
                _downloader.__set__downloadURL(_root.downloadURL);
            }
            if (_root.downloadTitle != undefined) {
                _downloader.__set__downloadTitle(_root.downloadTitle);
            }
            if (_root.downloadSize != undefined) {
                _downloader.__set__downloadSize(_root.downloadSize);
            }
            if (_root.downloadComplete != undefined) {
                _downloader.__set__downloadComplete(_root.downloadComplete);
            }
        }
        function _processZoomHintJSSettings() {
            if (_root.zoomHint != undefined) {
                _zoomHint.__set__text(_root.zoomHint);
            }
        }
        function _subscribeToBookEvents() {
            _book.addEventListener("onInit", mx.utils.Delegate.create(this, onBookInit));
            _book.addEventListener("onPutPage", mx.utils.Delegate.create(this, onBookPutPage));
        }
        function onBookInit(eventObject) {
            _positionObjects();
        }
        function onBookPutPage(eventObject) {
            _root.onPutPage(_book.__get__leftPageNumber(), _book.__get__rightPageNumber());
        }
        function _onBookPositionChanged(eventObject) {
            _zoomer.__set__originalBookX(_book.x);
            _zoomer.__set__originalBookY(_book.y);
        }
        function _getClickShift() {
            var _local3 = 0;
            var _local2 = 0;
            if (_bookCenterer.__get__centerBook() && (_book.__get__leftPageNumber() == undefined)) {
                _local3 = _book.__get__width() / 4;
            } else if (_bookCenterer.__get__centerBook() && (_book.__get__rightPageNumber() == undefined)) {
                _local3 = (-_book.__get__width()) / 4;
            }
            return({dx:_local3, dy:_local2});
        }
        function _flipBookByWheel(delta) {
            if (!_zoomer.__get__zoomedIn()) {
                if (delta > 0) {
                    _book.flipBack();
                } else {
                    _book.flipForward();
                }
            }
        }
    }
