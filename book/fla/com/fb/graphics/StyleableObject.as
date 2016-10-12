
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.graphics.StyleableObject
    {
        var _rootClip, _contentClip, _animationQueue, _gradientOpacity, _dropShadowClip, _innerShadowClip, _gradientClip, _gradientMaskClip;
        function StyleableObject (clip) {
            _rootClip = clip;
            _contentClip = _rootClip.createEmptyMovieClip("content", _contentDepth);
            _animationQueue = new com.fb.animation.AnimationQueue();
            _animationQueue.addEventListener("animationFinished", this);
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function get clip() {
            return(_rootClip);
        }
        function get x() {
            return(_x);
        }
        function set x(newX) {
            _x = newX;
            _repositionObject();
            //return(x);
        }
        function xTo(newX, duration, delay) {
            activateAnimationObject("_x", _repositionObject, "position", newX, duration, delay);
        }
        function get y() {
            return(_y);
        }
        function set y(newY) {
            _y = newY;
            _repositionObject();
            //return(y);
        }
        function yTo(newY, duration, delay) {
            activateAnimationObject("_y", _repositionObject, "position", newY, duration, delay);
        }
        function set blendMode(newMode) {
            _rootClip.blendMode = newMode;
            //return(blendMode);
        }
        function get blendMode() {
            return(String(_rootClip.blendMode));
        }
        function get color() {
            return(_contentColor);
        }
        function set color(newColor) {
            _contentColor = newColor;
            _drawColor();
            //return(color);
        }
        function colorTo(newColor, duration, delay) {
            activateAnimationObject("_contentColor", _drawColor, "shapeColor", newColor, duration, delay);
        }
        function set opacity(newOpacity) {
            _contentOpacity = newOpacity;
            _drawOpacity();
            //return(opacity);
        }
        function get opacity() {
            return(_contentOpacity);
        }
        function opacityTo(newOpacity, duration, delay) {
            activateAnimationObject("_contentOpacity", _drawOpacity, "shapeOpacity", newOpacity, duration, delay);
        }
        function set fill(newFill) {
            _contentFill = newFill;
            _drawFill();
            //return(fill);
        }
        function get fill() {
            return(_contentFill);
        }
        function fillTo(newFill, duration, delay) {
            activateAnimationObject("_contentFill", _drawFill, "shapeFill", newFill, duration, delay);
        }
        function get dropShadowSize() {
            return(_dsSize);
        }
        function set dropShadowSize(newSize) {
            _dsSize = newSize;
            _drawDropShadow();
            //return(dropShadowSize);
        }
        function dropShadowSizeTo(newSize, duration, delay) {
            activateAnimationObject("_dsSize", _drawDropShadow, "dropShadow", newSize, duration, delay);
        }
        function get dropShadowDistance() {
            return(_dsDistance);
        }
        function set dropShadowDistance(newDistance) {
            _dsDistance = newDistance;
            _drawDropShadow();
            //return(dropShadowDistance);
        }
        function dropShadowDistanceTo(newDistance, duration, delay) {
            activateAnimationObject("_dsDistance", _drawDropShadow, "dropShadow", newDistance, duration, delay);
        }
        function get dropShadowColor() {
            return(_dsColor);
        }
        function set dropShadowColor(newColor) {
            _dsColor = newColor;
            _drawDropShadow();
            //return(dropShadowColor);
        }
        function dropShadowColorTo(newColor, duration, delay) {
            activateAnimationObject("_dsColor", _drawDropShadow, "dropShadow", newColor, duration, delay);
        }
        function get dropShadowBlendMode() {
            return(_dsBlendMode);
        }
        function set dropShadowBlendMode(newBlendMode) {
            _dsBlendMode = newBlendMode;
            _drawDropShadow();
            //return(dropShadowBlendMode);
        }
        function get dropShadowOpacity() {
            return(_dsAlpha * 100);
        }
        function set dropShadowOpacity(newOpacity) {
            _dsAlpha = newOpacity / 100;
            _drawDropShadow();
            //return(dropShadowOpacity);
        }
        function dropShadowOpacityTo(newOpacity, duration, delay) {
            newOpacity = newOpacity / 100;
            activateAnimationObject("_dsAlpha", _drawDropShadow, "dropShadow", newOpacity, duration, delay);
        }
        function get dropShadowQuality() {
            return(_dsQuality);
        }
        function set dropShadowQuality(newQuality) {
            _dsQuality = newQuality;
            _drawDropShadow();
            //return(dropShadowQuality);
        }
        function get dropShadowAngle() {
            return(_dsAngle);
        }
        function set dropShadowAngle(newAngle) {
            _dsAngle = newAngle;
            _drawDropShadow();
            //return(dropShadowAngle);
        }
        function dropShadowAngleTo(newAngle, duration, delay) {
            activateAnimationObject("_dsAngle", _drawDropShadow, "dropShadow", newAngle, duration, delay);
        }
        function get innerShadowSize() {
            return(_isSize);
        }
        function set innerShadowSize(newSize) {
            _isSize = newSize;
            _drawInnerShadow();
            //return(innerShadowSize);
        }
        function innerShadowSizeTo(newSize, duration, delay) {
            activateAnimationObject("_isSize", _drawInnerShadow, "innerShadow", newSize, duration, delay);
        }
        function get innerShadowDistance() {
            return(_isDistance);
        }
        function set innerShadowDistance(newDistance) {
            _isDistance = newDistance;
            _drawInnerShadow();
            //return(innerShadowDistance);
        }
        function innerShadowDistanceTo(newDistance, duration, delay) {
            activateAnimationObject("_isDistance", _drawInnerShadow, "innerShadow", newDistance, duration, delay);
        }
        function get innerShadowBlendMode() {
            return(_isBlendMode);
        }
        function set innerShadowBlendMode(newBlendMode) {
            _isBlendMode = newBlendMode;
            _drawInnerShadow();
            //return(innerShadowBlendMode);
        }
        function get innerShadowOpacity() {
            return(_isAlpha * 100);
        }
        function set innerShadowOpacity(newOpacity) {
            _isAlpha = newOpacity / 100;
            _drawInnerShadow();
            //return(innerShadowOpacity);
        }
        function innerShadowOpacityTo(newOpacity, duration, delay) {
            newOpacity = newOpacity / 100;
            activateAnimationObject("_isAlpha", _drawInnerShadow, "innerShadow", newOpacity, duration, delay);
        }
        function get innerShadowColor() {
            return(_isColor);
        }
        function set innerShadowColor(newColor) {
            _isColor = newColor;
            _drawInnerShadow();
            //return(innerShadowColor);
        }
        function innerShadowColorTo(newColor, duration, delay) {
            activateAnimationObject("_isColor", _drawInnerShadow, "innerShadow", newColor, duration, delay);
        }
        function get innerShadowQuality() {
            return(_isQuality);
        }
        function set innerShadowQuality(newQuality) {
            _isQuality = newQuality;
            _drawInnerShadow();
            //return(innerShadowQuality);
        }
        function get innerShadowAngle() {
            return(_isAngle);
        }
        function set innerShadowAngle(newAngle) {
            _isAngle = newAngle;
            _drawInnerShadow();
            //return(innerShadowAngle);
        }
        function innerShadowAngleTo(newAngle, duration, delay) {
            activateAnimationObject("_isAngle", _drawInnerShadow, "innerShadow", newAngle, duration, delay);
        }
        function get gradientAngle() {
            return(_gradientAngle);
        }
        function set gradientAngle(newAngle) {
            _gradientAngle = newAngle;
            _drawGradient();
            //return(gradientAngle);
        }
        function gradientAngleTo(newAngle, duration, delay) {
            activateAnimationObject("_gradientAngle", _drawGradient, "gradient", newAngle, duration, delay);
        }
        function get gradientOpacity() {
            return(_gradientOpacity);
        }
        function set gradientOpacity(newOpacity) {
            _gradientOpacity = newOpacity;
            _drawGradient();
            //return(gradientOpacity);
        }
        function gradientOpacityTo(newOpacity, duration, delay) {
            activateAnimationObject("_gradientOpacity", _drawGradient, "gradient", newOpacity, duration, delay);
        }
        function get gradientScale() {
            return(_gradientScale);
        }
        function set gradientScale(newScale) {
            _gradientScale = newScale;
            _drawGradient();
            //return(gradientScale);
        }
        function gradientScaleTo(newScale, duration, delay) {
            activateAnimationObject("_gradientScale", _drawGradient, "gradient", newScale, duration, delay);
        }
        function get gradientBlendMode() {
            return(_gradientBlendMode);
        }
        function set gradientBlendMode(newBlendMode) {
            _gradientBlendMode = newBlendMode;
            _drawGradient();
            //return(gradientBlendMode);
        }
        function get gradientFromColor() {
            return(_gradientFromColor);
        }
        function set gradientFromColor(newColor) {
            _gradientFromColor = newColor;
            _drawGradient();
            //return(gradientFromColor);
        }
        function gradientFromColorTo(newColor, duration, delay) {
            activateAnimationObject("_gradientFromColor", _drawGradient, "gradient", newColor, duration, delay);
        }
        function get gradientFromAlpha() {
            return(_gradientFromAlpha);
        }
        function set gradientFromAlpha(newAlpha) {
            _gradientFromAlpha = newAlpha;
            _drawGradient();
            //return(gradientFromAlpha);
        }
        function gradientFromAlphaTo(newAlpha, duration, delay) {
            activateAnimationObject("_gradientFromAlpha", _drawGradient, "gradient", newAlpha, duration, delay);
        }
        function get gradientToColor() {
            return(_gradientToColor);
        }
        function set gradientToColor(newColor) {
            _gradientToColor = newColor;
            _drawGradient();
            //return(gradientToColor);
        }
        function gradientToColorTo(newColor, duration, delay) {
            activateAnimationObject("_gradientToColor", _drawGradient, "gradient", newColor, duration, delay);
        }
        function get gradientToAlpha() {
            return(_gradientToAlpha);
        }
        function set gradientToAlpha(newAlpha) {
            _gradientToAlpha = newAlpha;
            _drawGradient();
            //return(gradientToAlpha);
        }
        function gradientToAlphaTo(newAlpha, duration, delay) {
            activateAnimationObject("_gradientToAlpha", _drawGradient, "gradient", newAlpha, duration, delay);
        }
        function get gradientReverse() {
            return(_gradientReverse);
        }
        function set gradientReverse(reverse) {
            _gradientReverse = reverse;
            _drawGradient();
            //return(gradientReverse);
        }
        function stopAnimation() {
            _animationQueue.stopAnimation();
        }
        function show() {
            _rootClip._visible = true;
        }
        function hide() {
            _rootClip._visible = false;
        }
        function _drawFill() {
            _contentClip._alpha = _contentFill;
        }
        function _drawOpacity() {
            _rootClip._alpha = _contentOpacity;
        }
        function _drawColor() {
            var _local2 = new Color(_contentClip);
            _local2.setRGB(_contentColor);
        }
        function _repositionObject() {
            _rootClip._x = _x;
            _rootClip._y = _y;
        }
        function _drawDropShadow() {
            var _local2 = new flash.filters.DropShadowFilter(_dsDistance, _dsAngle, _dsColor, _dsAlpha, _dsSize, _dsSize, _dsStrength, _dsQuality, false, true, false);
            _createDropShadowClip();
            _dropShadowClip.filters = [_local2];
            _dropShadowClip.blendMode = _dsBlendMode;
        }
        function _drawInnerShadow() {
            var _local2 = new flash.filters.DropShadowFilter(_isDistance, _isAngle, _isColor, _isAlpha, _isSize, _isSize, _isStrength, _isQuality, true, true, false);
            _createInnerShadowClip();
            _innerShadowClip.filters = [_local2];
            _innerShadowClip.blendMode = _isBlendMode;
        }
        function _drawGradient() {
            _createGradientClip();
            _createGradientMaskClip();
            _gradientClip.clear();
            var _local3 = _rootClip._width;
            var _local2 = _rootClip._height;
            var _local6 = (_gradientReverse ? (180 + _gradientAngle) : (_gradientAngle));
            var _local7 = [_gradientFromColor, _gradientToColor];
            var _local5 = [_gradientFromAlpha, _gradientToAlpha];
            var _local8 = [128 - ((128 * _gradientScale) / 100), 128 + ((127 * _gradientScale) / 100)];
            var _local4 = new flash.geom.Matrix();
            _local4.createGradientBox(_local3, _local2, (Math.PI/180) * _local6);
            _gradientClip.beginGradientFill("linear", _local7, _local5, _local8, _local4);
            _gradientClip.moveTo(0, 0);
            _gradientClip.lineTo(_local3, 0);
            _gradientClip.lineTo(_local3, _local2);
            _gradientClip.lineTo(0, _local2);
            _gradientClip.lineTo(0, 0);
            _gradientClip.endFill();
            _gradientClip._alpha = _gradientOpacity;
            _gradientClip.blendMode = _gradientBlendMode;
            _gradientClip.setMask(_gradientMaskClip);
        }
        function _createGradientClip() {
            if (_gradientClip == undefined) {
                _gradientClip = _rootClip.createEmptyMovieClip("gradient", _gradientDepth);
            }
        }
        function startAnimation() {
            if (_rootClip.onEnterFrame == undefined) {
                _rootClip.onEnterFrame = mx.utils.Delegate.create(this, animateStyles);
            }
        }
        function animateStyles() {
            _animationQueue.updateObjects();
            if (_animationQueue.queueIsEmpty()) {
                _animationQueue.stopTimer();
                delete _rootClip.onEnterFrame;
            }
        }
        function activateAnimationObject(parameterName, functionReference, renderGroupName, stopValue, duration, delay) {
            var _local2 = _animationQueue.getAnimationObject(parameterName);
            _local2.functionReference = functionReference;
            _local2.thisObject = this;
            if (_local2.isPointParameter) {
                if (_local2.pointX) {
                    _local2.startValue = getPoint(_local2.pointIndex).x;
                } else {
                    _local2.startValue = getPoint(_local2.pointIndex).y;
                }
            } else {
                _local2.startValue = this[parameterName];
            }
            _local2.renderGroupName = renderGroupName;
            _local2.stopValue = stopValue;
            _local2.duration = duration;
            _local2.__set__animationDelay(delay);
            _local2.startAnimation();
            startAnimation();
        }
        function animationFinished() {
            dispatchEvent({type:"animationFinished", target:this});
        }
        function _createDropShadowClip() {
        }
        function _createInnerShadowClip() {
        }
        function _createGradientMaskClip() {
        }
        function _createStrokeClip() {
        }
        function getPoint() {
        }
        var animationId = "default";
        var _x = 0;
        var _y = 0;
        var _contentColor = 0;
        var _contentFill = 100;
        var _contentOpacity = 100;
        var _contentBlendMode = "normal";
        var _contentDepth = 2;
        var _dsDistance = 5;
        var _dsAngle = 45;
        var _dsColor = 0;
        var _dsAlpha = 1;
        var _dsSize = 5;
        var _dsStrength = 1;
        var _dsQuality = 1;
        var _dsBlendMode = "normal";
        var _dropShadowDepth = 0;
        var _isDistance = 5;
        var _isAngle = 45;
        var _isColor = 0;
        var _isAlpha = 1;
        var _isSize = 5;
        var _isStrength = 1;
        var _isQuality = 1;
        var _isBlendMode = "normal";
        var _innerShadowDepth = 3;
        var _gradientAngle = 90;
        var _gradientScale = 50;
        var _gradientBlendMode = "normal";
        var _gradientFromColor = 16777215;
        var _gradientToColor = 0;
        var _gradientFromAlpha = 100;
        var _gradientToAlpha = 100;
        var _gradientReverse = false;
        var _gradientDepth = 4;
        var _gradientMaskDepth = 5;
        var _strokeSize = 3;
        var _strokeColor = 16711680;
        var _strokePosition = "outer";
        var _strokeBlendMode = "normal";
        var _strokeOpacity = 100;
        var _strokeDepth = 6;
    }
