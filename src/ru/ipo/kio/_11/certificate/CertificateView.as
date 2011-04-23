/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 22.04.11
 * Time: 17:07
 */
package ru.ipo.kio._11.certificate {

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

    [Embed(source="../resources/Sertificat_005.jpg")]
    private static var LEVEL_1:Class;
    private var IMG_1:BitmapAsset = new LEVEL_1;

    [Embed(source="../resources/Sertificat_006.jpg")]
    private static var LEVEL_2:Class;
    private var IMG_2:BitmapAsset = new LEVEL_2;

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

        buttonsPanel.graphics.beginFill(0xbfdbff);
        buttonsPanel.graphics.drawRect(0, 0, 4000, topHeight);
        buttonsPanel.graphics.endFill();
    }

    private function loadClick(event:MouseEvent):void {
        certificateFile = new FileReference();
        certificateFile.addEventListener(Event.SELECT, fileSelected);
        certificateFile.browse([
            new FileFilter("Файлы сертификатов конкурса КИО", "*.kio-certificate"),
            new FileFilter("Все файлы", "*.*")
        ]);
    }

    private function createWelcomePanel():void {
        welcomePanel = new Sprite;

        helloTextField = TextUtils.createCustomTextField(false);
        helloTextField.htmlText = "<p class='h1' align='center'>Нажмите на любое место экрана, чтобы загрузить сертификат</p><br><p align='center'>" +
                "ололо одинодин</p>";
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
        welcomePanel.graphics.beginFill(0xbfdbff);
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

        img = (certificate.level == 1 ? IMG_1 : IMG_2).bitmapData;
        certificatePanel.graphics.clear();
        certificatePanel.graphics.beginBitmapFill(img);
        certificatePanel.graphics.drawRect(0, 0, img.width, img.height);
        certificatePanel.graphics.endFill();

        rescaleCertificate();
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
            try {
                printJob.addPage(certificatePanel);
            } catch(e:Error) {
                return;
            }
            printJob.send();
        }
    }

    private function rescaleCertificate(event:Event = null):void {
        trace('rescaling');
        if (img == null)
            return;

        var spaceWidth:Number = stage.stageWidth;
        var spaceHeight:Number = stage.stageHeight - buttonsPanel.height;

        var certWidth:Number = img.width;
        var certHeight:Number = img.height;

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
        certificatePanel.x = (stage.stageWidth - certWidth * scale) / 2;
        certificatePanel.y = buttonsPanel.height;
    }

}
}
