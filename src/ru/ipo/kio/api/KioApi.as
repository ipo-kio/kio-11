/**
 * Created by IntelliJ IDEA.
 * User: iposov
 * Date: 23.12.10
 * Time: 15:48
 */
package ru.ipo.kio.api {
import flash.utils.Dictionary;

import ru.ipo.kio.api.LsoProxy;

public class KioApi {

    private var problem:KioProblem;

    private static var apis:Dictionary = new Dictionary();
    private static var locs:Dictionary = new Dictionary();

    private var lso : LsoProxy;
    private var problemData : Object;

    /**
     * Конструктор, вызывать не следует
     * @param problem
     */
    public function KioApi(problem:KioProblem) {
        this.problem = problem;
        lso = LsoProxy.getInstance(problem.level, problem.year);
        problemData = lso.getProblemData(problem.id);
    }

    /**
     * Инициализация api для конкретной задачи,должна вызываться в конструкторе задачи
     * @param problem регистрируемая задача
     */
    public static function initialize(problem:KioProblem):void {
        apis[problem.id] = new KioApi(problem);
    }

    /**
     * Позволяет обратиться к api задачи по ее id
     * @param id
     * @return
     */
    public static function instance(id:String):KioApi {
        return apis[id];
    }

    /**
     * Регистрирует объект, содержащий набор данных, специфичных для текущей локали.
     * Этот объект будет выдаваться при вызове localization()
     * @param id
     * @param localization_object
     */
    public static function registerLocalization(id:String, localization_object:Object):void {
        locs[id] = localization_object;
    }

    /**
     * Получить объект, содержащий специфичный для локали набор данных
     */
    public function get localization():Object {
        return locs[problem.id];
    }

    /**
     * Получить настройки для задачи. Настройки могут использоваться для хранения параметров задачи, которые
     * выбрал пользователь. Например, набор цветов, шрифт и т.п.
     */
    public function get settings():Object {
        if (! problemData.settings)
            problemData.settings = {};

        return problemData.settings;
    }

    public function flushSettings():void {
        lso.flush();
    }

    /**
     * Считается, что пользователь должен открывать задачу всегда в том же состоянии, в котором он ее закрыл.
     * Поэтому каждый раз когда пользователь значительно изменяет свое решение, следует вызывать
     * этот метод. Он сохранит текущее решение. При загрузке оно насильно будет загружено в программу.
     */
    public function autoSaveSolution():void {
        problemData.autoSave = problem.solution;
        lso.flush();
    }

    /**
     * В тот момент, когда очередное решение пользователя оказалось лучше всех других, следует вызвать
     * этот метод, чтобы это решение сохранилось как наилучшее.
     */
    public function saveBestSolution():void {
        problemData.best = problem.solution;
        lso.flush();
    }

}
}
