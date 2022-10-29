import Toybox.Lang;
import Toybox.Graphics;
import Toybox.WatchUi;

class DrawableMenuFooter extends WatchUi.Drawable {
    function initialize() {
        Drawable.initialize({});
    }

    function draw(drawContext as Dc) {
        drawContext.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK);
        drawContext.drawLine(0, 0, drawContext.getWidth(), 0);
    }
}
