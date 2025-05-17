import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;
import Components;

class BackgroundView extends Components.BaseDrawable {
    function initialize(params) {
        Components.BaseDrawable.initialize(params);
    }

    function draw(dc as Dc) as Void {
        var color = self.isAod ? Graphics.COLOR_BLACK : self.backgroundColor;

        dc.setColor(Graphics.COLOR_TRANSPARENT, color);
        dc.clear();
    }
}
