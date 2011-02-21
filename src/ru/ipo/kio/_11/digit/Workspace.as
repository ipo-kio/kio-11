/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 21.02.11
 * Time: 15:57
 */
package ru.ipo.kio._11.digit {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class Workspace extends Sprite {

    [Embed(source="resources/Background+Robot.jpg")]
    private static const BG:Class;

    [Embed(source="resources/buttons/Basket_01.png")]
    private static const TRASH_NORMAL:Class;
    private static const TRASH_NORMAL_IMG:DisplayObject = new TRASH_NORMAL;

    [Embed(source="resources/buttons/Basket_02.png")]
    private static const TRASH_OVER:Class;
    private static const TRASH_OVER_IMG:DisplayObject = new TRASH_OVER;

    private var _trash:DisplayObject;

    private static const TRASH_X:int = 671;
    private static const TRASH_Y:int = 410;

    private var _field:Field = new Field;

    private var _new_gate_or:Gate = GatesFactory.createGate(GatesFactory.TYPE_OR);
    private var _new_gate_and:Gate = GatesFactory.createGate(GatesFactory.TYPE_AND);
    private var _new_gate_not:Gate = GatesFactory.createGate(GatesFactory.TYPE_NOT);
    private var _new_gate_nop:Gate = GatesFactory.createGate(GatesFactory.TYPE_NOP);

    public function Workspace() {
        addChild(new BG);

        addChild(_field);

        Globals.instance.workspace = this;

        if (stage)
            init();
        else
            addEventListener(Event.ADDED_TO_STAGE, init);

        _trash = TRASH_NORMAL_IMG;
        _trash.x = TRASH_X;
        _trash.y = TRASH_Y;
        addChild(_trash);

        placeNewGates();
    }

    public function init(event:Event = null):void {
        removeEventListener(Event.ADDED_TO_STAGE, init);

        stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
        stage.addEventListener(MouseEvent.MOUSE_MOVE, stageMouseMove);
    }

    //when mouse is up and there was constrained moving rectangle, up coordinates are irrelevant
    private var __last_mouse_up_x:Number;
    private var __last_mouse_up_y:Number;

    private function stageMouseMove(event:Event):void {
        switch (Globals.instance.drag_type) {
            case Globals.DRAG_TYPE_GATE:
                var g:Gate = Gate(Globals.instance.drag_object);
                g.positionSubElements();
                __last_mouse_up_x = mouseX;
                __last_mouse_up_y = mouseY;
                updateTrashState(__last_mouse_up_x, __last_mouse_up_y);
                break;
            case Globals.DRAG_TYPE_CONNECTOR:
                var c:Connector = Connector(Globals.instance.drag_object);
                c.positionSubElements();
                break;
            case Globals.DRAG_TYPE_NEW_GATE:
                var ng:Gate = Gate(Globals.instance.drag_object);
                ng.positionSubElements();
                break;
        }
    }

    private function stageMouseUp(event:Event):void {
        switch (Globals.instance.drag_type) {
            case Globals.DRAG_TYPE_GATE:
                var g:Gate = Gate(Globals.instance.drag_object);
                g.stopDrag();
                updateTrashImage(TRASH_NORMAL_IMG);
                if (trashHitTest(__last_mouse_up_x, __last_mouse_up_y))
                    _field.removeGate(g);
                break;
            case Globals.DRAG_TYPE_CONNECTOR:
                var c:Connector = Connector(Globals.instance.drag_object);
                c.stopDrag();
                c.positionSubElements();
                break;
            case Globals.DRAG_TYPE_NEW_GATE:
                var ng:Gate = Gate(Globals.instance.drag_object);
                if (
                        _field.mouseX >= 0 &&
                                _field.mouseX <= Field.WIDTH - ng.width &&
                                _field.mouseY >= 0 &&
                                _field.mouseY <= Field.HEIGHT - ng.height
                        ) {
                    _field.addGate(GatesFactory.createGate(ng.type), _field.mouseX - ng.mouseX, _field.mouseY - ng.mouseY);
                }
                ng.stopDrag();
                ng.moveBackThisNewGate();
                break;
        }
        Globals.instance.drag_type = Globals.DRAG_TYPE_NOTHING;
    }

    private function updateTrashState(x:Number, y:Number):void {
        var _new_trash:DisplayObject = trashHitTest(x, y) ? TRASH_OVER_IMG : TRASH_NORMAL_IMG;
        updateTrashImage(_new_trash);
    }

    private function trashHitTest(x:Number, y:Number):Boolean {
        var tx:Number = x - TRASH_X;
        var ty:Number = y - TRASH_Y;
        return tx >= 0 && tx <= _trash.width && ty >= 0 && ty <= _trash.height;
    }

    private function updateTrashImage(new_trash:DisplayObject):void {
        if (_trash != new_trash) {
            new_trash.x = TRASH_X;
            new_trash.y = TRASH_Y;
            removeChild(_trash);
            addChild(new_trash);
            _trash = new_trash;
        }
    }

    public function get field():Field {
        return _field;
    }

    public function placeNewGates():void {
        _new_gate_and.is_new = true;
        _new_gate_and.x = 58;
        _new_gate_and.y = 326 + 10;
        _new_gate_and.addTo(this);

        _new_gate_or.is_new = true;
        _new_gate_or.x = 119;
        _new_gate_or.y = 326 + 10;
        _new_gate_or.addTo(this);

        _new_gate_not.is_new = true;
        _new_gate_not.x = 58;
        _new_gate_not.y = 367 + 10;
        _new_gate_not.addTo(this);

        _new_gate_nop.is_new = true;
        _new_gate_nop.x = 119;
        _new_gate_nop.y = 367 + 10 + 5;
        _new_gate_nop.addTo(this);
    }
}
}
