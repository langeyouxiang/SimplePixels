import Toybox.Lang;

module Services {
    enum ServiceType {
        SENSORS_INFO = 1,
        WATHERS_STORE,
    }

    var _cachedServices = {} as Dictionary<ServiceType, Object>;

    function register() as Void {
        if (_cachedServices.size() > 0) {
            return;
        }

        _cachedServices.put(SENSORS_INFO, new SensorInfoModule.SensorsInfoService());
        _cachedServices.put(WATHERS_STORE, new WatcherModule.Store());
    }

    function SensorInfo() as SensorInfoModule.SensorsInfoService {
        return _cachedServices.get(SENSORS_INFO);
    }

    function WathersStore() as WatcherModule.Store {
        return _cachedServices.get(WATHERS_STORE);
    }
}