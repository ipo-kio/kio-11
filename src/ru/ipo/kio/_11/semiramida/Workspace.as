package ru.ipo.kio._11.semiramida {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;

import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.controls.TextButton;
import ru.ipo.kio.base.GlobalMetrics;

public class Workspace extends Sprite {

    private var _house:House;

    private var currentResults:ResultsPanel;
    private var recordResults:ResultsPanel;

    public function Workspace() {
        var api:KioApi = KioApi.instance(SemiramidaProblem.ID);

        //add background
        var m:Matrix = Resources.Bg.transform.matrix;
        m.scale(
                GlobalMetrics.WORKSPACE_WIDTH / Resources.Bg.bitmapData.width,
                GlobalMetrics.WORKSPACE_HEIGHT / Resources.Bg.bitmapData.height
                );
        Resources.Bg.transform.matrix = m;
        addChild(Resources.Bg);

        //scale flowers
        m = Resources.Flowers.transform.matrix;
        m.scale(
                700 / Resources.Flowers.bitmapData.width,
                450 / Resources.Flowers.bitmapData.height
                );
        Resources.Flowers.transform.matrix = m;

        //add _house
        _house = new House(700, 450);
        _house.x = 10;
        _house.y = 10;
        addChild(_house);

        //add buttons
        var createPipeButton:TextButton = new TextButton(api.localization.buttons.create_pipe);
        createPipeButton.x = 10;
        createPipeButton.y = 500;
        createPipeButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.createPipe();
            _house.refreshRooms();
        });
        addChild(createPipeButton);

        var removePipeButton:TextButton = new TextButton(api.localization.buttons.remove_pipe);
        removePipeButton.x = 10;
        removePipeButton.y = 540;
        removePipeButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.removePipe();
            _house.refreshRooms();
        });
        addChild(removePipeButton);

        var movePipeLeftButton:TextButton = new TextButton(api.localization.buttons.left);
        movePipeLeftButton.x = 140;
        movePipeLeftButton.y = 520;
        movePipeLeftButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.movePipe(-1);
        });
        addChild(movePipeLeftButton);

        var movePipeRightButton:TextButton = new TextButton(api.localization.buttons.right);
        movePipeRightButton.x = 240;
        movePipeRightButton.y = 520;
        movePipeRightButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.movePipe(1);
        });
        addChild(movePipeRightButton);

        var movePipeUpButton:TextButton = new TextButton(api.localization.buttons.up);
        movePipeUpButton.x = 180;
        movePipeUpButton.y = 480;
        movePipeUpButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.changePipeLength(1);
        });
        addChild(movePipeUpButton);

        var movePipeDownButton:TextButton = new TextButton(api.localization.buttons.down);
        movePipeDownButton.x = 180;
        movePipeDownButton.y = 560;
        movePipeDownButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.changePipeLength(-1);
        });
        addChild(movePipeDownButton);

        currentResults = new ResultsPanel(api.localization.results.current, 200);
        recordResults = new ResultsPanel(api.localization.results.record, 200);

        currentResults.x = 340;
        currentResults.y = 470;
        addChild(currentResults);

        recordResults.x = 560;
        recordResults.y = 470;
        addChild(recordResults);

        //extra
        var switchTimer:TextButton = new TextButton("Анимация");
        switchTimer.x = 600;
        switchTimer.y = 570;
        switchTimer.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.switchWaterTimer();
        });
        addChild(switchTimer);
    }


    public function get house():House {
        return _house;
    }

    public function updateResults(isRecord:Boolean, rooms:int, pipesLength:int):void {
        var rp:ResultsPanel = isRecord ? recordResults : currentResults;

        rp.rooms = rooms;
        rp.pipesLength = pipesLength;
    }

}
}