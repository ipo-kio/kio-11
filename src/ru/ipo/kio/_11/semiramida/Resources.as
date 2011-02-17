/**
 * Created by IntelliJ IDEA.
 * User: ilya
 * Date: 16.02.11
 * Time: 16:41
 */
package ru.ipo.kio._11.semiramida {

import mx.core.BitmapAsset;

public class Resources {

    [Embed(source="resouces/flowers.jpg")]
    private static const FLOWERS:Class;
    public static const Flowers:BitmapAsset = new FLOWERS;

    [Embed(source="resouces/bg.jpg")]
    private static const BG:Class;
    public static const Bg:BitmapAsset = new BG;
}
}
