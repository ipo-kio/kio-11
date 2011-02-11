/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 10.02.11
 * Time: 21:27
 * To change this template use File | Settings | File Templates.
 */
package ru.ipo.kio.base.displays {
import flash.display.Sprite;

import ru.ipo.kio.base.resources.Resources;

public class ProblemsDisplay extends Sprite {
    public function ProblemsDisplay() {
        addChild(new Resources.BG_IMAGE);
    }
}
}
