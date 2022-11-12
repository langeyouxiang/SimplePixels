import Toybox.Lang;
import Toybox.WatchUi;
import SettingsModule.SettingType;
import SettingsMenuBuilder;

function SettingsMenu() as WatchUi.Menu2 or WatchUi.CustomMenu {
    return SettingsMenuBuilder.generateMenu({
        :buider => SettingsMenuBuilder.MENU,
        :buiderProps => { :title => Rez.Strings.SettingsMenu },
        :items => [
            // Color
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.BACKGROUND_COLOR,
                    :label => Rez.Strings.BackgroundColorTitle
                }
            },
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.FOREGROUND_COLOR,
                    :label => Rez.Strings.ForegroundColorTitle,
                    :subLabel => Rez.Strings.ForegroundColorSubLabel
                }
            },
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.TEXT_COLOR,
                    :label => Rez.Strings.TextColorTitle,
                    :subLabel => Rez.Strings.TextColorTitleSubLabel
                }
            },
            // Main
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.DISPLAY_SECONDS,
                    :label => Rez.Strings.DisplaySeconds
                }
            },
            // Separator
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.SEPARATOR_COLOR,
                    :label => Rez.Strings.SeparatorColorTitle
                }
            },
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.SEPARATOR_INFO,
                    :label => Rez.Strings.SeparatorInfoTitle
                }
            },
            // Left Sensor Info
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.LEFT_SENSOR,
                    :label => Rez.Strings.LeftSensor
                }
            },
            {
                :buider => SettingsMenuBuilder.TOGGLE_ITEM,
                :valueKey => SettingType.DISPLAY_STATUS_ICONS,
                :buiderProps => {
                    :identifier => SettingType.DISPLAY_STATUS_ICONS,
                    :label => Rez.Strings.DisplayStatusIcons,
                    :options => {
                        :alignment => WatchUi.MenuItem.MENU_ITEM_LABEL_ALIGN_RIGHT
                    }
                }
            },
            // Top Sensor Fields
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.TOP_SENSOR_1,
                    :label => Rez.Strings.TopSensor1
                }
            },
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.TOP_SENSOR_2,
                    :label => Rez.Strings.TopSensor2
                }
            },
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.TOP_SENSOR_3,
                    :label => Rez.Strings.TopSensor3
                }
            },
            // Bottom Sensor Fields
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.BOTTOM_SENSOR_1,
                    :label => Rez.Strings.BottomSensor1
                }
            },
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.BOTTOM_SENSOR_2,
                    :label => Rez.Strings.BottomSensor2
                }
            },
            {
                :buider => SettingsMenuBuilder.ITEM,
                :buiderProps => {
                    :identifier => SettingType.BOTTOM_SENSOR_3,
                    :label => Rez.Strings.BottomSensor3
                }
            }
        ] as Array<GenerateItemProps>
    });
}
