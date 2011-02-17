package ru.ipo.kio._11.semiramida {
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Matrix;
import flash.geom.Transform;

import ru.ipo.kio._11.VirtualPhysics.virtual_physics.KIO2011;
import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.controls.TextButton;
import ru.ipo.kio.base.GlobalMetrics;

public class Workspace extends Sprite {

    private var _house:House;

    public function Workspace() {
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
                450 / Resources.Flowers.bitmapData.width,
                450 / Resources.Flowers.bitmapData.height
                );
        Resources.Flowers.transform.matrix = m;

        //add _house
        _house = new House(700, 450);
        _house.x = 10;
        _house.y = 10;
        addChild(_house);

        //add buttons
        var createPipeButton:TextButton = new TextButton("Создать");
        createPipeButton.x = 10;
        createPipeButton.y = 500;
        createPipeButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.createPipe();
        });
        addChild(createPipeButton);

        var removePipeButton:TextButton = new TextButton("Удалить");
        removePipeButton.x = 10;
        removePipeButton.y = 540;
        removePipeButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.removePipe();
        });
        addChild(removePipeButton);

        var movePipeLeftButton:TextButton = new TextButton("Влево");
        movePipeLeftButton.x = 400;
        movePipeLeftButton.y = 520;
        movePipeLeftButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.movePipe(-1);
        });
        addChild(movePipeLeftButton);

        var movePipeRightButton:TextButton = new TextButton("Вправо");
        movePipeRightButton.x = 480;
        movePipeRightButton.y = 520;
        movePipeRightButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.movePipe(1);
        });
        addChild(movePipeRightButton);

        var movePipeUpButton:TextButton = new TextButton("Вверх");
        movePipeUpButton.x = 440;
        movePipeUpButton.y = 480;
        movePipeUpButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.changePipeLength(1);
        });
        addChild(movePipeUpButton);

        var movePipeDownButton:TextButton = new TextButton("Вверх");
        movePipeDownButton.x = 440;
        movePipeDownButton.y = 560;
        movePipeDownButton.addEventListener(MouseEvent.CLICK, function(event:Event):void {
            _house.changePipeLength(-1);
        });
        addChild(movePipeDownButton);
    }


    public function get house():House {
        return _house;
    }

}
}