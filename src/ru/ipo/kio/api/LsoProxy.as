/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 05.02.11
 * Time: 22:08
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.api {
import flash.net.SharedObject;
import flash.utils.Dictionary;

public class LsoProxy {

    private static var _instance:Dictionary = new Dictionary(); // year + '-' + level -> LsoProxy

    public static function getInstance(level : int, year : int):LsoProxy {
        var id : String = year + '-' + level;
        if (!_instance[id])
            _instance[id] = new LsoProxy(level, year);
        return _instance[id];
    }

    public static var STATE_SYNCHRONIZED:String = "synchronized";
    //public static var STATE_MODIFIED:String = "modified";
    public static var STATE_SYNC_FAILED:String = "failed";

    private var _state : String;
    private var _local : SharedObject;
    private var _data : Object;

    public function LsoProxy(level : int, year : int) {
        //TODO handle errors
        try {
            _local = SharedObject.getLocal("ru/ipo/kio/" + year + "/" + level, "/");
            _data = _local.data;
            _state = STATE_SYNCHRONIZED;
        } catch (e:Error) {
            _local = null;
            _data = {};
            _state = STATE_SYNC_FAILED;
        }
    }

    public function flush():void {
        //TODO handle errors
        _local.flush();
    }

    public function getProblemData(id:String):Object {
        if (!_data[id]) {
            _data[id] = {};
            flush();
        }

        return _data[id];
    }

}
}
