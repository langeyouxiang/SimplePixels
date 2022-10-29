import Toybox.Lang;

module PositionUtils {
    enum AlignmentEnum {
        ALIGN_START = "start",
        ALIGN_CENTER = "center",
        ALIGN_END = "end"
    }

    function parsePosition(position as String, size as Number) as Number {
        var mode = position.find("%") ? "percent" : "regular";
        var originalPosition = position.toNumber();
        
        var result = 0;

        switch(mode) {
            case "percent":
                result = (originalPosition.toFloat() / 100);
                result = size.toFloat() * result;

                result = result.toNumber();
            break;
            case "regular":
                result = originalPosition;
            break;
        }

        return result;
    }

    function calcAlignmentShift(alignment as AlignmentEnum, pointSize as Number) as Number {
        var result = 0;

        switch(alignment) {
            case ALIGN_START:
                result = 0;
            break;
            case ALIGN_END:
                result = pointSize;
            break;
            case ALIGN_CENTER:
                result = pointSize / 2;
            break;
        }

        return result;
    }
}
