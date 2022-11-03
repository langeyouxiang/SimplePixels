import Toybox.Lang;
import Toybox.WatchUi;
import ObservedStoreModule;
import ObservedStoreModule.Scope;
import Services;
import SensorInfoModule.SensorType;
import SettingsModule;

class AwakeObservedKey extends ObservedStoreModule.KeyInstance {
    public static var key as String = "AwakeObservedKey";
    public var scope as Array<Scope.Enum> = [
        Scope.ON_UPDATE,
        Scope.ON_PARTIAL_UPDATE,
        Scope.ON_NIGHT_MODE_CHANGED,
    ] as Array<Scope.Enum>;

    private var _isAwake as Boolean;
    private var _mainView as WatchUi.View;

    function initialize(mainView as WatchUi.View, isAwake as Boolean) {
        ObservedStoreModule.KeyInstance.initialize();

        self._mainView = mainView;
        self._isAwake = isAwake;
    }

    function setIsAwake(isAwake as Boolean) as Void {
        self._isAwake = isAwake;
    }

    function get() as Lang.Object? {
        var service = Services.SensorInfo();
        var isNightMode = service.getValue(SensorType.IS_NIGHT_MODE_ENABLED);
        var isSleepTime = service.getValue(SensorType.IS_SLEEP_TIME);

        return isNightMode == true || isSleepTime == true ? false : self._isAwake;
    }

    private function updateViewProps(value as InstanceGetter) as Void {
        var isAwake = value as Boolean;
        var secondsViewID = $.VIEWS_LIST.get(:seconds);
        var secondsView = self._mainView.findDrawableById(secondsViewID) as SecondsView;
        var displaySecondsType = Services.ObservedStore().getValue(DisplaySecondsObservedKey) as DisplaySecondsType.Enum;

        secondsView.setViewProps(displaySecondsType, isAwake);
    }

    function onValueInit(value as InstanceGetter) as Void {
        self.updateViewProps(value);
    }

    function onValueUpdated(value as InstanceGetter, prevValue as InstanceGetter) as Void {
        self.updateViewProps(value);
    }
}