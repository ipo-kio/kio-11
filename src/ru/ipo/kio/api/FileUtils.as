package ru.ipo.kio.api {
import com.adobe.serialization.json.JSON;

import flash.events.Event;
import flash.net.FileFilter;
import flash.net.FileReference;
import flash.utils.ByteArray;

import ru.ipo.kio.base.KioBase;

/**
 * ...
 * @author Ilya
 */
public class FileUtils {

    private static const SOLUTION_FILE_NAME:String = "solution";
    private static const RESULTS_FILE_NAME:String = "results";

    public static function loadSolution(problem:KioProblem):void {
        var fr:FileReference = new FileReference();

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID);

        fr.browse([
            new FileFilter(loc.files.solutions, "*.kio-" + problem.id),
            new FileFilter(loc.files.all_files, "*.*")
        ]);
        fr.addEventListener(Event.SELECT, function(e:Event):void {
            fr.addEventListener(Event.COMPLETE, function(e:Event):void {
                var data:ByteArray = fr.data;
//					var o : Object = data.readObject();
                var solUTF:String = data.readUTFBytes(data.length);
                try {
                    var sol:Object = JSON.decode(solUTF);
                    problem.loadSolution(sol);
                } catch (error:Error) {
                    //TODO show error message
                }
            });
            fr.load();
        });
    }

    public static function saveSolution(problem:KioProblem):void {
        var fr:FileReference = new FileReference();
//        var data:ByteArray = new ByteArray();
        var sol:Object = problem.solution;
        //data.writeObject(sol);
        //fr.save(data);

        fr.save(JSON.encode(sol), SOLUTION_FILE_NAME + ".kio-" + problem.id);
    }

    public static function saveAll():void {
        var fr:FileReference = new FileReference();
        var sol:Object = KioBase.instance.lsoProxy.data;
        fr.save(JSON.encode(sol), RESULTS_FILE_NAME + ".kio");
    }

    public static function loadAll():void {
        var fr:FileReference = new FileReference();

        var loc:Object = KioApi.getLocalization(KioBase.BASE_API_ID);

        fr.browse([
            new FileFilter(loc.files.results, "*.kio"),
            new FileFilter(loc.files.all_files, "*.*")
        ]);
        fr.addEventListener(Event.SELECT, function(e:Event):void {
            fr.addEventListener(Event.COMPLETE, function(e:Event):void {
                var data:ByteArray = fr.data;
                var solUTF:String = data.readUTFBytes(data.length);
//                try {
                    var allData:* = JSON.decode(solUTF);
                    KioBase.instance.loadAllData(allData);
                /*} catch (error:Error) {
                    //TODO show error message
                    trace('failed to load all data');
                }*/
            });
            fr.load();
        });
    }

}
}