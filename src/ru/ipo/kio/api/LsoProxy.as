/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 05.02.11
 * Time: 22:08
 */
package ru.ipo.kio.api {
import flash.events.Event;
import flash.events.NetStatusEvent;
import flash.net.SharedObject;
import flash.net.SharedObjectFlushStatus;
import flash.utils.Dictionary;

import ru.ipo.kio.base.KioBase;

public class LsoProxy {

    private static var _instance:Dictionary = new Dictionary(); // year + '-' + level -> LsoProxy

    private static const LSO_SIZE:int = 1000000;

    private var level:int;
    private var year:int;

    public static function getInstance(level : int, year : int):LsoProxy {
        var id : String = year + '-' + level;
        if (!_instance[id])
            _instance[id] = new LsoProxy(level, year);
        return _instance[id];
    }

    private var _local : SharedObject;
    private var _data : Object;

    public function LsoProxy(level : int, year : int) {
        this.level = level;
        this.year = year;
        _data = {};
        createLSO();
    }

    private function createLSO():void {
        try {
            _local = getLocal();
            _data = _local.data;
        } catch (e:Error) {
            _local = null;
        }
    }

    private function getLocal():SharedObject {
        var local:SharedObject = SharedObject.getLocal("ru/ipo/kio/" + year + "/" + level, "/");
        local.addEventListener(NetStatusEvent.NET_STATUS, function (event:Event):void{
            trace('net status handled');
            //TODO find out WHY this event was not triggered before. (google suggests it is just not handled at all in linux)
        });
        return local;
    }

    public function flush():void {
        if (_local == null) {
            createLSO();
            if (_local == null) {
                KioBase.instance.complainLSO();
                return;
            }
            //copy data
            for (var key:String in _data)
                _local.data[key] = _data[key];
            _data = _local.data;
        }

        try {
            if (_local.flush(LSO_SIZE) != SharedObjectFlushStatus.FLUSHED)
                KioBase.instance.complainLSO();
        } catch (e:Error) {
            KioBase.instance.complainLSO();
        }
    }

    public function getProblemData(id:String):Object {
        if (!_data[id]) {
            _data[id] = {};
        }

        return _data[id];
    }

    public function getGlobalData():Object {
        if (!_data.kio_base)
            _data.kio_base = {};

        return _data.kio_base;
    }

    public function getAnketa():Object {
        var gd:Object = getGlobalData();
        if (!gd.anketa)
            gd.anketa = {};

        return gd.anketa;
    }

    public function get data():Object {
        return _data;
    }

    public function set data(data:Object):void {
        //TODO select better record. Should store record together with the checker results
        for (var key:String in data)
            _data[key] = data[key];
        flush();
    }
}
}
