/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 09.02.11
 * Time: 19:36
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.api {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.text.Font;
import flash.text.StyleSheet;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.Dictionary;

public class TextUtils {

    /*
     [Embed(source='../../../../../resources/fonts/ds_crystal.ttf', embedAsCFF = "false", fontName="DS Crystal", mimeType="application/x-font-truetype")]
     private static var DC_CRYSTAL_FONT:Class;
     */
    [Embed(source='../base/resources/fonts/ACADEMY.TTF', embedAsCFF = "false", fontName="Academy", mimeType="application/x-font-truetype")]
    private static var ACADEMY_FONT:Class;

    [Embed(source='../base/resources/fonts/PRESENT.TTF', embedAsCFF = "false", fontName="Presentum", mimeType="application/x-font-truetype")]
    private static var PRESENTUM_FONT:Class;

    [Embed(source='../base/resources/fonts/IRISN4.TTF', embedAsCFF = "false", fontName="Iris", mimeType="application/x-font-truetype")]
    private static var IRIS_FONT:Class;

    [Embed(systemFont="Arial", fontName="InputArial", embedAsCFF = "false", mimeType="application/x-font")]
    private static var ARIAL_FONT:Class;

    public static const SMALL_TEXT_SIZE:int = 14;
    public static const NORMAL_TEXT_SIZE:int = 18;
    public static const LARGE_TEXT_SIZE:int = 24;
    public static const X_LARGE_TEXT_SIZE:int = 32;

    public static const FONT_MESSAGES:String = "Academy";
    public static const FONT_INPUT:String = "InputArial";

    public static const CSS:String =
            " p , li {font-family: " + FONT_MESSAGES + "; font-size: 20; color:#ffffff;} " +
                    ".h1 { color:#ee82ee; font-size: 32; } " +
                    ".h15 { color:#ee82ee; font-size: 24; } " +
                    ".h2 { color:#0082ee; font-size: 20; } " +
                    ".footnote {font-size: 14} " +
                    ".warning {color:#ffaa44; font-size: smaller} " +
                    ".c {textAlign: center;}";

    private static function prepareTextField(text:String, x0:int, y0:int, size:int, align:String, color:uint, alpha:Number):TextField {
        var tf:TextField = new TextField;
        tf.text = text;
        tf.setTextFormat(new TextFormat('Academy', size));
        tf.x = x0;
        tf.y = y0;
        tf.textColor = color;
        tf.alpha = alpha;
        tf.autoSize = align;
        tf.embedFonts = true;
        return tf;
    }

    public static function drawText(text:String, size:int, align:String, color:uint, alpha:Number):TextField {
        return prepareTextField(text, 0, 0, size, align, color, alpha);
    }

    public static function drawTextWidth(text:String, width:int, size:int, align:String, color:uint, alpha:Number):TextField {
        var tf:TextField = prepareTextField(text, 0, 0, size, align, color, alpha);
        tf.width = width;
        tf.wordWrap = true;
        tf.multiline = true;
        return tf;
    }

    private static var textOutInfo:Dictionary = new Dictionary();

    public static function moveTo(container:DisplayObjectContainer, x:int, y:int, lineSkip:int, width:int = -1):void {
        textOutInfo[container] = {x : x, y : y, width : width, lineSkip:lineSkip};
    }

    public static function output(container:DisplayObjectContainer, message:DisplayObject, align:String = TextFieldAutoSize.LEFT):void {
        var info:Object = textOutInfo[container];
        var x:int = info.x;
        var y:int = info.y;
        switch (align) {
            case TextFieldAutoSize.RIGHT:
                x = info.x + info.width - message.width;
                break;
            case TextFieldAutoSize.CENTER:
                x = info.x + (info.width - message.width) / 2;
                break;
        }

        message.x = x;
        message.y = y;

        container.addChild(message);
        info.y += message.height + info.lineSkip;
    }

    public static function createCustomTextField(multiline:Boolean = true):TextField {
        var tf:TextField = new TextField();
        tf.multiline = multiline;
        tf.wordWrap = multiline;
        tf.embedFonts = true;
        tf.autoSize = TextFieldAutoSize.LEFT;
        tf.styleSheet = new StyleSheet();
        tf.styleSheet.parseCSS(TextUtils.CSS);
        tf.selectable = false;
        return tf;
    }

}
}
