import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
import Services;
import ObserverModule;
import GlobalKeys;
import SettingsModule;

class SimplePixelsView extends WatchUi.WatchFace {
    private var _wasShowed = false;

    function initialize() {
        WatchFace.initialize();
        GlobalKeys.initSettings();
        Services.register();
    }

    function _onConnectionChanged(
        value as ObserverModule.InstanceGetter,
        prevValue as ObserverModule.InstanceGetter
    ) as Void {
        OWBackgroundController.setup();
    }

    function _onAODChanged(
        value as ObserverModule.InstanceGetter,
        prevValue as ObserverModule.InstanceGetter
    ) as Void {
        if (GlobalKeys.IS_AMOLED) {
            aodMode(value as Boolean);
        }
    }

    function _onAwakeChanged(
        value as ObserverModule.InstanceGetter,
        prevValue as ObserverModule.InstanceGetter
    ) as Void {
        var secondsView = self.findDrawableById(ViewsKeys.SECONDS) as SecondsView;

        secondsView.setViewProps(value as Boolean);
        WatchUi.requestUpdate();
    }

    function aodMode(isAod as Boolean) {
        var viewValues = ViewsKeys.VALUES;

        for (var i = 0; i < viewValues.size(); i++) {
            var id = viewValues[i] as String;
            var view = self.findDrawableById(id);

            (view as Components.BaseDrawable).setAodMode(isAod);
        }
        WatchUi.requestUpdate();
    }

    function onInit(drawContext as Dc) as Void {
        Services.ObserverStore().setup(
            [
                new AwakeObserver(self.method(:_onAwakeChanged), true),
                new ConnectionObserverObserver(self.method(:_onConnectionChanged)),
                new AODObserver(self.method(:_onAODChanged))
            ] as Array<ValueObserver>
        );

        if (GlobalKeys.IS_NEW_SDK) {
            Services.SensorInfo().init();
        }
    }

    function onLayout(drawContext as Dc) as Void {
        WatchFace.setLayout(Rez.Layouts.MainLayout(drawContext));

        self.onInit(drawContext);
    }

    function onUpdate(drawContext as Dc) as Void {
        drawContext.clearClip();

        Services.ObserverStore().runScope(ObserverModule.ON_UPDATE);

        WatchFace.onUpdate(drawContext);

        if (!GlobalKeys.IS_NEW_SDK) {
            Services.SensorInfo().init();
        }
    }

    function onPartialUpdate(drawContext as Dc) as Void {
        drawContext.clearClip();

        AwakeObserver.isAwake = false;
        Services.ObserverStore().runScope(ObserverModule.ON_PARTIAL_UPDATE);

        WatchFace.onPartialUpdate(drawContext);
    }

    function onShow() as Void {
        if (!self._wasShowed) {
            self._wasShowed = true;
        } else {
            // need to skip the initial rendering but update global attributes next time
            GlobalKeys.initSettings();
        }

        AwakeObserver.isAwake = true;
        Services.ObserverStore().runScope(ObserverModule.ON_EXIT_SLEEP);

        WatchFace.onShow();
    }

    function onEnterSleep() as Void {
        AwakeObserver.isAwake = false;
        Services.ObserverStore().runScope(ObserverModule.ON_ENTER_SLEEP);

        WatchFace.onEnterSleep();
    }

    function onExitSleep() as Void {
        AwakeObserver.isAwake = true;
        Services.ObserverStore().runScope(ObserverModule.ON_EXIT_SLEEP);

        WatchFace.onExitSleep();
    }

    function onNightModeChanged() as Void {
        AwakeObserver.isAwake = false;
        Services.ObserverStore().runScope(ObserverModule.ON_NIGHT_MODE_CHANGED);
    }

    function onSettingsChanged() as Void {
        Services.ObserverStore().runScope(ObserverModule.ON_SETTINGS_CHANGED);

        var viewValues = ViewsKeys.VALUES;

        for (var i = 0; i < viewValues.size(); i++) {
            var id = viewValues[i] as String;
            var view = self.findDrawableById(id);

            (view as Components.BaseDrawable).onSettingsChanged();
        }

        WatchUi.requestUpdate();
    }
}
