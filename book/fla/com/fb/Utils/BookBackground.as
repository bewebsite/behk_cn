
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.BookBackground
    {
        var _clip, _backgroundImage, _imageLoader, _imageClip;
        function BookBackground (parentClip) {
            _clip = parentClip;
            _create();
            _subscribeToStageEvents();
        }
        function get backgroundImage() {
            return(_backgroundImage);
        }
        function set backgroundImage(newURL) {
            _backgroundImage = newURL;
            _reloadImage();
            //return(backgroundImage);
        }
        function get backgroundImagePlacement() {
            return(_backgroundImagePlacement);
        }
        function set backgroundImagePlacement(newPlacement) {
            _backgroundImagePlacement = newPlacement;
            _repositionImage();
            //return(backgroundImagePlacement);
        }
        function _create() {
            _imageLoader = new MovieClipLoader();
            _imageLoader.addListener(this);
            _imageClip = _clip.createEmptyMovieClip("image", _clip.getNextHighestDepth());
        }
        function _subscribeToStageEvents() {
            Stage.addListener(this);
        }
        function onResize() {
            _repositionImage();
        }
        function _reloadImage() {
            _prepareImageForLoading();
            _imageLoader.loadClip(_backgroundImage, _imageClip);
        }
        function _prepareImageForLoading() {
            _imageClip._xscale = (_imageClip._yscale = 100);
            _imageLoaded = false;
        }
        function onLoadInit() {
            _imageLoaded = true;
            _repositionImage();
        }
        function _repositionImage() {
            if (_imageLoaded) {
                switch (_backgroundImagePlacement) {
                    case "top left" : 
                        _imageClip._x = 0;
                        _imageClip._y = 0;
                        break;
                    case "center" : 
                        _imageClip._x = (Stage.width / 2) - (_imageClip._width / 2);
                        _imageClip._y = (Stage.height / 2) - (_imageClip._height / 2);
                        break;
                    case "fit" : 
                        _imageClip._x = 0;
                        _imageClip._y = 0;
                        _imageClip._width = Stage.width;
                        _imageClip._height = Stage.height;
                        break;
                }
            }
        }
        var _backgroundImagePlacement = "top left";
        var _imageLoaded = false;
    }
