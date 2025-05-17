import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
import GlobalKeys;

typedef CustomIconMenuItemProps as {
    :identifier as Object or Number or String,
    :icon as ResourceId?,
    :label as ResourceId or String
};

typedef CustomColorMenuItemProps as {
    :identifier as Object or Number or String,
    :color as Number,
    :label as ResourceId or String
};

class CustomSettingMenuItem extends WatchUi.CustomMenuItem {
    var _label as ResourceId;
    var _icon as ResourceId?;
    var _color as Number?;

    function initialize(params as CustomIconMenuItemProps or CustomColorMenuItemProps) {
        WatchUi.CustomMenuItem.initialize(params.get(:identifier), {});

        self._label = params.get(:label);
        self._icon = params.get(:icon);
        self._color = params.get(:color);
    }

    function draw(drawContext as Dc) as Void {
        drawContext.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_WHITE);
        drawContext.fillRectangle(0, 0, drawContext.getWidth(), drawContext.getHeight());
        var iconWidth = 40;
        var font = Graphics.FONT_SMALL;
        var fontColor = Graphics.COLOR_DK_GRAY;
        var height = drawContext.getHeight();
        var labelText = self._label instanceof Lang.String ? self._label : WatchUi.loadResource(self._label);

        if (isFocused()) {
            font = Graphics.FONT_MEDIUM;
            fontColor = Graphics.COLOR_BLACK;
        }

        drawContext.setColor(fontColor, Graphics.COLOR_TRANSPARENT);
        drawContext.drawText(
            iconWidth,
            height / 2,
            font,
            labelText,
            Graphics.TEXT_JUSTIFY_LEFT | Graphics.TEXT_JUSTIFY_VCENTER
        );

        if (self._color != null) {
            drawContext.setColor(self._color, Graphics.COLOR_BLACK);
            drawContext.fillRectangle(0, 0, height, height);
        }

        if (self._icon != null) {
            drawContext.setColor(fontColor, Graphics.COLOR_TRANSPARENT);
            drawContext.drawText(
                iconWidth / 2,
                height / 2,
                WatchUi.loadResource(self._icon),
                GlobalKeys.ICON_SYMBOL,
                Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER
            );
        }
    }
}
