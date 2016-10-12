
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.graphics.StyleableRectangle extends com.fb.graphics.StyleableShape
    {
        var __set__x, __set__y, addPoint, draw, getPoint, _topLeftCornerRadius, _topRightCornerRadius, _bottomRightCornerRadius, _bottomLeftCornerRadius, _cornerRadius, activateAnimationObject, movePoint;
        function StyleableRectangle (clip, topLeftX, topLeftY, width, height) {
            super(clip);
            _width = width;
            _height = height;
            __set__x(topLeftX);
            __set__y(topLeftY);
            addPoint(0, 0);
            addPoint(width, 0);
            addPoint(width, height);
            addPoint(0, height);
            draw();
        }
        function get width() {
            return(_width);
        }
        function set width(newWidth) {
            _width = newWidth;
            _updateRectangle();
            //return(width);
        }
        function setCustomCornerRadius(newRadius, cornerPosition) {
            switch (cornerPosition) {
                case "top-left" : 
                    getPoint(0).customCornerRadius = newRadius;
                    _topLeftCornerRadius = newRadius;
                    break;
                case "top-right" : 
                    getPoint(1).customCornerRadius = newRadius;
                    _topRightCornerRadius = newRadius;
                    break;
                case "bottom-right" : 
                    getPoint(2).customCornerRadius = newRadius;
                    _bottomRightCornerRadius = newRadius;
                    break;
                case "bottom-left" : 
                    getPoint(3).customCornerRadius = newRadius;
                    _bottomLeftCornerRadius = newRadius;
                    break;
            }
            _updateRectangle();
        }
        function customCornerRadiusTo(newRadius, cornerPosition, duration, delay) {
            switch (cornerPosition) {
                case "top-left" : 
                    if (_topLeftCornerRadius == undefined) {
                        _topLeftCornerRadius = _cornerRadius;
                    }
                    activateAnimationObject("_topLeftCornerRadius", _updateTopLeftCornerRadius, "topLeftCornerRadiusGroup", newRadius, duration, delay);
                    break;
                case "top-right" : 
                    if (_topRightCornerRadius == undefined) {
                        _topRightCornerRadius = _cornerRadius;
                    }
                    activateAnimationObject("_topRightCornerRadius", _updateTopRightCornerRadius, "topRightCornerRadiusGroup", newRadius, duration, delay);
                    break;
                case "bottom-left" : 
                    if (_bottomLeftCornerRadius == undefined) {
                        _bottomLeftCornerRadius = _cornerRadius;
                    }
                    activateAnimationObject("_bottomLeftCornerRadius", _updateBottomLeftCornerRadius, "bottomLeftCornerRadiusGroup", newRadius, duration, delay);
                    break;
                case "bottom-right" : 
                    if (_bottomRightCornerRadius == undefined) {
                        _bottomRightCornerRadius = _cornerRadius;
                    }
                    activateAnimationObject("_bottomRightCornerRadius", _updateBottomRightCornerRadius, "bottomRightCornerRadiusGroup", newRadius, duration, delay);
                    break;
            }
        }
        function widthTo(newWidth, duration, delay) {
            activateAnimationObject("_width", _updateRectangle, "rectangleSize", newWidth, duration, delay);
        }
        function get height() {
            return(_height);
        }
        function set height(newHeight) {
            _height = newHeight;
            _updateRectangle();
            //return(height);
        }
        function heightTo(newHeight, duration, delay) {
            activateAnimationObject("_height", _updateRectangle, "rectangleSize", newHeight, duration, delay);
        }
        function setSize(newWidth, newHeight) {
            _width = newWidth;
            _height = newHeight;
            _updateRectangle();
        }
        function setSizeTo(newWidth, newHeight, duration, delay) {
            widthTo(newWidth, duration, delay);
            heightTo(newHeight, duration, delay);
        }
        function _updateTopLeftCornerRadius() {
            setCustomCornerRadius(_topLeftCornerRadius, "top-left");
        }
        function _updateTopRightCornerRadius() {
            setCustomCornerRadius(_topRightCornerRadius, "top-right");
        }
        function _updateBottomRightCornerRadius() {
            setCustomCornerRadius(_bottomRightCornerRadius, "bottom-right");
        }
        function _updateBottomLeftCornerRadius() {
            setCustomCornerRadius(_bottomLeftCornerRadius, "bottom-left");
        }
        function _updateRectangle() {
            movePoint(1, _width, 0);
            movePoint(2, _width, _height);
            movePoint(3, 0, _height);
            draw();
        }
        var _width = 100;
        var _height = 30;
    }
