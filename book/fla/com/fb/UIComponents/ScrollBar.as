
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.UIComponents.ScrollBar
    {
        var _clip, _view, _mainColor, _x, _y;
        function ScrollBar (parentClip, horizontal) {
            _clip = parentClip;
            _view = new com.fb.UIComponents.scrollBarClasses.ScrollBarView(_clip, horizontal);
            _view.addEventListener("onChange", this);
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function destroyObject() {
            _clip.removeMovieClip();
        }
        function update(contentSize, contentPosition, paneSize) {
            _view.__set__width(paneSize);
            _view.__set__handleWidth((paneSize * (paneSize - 36)) / contentSize);
            _view.__set__handlePosition((100 * (contentPosition - (paneSize / 2))) / (contentSize - paneSize));
        }
        function show() {
            _clip._visible = true;
        }
        function hide() {
            _clip._visible = false;
        }
        function get width() {
            return(_view.__get__width());
        }
        function get height() {
            return(_view.__get__height());
        }
        function get mainColor() {
            return(_mainColor);
        }
        function set mainColor(color) {
            _mainColor = color;
            _view.__set__mainColor(_mainColor);
            //return(mainColor);
        }
        function get x() {
            return(_x);
        }
        function set x(x) {
            _x = x;
            _clip._x = _x;
            //return(this.x);
        }
        function get y() {
            return(_y);
        }
        function set y(y) {
            _y = y;
            _clip._y = _y;
            //return(this.y);
        }
        function get contentSize() {
            return(_contentSize);
        }
        function get paneSize() {
            return(_paneSize);
        }
        function get contentPosition() {
            return(_contentPosition);
        }
        function get buttonStep() {
            return(_view.__get__buttonStep());
        }
        function set buttonStep(step) {
            _view.__set__buttonStep(step);
            //return(buttonStep);
        }
        function onChange(evt) {
            dispatchEvent({type:"change", normedPosition:evt.normedPosition});
        }
        var _contentSize = 0;
        var _paneSize = 0;
        var _contentPosition = 0;
    }
