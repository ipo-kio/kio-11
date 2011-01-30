/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 13.12.10
 * Time: 17:15
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.api{

public class Problem {

    private var year : int;
    private var level : int;
    private var id : String;

    public function Problem(year:int, level:int, id:String) {
        this.year = year;
        this.level = level;
        this.id = id;
    }

}
}