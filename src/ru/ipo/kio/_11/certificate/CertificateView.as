/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 22.04.11
 * Time: 17:07
 */
package ru.ipo.kio._11.certificate {
import flash.events.TimerEvent;
import flash.geom.Rectangle;

import flash.printing.PrintJobOptions;

import flash.text.TextFieldAutoSize;

import flash.utils.Timer;

import ru.ipo.kio._11.*;

import com.adobe.serialization.json.JSON;

import flash.display.BitmapData;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.errors.IOError;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.printing.PrintJob;
import flash.text.TextField;
import flash.utils.ByteArray;

import mx.core.BitmapAsset;

import ru.ipo.kio.api.TextUtils;
import ru.ipo.kio.base.displays.ShellButton;

public class CertificateView extends Sprite {

    private var WELCOME_MESSAGE:String = "<p class='h1' align='center'>Нажмите на любое место экрана, чтобы загрузить сертификат</p>";
    private var LOADING_MESSAGE:String = "<p align='center'>Загрузка...</p>";

    [Embed(source="../resources/Sertificat_005b.png")]
    private static var WITH_RANK:Class;
    private var IMG_RANK:BitmapAsset = new WITH_RANK;

    [Embed(source="../resources/Sertificat_005bb.png")]
    private static var NO_RANK:Class;
    private var IMG_NO_RANK:BitmapAsset = new NO_RANK;

    [Embed(systemFont="Arial", fontName="KioArial", embedAsCFF = "false", fontWeight="bold", mimeType="application/x-font")]
    private static var ARIAL_FONT:Class;

    [Embed(
            source='../resources/AmbassadoreType.ttf',
            embedAsCFF = "false",
            fontName="KioAmbassadore",
            mimeType="application/x-font-truetype",
            unicodeRange = "U+0000-U+FFFF"
            )]
    private static var AMBASSADORE_FONT:Class;

    [Embed(
            source='../resources/AmbassadoreType Italic.Ttf',
            embedAsCFF = "false",
            fontStyle = "italic",
            fontName="KioAmbassadore",
            mimeType="application/x-font-truetype",
            unicodeRange = "U+0000-U+FFFF"
            )]
    private static var AMBASSADORE_BD_FONT:Class;

    private static const BUTTONS_LEFT:int = 4;
    private static const BUTTONS_SKIP:int = 10;
    private static const BUTTONS_TOP:int = 4;

    //buttons panel
    private var buttonsPanel:Sprite;
    private var slider:Slider;

    //welcome panel
    private var welcomePanel:Sprite;
    private var helloTextField:TextField;

    //certificate panel
    private var certificatePanel:Sprite;
    private var img:BitmapData = null;

    private var topHeight:int;

    private var certificateFile:FileReference;

    private static const certColor:uint = 0xbfdbff;
    private static const certLightColor:uint = 0xdfedff;

    public function CertificateView() {
        if (!stage)
            addEventListener(Event.ADDED_TO_STAGE, init);
        else
            init();
    }

    private function init(event:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;

        stage.addEventListener(Event.RESIZE, placeElement);

        //draw a rectangle
        graphics.beginFill(certLightColor);
        graphics.drawRect(0, 0, 8000, 8000);
        graphics.endFill();

        createButtonsPanel();
        createCertificatePanel();
        createWelcomePanel();

        placeElement();

        addChild(welcomePanel);
        stage.addEventListener(MouseEvent.CLICK, function(event:MouseEvent):void {
            trace(event.stageX, event.stageY, event.localX, event.localY);
        });
    }

    private function createCertificatePanel():void {
        certificatePanel = new Sprite;
        certificatePanel.x = 0;
        certificatePanel.y = topHeight;
        certificatePanel.addEventListener(MouseEvent.MOUSE_DOWN, certificateMouseDown);
        stage.addEventListener(MouseEvent.MOUSE_UP, certificateMouseUp);
    }

    private function certificateMouseDown(event:Event):void {
//        var span:Number = Math.max(0, certificatePanel.height - stage.stageHeight + topHeight);
//        certificatePanel.startDrag(false, new Rectangle(certificatePanel.x, buttonsPanel.height - span, 0, span));
        trace('certificate panel x', certificatePanel.x);
        trace('cph', certificatePanel.height);
        trace('topHeight - cph / 2', topHeight - certificatePanel.height / 2);
        trace('sh - th', stage.stageHeight - topHeight);
        certificatePanel.startDrag(false, new Rectangle(
                certificatePanel.x,
            //2 * (topHeight + stage.stageHeight) / 3 - certificatePanel.height,
                minY(),
                0,
            //certificatePanel.height - (topHeight + stage.stageHeight) / 3
                maxY() - minY()
                ));
    }

    private function maxY():Number {
        return minY() + topHeight + 32 - stage.stageHeight + certificatePanel.height;
    }

    private function minY():Number {
        return stage.stageHeight - certificatePanel.height - 16;
    }

    private function certificateMouseUp(event:Event):void {
        certificatePanel.stopDrag();
    }

    private function createButtonsPanel():void {
        buttonsPanel = new Sprite;
        var load:SimpleButton = new ShellButton("Загрузить");
        var print:SimpleButton = new ShellButton("Напечатать");
        slider = new Slider(0, 1, 150);

        load.x = BUTTONS_LEFT;
        load.y = BUTTONS_TOP;
        print.x = load.x + load.width + BUTTONS_SKIP;
        print.y = BUTTONS_TOP;
        slider.x = print.x + print.width + BUTTONS_SKIP;
        slider.y = BUTTONS_TOP;

        slider.addEventListener(Slider.VALUE_CHANGED, rescaleCertificate);

        load.addEventListener(MouseEvent.CLICK, loadClick);
        print.addEventListener(MouseEvent.CLICK, printClick);

        buttonsPanel.addChild(load);
        buttonsPanel.addChild(print);
        buttonsPanel.addChild(slider);

        topHeight = 2 * BUTTONS_TOP + load.height;

        buttonsPanel.graphics.beginFill(certLightColor);
        buttonsPanel.graphics.drawRect(0, 0, 4000, topHeight);
        buttonsPanel.graphics.endFill();
    }

    private function loadClick(event:MouseEvent):void {
        helloTextField.htmlText = WELCOME_MESSAGE + LOADING_MESSAGE;

        var smallLatency:Timer = new Timer(100, 1);
        smallLatency.addEventListener(TimerEvent.TIMER, function(event:Event):void {
            certificateFile = new FileReference();
            certificateFile.addEventListener(Event.SELECT, fileSelected);
            certificateFile.addEventListener(Event.CANCEL, fileSelectionCanceled);
            certificateFile.browse([
                new FileFilter("Файлы сертификатов конкурса КИО", "*.kio-certificate"),
                new FileFilter("Все файлы", "*.*")
            ]);
        });

        smallLatency.start();
    }

    private function fileSelectionCanceled(event:Event):void {
        helloTextField.htmlText = WELCOME_MESSAGE;
    }

    private function createWelcomePanel():void {
        welcomePanel = new Sprite;

        helloTextField = TextUtils.createCustomTextField();
        helloTextField.htmlText = WELCOME_MESSAGE;
        welcomePanel.addChild(helloTextField);

        welcomePanel.addEventListener(MouseEvent.CLICK, loadClick);
    }

    private function placeElement(event:Event = null):void {
        trace("resizing " + stage.stageWidth + 'x' + stage.stageHeight);
        if (welcomePanel)
            resizeWelcomePanel();
        resizeButtonsPanel();
        resizeCertificatePanel();
    }

    private function resizeWelcomePanel():void {
        welcomePanel.graphics.beginFill(certColor);
        welcomePanel.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
        welcomePanel.graphics.endFill();

        helloTextField.width = stage.stageWidth;
        helloTextField.x = 0;
        helloTextField.y = (stage.stageHeight - helloTextField.height) / 2;
    }

    private function resizeCertificatePanel():void {
        rescaleCertificate();
    }

    private function resizeButtonsPanel():void {
        buttonsPanel.x = 0;
        buttonsPanel.y = 0
    }

    private function fileSelected(event:Event):void {
        certificateFile.addEventListener(Event.COMPLETE, fileLoaded);
        certificateFile.load();
    }

    private function fileLoaded(event:Event):void {
        var certificate:Object = loadCertificate(certificateFile.data);

        if (welcomePanel) {
            removeChild(welcomePanel);
            welcomePanel = null;
            addChild(certificatePanel);
            addChild(buttonsPanel);
        }

        img = (needDisplayRank(certificate) ? IMG_RANK : IMG_NO_RANK).bitmapData;
        certificatePanel.graphics.clear();
        certificatePanel.graphics.beginBitmapFill(img);
        certificatePanel.graphics.drawRect(0, 0, img.width, img.height);
        certificatePanel.graphics.endFill();

        putDataOnCertificate(certificate);

        rescaleCertificate();
    }

    private function putDataOnCertificate(certificate:Object):void {
        while (certificatePanel.numChildren > 0)
            certificatePanel.removeChildAt(0);

        var fi:TextField = TextUtils.createTextFieldWithFont('KioAmbassadore', 125, false, true);
        fi.autoSize = TextFieldAutoSize.NONE;
        fi.x = 0;
        fi.width = img.width;
        fi.y = 1320;
//        fi.text = "Константинопольский Константин";
        fi.text = certificate._anketa.surname + ' ' + certificate._anketa.name;
        certificatePanel.addChild(fi);

        if (needDisplayRank(certificate)) {
            var rank:TextField = TextUtils.createTextFieldWithFont('KioAmbassadore', 67, false, true);
            rank.autoSize = TextFieldAutoSize.NONE;
            var strange_left_padding:int = 20;
            rank.x = - strange_left_padding;
            rank.width = img.width + strange_left_padding;
            rank.y = 1870;
            rank.text = certificate._rank + ' место ( ' + (certificate._level == 1 ? 'I' : 'II') + ' уровень )';
            certificatePanel.addChild(rank);
        }

        //display problems info
        var y0:int = 2020;
        y0 += 24 + displayProblemInfo(y0, "Сады Семирамиды", [
            "Орошенных комнат: " + certificate.semiramida.rooms + ' из 249',
            "Длина труб в этажах: " + certificate.semiramida.pipesLength
        ]);

        if (certificate._level == 1) {
            y0 += 24 + displayProblemInfo(y0, "Глазастый робот", [
                "Распознается цифр: " + certificate.digit.recognized + " из 10",
                "Элементов: " + certificate.digit.elements
            ]);

            y0 += 24 + displayProblemInfo(y0, "Нить Ариадны", [
                "Время: " + certificate.ariadne.time + " с."
            ]);
        } else {
            y0 += 24 + displayProblemInfo(y0, "Почтовые индексы", [
                "Распознается ситуаций: " + certificate.digit.recognized + " из 100",
                "Элементов: " + certificate.digit.elements
            ]);

            y0 += 24 + displayProblemInfo(y0, "Характер физических законов", [
                "Не в той половинке: " + certificate.physics.other_half,
                "Клеток с одним шаром: " + certificate.physics.one_ball,
                "Расстояние до центра: " + certificate.physics.center_distance
            ]);
        }

        /*

         "Константинопольский Константин"
         - шрифт Ambassadore Type;
         - 30 пт,(высота надписи, включая заглавные буквы 6,54 мм);
         - обводка 0,2 мм;
         - выравнивание - по вертикальному центру сертификата;

         "5964 место ( I уровень )"
         - "I" - заглавная буква "И" английского алфавита;
         - после открывающей скобки - пробел, перед закрывающей скобкой -
         пробел (если не сделать, то в этом шрифте будут очень маленькие
         расстояния между символами);
         - шрифт Ambassadore Type (файлы прилагаю);
         - 16 пт, (высота надписи, включая скобки, 4,783 мм);
         - обводка 0,5 мм ;
         - выравнивание - по вертикальному центру сертификата.

         "результат в задаче “Лазерное шоу”"
         - Arial, 11 пт (высота надписи, включая заглавные буквы 3,621 мм);
         - Bold.


         Для учителей

         Настоящий сертификат удостоверяет, что ФИО, название
         населенного пункта, принимал(а) активное участие в организации
         и проведении Международного Конкурса по применению ИКТ
         в естественных науках и математике «Конструируй, Исследуй ,
         Оптимизируй» (КИО-2011)

         Для участников первой сотни

         Настоящий сертификат удостоверяет, что ФИ принимал(а)
         участие в Международном Конкурсе по применению ИКТ в
         естественных науках и математике «Конструируй, Исследуй,
         Оптимизируй» (КИО-2011) и занял (а) в рейтинге такое-то место
         Далее, как было.

         Для участников за первой сотни

         Настоящий сертификат удостоверяет, что ФИ, принимал(а)
         участие в Международном Конкурсе по применению ИКТ в
         естественных науках и математике «Конструируй, Исследуй,
         Оптимизируй» (КИО-2011)
         Далее подписи
         */
    }

    private function displayProblemInfo(y0:int, name:String, info:Array):int {
        var nameTf:TextField = TextUtils.createTextFieldWithFont("KioArial", 46, false, false);
        nameTf.x = 365;
        nameTf.y = y0;
        nameTf.htmlText = "<b>Результат в задаче \u00AB" + name + "\u00BB</b>";
        certificatePanel.addChild(nameTf);

        var dataTf:TextField = TextUtils.createTextFieldWithFont("KioArial", 46, true, false);
        dataTf.x = 1650;
        dataTf.y = y0;
        dataTf.width = 100500;
        dataTf.htmlText = "<b>" + info.join("<br>") + "</b>";
        certificatePanel.addChild(dataTf);

        return dataTf.height;
    }

    private function loadCertificate(data:ByteArray):Object {
        var keyed_certificate:Object = JSON.decode(data.readUTFBytes(data.length));
        var json_certificate:String = keyed_certificate.json_certificate;
        if (KioChecker.signString(json_certificate) != keyed_certificate.signature)
            throw new IOError('Подпись не соответствует сертификату');
        return JSON.decode(json_certificate);
    }

    private function printClick(event:Event):void {
        var printJob:PrintJob = new PrintJob();
        if (printJob.start()) {
            var options:PrintJobOptions = new PrintJobOptions();
            options.printAsBitmap = true;
            try {
                printJob.addPage(certificatePanel, null, options);
            } catch(e:Error) {
                return;
            }
            printJob.send();
        }
    }

    private function rescaleCertificate(event:Event = null):void {
        if (img == null)
            return;

        var spaceWidth:Number = stage.stageWidth;
        var spaceHeight:Number = stage.stageHeight - buttonsPanel.height;

        var certWidth:Number = img.width;
        var certHeight:Number = img.height;

        //get previous top line
        var topPercents:Number = (topHeight - certificatePanel.y) / certificatePanel.height;

        var scFrom:Number = spaceWidth / certWidth;
        var scTo:Number = spaceHeight / certHeight;

        if (scFrom > scTo) {
            var temp:Number = scFrom;
            scFrom = scTo;
            scTo = temp;
        }

        var scale:Number = scFrom + slider.value * (scTo - scFrom);

        var transformationMatrix:Matrix = new Matrix();
        transformationMatrix.scale(scale, scale);
        certificatePanel.transform.matrix = transformationMatrix;

        //move certificate
        certificatePanel.x = Math.round((stage.stageWidth - certWidth * scale) / 2);

        var newY:Number = topHeight - certHeight * scale * topPercents;
        if (newY < minY())
            newY = minY();
        if (newY > maxY())
            newY = maxY();

        certificatePanel.y = newY;
    }

    private static function needDisplayRank(certificate:Object):Boolean {
        //return certificate._rank < 100;
        return true;
    }


}
}
