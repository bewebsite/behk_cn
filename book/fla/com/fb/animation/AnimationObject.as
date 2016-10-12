
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.animation.AnimationObject
    {
        var parameterName, animationManager, id, pointIndex, pointX, duration, stopValue, thisObject, startValue, valueChange;
        function AnimationObject (parameterName, id, animationManager) {
            this.parameterName = parameterName;
            this.animationManager = animationManager;
            this.id = id;
            isColorParameter = parameterName.toUpperCase().indexOf("COLOR") != -1;
            isPointParameter = parameterName.toUpperCase().indexOf("POINT") != -1;
            if (isPointParameter) {
                pointIndex = Number(parameterName.substring(parameterName.indexOf("__") + 2, parameterName.length));
                pointX = parameterName.toUpperCase().indexOf("_X_") != -1;
            }
        }
        function startAnimation() {
            animationManager.removeCompetitors(this);
            animationManager.addToQueue(this);
        }
        function stopAnimation() {
            animationManager.removeFromQueue(this);
        }
        function get remaining() {
            return((delay + duration) - elapsed);
        }
        function get time() {
            return(elapsed);
        }
        function set time(newTime) {
            elapsed = newTime;
            update();
            //return(time);
        }
        function get animationDelay() {
            return(delay);
        }
        function set animationDelay(newDelay) {
            if (newDelay != undefined) {
                delay = newDelay;
            }
            //return(animationDelay);
        }
        function update() {
            if (finished) {
                stopAnimation();
                return(undefined);
            }
            if (elapsed >= delay) {
                if (!started) {
                    prepareAnimation();
                }
                setNewParameterValue(getNewParameterValue());
            }
            if ((elapsed - delay) >= duration) {
                setNewParameterValue(stopValue);
                finished = true;
            }
        }
        function setNewParameterValue(value) {
            if (isPointParameter) {
                if (pointX) {
                    thisObject.pointX(pointIndex, value);
                } else {
                    thisObject.pointY(pointIndex, value);
                }
            } else {
                thisObject[parameterName] = value;
            }
        }
        function getNewParameterValue() {
            if (isColorParameter) {
                var _local2 = startValue >> 16;
                var _local7 = stopValue >> 16;
                var _local6 = com.robertpenner.easing.Quad.easeOut(elapsed - delay, _local2, _local7 - _local2, duration);
                var _local4 = (startValue >> 8) & 255;
                var _local9 = (stopValue >> 8) & 255;
                var _local10 = com.robertpenner.easing.Quad.easeOut(elapsed - delay, _local4, _local9 - _local4, duration);
                var _local3 = startValue & 255;
                var _local8 = stopValue & 255;
                var _local5 = com.robertpenner.easing.Quad.easeOut(elapsed - delay, _local3, _local8 - _local3, duration);
                return(((_local6 << 16) | (_local10 << 8)) | _local5);
            } else {
                return(com.robertpenner.easing.Quad.easeOut(elapsed - delay, startValue, valueChange, duration));
            }
        }
        function getCurrentParameterValue() {
            if (isPointParameter) {
                if (pointX) {
                    return(thisObject.getPoint(pointIndex).x);
                } else {
                    return(thisObject.getPoint(pointIndex).y);
                }
            }
            return(thisObject[parameterName]);
        }
        function prepareAnimation() {
            var _local2 = stopValue - startValue;
            startValue = getCurrentParameterValue();
            valueChange = stopValue - startValue;
            started = true;
        }
        var delay = 0;
        var elapsed = 0;
        var started = false;
        var finished = false;
        var isColorParameter = false;
        var isPointParameter = false;
    }
