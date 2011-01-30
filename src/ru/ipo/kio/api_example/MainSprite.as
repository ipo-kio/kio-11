package ru.ipo.kio.api_example{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.*;
	import ru.ipo.kio.api.*;
	
	/**
	 * Это спрайт с задачей, на нем рисуются все видимые объекты. В нашем случае единственный видимый объект - 
	 * это слово текстовое поле со сторокой текста
	 * @author Ilya
	 */
	public class MainSprite extends Sprite
	{
		
		//текстовое поле - единственный видимый объект задачи
		private var textField:TextField;
		
		//конструктор спрайта, инициализация всех объектов
		public function MainSprite() 
		{
			//получаем доступ к API, для этого передаем в качестве параметра id нашей задачи
			var api:KioApi = KioApi.instance(Pr1.ID);
			
			textField = new TextField();
			//в качестве текста для отображения устанавливаем текст, взятый из объекта локализации
			textField.text = api.localization.text1;
			addChild(textField);
			//разрешаем пользователю изменять текст
			textField.type = TextFieldType.INPUT;
			
			//устанавливаем слушатель на изменение текста
			textField.addEventListener(Event.CHANGE, function(e:Event):void {
				//просим api сохранить текущее решение, т.е. содержимое текстового поля (см. описание класса Pr1)
				api.autoSaveSolution();
			});
		}
		
		//разрешаем устанавливать и читать содержимое текстового поля
		
		public function set text(t:String):void {
			textField.text = t;
		}
		
		public function get text():String {
			return textField.text;
		}
		
	}

}