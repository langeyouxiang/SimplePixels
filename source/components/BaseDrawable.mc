import Toybox.Lang;
import Toybox.WatchUi;
import ColorsModule;
import SettingsModule;
import SettingsModule.SettingType;

module Component {
    class BaseDrawable extends WatchUi.Drawable {        
        protected var backgroundColor as Number = 0;
        protected var foregroundColor as Number = 0;
        protected var textColor as Number = 0;

        function initialize(params) {
            self.onSettingsChanged();

            Drawable.initialize(params);
        }

        public function onSettingsChanged() {
            var backgroundColor = SettingsModule.getValue(SettingType.BACKGROUND_COLOR) as ColorsTypes.Enum;
            var foregroundColor = SettingsModule.getValue(SettingType.FOREGROUND_COLOR) as ColorsTypes.Enum;
            var textColor = SettingsModule.getValue(SettingType.TEXT_COLOR) as ColorsTypes.Enum;

            self.backgroundColor = ColorsModule.getColor(backgroundColor);
            self.foregroundColor = ColorsModule.getColor(foregroundColor);
            self.textColor = ColorsModule.getColor(textColor);
        }
    }
}