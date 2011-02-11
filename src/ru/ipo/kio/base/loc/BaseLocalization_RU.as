package ru.ipo.kio.base.loc {
import flash.sampler._getInvocationCount;

//TODO load from json file
public class BaseLocalization_RU {
    [Embed(source="../../../../../../resources/imgs/settings_ru.png")]
    private static var SETTINGS_IMG:Class;

    public static function get mapping():Object {
        return {
            contest_panel: {
                buttons : {
                    load : "Загрузить",
                    save : "Сохранить",
                    back : "ЗАКРЫТЬ"
                }
            },
            screen:{
                buttons : {
                    continue_: "Продолжить",
                    loadWorkspace : "Загрузить"
                },
                welcome:{
                    mainMessage: '<p class="h1">Вас приветствует конкурс КИО 2011!</p><p>Вам предстоит решить три задачи и прочитать еще немного приветственного текста.</p><p>Перед тем как приступить к решению задач, вам потребуется:</p><li>Позволить программе сохранять данные на диск</li><li>Заполнить анкету</li><p>Для продолжения нажмите "Продолжить".</p>',
                    loadWorkspace: 'Если вы имеете сохраненные результаты участия, можоте загрузить их:'
                },
                settings:{
                    mainMessage: '<p class="h1">Исправьте настройки конкурса</p><p>Для работы с программой вам необходимо позволить ей хранить данные на вашем диске. Нажмите "Настроить" и установите настройки так, как это изображено на рисунке:</p>',
                    image: SETTINGS_IMG,
                    mainMessageContinuation: '<p>Убедитесь, что</p><li>Галочка "не спрашивать" не выбрана</li><li>Ползунок установлен как минимум на 1 мегабайт</li><p class="warning">Внимание! Если вы установите настройки неверно, программа будет требовать установить их правильно и не продолжит работу, пока вы это не сделаете.</p>'
                },
                form: {
                    header: "Заполните Анкету"
                }
            }
        };
    }
}
}