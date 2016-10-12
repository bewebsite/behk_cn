
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.animation.AnimationQueue
    {
        var animationQueue, renderGroups, now, previousTime, timeChange;
        function AnimationQueue () {
            animationQueue = new Array();
            renderGroups = new Array();
            mx.events.EventDispatcher.initialize(this);
        }
        function addEventListener() {
        }
        function removeEventListener() {
        }
        function dispatchEvent() {
        }
        function getAnimationObject(parameterName) {
            return(new com.fb.animation.AnimationObject(parameterName, String(++idCounter), this));
        }
        function updateObjects() {
            var _local4 = new Date();
            now = _local4.getTime();
            if (previousTime == undefined) {
                previousTime = now;
            }
            timeChange = now - previousTime;
            previousTime = now;
            var _local3 = 0;
            while (_local3 < animationQueue.length) {
                animationQueue[_local3].time = animationQueue[_local3].time + timeChange;
                _local3++;
            }
            var _local2 = 0;
            while (_local2 < renderGroups.length) {
                renderGroups[_local2].render();
                _local2++;
            }
        }
        function stopTimer() {
            previousTime = undefined;
        }
        function removeCompetitors(animationObject) {
            var _local2 = 0;
            while (_local2 < animationQueue.length) {
                if (competitionBetween(animationObject, animationQueue[_local2])) {
                    animationQueue[_local2].stopAnimation();
                }
                _local2++;
            }
        }
        function competitionBetween(newObject, existingObject) {
            var _local2 = newObject.parameterName == existingObject.parameterName;
            var _local1 = existingObject.__get__remaining() > newObject.delay;
            return(_local2 && (_local1));
        }
        function addToQueue(animationObject) {
            var _local5 = getItemIndex(animationQueue, "id", animationObject.id);
            if (_local5 == -1) {
                animationQueue.push(animationObject);
                var _local4 = getItemIndex(renderGroups, "name", animationObject.renderGroupName);
                var _local3;
                if (_local4 == -1) {
                    _local3 = new com.fb.animation.RenderGroup(animationObject.renderGroupName, animationObject.functionReference, animationObject.thisObject);
                    renderGroups.push(_local3);
                } else {
                    _local3 = renderGroups[_local4];
                }
                _local3.objectsCount++;
            }
        }
        function removeFromQueue(animationObject) {
            var _local3 = getItemIndex(animationQueue, "id", animationObject.id);
            if (_local3 != undefined) {
                animationQueue.splice(_local3, 1);
                var _local2 = getItemIndex(renderGroups, "name", animationObject.renderGroupName);
                var _local4 = renderGroups[_local2];
                if ((--_local4.objectsCount) == 0) {
                    renderGroups.splice(_local2, 1);
                }
            }
            if (animationQueue.length == 0) {
                dispatchEvent({type:"animationFinished"});
            }
        }
        function stopAnimation() {
            var _local2 = 0;
            while (_local2 < animationQueue.length) {
                var _local3 = animationQueue[_local2];
                removeFromQueue(_local3);
                _local2++;
            }
        }
        function queueIsEmpty() {
            return(animationQueue.length == 0);
        }
        function getItemIndex(searhArray, itemKey, itemId) {
            var _local1 = 0;
            while (_local1 < searhArray.length) {
                if (searhArray[_local1][itemKey] == itemId) {
                    return(_local1);
                }
                _local1++;
            }
            return(-1);
        }
        var idCounter = 0;
    }
