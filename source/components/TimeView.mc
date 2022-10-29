import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;

module Component {
    module TimeViewType {
        enum {
            HOURS = 1,
            MINUTES = 2,
        }
    }

    class TimeView extends Box {
        protected var _timeType as TimeViewType;
        protected var _is24hour as Boolean;
        protected var _textAligment as Graphics.TextJustification;

        private var _calculatedTextPosition as Dictionary or Null = null;
        
        function initialize(params as Dictionary<String, String?>) {
            Box.initialize(params);

            self._timeType = params.hasKey(:type) ? params.get(:type) : TimeViewType.HOURS;
            self._textAligment = params.hasKey(:textAligment) ? params.get(:textAligment) : Graphics.TEXT_JUSTIFY_LEFT;
            self._is24hour = System.getDeviceSettings().is24Hour;
        }

        private function getHours() as Number {
            var hours = System.getClockTime().hour;

            if (!self._is24hour && hours > 12) {
                hours = hours - 12;
            }

            return hours;
        }

        private function getMinutes() as Number {
            return System.getClockTime().min;
        }

        protected function getTime() as Number {
            switch (self._timeType) {
                case TimeViewType.HOURS:
                    return self.getHours();
                break;

                case TimeViewType.MINUTES:
                    return self.getMinutes();
                break;
            }
        }

        protected function calcTextPosition(drawContext as Dc) as {:x as Number, :y as Number} {
            if (self._calculatedTextPosition == null) {
                var position = self.getPosition();
                var boxSize = self.getActualBoxSize();
                var posX = position.get(:x);
                var posY = position.get(:y);
                var width = boxSize.get(:width);
                var height = boxSize.get(:height);

                switch(self._textAligment) {
                    case Graphics.TEXT_JUSTIFY_RIGHT:
                        posX += width;
                    break;
                    case Graphics.TEXT_JUSTIFY_CENTER:
                        posX += (width * 0.5).toNumber();
                        posY += (height * 0.5).toNumber();
                    break;
                    case Graphics.TEXT_JUSTIFY_VCENTER:
                        posY += (height * 0.5).toNumber();
                    break;
                }


                self._calculatedTextPosition = {
                    :x => posX,
                    :y => posY,
                };
            }

            return self._calculatedTextPosition;
        }

        protected function renderTime(time as Number, drawContext as Dc) as Void {
            var position = self.calcTextPosition(drawContext);
            var boxSize = self.getActualBoxSize();
            var posX = position.get(:x);
            var posY = position.get(:y);
            var width = boxSize.get(:width);
            var height = boxSize.get(:height);

            var backgroundColor = Graphics.COLOR_TRANSPARENT;
            var foregroundColor = self.foregroundColor;
            var font = self._font;

            drawContext.setColor(foregroundColor, backgroundColor);
            drawContext.drawText(posX, posY, font, time.format("%02d"), self._textAligment);
        }

        protected function render(drawContext as Dc) as Void {
            self.renderTime(self.getTime(), drawContext);
        }
    }
}

