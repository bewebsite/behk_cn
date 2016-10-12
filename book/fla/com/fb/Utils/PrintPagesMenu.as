
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.Utils.PrintPagesMenu
    {
        var _clip, _leftPageButton, _bothPagesButton, _rightPageButton, _selection, _leftDiv, _rightDiv;
        function PrintPagesMenu (parentClip) {
            _clip = parentClip;
            _create();
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function get freeze() {
            return(_freeze);
        }
        function set freeze(needToFreeze) {
            _freeze = needToFreeze;
            _leftPageButton.__set__freeze(_freeze);
            _bothPagesButton.__set__freeze(_freeze);
            _rightPageButton.__set__freeze(_freeze);
            if (!_freeze) {
                _hideSelection();
            }
            //return(freeze);
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
        function set width(newWidth) {
            _width = newWidth;
            _positionObjects();
            //return(width);
        }
        function get height() {
            return(_height);
        }
        function set height(newHeight) {
            _height = newHeight;
            _positionObjects();
            //return(height);
        }
        function setSize(newWidth, newHeight) {
            _width = newWidth;
            _height = newHeight;
            _positionObjects();
        }
        function get leftPageEnabled() {
            return(_leftPageEnabled);
        }
        function set leftPageEnabled(enabled) {
            _leftPageEnabled = enabled;
            _updateButtons();
            //return(leftPageEnabled);
        }
        function get rightPageEnabled() {
            return(_rightPageEnabled);
        }
        function set rightPageEnabled(enabled) {
            _rightPageEnabled = enabled;
            _updateButtons();
            //return(rightPageEnabled);
        }
        function refresh() {
            _hideSelection();
        }
        function _create() {
            _createSelection();
            _createLeftButton();
            _createLeftDiv();
            _createBothButton();
            _createRightDiv();
            _createRightButton();
        }
        function _createSelection() {
            var _local2 = _clip.createEmptyMovieClip("selection", _clip.getNextHighestDepth());
            _selection = new com.fb.graphics.StyleableRectangle(_local2, 0, 0, _selectionWidth, _selectionHeight);
            _selection.__set__color(16777215);
            _selection.__set__cornerRadius(2);
            _selection.__set__fill(31);
            _selection.__set__opacity(0);
            _selection.__set__y(0);
        }
        function _createLeftButton() {
            var _local2 = _clip.createEmptyMovieClip("leftPage", _clip.getNextHighestDepth());
            _leftPageButton = new com.fb.Utils.IconButton("leftPageIcon", _local2);
            _leftPageButton.__set__x(_horizontalPadding);
            _leftPageButton.__set__y(0);
            _leftPageButton.setSize(_buttonWidth, _buttonHeight);
            _leftPageButton.__set__normalFill(90);
            _leftPageButton.addEventListener("onRollOver", mx.utils.Delegate.create(this, onButtonRollOver));
            _leftPageButton.addEventListener("onRollOut", mx.utils.Delegate.create(this, onButtonRollOut));
            _leftPageButton.addEventListener("onRelease", mx.utils.Delegate.create(this, onButtonRelease));
        }
        function _createLeftDiv() {
            var _local2 = _clip.createEmptyMovieClip("leftDiv", _clip.getNextHighestDepth());
            _leftDiv = new com.fb.Utils.Icon("divIcon", _local2);
            _leftDiv.__set__x(_leftPageButton.__get__x() + _leftPageButton.__get__width());
            _leftDiv.__set__y(0);
            _leftDiv.setSize(_divWidth, _divHeight);
        }
        function _createBothButton() {
            var _local2 = _clip.createEmptyMovieClip("bothPages", _clip.getNextHighestDepth());
            _bothPagesButton = new com.fb.Utils.IconButton("bothPagesIcon", _local2);
            _bothPagesButton.__set__x(_leftDiv.__get__x() + _leftDiv.__get__width());
            _bothPagesButton.__set__y(0);
            _bothPagesButton.setSize(_buttonWidth, _buttonHeight);
            _bothPagesButton.__set__normalFill(90);
            _bothPagesButton.addEventListener("onRollOver", mx.utils.Delegate.create(this, onButtonRollOver));
            _bothPagesButton.addEventListener("onRollOut", mx.utils.Delegate.create(this, onButtonRollOut));
            _bothPagesButton.addEventListener("onRelease", mx.utils.Delegate.create(this, onButtonRelease));
        }
        function _createRightDiv() {
            var _local2 = _clip.createEmptyMovieClip("rightDiv", _clip.getNextHighestDepth());
            _rightDiv = new com.fb.Utils.Icon("divIcon", _local2);
            _rightDiv.__set__x(_bothPagesButton.__get__x() + _bothPagesButton.__get__width());
            _rightDiv.__set__y(0);
            _rightDiv.setSize(_divWidth, _divHeight);
        }
        function _createRightButton() {
            var _local2 = _clip.createEmptyMovieClip("rightPage", _clip.getNextHighestDepth());
            _rightPageButton = new com.fb.Utils.IconButton("rightPageIcon", _local2);
            _rightPageButton.__set__x(_rightDiv.__get__x() + _rightDiv.__get__width());
            _rightPageButton.__set__y(0);
            _rightPageButton.setSize(_buttonWidth, _buttonHeight);
            _rightPageButton.__set__normalFill(90);
            _rightPageButton.addEventListener("onRollOver", mx.utils.Delegate.create(this, onButtonRollOver));
            _rightPageButton.addEventListener("onRollOut", mx.utils.Delegate.create(this, onButtonRollOut));
            _rightPageButton.addEventListener("onRelease", mx.utils.Delegate.create(this, onButtonRelease));
        }
        function _positionObjects() {
            _leftPageButton.__set__x(_horizontalPadding);
            _leftPageButton.__set__y(Math.round((_height / 2) - (_leftPageButton.__get__height() / 2)));
            _leftDiv.__set__x(_leftPageButton.__get__x() + _leftPageButton.__get__width());
            _leftDiv.__set__y(Math.round((_height / 2) - (_leftDiv.__get__height() / 2)));
            _bothPagesButton.__set__x(_leftDiv.__get__x() + _leftDiv.__get__width());
            _bothPagesButton.__set__y(Math.round((_height / 2) - (_bothPagesButton.__get__height() / 2)));
            _rightDiv.__set__x(_bothPagesButton.__get__x() + _bothPagesButton.__get__width());
            _rightDiv.__set__y(Math.round((_height / 2) - (_rightDiv.__get__height() / 2)));
            _rightPageButton.__set__x(_rightDiv.__get__x() + _rightDiv.__get__width());
            _rightPageButton.__set__y(Math.round((_height / 2) - (_rightPageButton.__get__height() / 2)));
        }
        function _updateButtons() {
            _leftPageButton.__set__enabled(true);
            _bothPagesButton.__set__enabled(true);
            _rightPageButton.__set__enabled(true);
            if (!_leftPageEnabled) {
                _leftPageButton.__set__enabled(false);
                _bothPagesButton.__set__enabled(false);
            } else if (!_rightPageEnabled) {
                _bothPagesButton.__set__enabled(false);
                _rightPageButton.__set__enabled(false);
            }
        }
        function onButtonRollOver(eventObject) {
            if (!_freeze) {
                _moveSelection(eventObject.target.x + (eventObject.target.width / 2));
            }
        }
        function onButtonRollOut() {
            if (!_freeze) {
                _hideSelection();
            }
        }
        function onButtonRelease(eventObject) {
            if (_freeze) {
                return(undefined);
            }
            var _local3 = eventObject.target;
            var _local2 = "";
            if (_local3 == _leftPageButton) {
                _local2 = "left";
            } else if (_local3 == _rightPageButton) {
                _local2 = "right";
            } else if (_local3 == _bothPagesButton) {
                _local2 = "both";
            }
            dispatchEvent({type:"onButtonRelease", selection:_local2});
        }
        function _moveSelection(targetCenterX) {
            _selection.__set__x(Math.round(targetCenterX - (_selection.__get__width() / 2)));
            _selection.__set__opacity(100);
        }
        function _hideSelection() {
            _selection.__set__opacity(0);
        }
        var _width = 180;
        var _height = 40;
        var _leftPageEnabled = false;
        var _rightPageEnabled = false;
        var _buttonWidth = 40;
        var _buttonHeight = 26;
        var _selectionWidth = 50;
        var _selectionHeight = 40;
        var _divWidth = 20;
        var _divHeight = 26;
        var _horizontalPadding = 10;
        var _freeze = false;
    }
