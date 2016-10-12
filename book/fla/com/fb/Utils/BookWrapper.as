
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.BookWrapper
    {
        var _parentClip, _bookDepth, _bookName, _pagesSet, _book;
        function BookWrapper (parentClip) {
            _parentClip = parentClip;
            _bookDepth = _parentClip.getNextHighestDepth();
            _bookName = "Book" + _bookDepth;
            _pagesSet = new Array();
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function create() {
            _book = _parentClip.attachMovie(_bookSymbolId, _bookName, _bookDepth, _createInitObject());
            _subscribeToEvents();
        }
        function get componentClip() {
            return(MovieClip(_book));
        }
        function get clip() {
            return(_parentClip);
        }
        function get zoomedIn() {
            return(_zoomedIn);
        }
        function set zoomedIn(zoomed) {
            _zoomedIn = zoomed;
            //return(zoomedIn);
        }
        function get x() {
            _x = _parentClip._x;
            return(_x);
        }
        function set x(newX) {
            _x = newX;
            _parentClip._x = _x;
            //return(x);
        }
        function get y() {
            _y = _parentClip._y;
            return(_y);
        }
        function set y(newY) {
            _y = newY;
            _parentClip._y = _y;
            //return(y);
        }
        function get width() {
            return(_width);
        }
        function set width(newWidth) {
            _width = newWidth;
            if (_book != undefined) {
                _positionBook();
            }
            //return(width);
        }
        function get height() {
            return(_height);
        }
        function set height(newHeight) {
            _height = newHeight;
            if (_book != undefined) {
                _positionBook();
            }
            //return(height);
        }
        function setSize(newWidth, newHeight) {
            _width = newWidth;
            _height = newHeight;
            if (_book != undefined) {
                _positionBook();
            }
        }
        function get pagesSet() {
            return(_pagesSet);
        }
        function get extXML() {
            return(_extXML);
        }
        function set extXML(newURL) {
            _extXML = newURL;
            //return(extXML);
        }
        function get scaleContent() {
            return(_scaleContent);
        }
        function set scaleContent(scale) {
            _scaleContent = scale;
            if (_book != undefined) {
                _book.scaleContentProp = _scaleContent;
            }
            //return(scaleContent);
        }
        function get preserveProportions() {
            return(_preserveProportions);
        }
        function set preserveProportions(preserve) {
            _preserveProportions = preserve;
            if (_book != undefined) {
                _book.preserveProportionsProp = _preserveProportions;
            }
            //return(preserveProportions);
        }
        function get centerContent() {
            return(_centerContent);
        }
        function set centerContent(center) {
            _centerContent = center;
            if (_book != undefined) {
                _book.centerContentProp = _centerContent;
            }
            //return(centerContent);
        }
        function get hardcover() {
            return(_hardcover);
        }
        function set hardcover(enableHardcover) {
            _hardcover = enableHardcover;
            if (_book != undefined) {
                _book.hardcoverProp = _hardcover;
            }
            //return(hardcover);
        }
        function get hardcoverThickness() {
            return(_hardcoverThickness);
        }
        function set hardcoverThickness(thickness) {
            _hardcoverThickness = thickness;
            if (_book != undefined) {
                _book.hardcoverThicknessProp = _hardcoverThickness;
            }
            //return(hardcoverThickness);
        }
        function get hardcoverEdgeColor() {
            return(_hardcoverEdgeColor);
        }
        function set hardcoverEdgeColor(newColor) {
            _hardcoverEdgeColor = newColor;
            if (_book != undefined) {
                _book.hardcoverEdgeColorProp = _hardcoverEdgeColor;
            }
            //return(hardcoverEdgeColor);
        }
        function get highlightHardcover() {
            return(_highlightHardcover);
        }
        function set highlightHardcover(highlight) {
            _highlightHardcover = highlight;
            if (_book != undefined) {
                _book.highlightHardcoverProp = _highlightHardcover;
            }
            //return(highlightHardcover);
        }
        function get frameWidth() {
            return(_frameWidth);
        }
        function set frameWidth(newWidth) {
            _frameWidth = newWidth;
            if (_book != undefined) {
                _book.frameWidthProp = _frameWidth;
            }
            //return(frameWidth);
        }
        function get frameColor() {
            return(_frameColor);
        }
        function set frameColor(newColor) {
            _frameColor = newColor;
            if (_book != undefined) {
                _book.frameColorProp = _frameColor;
            }
            //return(frameColor);
        }
        function get frameAlpha() {
            return(_frameAlpha);
        }
        function set frameAlpha(newAlpha) {
            _frameAlpha = newAlpha;
            if (_book != undefined) {
                _book.frameAlphaProp = _frameAlpha;
            }
            //return(frameAlpha);
        }
        function get firstPageNumber() {
            return(_firstPage + 1);
        }
        function set firstPageNumber(newNumber) {
            _firstPage = newNumber - 1;
            if (_book != undefined) {
                _rebuildBook();
            }
            //return(firstPageNumber);
        }
        function get alwaysOpened() {
            return(_alwaysOpened);
        }
        function set alwaysOpened(opened) {
            _alwaysOpened = opened;
            if (_book != undefined) {
                _rebuildBook();
            }
            //return(alwaysOpened);
        }
        function get autoFlipSize() {
            return(_autoFlip);
        }
        function set autoFlipSize(newSize) {
            _autoFlip = newSize;
            if (_book != undefined) {
                _book.autoFlipProp = _autoFlip;
            }
            //return(autoFlipSize);
        }
        function get navigationFlipOffset() {
            return(_navigationFlipOffset);
        }
        function set navigationFlipOffset(newOffset) {
            _navigationFlipOffset = newOffset;
            if (_book != undefined) {
                _book.navigationFlipOffsetProp = _navigationFlipOffset;
            }
            //return(navigationFlipOffset);
        }
        function get flipOnClick() {
            return(_flipOnClick);
        }
        function set flipOnClick(flip) {
            _flipOnClick = flip;
            if (_book != undefined) {
                _book.flipOnClickProp = _flipOnClick;
            }
            //return(flipOnClick);
        }
        function get handOverCorner() {
            return(_handOverCorner);
        }
        function set handOverCorner(showHand) {
            _handOverCorner = showHand;
            if (_book != undefined) {
                _book.handOverCornerProp = _handOverCorner;
            }
            //return(handOverCorner);
        }
        function get handOverPage() {
            return(_handOverPage);
        }
        function set handOverPage(showHand) {
            _handOverPage = showHand;
            if (_book != undefined) {
                _book.handOverPageProp = _handOverPage;
            }
            //return(handOverPage);
        }
        function get staticShadowsType() {
            return(_staticShadowsType);
        }
        function set staticShadowsType(newType) {
            _staticShadowsType = newType;
            if (_book != undefined) {
                _book.staticShadowsTypeProp = _staticShadowsType;
            }
            //return(staticShadowsType);
        }
        function get staticShadowsDepth() {
            return(_staticShadowsDepth);
        }
        function set staticShadowsDepth(newDepth) {
            _staticShadowsDepth = newDepth;
            if (_book != undefined) {
                _book.staticShadowsDepthProp = _staticShadowsDepth;
            }
            //return(staticShadowsDepth);
        }
        function get staticShadowsLightColor() {
            return(_staticShadowsLightColor);
        }
        function set staticShadowsLightColor(newColor) {
            _staticShadowsLightColor = newColor;
            if (_book != undefined) {
                _book.staticShadowsLightColorProp = _staticShadowsLightColor;
            }
            //return(staticShadowsLightColor);
        }
        function get staticShadowsDarkColor() {
            return(_staticShadowsDarkColor);
        }
        function set staticShadowsDarkColor(newColor) {
            _staticShadowsDarkColor = newColor;
            if (_book != undefined) {
                _book.staticShadowsDarkColorProp = _staticShadowsDarkColor;
            }
            //return(staticShadowsDarkColor);
        }
        function get dynamicShadowsDepth() {
            return(_shadowsDepth);
        }
        function set dynamicShadowsDepth(newDepth) {
            _shadowsDepth = newDepth;
            if (_book != undefined) {
                _book.dynamicShadowsDepthProp = _shadowsDepth;
            }
            //return(dynamicShadowsDepth);
        }
        function get dynamicShadowsLightColor() {
            return(_dynamicShadowsLightColor);
        }
        function set dynamicShadowsLightColor(newColor) {
            _dynamicShadowsLightColor = newColor;
            if (_book != undefined) {
                _book.dynamicShadowsLightColorProp = _dynamicShadowsLightColor;
            }
            //return(dynamicShadowsLightColor);
        }
        function get dynamicShadowsDarkColor() {
            return(_dynamicShadowsDarkColor);
        }
        function set dynamicShadowsDarkColor(newColor) {
            _dynamicShadowsDarkColor = newColor;
            if (_book != undefined) {
                _book.dynamicShadowsDarkColorProp = _dynamicShadowsDarkColor;
            }
            //return(dynamicShadowsDarkColor);
        }
        function get moveSpeed() {
            return(_moveSpeed);
        }
        function set moveSpeed(newSpeed) {
            _moveSpeed = newSpeed;
            if (_book != undefined) {
                _book.moveSpeedProp = _moveSpeed;
            }
            //return(moveSpeed);
        }
        function get closeSpeed() {
            return(_closeSpeed);
        }
        function set closeSpeed(newSpeed) {
            _closeSpeed = newSpeed;
            if (_book != undefined) {
                _book.closeSpeedProp = _closeSpeed;
            }
            //return(closeSpeed);
        }
        function get gotoSpeed() {
            return(_gotoSpeed);
        }
        function set gotoSpeed(newSpeed) {
            _gotoSpeed = newSpeed;
            if (_book != undefined) {
                _book.gotoSpeedProp = _gotoSpeed;
            }
            //return(gotoSpeed);
        }
        function get rigidPageSpeed() {
            return(_rigidPageSpeed);
        }
        function set rigidPageSpeed(newSpeed) {
            _rigidPageSpeed = newSpeed;
            if (_book != undefined) {
                _book.rigidPageSpeedProp = _rigidPageSpeed;
            }
            //return(rigidPageSpeed);
        }
        function get flipSound() {
            return(_flipSound);
        }
        function set flipSound(newURL) {
            _flipSound = newURL;
            if (_book != undefined) {
                _book.flipSoundProp = _flipSound;
            }
            //return(flipSound);
        }
        function get hardcoverSound() {
            return(_hardcoverSound);
        }
        function set hardcoverSound(newURL) {
            _hardcoverSound = newURL;
            if (_book != undefined) {
                _book.hardcoverSoundProp = _hardcoverSound;
            }
            //return(hardcoverSound);
        }
        function get preloaderType() {
            return(_preloaderType);
        }
        function set preloaderType(newType) {
            _preloaderType = newType;
            if (_book != undefined) {
                _book.preloaderTypeProp = _preloaderType;
            }
            //return(preloaderType);
        }
        function get pageBackgroundColor() {
            return(_pageBack);
        }
        function set pageBackgroundColor(newColor) {
            _pageBack = newColor;
            if (_book != undefined) {
                _book.pageBackProp = _pageBack;
            }
            //return(pageBackgroundColor);
        }
        function get pageBackgroundSymbol() {
            return(_backgroundSymbol);
        }
        function set pageBackgroundSymbol(newId) {
            _backgroundSymbol = newId;
            if (_book != undefined) {
                _book.backgroundSymbolProp = _backgroundSymbol;
            }
            //return(pageBackgroundSymbol);
        }
        function get loadOnDemand() {
            return(_loadOnDemand);
        }
        function set loadOnDemand(load) {
            _loadOnDemand = load;
            if (_book != undefined) {
                _rebuildBook();
            }
            //return(loadOnDemand);
        }
        function get allowPagesUnload() {
            return(_allowPagesUnload);
        }
        function set allowPagesUnload(allow) {
            _allowPagesUnload = allow;
            if (_book != undefined) {
                _rebuildBook();
            }
            //return(allowPagesUnload);
        }
        function get cachePages() {
            return(_cachePages);
        }
        function set cachePages(cache) {
            _cachePages = cache;
            if (_book != undefined) {
                _rebuildBook();
            }
            //return(cachePages);
        }
        function get userPreloaderId() {
            return(_userPreloaderId);
        }
        function set userPreloaderId(newId) {
            _userPreloaderId = newId;
            if (_book != undefined) {
                _rebuildBook();
            }
            //return(userPreloaderId);
        }
        function get showUnderlyingPages() {
            return(_showUnderlyingPages);
        }
        function set showUnderlyingPages(show) {
            _showUnderlyingPages = show;
            if (_book != undefined) {
                _rebuildBook();
            }
            //return(showUnderlyingPages);
        }
        function get playOnDemand() {
            return(_playOnDemand);
        }
        function set playOnDemand(play) {
            _playOnDemand = play;
            if (_book != undefined) {
                _rebuildBook();
            }
            //return(playOnDemand);
        }
        function get freezeOnFlip() {
            return(_freezeOnFlip);
        }
        function set freezeOnFlip(freeze) {
            _freezeOnFlip = freeze;
            if (_book != undefined) {
                _book.globalFreezeOnFlipProp = _freezeOnFlip;
            }
            //return(freezeOnFlip);
        }
        function get smoothPages() {
            return(_smoothPages);
        }
        function set smoothPages(smooth) {
            _smoothPages = smooth;
            if (_book != undefined) {
                _book.globalSmoothProp = _smoothPages;
            }
            //return(smoothPages);
        }
        function get rigidPages() {
            return(_rigidPages);
        }
        function set rigidPages(rigid) {
            _rigidPages = rigid;
            if (_book != undefined) {
                _book.globalRigidProp = _rigidPages;
            }
            //return(rigidPages);
        }
        function get darkPages() {
            return(_darkPages);
        }
        function set darkPages(dark) {
            _darkPages = dark;
            if (_book != undefined) {
                _book.globalDarkProp = _darkPages;
            }
            //return(darkPages);
        }
        function get flipCornerStyle() {
            return(_flipCornerStyle);
        }
        function set flipCornerStyle(newStyle) {
            _flipCornerStyle = newStyle;
            //return(flipCornerStyle);
        }
        function get flipCornerPosition() {
            return(_flipCornerPosition);
        }
        function set flipCornerPosition(newPosition) {
            _flipCornerPosition = newPosition;
            if (_book != undefined) {
                _book.flipCornerPositionProp = _flipCornerPosition;
            }
            //return(flipCornerPosition);
        }
        function get flipCornerAmount() {
            return(_flipCornerAmount);
        }
        function set flipCornerAmount(newAmount) {
            _flipCornerAmount = newAmount;
            if (_book != undefined) {
                _book.flipCornerAmountProp = _flipCornerAmount;
            }
            //return(flipCornerAmount);
        }
        function get flipCornerAngle() {
            return(_flipCornerAngle);
        }
        function set flipCornerAngle(newAngle) {
            _flipCornerAngle = newAngle;
            if (_book != undefined) {
                _book.flipCornerAngleProp = _flipCornerAngle;
            }
            //return(flipCornerAngle);
        }
        function get flipCornerRelease() {
            return(_flipCornerRelease);
        }
        function set flipCornerRelease(release) {
            _flipCornerRelease = release;
            if (_book != undefined) {
                _book.flipCornerReleaseProp = _flipCornerRelease;
            }
            //return(flipCornerRelease);
        }
        function get flipCornerVibrate() {
            return(_flipCornerVibrate);
        }
        function set flipCornerVibrate(vibrate) {
            _flipCornerVibrate = vibrate;
            if (_book != undefined) {
                _book.flipCornerVibrateProp = _flipCornerVibrate;
            }
            //return(flipCornerVibrate);
        }
        function get flipCornerPlaySound() {
            return(_flipCornerPlaySound);
        }
        function set flipCornerPlaySound(play) {
            _flipCornerPlaySound = play;
            if (_book != undefined) {
                _book.flipCornerPlaySoundProp = _flipCornerPlaySound;
            }
            //return(flipCornerPlaySound);
        }
        function get totalPages() {
            return(_book.totalPages);
        }
        function get leftPageNumber() {
            var _local2 = _book.leftPageNumber + 1;
            if (isNaN(_local2)) {
                _local2 = undefined;
            }
            return(_local2);
        }
        function get rightPageNumber() {
            var _local2 = _book.rightPageNumber + 1;
            if (isNaN(_local2)) {
                _local2 = undefined;
            }
            return(_local2);
        }
        function addPage(pageURL, pageParams) {
            var _local5 = pageURL;
            if (pageParams != undefined) {
                var _local3 = 0;
                for (var _local6 in pageParams) {
                    var _local2 = ((_local3 > 0) ? "&" : "?");
                    _local5 = _local5 + (((_local2 + _local6) + "=") + pageParams[_local6]);
                    _local3++;
                }
            }
            _pagesSet.push(_local5);
            if (_book != undefined) {
                _rebuildBook();
            }
        }
        function flipCorner(cornerPosition, release, amount, angle, vibrate, playSound) {
            if (_book != undefined) {
                _book.flipCorner(cornerPosition, release, amount, angle, vibrate, playSound);
            }
        }
        function gotoPage(pageNumber) {
            pageNumber = Number(pageNumber);
            if (_book != undefined) {
                if (!_zoomedIn) {
                    _book.gotoPage(pageNumber - 1);
                } else {
                    dispatchEvent({type:"zoomNavigationCall", functionName:"gotoPage", targetPage:pageNumber});
                }
            }
        }
        function flipGotoPage(pageNumber) {
            pageNumber = Number(pageNumber);
            if (_book != undefined) {
                if (!_zoomedIn) {
                    _book.flipGotoPage(pageNumber - 1);
                } else {
                    dispatchEvent({type:"zoomNavigationCall", functionName:"flipGotoPage", targetPage:pageNumber});
                }
            }
        }
        function directGotoPage(pageNumber) {
            pageNumber = Number(pageNumber);
            if (_book != undefined) {
                if (!_zoomedIn) {
                    _book.directGotoPage(pageNumber - 1);
                } else {
                    dispatchEvent({type:"zoomNavigationCall", functionName:"directGotoPage", targetPage:pageNumber});
                }
            }
        }
        function switchToPage(pageNumber) {
            pageNumber = Number(pageNumber);
            _book.directGotoPage(pageNumber - 1);
        }
        function flipForward() {
            if (_book != undefined) {
                if (!_zoomedIn) {
                    _book.flipForward();
                } else {
                    dispatchEvent({type:"zoomNavigationCall", functionName:"flipForward"});
                }
            }
        }
        function flipBack() {
            if (_book != undefined) {
                if (!_zoomedIn) {
                    _book.flipBack();
                } else {
                    dispatchEvent({type:"zoomNavigationCall", functionName:"flipBack"});
                }
            }
        }
        function getPageLink(pageNumber) {
            return(_book.getPageLink(pageNumber - 1));
        }
        function isPageVisible(pageNumber) {
            return(_book.isPageVisible(pageNumber));
        }
        function isPageLoaded(pageNumber) {
            return(_book.isPageLoaded(pageNumber));
        }
        function getPageURL(pageNumber) {
            return(_book.getPageURL(pageNumber));
        }
        function getPageParams(pageNumber) {
            return(_book.getPageParams(pageNumber));
        }
        function isLeftPage(pageNumber) {
            return(_book.isLeftPage(pageNumber));
        }
        function isRightPage(pageNumber) {
            return(_book.isRightPage(pageNumber));
        }
        function show() {
            _parentClip._visible = true;
        }
        function hide() {
            _parentClip._visible = false;
        }
        function loadLargePages() {
            _book.loadLargePages();
        }
        function unloadLargePages() {
            _book.unloadLargePages();
        }
        function showZoomPages() {
            _book.showZoomPages();
        }
        function _subscribeToEvents() {
            _book.addEventListener(this);
        }
        function onInit(eventObject) {
            _positionBook();
            dispatchEvent({type:"onInit", target:_book});
        }
        function onPageLoad(eventObject) {
            dispatchEvent({type:"onPageLoad", target:_book, URL:eventObject.URL, pageNumber:Number(eventObject.pageNumber) + 1});
        }
        function onPageUnload(eventObject) {
            dispatchEvent({type:"onPageUnload", target:_book, pageNumber:eventObject.pageNumber});
        }
        function onPutPage(eventObject) {
            dispatchEvent({type:"onPutPage", target:_book, pageNumber:eventObject.pageNumber, pageClip:eventObject.page_mc});
        }
        function onLastPage(eventObject) {
            dispatchEvent({type:"onLastPage", target:_book});
        }
        function onFirstPage(eventObject) {
            dispatchEvent({type:"onFirstPage", target:_book});
        }
        function onEndGoto(eventObject) {
            dispatchEvent({type:"onEndGoto", target:_book});
        }
        function onNavigationFunctionCall(eventObject) {
            dispatchEvent({type:"onNavigationFunctionCall", target:_book, functionName:eventObject.functionName, targetPage:eventObject.targetPage});
        }
        function onXMLComplete(eventObject) {
            _updateSettingsFromXML();
            dispatchEvent({type:"onXMLComplete", target:_book});
        }
        function onRollOver(eventObject) {
            dispatchEvent({type:"onRollOver", target:_book});
        }
        function onRollOut(eventObject) {
            dispatchEvent({type:"onRollOut", target:_book});
        }
        function onRelease(eventObject) {
            dispatchEvent({type:"onRelease", target:_book, pageNumber:eventObject.pageNumber, pageClip:eventObject.page_mc, isCorner:eventObject.isCorner});
        }
        function onStartPageDrag(eventObject) {
            dispatchEvent({type:"onStartPageDrag", target:_book, pageNumber:eventObject.pageNumber, pageClip:eventObject.page_mc, isCorner:eventObject.isCorner});
        }
        function onStartPageHold(eventObject) {
            dispatchEvent({type:"onStartPageHold"});
        }
        function onStopPageDrag(eventObject) {
            dispatchEvent({type:"onStopPageDrag", target:_book, pageNumber:eventObject.pageNumber, pageClip:eventObject.page_mc, isCorner:eventObject.isCorner});
        }
        function onDoubleClick(eventObject) {
            dispatchEvent({type:"onDoubleClick", target:_book, pageNumber:eventObject.pageNumber, pageClip:eventObject.page_mc, isCorner:eventObject.isCorner});
        }
        function onZoomContentLoadInit(eventObject) {
            dispatchEvent({type:"onZoomContentLoadInit", target:_book, pageClip:eventObject.pageClip});
        }
        function onZoomContentLoadProgress(eventObject) {
            dispatchEvent({type:"onZoomContentLoadProgress", target:_book, pageClip:eventObject.pageClip, progress:eventObject.progress});
        }
        function onZoomContentLoadComplete(eventObject) {
            dispatchEvent({type:"onZoomContentLoadComplete", target:_book, pageClip:eventObject.pageClip, zoomPageClip:eventObject.zoomPageClip, cache:eventObject.cache});
        }
        function onReleaseOutside(eventObject) {
            dispatchEvent({type:"onReleaseOutside", target:_book});
        }
        function onClick(eventObject) {
            dispatchEvent({type:"onClick", target:_book, pageNumber:eventObject.pageNumber, pageClip:eventObject.page_mc, isCorner:eventObject.isCorner});
        }
        function onClickWithoutDragging(eventObject) {
            dispatchEvent({type:"onClickWithoutDragging", target:_book, pageNumber:eventObject.pageNumber, pageClip:eventObject.page_mc, isCorner:eventObject.isCorner});
        }
        function onStartFlip(eventObject) {
            dispatchEvent({type:"onStartFlip", target:_book, pageNumber:eventObject.pageNumber});
        }
        function onFlipOver(eventObject) {
            dispatchEvent({type:"onFlipOver", target:_book, forward:eventObject.forward});
        }
        function onCornerOut(eventObject) {
            dispatchEvent({type:"onCornerOut", target:_book});
        }
        function onCornerOver(eventObject) {
            dispatchEvent({type:"onCornerOver", target:_book});
        }
        function onFlipBack(eventObject) {
            dispatchEvent({type:"onFlipBack", target:_book, pageNumber:eventObject.pageNumber});
        }
        function onPageOver(eventObject) {
            dispatchEvent({type:"onPageOver", target:_book, isLeftPage:eventObject.isLeftPage, pageNumber:eventObject.pageNumber});
        }
        function onPageOut(eventObject) {
            dispatchEvent({type:"onPageOut", target:_book, isLeftPage:eventObject.isLeftPage, pageNumber:eventObject.pageNumber});
        }
        function onBookOver(eventObject) {
            dispatchEvent({type:"onBookOver", target:_book, isLeftPage:eventObject.isLeftPage});
        }
        function onBookOut(eventObject) {
            dispatchEvent({type:"onBookOut", target:_book, isLeftPage:eventObject.isLeftPage});
        }
        function _positionBook() {
            _book.width = _width;
            _book.height = _height;
            _book._x = _width / 2;
            _book._y = _height / 2;
        }
        function _rebuildPagesPaths() {
            var _local2 = 0;
            while (_local2 < _pagesSet.length) {
                var _local7 = _pagesSet[_local2];
                var _local6 = _cleanPageURL(_local7);
                var _local3 = _book.getPageLink(_local2).params;
                if (_local3 != undefined) {
                    var _local5 = 0;
                    for (var _local8 in _local3) {
                        var _local4 = ((_local5 > 0) ? "&" : "?");
                        _local6 = _local6 + (((_local4 + _local8) + "=") + _local3[_local8]);
                        _local5++;
                    }
                }
                _pagesSet.splice(_local2, 1, _local6);
                _local2++;
            }
        }
        function _cleanPageURL(pageURL) {
            var _local2 = pageURL.indexOf(_book._constants.DELIMITER);
            if (_local2 != -1) {
                return(pageURL.substr(_local2 + _book._constants.DELIMITER.length));
            }
            return(pageURL);
        }
        function _rebuildBook() {
            _book.removeEventListener(this);
            _rebuildPagesPaths();
            create();
        }
        function _createInitObject() {
            var _local2 = new Object();
            _local2.pagesSet = _pagesSet;
            _local2.extXML = _extXML;
            _local2.scaleContent = _scaleContent;
            _local2.preserveProportions = _preserveProportions;
            _local2.centerContent = _centerContent;
            _local2.hardcover = _hardcover;
            _local2.hardcoverThickness = _hardcoverThickness;
            _local2.hardcoverEdgeColor = _hardcoverEdgeColor;
            _local2.highlightHardcover = _highlightHardcover;
            _local2.frameWidth = _frameWidth;
            _local2.frameColor = _frameColor;
            _local2.frameAlpha = _frameAlpha;
            _local2.firstPage = _firstPage;
            _local2.alwaysOpened = _alwaysOpened;
            _local2.autoFlip = _autoFlip;
            _local2.navigationFlipOffset = _navigationFlipOffset;
            _local2.flipOnClick = _flipOnClick;
            _local2.handOverCorner = _handOverCorner;
            _local2.handOverPage = _handOverPage;
            _local2.staticShadowsType = _staticShadowsType;
            _local2.staticShadowsDepth = _staticShadowsDepth;
            _local2.staticShadowsLightColor = _staticShadowsLightColor;
            _local2.staticShadowsDarkColor = _staticShadowsDarkColor;
            _local2.shadowsDepth = _shadowsDepth;
            _local2.dynamicShadowsLightColor = _dynamicShadowsLightColor;
            _local2.dynamicShadowsDarkColor = _dynamicShadowsDarkColor;
            _local2.moveSpeed = _moveSpeed;
            _local2.closeSpeed = _closeSpeed;
            _local2.gotoSpeed = _gotoSpeed;
            _local2.rigidPageSpeed = _rigidPageSpeed;
            _local2.flipSound = _flipSound;
            _local2.hardcoverSound = _hardcoverSound;
            _local2.preloaderType = _preloaderType;
            _local2.pageBack = _pageBack;
            _local2.backgroundSymbol = _backgroundSymbol;
            _local2.loadOnDemand = _loadOnDemand;
            _local2.allowPagesUnload = _allowPagesUnload;
            _local2.cachePages = _cachePages;
            _local2.cacheSize = _cacheSize;
            _local2.userPreloaderId = _userPreloaderId;
            _local2._showUnderlyingPages = _showUnderlyingPages;
            _local2.playOnDemand = _playOnDemand;
            _local2.globalFreezeOnFlip = _freezeOnFlip;
            _local2.globalDark = _darkPages;
            _local2.globalSmooth = _smoothPages;
            _local2.globalRigid = _rigidPages;
            _local2.flipCornerStyle = _flipCornerStyle;
            _local2.flipCornerPosition = _flipCornerPosition;
            _local2.flipCornerAmount = _flipCornerAmount;
            _local2.flipCornerAngle = _flipCornerAngle;
            _local2.flipCornerRelease = _flipCornerRelease;
            _local2.flipCornerVibrate = _flipCornerVibrate;
            _local2.flipCornerPlaySound = _flipCornerPlaySound;
            _local2._width = _width;
            _local2._height = _height;
            _local2._x = Math.round(_width / 2);
            _local2._y = Math.round(_height / 2);
            return(_local2);
        }
        function _updateSettingsFromXML() {
            _width = _book.width;
            _height = _book.height;
        }
        var _bookSymbolId = "FFlippingBookSymbol";
        var _x = 0;
        var _y = 0;
        var _width = 400;
        var _height = 250;
        var _extXML = "";
        var _scaleContent = true;
        var _preserveProportions = false;
        var _centerContent = true;
        var _hardcover = false;
        var _hardcoverThickness = 2;
        var _hardcoverEdgeColor = 13421772;
        var _highlightHardcover = true;
        var _frameWidth = 0;
        var _frameColor = 16777215;
        var _frameAlpha = 100;
        var _firstPage = 0;
        var _alwaysOpened = false;
        var _autoFlip = 50;
        var _navigationFlipOffset = 50;
        var _flipOnClick = true;
        var _handOverCorner = true;
        var _handOverPage = true;
        var _staticShadowsType = "Asymmetric";
        var _staticShadowsDepth = 1;
        var _staticShadowsLightColor = 16777215;
        var _staticShadowsDarkColor = 0;
        var _shadowsDepth = 1;
        var _dynamicShadowsLightColor = 16777215;
        var _dynamicShadowsDarkColor = 0;
        var _moveSpeed = 2;
        var _closeSpeed = 3;
        var _gotoSpeed = 3;
        var _rigidPageSpeed = 5;
        var _flipSound = "";
        var _hardcoverSound = "";
        var _preloaderType = "Progress Bar";
        var _pageBack = 10079487;
        var _backgroundSymbol = "";
        var _loadOnDemand = true;
        var _allowPagesUnload = true;
        var _cachePages = true;
        var _cacheSize = 10;
        var _userPreloaderId = "";
        var _showUnderlyingPages = false;
        var _playOnDemand = true;
        var _freezeOnFlip = false;
        var _smoothPages = false;
        var _rigidPages = false;
        var _darkPages = false;
        var _flipCornerPosition = "bottom-right";
        var _flipCornerStyle = "manually";
        var _flipCornerAmount = 50;
        var _flipCornerAngle = 45;
        var _flipCornerRelease = true;
        var _flipCornerVibrate = true;
        var _flipCornerPlaySound = false;
        var _zoomedIn = false;
    }
