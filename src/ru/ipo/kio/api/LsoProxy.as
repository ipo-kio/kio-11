/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 05.02.11
 * Time: 22:08
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.api {
import flash.net.SharedObject;
import flash.net.SharedObjectFlushStatus;
import flash.utils.Dictionary;

import ru.ipo.kio.api.controls.SpaceSettingsDialog;
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

    private var _state : String;
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
        return SharedObject.getLocal("ru/ipo/kio/" + year + "/" + level, "/");
    }

    public function flush():void {
        if (_local == null) {
            createLSO();
            if (_local == null) {
                KioBase.instance.complainLSO();
                return;
            }
            //copy data
            for (var key:* in _data)
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
        if (!_data.kio_base) {
            _data.kio_base = {};
        }

        return _data.kio_base;
    }

    public function get isConnecedToLSO():Boolean {
        return _local != null;
    }

}
}
