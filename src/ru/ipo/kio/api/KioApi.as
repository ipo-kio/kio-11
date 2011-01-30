/**
 * Created by IntelliJ IDEA.
 * User: iposov
 * Date: 23.12.10
 * Time: 15:48
 */
package ru.ipo.kio.api {
import flash.utils.Dictionary;

public class KioApi {

    private var problem:KioProblem;

    private static var apis:Dictionary = new Dictionary();
    private static var locs:Dictionary = new Dictionary();

    public function KioApi(problem:KioProblem) {
        this.problem = problem;
    }

    public static function initialize(problem:KioProblem):void {
        apis[problem.id] = new KioApi(problem);
    }

    public static function instance(id:String):KioApi {
        return apis[id];
    }

    public static function registerLocalization(id:String, localization_object:Object):void {
        locs[id] = localization_object;
    }

    public function get localization():Object {
        return locs[problem.id];
    }

    public function get settings():DataSource {
        return null;
    }

    public function autoSaveSolution():void {
        trace("auto save solution");
    }

    public function saveBestSolution():void {
        trace("auto save solution");
    }

}
}
