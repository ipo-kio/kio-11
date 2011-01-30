/**
 * Created by IntelliJ IDEA.
 * User: iposov
 * Date: 23.12.10
 * Time: 15:59
 */
package ru.ipo.kio.api {
public interface DataSource {

    /**
     * Возвращает объект, который необходимо изменять или читать для работы с данными
     */
    function get data():Object;

    /**
     * Необходимо вызывать, чтобы быть уверенным, что внесенные изменения сохранены.В определенных случаях
     * метод вызывается автоматически
     */
    function flush():void;

}
}
