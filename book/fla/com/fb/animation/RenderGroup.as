
//Created by Action Script Viewer - http://www.buraks.com/asv
    class com.fb.animation.RenderGroup
    {
        var functionReference, thisObject, name;
        function RenderGroup (groupName, functionReference, thisObject) {
            this.functionReference = functionReference;
            this.thisObject = thisObject;
            name = groupName;
        }
        function render() {
            functionReference.call(thisObject);
        }
        var objectsCount = 0;
    }
