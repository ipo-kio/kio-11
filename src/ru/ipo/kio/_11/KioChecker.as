/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 20.04.11
 * Time: 20:50
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio._11 {
import com.adobe.serialization.json.JSON;

import flash.events.Event;
import flash.net.FileFilter;
import flash.net.FileReference;

import flash.utils.ByteArray;

import mx.core.UIComponent;

import nochump.util.zip.ZipEntry;
import nochump.util.zip.ZipFile;

import nochump.util.zip.ZipOutput;

import ru.ipo.kio._11.VirtualPhysics.PhysicsProblem;
import ru.ipo.kio._11.ariadne.AriadneProblem;
import ru.ipo.kio._11.digit.DigitProblem;
import ru.ipo.kio._11.semiramida.SemiramidaProblem;
import ru.ipo.kio.api.KioApi;
import ru.ipo.kio.api.KioProblem;
import ru.ipo.kio.base.KioBase;

public class KioChecker extends UIComponent {

    private var output:ZipOutput = new ZipOutput();

    private var second_sol:Array = [{}, //level 0
        { //level 1
        "alina3101 (2)": [1, 2, 3],
        "amina (2)": [1, 2, 3],
        "bsh_05_12 (2)": [1, 2, 3],
        "bsh_05_12 (3)": [1, 2, 3],
        "bsh_05_12 (4)": [1, 2, 3],
        "dmitriy49 (2)": [1, 2, 3],
        "iarik (2)": [1, 2, 3],
        "krd_15_07 (2)": [2],
        "krd_15_07 (3)": [3],
        "krd_15_07 (4)": [1],
        "krd_15_07 (5)": [2],
        "krd_15_07 (6)": [3],
        "krd_18_02 (2)": [1],
        "krd_18_02 (3)": [3],
        "nasedkinw (2)": [1, 2, 3],
        "pnz_44_35 (2)": [1, 2, 3],
        "pupil35612 (2)": [1, 2, 3],
        "sch165_2 (2)": [2],
        "sch165_2 (3)": [3],
        "sch9020 (2)": [3],
        "smr_93_01 (2)": [1, 2, 3],
        "spb_597_09 (2)": [2],
        "svd_34_03 (2)": [3],
        "svd_34_05 (2)": [3],
        "svd_34_06 (2)": [3],
        "svd_34_07 (2)": [3],
        "svd_34_08 (2)": [3],
        "svd_34_10 (2)": [3],
        "svd_34_11 (2)": [3],
        "svd_34_11 (3)": [3],
        "svd_34_12 (2)": [3],
        "svd_34_13 (2)": [3],
        "svd_34_14 (2)": [3],
        "svd_34_16 (2)": [3],
        "svd_34_18 (2)": [3],
        "svd_34_19 (2)": [3],
        "svd_34_20 (2)": [3],
        "svd_34_21 (2)": [3],
        "svd_34_23 (2)": [3],
        "svd_34_26 (2)": [3],
        "svd_34_27 (2)": [3],
        "timofej (2)": [2],
        "vlg_30_15 (2)": [3],
        "vlg_30_15 (3)": [2],
        "vlg_40_02 (2)": [1, 2, 3],
        "zolotuhinivan (2)": [1, 2, 3]
    },
        {

        }];

    public function go():void {

        //open file with zip of solutions
        var fr:FileReference = new FileReference();

        fr.addEventListener(Event.SELECT, function(e:Event):void {
            fr.load();
        });
        fr.addEventListener(Event.COMPLETE, function(e:Event):void {
            var zip:ZipFile = new ZipFile(fr.data);
            processSolutions(zip);
        });

        fr.browse([
            new FileFilter("zip", "*.zip"),
            new FileFilter("all", "*.*")
        ]);
    }

    private function log(message:String):void {
        var d:Date = new Date();
        trace(d.toLocaleTimeString() + ": " + message);
    }

    private function write(fileName:String, data:*):void {
        var entry:ZipEntry = new ZipEntry(fileName);
        var fileData:ByteArray = new ByteArray();
        fileData.writeUTFBytes(data);
        output.putNextEntry(entry);
        output.write(fileData);
        output.closeEntry();
    }

    private function processSolutions(zip:ZipFile):void {
        var certificates:Array = [];
        certificates[1] = []; //levels 1 and 2
        certificates[2] = [];

        for each (var entry:ZipEntry in zip.entries) {
            var login:String = entry.name;
            //remove extension, skip entry if there is no extension
            var last_point:int = login.lastIndexOf('.');
            if (last_point == -1) {
                log("skipping entry " + entry.name);
                continue;
            }
            login = login.substring(0, last_point);
            //remove folder
            var last_slash:int = login.lastIndexOf('/');
            if (last_slash >= 0)
                login = login.substring(last_slash + 1);

            if (login.match(/\(\d\)$/))
                continue;

            log("solution found for login " + login);
            var certificate:Object = processSolution(login, zip.getInput(entry));

            var sol_ind:int = 2;
            while (true) {
                var second_key:String = login + ' (' + sol_ind + ')';
                var second_file:String = entry.name.substring(0, last_point) + ' (' + sol_ind + ')' + entry.name.substring(last_point);

                if (!second_sol[certificate._level][second_key])
                    break;

                var probs:Array = second_sol[certificate._level][second_key];
                updateSolution(
                        certificate._level,
                        certificate,
                        probs,
                        zip.getInput(zip.getEntry(second_file))
                );
            }

            certificates[certificate._level].push(certificate);
        }

        var levelProblems:Array = [
            [],
            [new SemiramidaProblem(1), new DigitProblem(1), new AriadneProblem],
            [new SemiramidaProblem(2), new DigitProblem(2), new PhysicsProblem]
        ];

        var levelProblemHeaders:Array = [
            [],
            [
                ['rooms', 'pipesLength'],
                ['recognized', 'elements'],
                ['time']
            ],
            [
                ['rooms', 'pipesLength'],
                ['recognized', 'elements'],
                ['other_half', 'one_ball', 'center_distance']
            ]
        ];

        //level 1
        for each (var problem_1:KioProblem in levelProblems[1])
            sortCertificatesAndFillScores(problem_1, certificates[1]);

        //level 2
        for each (var problem_2:KioProblem in levelProblems[2])
            sortCertificatesAndFillScores(problem_2, certificates[2]);

        //sum scores in all certificates
        for each (var level:int in [1,2]) {
            for each (var cert:Object in certificates[level])
                cert._scores =
                        cert[levelProblems[level][0].id + '_scores'] +
                                cert[levelProblems[level][1].id + '_scores'] +
                                cert[levelProblems[level][2].id + '_scores'];
        }

        sortCertificatesAndFillRank(certificates[1]);
        sortCertificatesAndFillRank(certificates[2]);

        for each (var l:int in [1,2])
            for each (var c:Object in certificates[l])
                write(c._login + '.kio-certificate', JSON.encode(sign(c)));

        for each (l in [1,2])
            makeTable(l, certificates[l], levelProblems[l], levelProblemHeaders[l]);

        output.finish();
        var zipOut:FileReference = new FileReference();
        var date:Date = new Date();
        zipOut.save(output.byteArray, "checker" + '.' + date.getDay() + '.' + date.getHours() + '.' + date.getMinutes() + ".zip");
    }

    private function addText(text:String, table:Object):void {
        text = text.replace(/"/g, '""');

        table.text += '"' + text + '";';
    }

    private function makeTable(level:int, certificates:Array, levelProblem:Array, levelProblemHeader:Array):void {
        var table:Object = {text:""};

        //write header
        addText("login", table);
        addText("rank", table);
        addText("scores", table);
        addText("-", table);
        //add for problems

        var p_id:int;
        var headers:Array;
        var header:String;

        for (p_id = 0; p_id < 3; ++p_id) {
            headers = levelProblemHeader[p_id];

            for each (header in headers)
                addText(header, table);
            addText('scores', table);
            addText('-', table);
        }

        var anketa_headers:Array = ['surname', 'name', 'second_name', 'email', 'inst_name', 'grade', 'address'];
        for each (header in anketa_headers)
            addText(header, table);

        table.text += "\n";

        for each (var certificate:Object in certificates) {
            addText(certificate._login, table);
            addText(certificate._rank, table);
            addText(certificate._scores, table);
            addText('', table);

            for (p_id = 0; p_id < 3; ++p_id) {
                var p:KioProblem = levelProblem[p_id];
                headers = levelProblemHeader[p_id];
                var problem_result:Object = certificate[p.id];

                for each (header in headers)
                    if (!problem_result)
                        addText('', table);
                    else
                        addText(problem_result[header], table);

                addText(certificate[p.id + '_scores'], table);
                addText('', table);
            }

            for each (header in anketa_headers)
                addText(certificate._anketa[header], table);

            table.text += "\n";
        }

        write('kio-results-' + level + '.csv', table.text);
    }

    private function sortCertificatesAndFillRank(certificates:Array):void {
        certificates.sortOn("_scores", [Array.DESCENDING, Array.NUMERIC]);
        var N:int = certificates.length;
        if (N == 0)
            return;
        var rank:int = 1;
        certificates[0]._rank = rank;
        for (var i:int = 1; i < N; ++i) {
            if (certificates[i]._scores != certificates[i - 1]._scores)
                rank++;
            certificates[i]._rank = rank;
        }
    }

    private function sortCertificatesAndFillScores(problem:KioProblem, certificates:Array):void {
        //bubble sort
        var N:int = certificates.length;

        var comparator:Function = function(i:int, j:int):int {
            //TODO make compare() always compare non-null values
            return problem.compare(certificates[i][problem.id], certificates[j][problem.id]);
        };

        for (var i:int = 0; i < N; ++i)
            for (var j:int = i + 1; j < N; ++j)
                if (comparator(i, j) > 0) {
                    var temp:* = certificates[i];
                    certificates[i] = certificates[j];
                    certificates[j] = temp;
                }

        if (N == 0)
            return;

        //make null solutions {}

        //fill scores
        var scores:int = 0;

        var scores_ind:String = problem.id + '_scores';
        certificates[0][scores_ind] = scores;
        for (i = 1; i < N; ++i) {
            if (comparator(i - 1, i) < 0)
                ++scores;
            certificates[i][scores_ind] = scores;
        }
    }

    private function processSolution(login:String, input:ByteArray):Object {
        var solUTF:String = input.readUTFBytes(input.length);
        var data:* = JSON.decode(solUTF);

        var level:int = data.kio_base.level;
        var anketa:* = data.kio_base.anketa;
        var language:String = data.kio_base.language;
        KioApi.language = language;
        log("level, language, name = " + level + ", " + language + ", " +
                anketa.name + " " +
                anketa.surname + " " +
                anketa.second_name + " ");

        var problems:Array = [
            new SemiramidaProblem(level),
            new DigitProblem(level),
            level == 1 ? new AriadneProblem : new PhysicsProblem
        ];

        var certificate:Object = {
            _login: login,
            _level: level,
            _anketa : anketa
        };

        for each (var problem:KioProblem in problems) {
            //get and log problem title
            var problem_title:String = KioApi.getLocalization(problem.id).title;
            if (!problem_title)
                problem_title = KioApi.getLocalization(problem.id)["title" + problem.level];

            log("checking problem " + problem_title);

            KioBase.instance.checkProblem(this, problem, data);
            certificate[problem.id] = problem.best;
        }

        return certificate;

        /*var signed_certificate:Object = sign(certificate);

         write(login + '.kio-certificate', signed_certificate);*/
    }

    private function updateSolution(level:int, certificate:Object, probs:Array, input:ByteArray):void {
        var solUTF:String = input.readUTFBytes(input.length);
        var data:* = JSON.decode(solUTF);

        var problems:Array = [];
        for each (var p_ind:int in probs) {
            if (p_ind == 1)
                problems.push(new SemiramidaProblem(level));
            if (p_ind == 2)
                problems.push(new DigitProblem(level));
            if (p_ind == 3)
                problems.push(level == 1 ? new AriadneProblem : new PhysicsProblem);
        }

        for each (var problem:KioProblem in problems) {
            //get and log problem title
            log("updating problem " + problem.id);

            KioBase.instance.checkProblem(this, problem, data);
            if (problem.compare(problem.best, certificate[problem.id]) > 0)
                certificate[problem.id] = problem.best;
        }
    }

    private function sign(certificate:Object):Object {
        var cert:String = JSON.encode(certificate);
        return {
            json_certificate: cert,
            signature: 239 //TODO use as3crypto
        };
    }
}
}
