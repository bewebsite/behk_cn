
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.PrintUtility
    {
        var _pageURLs, _clip, _pagesLoader, _pageClips, _printInterval;
        function PrintUtility () {
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function print(pagesRange, bookInstance) {
            var _local3 = _getPageNumbers(pagesRange);
            _pageURLs = _getPageURLs(_local3, bookInstance);
            _loaded = 0;
            _total = _pageURLs.length;
            if (_clip == undefined) {
                _clip = _root.createEmptyMovieClip("FlippingBookPrintHolder", _root.getNextHighestDepth());
            }
            Stage.addListener(this);
            this.onResize();
            _pagesLoader = new MovieClipLoader();
            _pagesLoader.addListener(this);
            _pageClips = new Array();
            _isLoading = true;
            _cancelled = false;
            _loadNextPage();
            dispatchEvent({type:"onLoadStart"});
        }
        function cancel() {
            _destroyPrintData();
        }
        function get isLoading() {
            return(_isLoading);
        }
        function onResize() {
            _clip._x = Stage.width;
        }
        function _loadNextPage() {
            if (_cancelled) {
                return(undefined);
            }
            var _local2 = String(_pageURLs.slice(0, 1));
            _pageURLs = _pageURLs.slice(1);
            if (_local2) {
                var _local4 = _clip.getNextHighestDepth();
                var _local3 = _clip.createEmptyMovieClip("page" + _local4, _local4);
                _pageClips.push(_local3);
                _pagesLoader.loadClip(_local2, _local3);
            } else {
                _isLoading = false;
                clearInterval(_printInterval);
                _printInterval = setInterval(this, "_printPages", 1000);
            }
        }
        function _printPages() {
            clearInterval(_printInterval);
            if (_cancelled) {
                return(undefined);
            }
            var _local4 = new PrintJob();
            if (_local4.start()) {
                dispatchEvent({type:"onPrintStart"});
                var _local2 = 0;
                while (_local2 < _pageClips.length) {
                    var _local3 = _preparePage(_pageClips[_local2], _local4.pageWidth, _local4.pageHeight);
                    _local4.addPage(_pageClips[_local2], {xMin:0, xMax:_pageClips[_local2]._width / _local3, yMin:0, yMax:_pageClips[_local2]._height / _local3}, {printAsBitmap:true});
                    _local2++;
                }
                _local4.send();
            } else {
                dispatchEvent({type:"onCancelledByUser"});
            }
            _destroyPrintData();
        }
        function _preparePage(pageClip, pageWidth, pageHeight) {
            var _local3 = new flash.display.BitmapData(pageClip._width, pageClip._height, false, 0);
            _local3.draw(pageClip);
            pageClip.attachBitmap(_local3, pageClip.getNextHighestDepth(), "auto", true);
            pageClip.savedBitmap = _local3;
            var _local7 = System.capabilities.screenDPI;
            var _local4 = 0.0138888888888889 * _local7;
            var _local6 = pageWidth / (pageClip._width * _local4);
            var _local5 = pageHeight / (pageClip._height * _local4);
            var _local2 = ((_local6 < _local5) ? (_local6) : (_local5));
            pageClip._width = pageClip._width * _local2;
            pageClip._height = pageClip._height * _local2;
            return(_local2);
        }
        function _destroyPrintData() {
            _cancelled = true;
            var _local2 = 0;
            while (_local2 < _pageClips.length) {
                var _local3 = _pageClips[_local2];
                _local3.savedBitmap.dispose();
                _pagesLoader.unloadClip(_local3);
                _local2++;
            }
        }
        function _getPageNumbers(pagesRange) {
            var _local9 = pagesRange.split(",");
            var _local8 = new Array();
            var _local4 = 0;
            while (_local4 < _local9.length) {
                var _local3 = _local9[_local4];
                var _local5 = _local3.indexOf("-");
                if (_local5 != -1) {
                    var _local6 = Number(_local3.substring(0, _local5));
                    var _local7 = Number(_local3.substring(_local5 + 1));
                    var _local2 = _local6;
                    while (_local2 <= _local7) {
                        _local8.push(_local2);
                        _local2++;
                    }
                } else {
                    _local8.push(Number(_local3));
                }
                _local4++;
            }
            _local8 = _getCleanPageNumbers(_local8);
            return(_local8);
        }
        function _getCleanPageNumbers(pageNumbers) {
            var _local3 = new Array();
            pageNumbers.sort(Array.NUMERIC);
            var _local1 = 0;
            while (_local1 < pageNumbers.length) {
                if (pageNumbers[_local1] == pageNumbers[_local1 + 1]) {
                } else {
                    _local3.push(pageNumbers[_local1]);
                }
                _local1++;
            }
            return(_local3);
        }
        function _getPageURLs(pageNumbers, book) {
            var _local6 = new Array();
            var _local2 = 0;
            while (_local2 < pageNumbers.length) {
                var _local4 = pageNumbers[_local2] - 1;
                var _local3 = book.getPageLink(_local4);
                var _local1 = _local3.params.print;
                if (_local1 == undefined) {
                    _local1 = _local3.URL;
                }
                if (_local1 != undefined) {
                    _local6.push(_local1);
                }
                _local2++;
            }
            return(_local6);
        }
        function onLoadProgress(targetClip, loaded, total) {
            if (!_cancelled) {
                dispatchEvent({type:"onLoadProgress", loaded:_loaded + (loaded / total), total:_total});
            }
        }
        function onLoadInit(targetClip) {
            _loaded++;
            _loadNextPage();
        }
        var _loaded = 0;
        var _total = 0;
        var _isLoading = false;
        var _cancelled = false;
    }
