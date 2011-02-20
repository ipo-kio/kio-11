package ru.ipo.kio._11.recognition
{
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	import flash.utils.Timer;
	import ru.ipo.kio.api.*;
	import ru.ipo.kio.api.controls.TextButton;	
	/**
	 * ...
	 * @author Dmitriy
	 */
	//[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		public var andLeftResult: Array = new Array(); // массив, содержащий входящие значения в левые контакты блока
		public var andRightResult: Array = new Array(); //массив, содержащий входящие значения в правые контакты блока
		public var andAimResult: Array = new Array(); // массив , содержащий исходящие значения после блока
        public var andTull: Array = new Array()//массив тел блока и
		public var andLeft:Array = new Array();//массив левых контактов блока и
		public var andRight:Array = new Array();//массив правых контактов блокаи
		public var andAim:Array = new Array();//массив результирующих элементов блока и
		
		public var orLeftResult: Array = new Array(); // массив, содержащий входящие значения в левые контакты блока
		public var orRightResult: Array = new Array(); //массив, содержащий входящие значения в правые контакты блока
		public var orAimResult: Array = new Array(); // массив , содержащий исходящие значения после блока
        public var orTull: Array = new Array()//массив тел блока или
		public var orLeft:Array = new Array();//массив левых контактов блока или
		public var orRight:Array = new Array();//массив правых контактов блока или
		public var orAim:Array = new Array();//массив результирующих элементов блока или
		
		public var notRightResult: Array = new Array(); //массив, содержащий входящие значения в контакты блока
		public var notAimResult: Array = new Array(); // массив , содержащий исходящие значения после блока
        public var notTull: Array = new Array()//массив тел блока не
		public var notRight:Array = new Array();//массив левых контактов блока не
		public var notAim:Array = new Array();//массив результирующих элементов блока не
		
		public var andLineAim:Array = new Array(); //массив линий соединяющих блок "и" и цель 
		public var andLineR:Array = new Array(); //массив линий соединяющих блок "и" и правый контакт 
		public var andLineL:Array = new Array(); //массив линий соединяющих блок "и" и левый контакт 
		
		public var orLineAim:Array = new Array(); //массив линий соединяющих блок "или" и цель
		public var orLineR:Array = new Array(); //массив линий соединяющих блок "или"  правый контакт
		public var orLineL:Array = new Array(); //массив линий соединяющих блок "или" левый контакт
		
		public var notLineAim:Array = new Array(); //массив линий соединяющих блок "не"и цель
		public var notLineR:Array = new Array(); //массив линий соединяющих блок "не" и правый контакт
		
		public var controlAnswer:Array = new Array();
			
		public var leftAndHit:Array = new Array();//показатель присоединения левого контакта блока И
		public var rightAndHit:Array = new Array();//показатель присоединения правого контакта блока И
		
		public var leftOrHit:Array = new Array();//показатель присоединения левого контакта блока ИЛИ
		public var rightOrHit:Array = new Array();//показатель присоединения правого контакта блока ИЛИ
		
		public var rightNotHit:Array = new Array();//показатель присоединения контакта блока НЕ
		
		public var additLineLAnd:Array = new Array();//линия выделения левого провода блока И 
		public var lineLAddAnd:Array = new Array;// показатель выделенности левой линии блока И
		
		public var lineLAddOr:Array = new Array;// показатель выделенности левой линии блока Или
		public var additLineLOr:Array = new Array();//линия выделения левого провода блока Или
		
		public var additLineRNot:Array = new Array();//линия выделения левого провода блока НЕ
		public var lineRAddNot:Array = new Array;// показатель выделенности левой линии блока Не
		
		public var complite:int = 0;
		public var complite2:int = 0;
		public var complite3:int = 0;
		
		public var additLineRAnd:Array = new Array();//линия выделения правого провода блока И
		public var lineRAddAnd:Array = new Array;// показатель выделенности правой линии блока И
		
		public var lineRAddOr:Array = new Array;// показатель выделенности правой линии блока Или
		public var additLineROr:Array = new Array();//линия выделения правого провода блока Или
		
		public var myVar:int = 0;// xитрая глобальная переменная(костыль для программы) 
		public var myVar2:int = 0;// xитрая глобальная переменная(костыль для программы)
		public var myVar3:int = 0;// xитрая глобальная переменная(костыль для программы)
				
		public var NumberBlokcs:int = 0;//количество используемых блоков
		public var Result:int = 0; // Переменная содержащая результат 
		public var Record_NumberBlokcs:int = 0;// Переменная содержащая рекорд количества блоков
		public var Record_Result:int = 0;// Переменная содержащая рекорд количества правильно рапознаных цифр
		public var t_result:TextField = new TextField();// Текстовое поле для результата
		public var t_nB:TextField = new TextField();//Текстовое поле для количествва блоков
		public var t_record_result:TextField = new TextField();// Текстовое поле для результата
		public var t_record_numberBlokcs:TextField = new TextField();//Текстовое поле для количествва блоков
		public var text_lvl_1:TextField = new TextField();//Текстовое поле для уровня
		
		public var NUM_first_Break_lamp:int = 11; 
		public var NUM_second_Break_lamp:int = 11;
		
		public var numAnd:int = 0;
		public var numOr:int = 0;
		public var numNot:int = 0;
		
		public var ButtonDown:Boolean;
		
		public var bin:Sprite = createRect(0x508080, 30, 50)//корзина
		public var level:int = 1;
		public var NUM:int = 0;
		public var NUM_1:int = 0;
        public var circle_lamp_Green_prov:Array = new Array(); // массив содержащий все зеленые круглые лампочки конечной проверки
		public var circle_lamp_Red_prov:Array = new Array(); // массив содержащий все красные круглые лампочки конечной проверк
		public var circle_lamp_Green:Array = new Array(); // массив содержащий все зеленые круглые лампочки контакты
		public var circle_lamp_Red:Array = new Array(); // массив содержащий все красные круглые лампочки контакты
		public var rect_lamp_Green:Array = new Array(); // массив содержащий все зеленые лампочки
		
		// Создание кнопок
		public var Del_1_lamp:SimpleButton = createButtons("Сломать лампу");
		public var Del_2_lamp:SimpleButton = createButtons("");
		public var timer:Timer = new Timer(4000, 10);
		public function Main():void 
		{
			var i:int;	
			createNum();
			createCont();
			createCont_Prov();
			Buttons();
			createBin();
			text_fields();
			//--------------------------------------------------------
			//линия разграничения
			var line:Shape = new Shape();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(120, 0);
			line.graphics.lineTo(120, 900);
			addChild(line);
			//-----------------------------------------------------			
			addEventListener(Event.ENTER_FRAME, controlLamp);
		}
		//===================================================
		public function text_fields():void
		{
		
			// текстовые поля вывода уровня
			var text_lvl:TextField = new TextField();
			text_lvl.autoSize = TextFieldAutoSize.LEFT;
			text_lvl.text = "Уровень:";
			text_lvl.x = 10;
			text_lvl.y = 50;			
			addChild(text_lvl);
			
			text_lvl_1.autoSize = TextFieldAutoSize.LEFT;
			text_lvl_1.text = '            '+level;
			text_lvl_1.x = 30;
			text_lvl_1.y = 50;			
			addChild(text_lvl_1);
			//-----------------------------------------------------------
			// текстовые поля вывода результата
			var text_result:TextField = new TextField();
			text_result.autoSize = TextFieldAutoSize.LEFT;
			text_result.text = "Число верно распознанных цифр:";
			text_result.x = 500;
			text_result.y = 450;			
			addChild(text_result);
			
			
			t_result.autoSize = TextFieldAutoSize.LEFT;
			t_result.text =  '  '+Result;
			t_result.x = 670;
			t_result.y = 450;			
			addChild(t_result);				
			//-----------------------------------------------------------------
			// текстовые поля вывода количества блоков
			var text_numberBlokcs:TextField = new TextField();
			text_numberBlokcs.autoSize = TextFieldAutoSize.LEFT;
			text_numberBlokcs.text = "Количество блоков:";
			text_numberBlokcs.x = 500;
			text_numberBlokcs.y = 480;			
			addChild(text_numberBlokcs);
			
			
			t_nB.autoSize = TextFieldAutoSize.LEFT;
			t_nB.text =  '  '+NumberBlokcs;
			t_nB.x = 600;
			t_nB.y = 480;			
			addChild(t_nB);	
			//-------------------------------------------------------------
			// текстовые поля вывода рекорда
			var text_record_result:TextField = new TextField();
			text_record_result.autoSize = TextFieldAutoSize.LEFT;
			text_record_result.text = "Число верно распознанных цифр Рекорд:";
			text_record_result.x = 500;
			text_record_result.y = 520;			
			addChild(text_record_result);
			
			
			t_record_result.autoSize = TextFieldAutoSize.LEFT;
			t_record_result.text =  '  '+Record_Result;
			t_record_result.x = 710;
			t_record_result.y = 520;			
			addChild(t_record_result);				
			//-----------------------------------------------------------------
			// текстовые поля вывода рекорда
			var text_record_numberBlokcs:TextField = new TextField();
			text_record_numberBlokcs.autoSize = TextFieldAutoSize.LEFT;
			text_record_numberBlokcs.text = "Количество блоков Рекорд:";
			text_record_numberBlokcs.x = 500;
			text_record_numberBlokcs.y = 560;			
			addChild(text_record_numberBlokcs);
			
			
			t_record_numberBlokcs.autoSize = TextFieldAutoSize.LEFT;
			t_record_numberBlokcs.text =  '  '+Record_NumberBlokcs;
			t_record_numberBlokcs.x = 640;
			t_record_numberBlokcs.y = 560;			
			addChild(t_record_numberBlokcs);			
			//-------------------------------------------------------------			
			var text_bin:TextField = new TextField();
			text_bin.autoSize = TextFieldAutoSize.LEFT;
			text_bin.text = "Корзина";
			text_bin.x = 25;
			text_bin.y = 380;			
			addChild(text_bin);			
		}
		//===================================================
public function test_continius(e:Event):void
{
			var i:int;	
			// блокировка скобок
			Del_1_lamp.removeEventListener(MouseEvent.CLICK, one_Break_lamp);
			Del_2_lamp.removeEventListener(MouseEvent.CLICK, two_Breaks_lamp);				
	for (i = 0; i < 10 ; i++)
	{
				// цифра 0 на табло
		if (i == 0)
		{
			     if ( level == 2)
				{
					rect_lamp_Green[3].visible = false;
			        circle_lamp_Green[3].visible = false;
					rect_lamp_Green[7].visible = false;
			        circle_lamp_Green[7].visible = false;
					rect_lamp_Green[8].visible = false;
			        circle_lamp_Green[8].visible = false;
				}
				else
				{
				   rect_lamp_Green[3].visible = false;
			       circle_lamp_Green[3].visible = false;
				}
			// get_result(NUM);
		}
			 // цифра 1 на табло
		if (i == 1)
		{
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;					
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;	
					
			if (level == 2)
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;	
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;	
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;			 
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;	
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;	
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;	
			}
			// get_result(NUM);
		}		
			 // цифра 2 на табло
		if (i == 2)
		{						
				rect_lamp_Green[0].visible = true;
				circle_lamp_Green[0].visible = true;	
				rect_lamp_Green[1].visible = true;
				circle_lamp_Green[1].visible = true;	
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;			 
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;			
			 
			 if (level == 2)
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false;
			   rect_lamp_Green[3].visible = false;
			   circle_lamp_Green[3].visible = false;
			   rect_lamp_Green[4].visible = false;
			   circle_lamp_Green[4].visible = false;
			   rect_lamp_Green[7].visible = false;
			   circle_lamp_Green[7].visible = false;
			 }
			 else
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false;
			 }
			// get_result(NUM);
		}
			 // цифра 3 на табло
	    if (i ==3)
		{		 
			   rect_lamp_Green[0].visible = true;
			   circle_lamp_Green[0].visible = true;			 
			   rect_lamp_Green[6].visible = true;
			   circle_lamp_Green[6].visible = true;
			   rect_lamp_Green[3].visible = true;
			   circle_lamp_Green[3].visible = true;
			   rect_lamp_Green[4].visible = true;
			   circle_lamp_Green[4].visible = true;
			   rect_lamp_Green[7].visible = true;
			   circle_lamp_Green[7].visible = true;	
			   
			 if (level == 2)
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[2].visible = false;
			   circle_lamp_Green[2].visible = false;
			   rect_lamp_Green[4].visible = false;
			   circle_lamp_Green[4].visible = false;
			   rect_lamp_Green[5].visible = false;
			   circle_lamp_Green[5].visible = false;
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false; 				 
			 }
			 else 
			 {			
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
			 }
			// get_result(NUM);
		} 
			 // цифра 4 на табло
		if (i ==4)
		{		 
			   rect_lamp_Green[0].visible = true;
			   circle_lamp_Green[0].visible = true;			 
			   rect_lamp_Green[2].visible = true;
			   circle_lamp_Green[2].visible = true;
			   rect_lamp_Green[4].visible = true;
			   circle_lamp_Green[4].visible = true;
			   rect_lamp_Green[5].visible = true;
			   circle_lamp_Green[5].visible = true;
			   rect_lamp_Green[6].visible = true;
			   circle_lamp_Green[6].visible = true; 				
			 
			 if (level == 2)
			 {
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;			 	
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;			 
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;			 
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			 }
			 else
			 {		   
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;			 	
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;			 
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
			 }
			// get_result(NUM);
		} 
			 // цифра 5 на табло
		if (i ==5)
		{		 
				rect_lamp_Green[1].visible = true;
				circle_lamp_Green[1].visible = true;			 	
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;			 
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;			 
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;			 
			 
			if (level == 2)
			{
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;	
				rect_lamp_Green[4].visible = false;;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;	
				rect_lamp_Green[8].visible = false;;
				circle_lamp_Green[8].visible = false;
			 
			}
			else
			{			 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;	
				rect_lamp_Green[4].visible = false;;
				circle_lamp_Green[4].visible = false;
			} 
			 //get_result(NUM);
		}
			 // цифра 6 на табло
		if (i ==6)
		{			 
				rect_lamp_Green[2].visible = true;
				circle_lamp_Green[2].visible = true;	
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;	
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;				
			if (level == 2)
			{
				rect_lamp_Green[2].visible = false;
			    circle_lamp_Green[2].visible = false;
				rect_lamp_Green[0].visible = false;
			    circle_lamp_Green[0].visible = false;
				rect_lamp_Green[1].visible = false;
			    circle_lamp_Green[1].visible = false;
				rect_lamp_Green[8].visible = false;
			    circle_lamp_Green[8].visible = false;
			}
			else
			{ 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;		 
			} 
			// get_result(NUM);
		}
			 // цифра 7 на табло
		if (i ==7)
		{			 
			 	
			    rect_lamp_Green[2].visible = true;
			    circle_lamp_Green[2].visible = true;
				rect_lamp_Green[0].visible = true;
			    circle_lamp_Green[0].visible = true;
				rect_lamp_Green[1].visible = true;
			    circle_lamp_Green[1].visible = true;
				rect_lamp_Green[8].visible = true;
			    circle_lamp_Green[8].visible = true;		 
			 	
			if (level == 2)
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				 		 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
				rect_lamp_Green[6].visible = false;
				circle_lamp_Green[6].visible = false;
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				 		 
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;			 
			}
			 //get_result(NUM);			
		}
			 // цифра 8 на табло
		if (i ==8)
		{			
			    rect_lamp_Green[0].visible = true;
				circle_lamp_Green[0].visible = true;				 		 
				rect_lamp_Green[2].visible = true;
				circle_lamp_Green[2].visible = true;
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;
				rect_lamp_Green[6].visible = true;
				circle_lamp_Green[6].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
			
			if (level == 2)
			{
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			 
			 //get_result(NUM);
		}
			 // цифра 9 на табло
		if (i==9)
		{	    
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;
				
			if (level == 2)
			{
				rect_lamp_Green[4].visible = false;
			    circle_lamp_Green[4].visible = false;
			    rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;
				rect_lamp_Green[5].visible = false;
			    circle_lamp_Green[5].visible = false;
				rect_lamp_Green[6].visible = false;
			    circle_lamp_Green[6].visible = false;
			}
			else
			{
			 rect_lamp_Green[4].visible = false;
			 circle_lamp_Green[4].visible = false;				 
			}
		}	
		controllaContattonot(e);
		controllaContattoor(e);
		controllaContatto(e);
		controlLamp(e);//вставлено чтобы для блока не евент сработал до  обработки результата, иначе результат не зачтётся
		get_result(i);
		Record();
	}		  	
}
		//===================================================
		public function test_step(e:Event):void
		{
			// блокировка кнопок
			Del_1_lamp.removeEventListener(MouseEvent.CLICK, one_Break_lamp);
			Del_2_lamp.removeEventListener(MouseEvent.CLICK, two_Breaks_lamp);
			// цифра 0 на табло
			
		if (NUM == 0)
		{
			     if ( level == 2)
				{
					rect_lamp_Green[3].visible = false;
			        circle_lamp_Green[3].visible = false;
					rect_lamp_Green[7].visible = false;
			        circle_lamp_Green[7].visible = false;
					rect_lamp_Green[8].visible = false;
			        circle_lamp_Green[8].visible = false;
				}
				else
				{
				   rect_lamp_Green[3].visible = false;
			       circle_lamp_Green[3].visible = false;
				}
			 //get_result(NUM);
		}
		
			 // цифра 1 на табло
		if (NUM == 1)
		{
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;					
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;	
					
			if (level == 2)
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;	
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;	
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;			 
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;	
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;	
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;	
			}
			// get_result(NUM);
		}		
			 // цифра 2 на табло
		if (NUM == 2)
		{						
				rect_lamp_Green[0].visible = true;
				circle_lamp_Green[0].visible = true;	
				rect_lamp_Green[1].visible = true;
				circle_lamp_Green[1].visible = true;	
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;			 
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;			
			 
			 if (level == 2)
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false;
			   rect_lamp_Green[3].visible = false;
			   circle_lamp_Green[3].visible = false;
			   rect_lamp_Green[4].visible = false;
			   circle_lamp_Green[4].visible = false;
			   rect_lamp_Green[7].visible = false;
			   circle_lamp_Green[7].visible = false;
			 }
			 else
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false;
			 }
			// get_result(NUM);
		}
			 // цифра 3 на табло
	    if (NUM ==3)
		{		 
			   rect_lamp_Green[0].visible = true;
			   circle_lamp_Green[0].visible = true;			 
			   rect_lamp_Green[6].visible = true;
			   circle_lamp_Green[6].visible = true;
			   rect_lamp_Green[3].visible = true;
			   circle_lamp_Green[3].visible = true;
			   rect_lamp_Green[4].visible = true;
			   circle_lamp_Green[4].visible = true;
			   rect_lamp_Green[7].visible = true;
			   circle_lamp_Green[7].visible = true;	
			   
			 if (level == 2)
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[2].visible = false;
			   circle_lamp_Green[2].visible = false;
			   rect_lamp_Green[4].visible = false;
			   circle_lamp_Green[4].visible = false;
			   rect_lamp_Green[5].visible = false;
			   circle_lamp_Green[5].visible = false;
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false; 				 
			 }
			 else 
			 {			
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
			 }
			// get_result(NUM);
		} 
			 // цифра 4 на табло
		if (NUM ==4)
		{		 
			   rect_lamp_Green[0].visible = true;
			   circle_lamp_Green[0].visible = true;			 
			   rect_lamp_Green[2].visible = true;
			   circle_lamp_Green[2].visible = true;
			   rect_lamp_Green[4].visible = true;
			   circle_lamp_Green[4].visible = true;
			   rect_lamp_Green[5].visible = true;
			   circle_lamp_Green[5].visible = true;
			   rect_lamp_Green[6].visible = true;
			   circle_lamp_Green[6].visible = true; 				
			 
			 if (level == 2)
			 {
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;			 	
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;			 
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;			 
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			 }
			 else
			 {		   
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;			 	
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;			 
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
			 }
			// get_result(NUM);
		} 
			 // цифра 5 на табло
		if (NUM ==5)
		{		 
				rect_lamp_Green[1].visible = true;
				circle_lamp_Green[1].visible = true;			 	
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;			 
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;			 
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;			 
			 
			if (level == 2)
			{
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;	
				rect_lamp_Green[4].visible = false;;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;	
				rect_lamp_Green[8].visible = false;;
				circle_lamp_Green[8].visible = false;
			 
			}
			else
			{			 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;	
				rect_lamp_Green[4].visible = false;;
				circle_lamp_Green[4].visible = false;
			} 
			 //get_result(NUM);
		}
			 // цифра 6 на табло
		if (NUM ==6)
		{			 
				rect_lamp_Green[2].visible = true;
				circle_lamp_Green[2].visible = true;	
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;	
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;				
			if (level == 2)
			{
				rect_lamp_Green[2].visible = false;
			    circle_lamp_Green[2].visible = false;
				rect_lamp_Green[0].visible = false;
			    circle_lamp_Green[0].visible = false;
				rect_lamp_Green[1].visible = false;
			    circle_lamp_Green[1].visible = false;
				rect_lamp_Green[8].visible = false;
			    circle_lamp_Green[8].visible = false;
			}
			else
			{ 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;		 
			} 
			// get_result(NUM);
		}
			 // цифра 7 на табло
		if (NUM ==7)
		{			 
			 	
			    rect_lamp_Green[2].visible = true;
			    circle_lamp_Green[2].visible = true;
				rect_lamp_Green[0].visible = true;
			    circle_lamp_Green[0].visible = true;
				rect_lamp_Green[1].visible = true;
			    circle_lamp_Green[1].visible = true;
				rect_lamp_Green[8].visible = true;
			    circle_lamp_Green[8].visible = true;		 
			 	
			if (level == 2)
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				 		 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
				rect_lamp_Green[6].visible = false;
				circle_lamp_Green[6].visible = false;
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				 		 
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;			 
			}
			 //get_result(NUM);			
		}
			 // цифра 8 на табло
		if (NUM ==8)
		{			
			    rect_lamp_Green[0].visible = true;
				circle_lamp_Green[0].visible = true;				 		 
				rect_lamp_Green[2].visible = true;
				circle_lamp_Green[2].visible = true;
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;
				rect_lamp_Green[6].visible = true;
				circle_lamp_Green[6].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
			
			if (level == 2)
			{
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			 
			 //get_result(NUM);
		}
			 // цифра 9 на табло
		if (NUM ==9)
		{	    
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;
				
			if (level == 2)
			{
				rect_lamp_Green[4].visible = false;
			    circle_lamp_Green[4].visible = false;
			    rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;
				rect_lamp_Green[5].visible = false;
			    circle_lamp_Green[5].visible = false;
				rect_lamp_Green[6].visible = false;
			    circle_lamp_Green[6].visible = false;
			}
			else
			{
			 rect_lamp_Green[4].visible = false;
			 circle_lamp_Green[4].visible = false;				 
			}
		}	
		
		controllaContattonot(e);
		controllaContattoor(e);
		controllaContatto(e);
		controlLamp(e);//вставлено чтобы для блока не евент сработал до  обработки результата, иначе результат не зачтётся
		get_result(NUM);
		Record();
		NUM++;
		}
		//===============================================================================================
		public function test(e:Event):void
		{			
			// блокировка кнопок
			Del_1_lamp.removeEventListener(MouseEvent.CLICK, one_Break_lamp);
			Del_2_lamp.removeEventListener(MouseEvent.CLICK, two_Breaks_lamp);
			
			timer.addEventListener(TimerEvent.TIMER, test_time);
			timer.start();
			
		}
		public function test_time(e:Event):void
		{		
				// цифра 0 на табло
		if (NUM_1 == 0)
		{
			     if ( level == 2)
				{
					rect_lamp_Green[3].visible = false;
			        circle_lamp_Green[3].visible = false;
					rect_lamp_Green[7].visible = false;
			        circle_lamp_Green[7].visible = false;
					rect_lamp_Green[8].visible = false;
			        circle_lamp_Green[8].visible = false;
				}
				else
				{
				   rect_lamp_Green[3].visible = false;
			       circle_lamp_Green[3].visible = false;
				}
			// get_result(NUM);
		}
			 // цифра 1 на табло
		if (NUM_1 == 1)
		{
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;					
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;	
					
			if (level == 2)
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;	
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;	
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;			 
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;	
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;	
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;	
			}
			// get_result(NUM);
		}		
			 // цифра 2 на табло
		if (NUM_1 == 2)
		{						
				rect_lamp_Green[0].visible = true;
				circle_lamp_Green[0].visible = true;	
				rect_lamp_Green[1].visible = true;
				circle_lamp_Green[1].visible = true;	
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;			 
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;			
			 
			 if (level == 2)
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false;
			   rect_lamp_Green[3].visible = false;
			   circle_lamp_Green[3].visible = false;
			   rect_lamp_Green[4].visible = false;
			   circle_lamp_Green[4].visible = false;
			   rect_lamp_Green[7].visible = false;
			   circle_lamp_Green[7].visible = false;
			 }
			 else
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false;
			 }
			// get_result(NUM);
		}
			 // цифра 3 на табло
	    if (NUM_1 ==3)
		{		 
			   rect_lamp_Green[0].visible = true;
			   circle_lamp_Green[0].visible = true;			 
			   rect_lamp_Green[6].visible = true;
			   circle_lamp_Green[6].visible = true;
			   rect_lamp_Green[3].visible = true;
			   circle_lamp_Green[3].visible = true;
			   rect_lamp_Green[4].visible = true;
			   circle_lamp_Green[4].visible = true;
			   rect_lamp_Green[7].visible = true;
			   circle_lamp_Green[7].visible = true;	
			   
			 if (level == 2)
			 {
			   rect_lamp_Green[0].visible = false;
			   circle_lamp_Green[0].visible = false;			 
			   rect_lamp_Green[2].visible = false;
			   circle_lamp_Green[2].visible = false;
			   rect_lamp_Green[4].visible = false;
			   circle_lamp_Green[4].visible = false;
			   rect_lamp_Green[5].visible = false;
			   circle_lamp_Green[5].visible = false;
			   rect_lamp_Green[6].visible = false;
			   circle_lamp_Green[6].visible = false; 				 
			 }
			 else 
			 {			
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
			 }
			// get_result(NUM);
		} 
			 // цифра 4 на табло
		if (NUM_1 ==4)
		{		 
			   rect_lamp_Green[0].visible = true;
			   circle_lamp_Green[0].visible = true;			 
			   rect_lamp_Green[2].visible = true;
			   circle_lamp_Green[2].visible = true;
			   rect_lamp_Green[4].visible = true;
			   circle_lamp_Green[4].visible = true;
			   rect_lamp_Green[5].visible = true;
			   circle_lamp_Green[5].visible = true;
			   rect_lamp_Green[6].visible = true;
			   circle_lamp_Green[6].visible = true; 				
			 
			 if (level == 2)
			 {
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;			 	
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;			 
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;			 
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			 }
			 else
			 {		   
				rect_lamp_Green[1].visible = false;
				circle_lamp_Green[1].visible = false;			 	
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;			 
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
			 }
			// get_result(NUM);
		} 
			 // цифра 5 на табло
		if (NUM_1 ==5)
		{		 
				rect_lamp_Green[1].visible = true;
				circle_lamp_Green[1].visible = true;			 	
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;			 
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;			 
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;			 
			 
			if (level == 2)
			{
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;	
				rect_lamp_Green[4].visible = false;;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;	
				rect_lamp_Green[8].visible = false;;
				circle_lamp_Green[8].visible = false;
			 
			}
			else
			{			 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;	
				rect_lamp_Green[4].visible = false;;
				circle_lamp_Green[4].visible = false;
			} 
			 //get_result(NUM);
		}
			 // цифра 6 на табло
		if (NUM_1 ==6)
		{			 
				rect_lamp_Green[2].visible = true;
				circle_lamp_Green[2].visible = true;	
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;	
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;				
			if (level == 2)
			{
				rect_lamp_Green[2].visible = false;
			    circle_lamp_Green[2].visible = false;
				rect_lamp_Green[0].visible = false;
			    circle_lamp_Green[0].visible = false;
				rect_lamp_Green[1].visible = false;
			    circle_lamp_Green[1].visible = false;
				rect_lamp_Green[8].visible = false;
			    circle_lamp_Green[8].visible = false;
			}
			else
			{ 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;		 
			} 
			// get_result(NUM);
		}
			 // цифра 7 на табло
		if (NUM_1 ==7)
		{			 
			 	
			    rect_lamp_Green[2].visible = true;
			    circle_lamp_Green[2].visible = true;
				rect_lamp_Green[0].visible = true;
			    circle_lamp_Green[0].visible = true;
				rect_lamp_Green[1].visible = true;
			    circle_lamp_Green[1].visible = true;
				rect_lamp_Green[8].visible = true;
			    circle_lamp_Green[8].visible = true;		 
			 	
			if (level == 2)
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				 		 
				rect_lamp_Green[2].visible = false;
				circle_lamp_Green[2].visible = false;
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;
				rect_lamp_Green[6].visible = false;
				circle_lamp_Green[6].visible = false;
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
				rect_lamp_Green[0].visible = false;
				circle_lamp_Green[0].visible = false;				 		 
				rect_lamp_Green[3].visible = false;
				circle_lamp_Green[3].visible = false;
				rect_lamp_Green[4].visible = false;
				circle_lamp_Green[4].visible = false;
				rect_lamp_Green[5].visible = false;
				circle_lamp_Green[5].visible = false;			 
			}
			 //get_result(NUM);			
		}
			 // цифра 8 на табло
		if (NUM_1 ==8)
		{			
			    rect_lamp_Green[0].visible = true;
				circle_lamp_Green[0].visible = true;				 		 
				rect_lamp_Green[2].visible = true;
				circle_lamp_Green[2].visible = true;
				rect_lamp_Green[3].visible = true;
				circle_lamp_Green[3].visible = true;
				rect_lamp_Green[5].visible = true;
				circle_lamp_Green[5].visible = true;
				rect_lamp_Green[6].visible = true;
				circle_lamp_Green[6].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;
				rect_lamp_Green[4].visible = true;
				circle_lamp_Green[4].visible = true;
			
			if (level == 2)
			{
				rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			 
			 //get_result(NUM);
		}
			 // цифра 9 на табло
		if (NUM_1 ==9)
		{	    
				rect_lamp_Green[7].visible = true;
				circle_lamp_Green[7].visible = true;
				rect_lamp_Green[8].visible = true;
				circle_lamp_Green[8].visible = true;
				
			if (level == 2)
			{
				rect_lamp_Green[4].visible = false;
			    circle_lamp_Green[4].visible = false;
			    rect_lamp_Green[7].visible = false;
				circle_lamp_Green[7].visible = false;
				rect_lamp_Green[5].visible = false;
			    circle_lamp_Green[5].visible = false;
				rect_lamp_Green[6].visible = false;
			    circle_lamp_Green[6].visible = false;
			}
			else
			{
			 rect_lamp_Green[4].visible = false;
			 circle_lamp_Green[4].visible = false;				 
			}
		}	
			controllaContattonot(e);
			controllaContattoor(e);
			controllaContatto(e);
			controlLamp(e);//вставлено чтобы для блока не евент сработал до  обработки результата, иначе результат не зачтётся
			get_result(NUM_1);
			Record();
			 NUM_1++;			
		}		
		//===================================================
		public function Buttons():void	//функция создающая кнопки
		{				
			//кнопка смены уровня								
    		var But_level:TextButton = createButtons("Уровень");	
			But_level.x = 20;
			But_level.y = 80;
			addChild(But_level);
			But_level.addEventListener(MouseEvent.CLICK, Level);			
			//---------------------------------------------------
			var text_creat:TextField = new TextField();
			text_creat.autoSize = TextFieldAutoSize.LEFT;
			text_creat.text = "Добавить блок:";
			text_creat.x = 20;
			text_creat.y = 120;			
			addChild(text_creat);
			//кнопка или			
    		var But_create_or:TextButton = createButtons("'ИЛИ'");	
			But_create_or.x = 20;
			But_create_or.y = 160;
			addChild(But_create_or);
			But_create_or.addEventListener(MouseEvent.CLICK, Createor);
					
			//кнопка и		
			var But_create_and:SimpleButton = createButtons("'И'");
			But_create_and.x = 20;
			But_create_and.y = 200;
			addChild(But_create_and);
			But_create_and.addEventListener(MouseEvent.CLICK, CreateAnd);
						
			//кнопка не			
			var But_create_not:SimpleButton = createButtons("'НЕ'");
			But_create_not.x = 20;
			But_create_not.y = 240;
			addChild(But_create_not);
			But_create_not.addEventListener(MouseEvent.CLICK, Createnot);
			
			var But_create_Disconnect:SimpleButton = createButtons("Отсоединить");
			But_create_Disconnect.x = 20;
			But_create_Disconnect.y = 280;
			addChild(But_create_Disconnect);
			But_create_Disconnect.addEventListener(MouseEvent.CLICK, disconnect);
			
			//---------------------------------------------------------------------------
			
			var text_test:TextField = new TextField();
			text_test.autoSize = TextFieldAutoSize.LEFT;
			text_test.text = "Проверки:";
			text_test.x = 150;
			text_test.y = 450;			
			addChild(text_test);
			//кнопка пошаговая проверка
			var But_test_step:SimpleButton = createButtons("Пошаговая");
			But_test_step.x = 150;
			But_test_step.y = 480;
			addChild(But_test_step);
			But_test_step.addEventListener(MouseEvent.CLICK,test_step);
			myVar = 0;
			
			//кнопка проверка
			var But_test_continius:SimpleButton = createButtons("Мгновенная");
			But_test_continius.x = 250;
			But_test_continius.y = 480;
			addChild(But_test_continius);
			But_test_continius.addEventListener(MouseEvent.CLICK, test_continius);
						
			//кнопка Прверка с задержкой
			var But_test:SimpleButton = createButtons("С задержкой");
			But_test.x = 350;
			But_test.y = 480;
			addChild(But_test);
			But_test.addEventListener(MouseEvent.CLICK, test);
			//-------------------------------------------------------------------------------
			// кнопка сброса решения
			var Del_result:SimpleButton = createButtons("Сбросить");
			Del_result.x = 780;
			Del_result.y = 450;
			addChild(Del_result);
			Del_result.addEventListener(MouseEvent.CLICK, del_result);
			
			//-----------------------------------------------------------------------------------
		    //кнопка для убирания одной лапочки			
			Del_1_lamp.x = 150;
			Del_1_lamp.y = 520;
			addChild(Del_1_lamp);
			Del_1_lamp.addEventListener(MouseEvent.CLICK, one_Break_lamp);
						
			//кнопка для убирания двух лапочек			
			Del_2_lamp.x = 350;
			Del_2_lamp.y = 500;			
			Del_2_lamp.addEventListener(MouseEvent.CLICK, two_Breaks_lamp);
						
		}
		//===================================================================================================
		public function createButtons(a:String):TextButton  // функция создания кнопок
		{
				return new TextButton(a);
		}	
		
		//===================================================================================================
		public function createCont_Prov():void // функция создающая лампочки конечной проверки
		{	
			var i:int;
			var a:int = 40;
			
			
			//---------------------------------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------
			// красные лампочки
			for (i = 0; i < 10; i++) 
			{
				var c_lamp_Red_prov:Sprite = createCircle( 0xff0000, 10);
				circle_lamp_Red_prov[i] = c_lamp_Red_prov;
				
				circle_lamp_Red_prov[i].x = 860;
				circle_lamp_Red_prov[i].y = a;
				addChild(circle_lamp_Red_prov[i]);
				a = a + 40;
			}
			//---------------------------------------------------------------------------------
			// зеленые лампочки
			a = 40;
			for (i = 0; i < 10; i++) 
			{
				var c_lamp_Green_prov:Sprite = createCircle( 0x00ff00, 10);
				circle_lamp_Green_prov[i] = c_lamp_Green_prov;
				
				circle_lamp_Green_prov[i].x = 860;
				circle_lamp_Green_prov[i].y = a;
				addChild(circle_lamp_Green_prov[i]);
                a = a + 40;
			}
			
			
			
			circle_lamp_Green_prov[0].visible = false;
			var text_f_7:TextField = new TextField();
			text_f_7.autoSize = TextFieldAutoSize.LEFT;
			text_f_7.text = "0";
			text_f_7.x = 880;
			text_f_7.y = 25;			
			addChild(text_f_7);
			
			
			circle_lamp_Green_prov[1].visible = false;
			var text_f_8:TextField = new TextField();
			text_f_8.autoSize = TextFieldAutoSize.LEFT;
			text_f_8.text = "1";
			text_f_8.x = 880;
			text_f_8.y = 65;			
			addChild(text_f_8);
			
			
			circle_lamp_Green_prov[2].visible = false;
			var text_f_9:TextField = new TextField();
			text_f_9.autoSize = TextFieldAutoSize.LEFT;
			text_f_9.text = "2";
			text_f_9.x = 880;
			text_f_9.y = 105;			
			addChild(text_f_9);
			
			
			circle_lamp_Green_prov[3].visible = false;
			var text_f_10:TextField = new TextField();
			text_f_10.autoSize = TextFieldAutoSize.LEFT;
			text_f_10.text = "3";
			text_f_10.x = 880;
			text_f_10.y = 145;			
			addChild(text_f_10);
			
			
			circle_lamp_Green_prov[4].visible = false;
			var text_f_11:TextField = new TextField();
			text_f_11.autoSize = TextFieldAutoSize.LEFT;
			text_f_11.text = "4";
			text_f_11.x = 880;
			text_f_11.y = 185;			
			addChild(text_f_11);
			
			
			circle_lamp_Green_prov[5].visible = false;
			var text_f_12:TextField = new TextField();
			text_f_12.autoSize = TextFieldAutoSize.LEFT;
			text_f_12.text = "5";
			text_f_12.x = 880;
			text_f_12.y = 225;			
			addChild(text_f_12);
			
			
			circle_lamp_Green_prov[6].visible = false;
			var text_f_13:TextField = new TextField();
			text_f_13.autoSize = TextFieldAutoSize.LEFT;
			text_f_13.text = "6";
			text_f_13.x = 880;
			text_f_13.y = 265;			
			addChild(text_f_13);
			
			
			circle_lamp_Green_prov[7].visible = false;
			var text_f_14:TextField = new TextField();
			text_f_14.autoSize = TextFieldAutoSize.LEFT;
			text_f_14.text = "7";
			text_f_14.x = 880;
			text_f_14.y = 305;			
			addChild(text_f_14);
			
			
			circle_lamp_Green_prov[8].visible = false;
			var text_f_15:TextField = new TextField();
			text_f_15.autoSize = TextFieldAutoSize.LEFT;
			text_f_15.text = "8";
			text_f_15.x = 880;
			text_f_15.y = 345;			
			addChild(text_f_15);
			
		
			circle_lamp_Green_prov[9].visible = false;
			var text_f_16:TextField = new TextField();
			text_f_16.autoSize = TextFieldAutoSize.LEFT;
			text_f_16.text = "9";
			text_f_16.x = 880;
			text_f_16.y = 385;			
			addChild(text_f_16);

		}
		//===================================================================================================
		public function createCont():void //функция создающая контакты
		{
			var i:int = 0;
			var a:int = 100;
			// красные лампочки			
			for (i = 0; i < 9; i++) 
			{
				var c_lamp_Red:Sprite = createCircle( 0xff0000, 7);
				circle_lamp_Red[i] = c_lamp_Red;
				
				circle_lamp_Red[i].x = 280;
			    circle_lamp_Red[i].y =  a;			    
				a = a + 30;
			}			
		//-------------------------------------------------------------------------------------------
		// зеленые лампочки
		a = 100;
		for (i = 0; i < 9; i++) 
			{
				var c_lamp_Green:Sprite = createCircle( 0x00ff00, 7);
				circle_lamp_Green[i] = c_lamp_Green;
				
				circle_lamp_Green[i].x = 280;
			    circle_lamp_Green[i].y = a;			    
				a = a + 30;				
			}
		// вывод на сцены ламп
		  if (level == 1)
		  {
			  for (i = 0; i < 7; i++)	
			  {
				addChild(circle_lamp_Red[i]);
				addChild(circle_lamp_Green[i]);
			  }
		  }
		  if (level == 2)
		  {
			  for (i = 0; i < 9; i++)	
			  {
				addChild(circle_lamp_Red[i]);
				addChild(circle_lamp_Green[i]);
			   }
		  }					
		}	
		//===================================================================================================
		public function createNum():void //функция создающая табло
		{
		    var i:int;	
			var rect:Sprite = createRect( 0x808080, 150, 280); // основа табло 
			rect.x = 140;
			rect.y = 80;
			addChild(rect);			
			
			for (i = 0; i < 9; i++) 
			{
				var lamp_Green:Sprite = createRect( 0x00ff00, 60, 15);
				rect_lamp_Green[i] = lamp_Green;
			}			
			// местоположение зеленых горизонтальных ламп
			//верхний
			rect_lamp_Green[1].x = 170; 
			rect_lamp_Green[1].y = 90;			
			addChild(rect_lamp_Green[1]);
			//средний
			rect_lamp_Green[3].x = 170; 
			rect_lamp_Green[3].y = 170;
			addChild(rect_lamp_Green[3]);
			//нижний
			rect_lamp_Green[5].x = 170; 
			rect_lamp_Green[5].y = 245;
			addChild(rect_lamp_Green[5]);
			
			// местоположение зеленых вертикальных ламп
			//правый верхний
			rect_lamp_Green[0].x = 160; 
			rect_lamp_Green[0].y = 105;
			rect_lamp_Green[0].rotation = 90;
		    addChild(rect_lamp_Green[0]);
			//правый нижний
			rect_lamp_Green[4].x = 160; 
			rect_lamp_Green[4].y = 185;
			rect_lamp_Green[4].rotation = 90;
			addChild(rect_lamp_Green[4]);
			//левый верхний
			rect_lamp_Green[2].x = 255; 
			rect_lamp_Green[2].y = 105;
			rect_lamp_Green[2].rotation = 90;
			addChild(rect_lamp_Green[2]);
			//левый нижний
			rect_lamp_Green[6].x = 255; 
			rect_lamp_Green[6].y = 185;
			rect_lamp_Green[6].rotation = 90;
			addChild(rect_lamp_Green[6]);
			if ( level == 2)
			{
		    //диагональный верхний
			rect_lamp_Green[7].x = 172; 
			rect_lamp_Green[7].y = 152;
			rect_lamp_Green[7].rotation = -45;
			addChild(rect_lamp_Green[7]);
			//диагональный нижний
			rect_lamp_Green[8].x = 172; 
			rect_lamp_Green[8].y = 232;
			rect_lamp_Green[8].rotation =-45;
			addChild(rect_lamp_Green[8]);
			// текстовые поля вывода подписей на лампах
			var num8:TextField = new TextField();
			num8.autoSize = TextFieldAutoSize.LEFT;
			num8.text = "8";
			num8.x = 192;
			num8.y = 127;			
			addChild(num8);
			
			var num9:TextField = new TextField();
			num9.autoSize = TextFieldAutoSize.LEFT;
			num9.text = "9";
			num9.x = 192;
			num9.y = 207;			
			addChild(num9);			
			}			
			// текстовые поля вывода подписей на лампах
			var num1:TextField = new TextField();
			num1.autoSize = TextFieldAutoSize.LEFT;
			num1.text = "1";
			num1.x = 148;
			num1.y = 128;			
			addChild(num1);
			
			var num2:TextField = new TextField();
			num2.autoSize = TextFieldAutoSize.LEFT;
			num2.text = "2";
			num2.x = 195;
			num2.y = 89;			
			addChild(num2);
			
			var num3:TextField = new TextField();
			num3.autoSize = TextFieldAutoSize.LEFT;
			num3.text = "3";
			num3.x = 243;
			num3.y = 128;			
			addChild(num3);
			
			var num4:TextField = new TextField();
			num4.autoSize = TextFieldAutoSize.LEFT;
			num4.text = "4";
			num4.x = 195;
			num4.y = 169;			
			addChild(num4);			
			
			var num5:TextField = new TextField();
			num5.autoSize = TextFieldAutoSize.LEFT;
			num5.text = "5";
			num5.x = 148;
			num5.y = 208;			
			addChild(num5);
			
			var num6:TextField = new TextField();
			num6.autoSize = TextFieldAutoSize.LEFT;
			num6.text = "6";
			num6.x = 195;
			num6.y = 244;			
			addChild(num6);
			
			var num7:TextField = new TextField();
			num7.autoSize = TextFieldAutoSize.LEFT;
			num7.text = "7";
			num7.x = 243;
			num7.y = 208;			
			addChild(num7);	
		}
		
		//==========================================================================
		//==========================================================================
		public function createRect( color: int , length: int,width: int): Sprite
		{
			var shape:Sprite = new Sprite();			
			shape.graphics.beginFill(color);
			shape.graphics.lineStyle(1);
			shape.graphics.drawRect(0, 0, length,width);
			shape.graphics.endFill();			
			return shape;
		}
		//===================================================
		public function createCircle( color: int , radius:int ): Sprite
		{
			var shape:Sprite = new Sprite();
			shape.graphics.beginFill(color);
			shape.graphics.drawCircle(0, 0, radius);
			shape.graphics.endFill();	
			return shape;
		}
		
		public function del_result (e:Event) :void // функция сброса результатат
		{
			Del_1_lamp.addEventListener(MouseEvent.CLICK, one_Break_lamp);
			Del_2_lamp.addEventListener(MouseEvent.CLICK, two_Breaks_lamp);	
			
			 rect_lamp_Green[0].visible = true;
			 circle_lamp_Green[0].visible = true;	
			 rect_lamp_Green[1].visible = true;
			 circle_lamp_Green[1].visible = true;	
			 rect_lamp_Green[2].visible = true;
			 circle_lamp_Green[2].visible = true;
			 rect_lamp_Green[3].visible = true;
			 circle_lamp_Green[3].visible = true;			 
			 rect_lamp_Green[4].visible = true;
			 circle_lamp_Green[4].visible = true;
			 rect_lamp_Green[5].visible = true;
			 circle_lamp_Green[5].visible = true;
			 rect_lamp_Green[6].visible = true;
			 circle_lamp_Green[6].visible = true;
			 rect_lamp_Green[7].visible = true;
			 circle_lamp_Green[7].visible = true;
			 rect_lamp_Green[8].visible = true;
			 circle_lamp_Green[8].visible = true;
			 
			var i:int = 0;
			for ( i = 0 ; i < 10 ; i++)
			{
			   circle_lamp_Green_prov[i].visible = false;
			       		   
			}			 
			Result = 0;
			t_result.text =  '  ' + Result;
			t_nB.text =  '  ' + NumberBlokcs;
			if (NUM_first_Break_lamp != 11)
			{
			   addChild(rect_lamp_Green[NUM_first_Break_lamp]);			   
			   addChild(circle_lamp_Red[NUM_first_Break_lamp]);
			   addChild(circle_lamp_Green[NUM_first_Break_lamp]);
			}
			if (NUM_second_Break_lamp != 11)
			{
			   addChild(rect_lamp_Green[NUM_first_Break_lamp]);			   
			   addChild(circle_lamp_Red[NUM_first_Break_lamp]);
			   addChild(circle_lamp_Green[NUM_first_Break_lamp]);
			   
			   addChild(rect_lamp_Green[NUM_second_Break_lamp]);			   
			   addChild(circle_lamp_Red[NUM_second_Break_lamp]);
			   addChild(circle_lamp_Green[NUM_second_Break_lamp]);
			}
			NUM = 0;
			NUM_1 = 0;
			timer.stop();
		}		
	    //===================================================
		public function get_result (n:int) :void //функция получения результата
		{
			var i:int = 0;
			var flag:int = 1;
			var a:int = 0;
			if (n == 0)
				for (i = 0; i < 10; i++)
					controlAnswer[i] = -1;		
			for ( i = 0 ; i < 10 ; i++)
			{
				if (i != n  && circle_lamp_Green_prov[i].visible == true)
				{
					flag = 0;
					controlAnswer[i] = 0;
				}
				if (circle_lamp_Green_prov[i].visible == true && i == n  && flag != 0)
				{
					a = 1;
					if(controlAnswer[i]!=0)
						controlAnswer[i] = 1;
				}
			}
			if (n == 9)
			{
				for (i = 0; i < 10; i++)
				{
					if(controlAnswer[i] == 1)
						Result++;
				}
				t_result.text =  '  ' + Result;
				t_nB.text =  '  ' + NumberBlokcs;
			}
			
		}		
		//====================================================
		public function Record ():void
		{
			if (Result > Record_Result)
			{
			          Record_Result = Result;
					  Record_NumberBlokcs = NumberBlokcs;
			}
			else
			  if (Result == Record_Result)
			  {
				  if (NumberBlokcs > Record_NumberBlokcs)
				  {
					Record_Result = Result;
					 Record_NumberBlokcs = NumberBlokcs;  
				  }				  
			  }	
			  t_record_result.text =  '  ' + Record_Result;
			  t_record_numberBlokcs.text =  '  ' + Record_NumberBlokcs
		}
		//====================================================
		public function one_Break_lamp ( e:Event):void // функция удаления одной лампы
		{
			del_result(e);
			var i:int = 0;
			Del_2_lamp.removeEventListener(MouseEvent.CLICK, two_Breaks_lamp);
			i = Math.floor(Math.random()*7);
			removeChild(rect_lamp_Green[i]);
			removeChild(circle_lamp_Green[i]);
			removeChild(circle_lamp_Red[i]);
			NUM_first_Break_lamp = i;
			Del_1_lamp.removeEventListener(MouseEvent.CLICK, one_Break_lamp);
		}		
		//===================================================
		public function two_Breaks_lamp ( e:Event):void // функция удаления двух ламп
		{
			var j:int = 0;
			var i:int = 0;
			Del_1_lamp.removeEventListener(MouseEvent.CLICK, one_Break_lamp);
			i = Math.floor(Math.random() * 9);
			j = Math.floor(Math.random() * 9);
			if (i == j)
			{
				i = Math.floor(Math.random() * 9);
				j = Math.floor(Math.random() * 9);
			}		
			
			removeChild(rect_lamp_Green[j]);
			removeChild(circle_lamp_Green[j]);
			removeChild(circle_lamp_Red[j]);
			
			removeChild(rect_lamp_Green[i]);
			removeChild(circle_lamp_Green[i]);
			removeChild(circle_lamp_Red[i]);
			NUM_first_Break_lamp = i;	
			NUM_second_Break_lamp = j;
		}		
		//=================================================
		public function Level(e:Event):void
		{
			del_result(e);
			if (level == 1 )
			    level = 2;
			else
			    level = 1 ;
			text_lvl_1.text = '            ' + level;
			createNum();
			createCont();
			createCont_Prov();
		}
		/**
		* ...
		* @author this part is Vlad
		* 
		* 
		*/
		//=====================================================
		public function disconnect(e:Event):void
		{
			var flag:int = 1;
			var flag2:int = 1;
			var flag3:int = 1;
			for (var i:int=0; i < andTull.length && flag; i++)
			{
				if (lineLAddAnd[i]&&leftAndHit[i])
				{
					andLeft[i].x = andTull[i].x - 20; 
					andLeft[i].y = andTull[i].y -5;
					flag = 0;
				}
				if (lineRAddAnd[i] && rightAndHit[i])
				{
					andRight[i].x = andTull[i].x - 20; 
					andRight[i].y = andTull[i].y + 30;
					flag = 0;
				}
			}
			for (i=0; i < orTull.length && flag2; i++)
			{
				if (lineLAddOr[i]&&leftOrHit[i])
				{
					orLeft[i].x = orTull[i].x - 20; 
					orLeft[i].y = orTull[i].y -5;
					flag2 = 0;
				}
				if (lineRAddOr[i] && rightOrHit[i])
				{
					orRight[i].x = orTull[i].x - 20; 
					orRight[i].y = orTull[i].y + 30;
					flag2 = 0;
				}
			}
			for (i=0; i < notTull.length && flag3; i++)
			{
				if (lineRAddNot[i] && rightNotHit[i])
				{
					notRight[i].x = notTull[i].x - 20; 
					notRight[i].y = notTull[i].y + 15;
					flag3 = 0;
				}
			}			
			
		}
		//====================================================
		public function CreateAnd(e:Event):void 
		{
			del_result(e);
			timer.stop();
            var tull:Sprite = createRect( 0x508080, 30, 30); //тело
		    var leftc:Sprite = createCircle(0x228B22, 7);// левый контакт
		    var rightc:Sprite = createCircle(0x228B22, 7);// правый контакт
		    var aimc:Sprite = createCircle(0x200321, 7);	//		итоговый контакт
			
			tull.x = 350;
			tull.y = 10;
			leftc.x = 330;
			leftc.y = 10;
			rightc.x = 330;
			rightc.y = 35;
			aimc.x = 400;
			aimc.y = 25;
			
			andTull.push(tull);
			andLeft.push(leftc);
			andRight.push(rightc);
			andAim.push(aimc);
			
			addChild(leftc);
			addChild(tull);	
			addChild(rightc);
			addChild(aimc);
			
			createLine(tull.x, tull.y, aimc.x, aimc.y, andLineAim,30,15,numAnd);
			createBezie(tull.x, tull.y, leftc.x + 7, leftc.y - 3, andLineL, 0, 5,20,numAnd);
			createBezie(tull.x, tull.y, rightc.x + 7, rightc.y + 3,andLineR,0,25,-20,numAnd);
			
			addEventListener(MouseEvent.MOUSE_DOWN, down);
			addEventListener(MouseEvent.MOUSE_UP,  up);
			
			
			addEventListener(Event.ENTER_FRAME, controllaContatto);
			addEventListener(Event.ENTER_FRAME, controlWire);
			NumberBlokcs++;
			numAnd++;
		}
		//========================================================= 
		public function controlLamp(e:Event):void
		{
			var i:int;
			var k:int;
			var flag:int = 1;
			var flag2:int = 1;
			var flag3:int = 1;
			for (i = 0; i < 10; i++)
			{
				for (k = 0; k < andTull.length&&flag; k++)
				{
					if (circle_lamp_Green_prov[i].hitTestObject(andAim[k]))
					{
						circle_lamp_Green_prov[i].visible = andAimResult[k];
						flag = 0;
					}
				}
				for (k = 0; k < orTull.length&&flag2; k++)
				{
					if (circle_lamp_Green_prov[i].hitTestObject(orAim[k]))
					{
						circle_lamp_Green_prov[i].visible = orAimResult[k];
						flag2 = 0;
					}
				}
				for (k = 0; k < notTull.length&&flag3; k++)
				{
					if (circle_lamp_Green_prov[i].hitTestObject(notAim[k]))
					{
						circle_lamp_Green_prov[i].visible = notAimResult[k];
						flag3 = 0;
					}
				}
				if (flag&&flag2&&flag3)
				{
					circle_lamp_Green_prov[i].visible = false;
				}
				flag = 1;
				flag2 = 1;
				flag3 = 1;
			}
		}
		//=========================================================
		public function createLine(x1:int, y1:int, x2:int, y2:int,arr:Array, stepX:int, stepY:int,n:int):void
		{
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(3);
			line.graphics.moveTo(x1+stepX, y1+stepY);
			line.graphics.lineTo(x2,y2);
			addChild(line);
			arr[n]=line;
		}
		//==================================================
		public function createBezie(x1:int, y1:int, x2:int, y2:int, arr:Array, stepX:int, stepY:int,stepYAnchor:int,n:int):void
		{
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(3,0x0000CC);
			line.graphics.moveTo(x1+stepX, y1+stepY);
			line.graphics.curveTo(x1+20+(x2-x1)/2,y2-stepYAnchor,x2,y2);
			addChild(line);
			arr[n]=line;
		}
		//===================================================
		public function wireL(e:Event,n:int):void
		{   
			removeChild(andLineL[n]);
			var additLine:Sprite = new Sprite();
			var line:Sprite = new Sprite();
			if (andLeftResult[n] == true)
				{
					line.graphics.lineStyle(3, 0xFF0000);
				}
			else
				{
					line.graphics.lineStyle(3, 0x0000CC);
				}
				
			if (lineLAddAnd[n])
				{
					removeChild(additLineLAnd[n]);
					additLine.graphics.lineStyle(6, 0x00CCFF);
					additLine.graphics.moveTo(andTull[n].x, andTull[n].y+5);
					additLine.graphics.curveTo(andTull[n].x+20+(andLeft[n].x + 7-andTull[n].x)/2,andLeft[n].y - 23,andLeft[n].x + 7,andLeft[n].y - 3);
					additLineLAnd[n] = additLine;
					addChild(additLineLAnd[n]);
				}
				
			line.graphics.moveTo(andTull[n].x, andTull[n].y+5);
			line.graphics.curveTo(andTull[n].x+20+(andLeft[n].x + 7-andTull[n].x)/2,andLeft[n].y - 23,andLeft[n].x + 7,andLeft[n].y - 3);
			addChild(line);
			andLineL[n] = line;
		}
		//=====================================================
		public function wireR(e:Event,n:int):void
		{   
			removeChild(andLineR[n]);
			var line:Sprite = new Sprite();
			var additLine:Sprite = new Sprite();
			if (andRightResult[n] == true)
				{
					line.graphics.lineStyle(3, 0xFF0000);
				}
			else
				{
					line.graphics.lineStyle(3, 0x0000CC);
				}
			if (lineRAddAnd[n])
				{
					removeChild(additLineRAnd[n]);
					additLine.graphics.lineStyle(6, 0x00CCFF);
					additLine.graphics.moveTo(andTull[n].x, andTull[n].y+25);
					additLine.graphics.curveTo(andTull[n].x+20+(andRight[n].x + 7-andTull[n].x)/2,andRight[n].y + 17,andRight[n].x + 7,andRight[n].y - 3);
					additLineRAnd[n] = additLine;
					addChild(additLineRAnd[n]);
				}
			line.graphics.moveTo(andTull[n].x, andTull[n].y+25);
			line.graphics.curveTo(andTull[n].x+20+(andRight[n].x + 7-andTull[n].x)/2,andRight[n].y + 17,andRight[n].x + 7,andRight[n].y - 3);
			addChild(line);
			andLineR[n] = line;
		}
		//====================================================
		/*public function distanceAnd(e:MouseEvent):void
		{
			controlDistance(e, andTull, andRight, andLeft, myVar, dragCircle, dragContactsAnd);
		}
		//=======================================================
		public function distanceOr(e:MouseEvent):void
		{
			controlDistance(e, orTull, orRight, orLeft, myVar2, dragCircleor, dragContactsOr);
		}
		//+======================================================
		public function distanceNot(e:MouseEvent):void
		{
			controlDistance(e, notTull, notRight, null, myVar3, dragCirclenot, dragContactsNot);
		}*/
		//====================================================
		/*public function controlDistance(e:MouseEvent,body:Array, right:Array, left:Array, k:int,func1:Function,func2:Function):void
		{
			if(left)
			{	
				if((Math.sqrt(Math.pow((body[k].x - right[k].x),2)+Math.pow((body[k].y - right[k].y),2)) < 200)||(Math.sqrt(Math.pow((body[k].x - left[k].x),2)+Math.pow((body[k].y - left[k].y),2)) < 200))
				{
					func1(e);
				}
				else
				{
					func2(e);
				}
			}
			else
			{
				if((Math.sqrt(Math.pow((body[k].x - right[k].x),2)+Math.pow((body[k].y - right[k].y),2)) < 200))
				{
					func1(e);
				}
				else
				{
					func2(e);
				}
			}
		}*/
		//====================================================
		
		public function down(e:Event):void
		{
			var vs:Sprite = new Sprite();
			var flag : int = 0 ;
			var k: int = 0;
			
			var additLine:Sprite = new Sprite();
			for (k = 0;k < 30 && flag==0; k++)
			{
				if(andTull[k]==e.target)
				{
					setChildIndex(andTull[k], numChildren - 1);
					flag = 1;
					myVar = k;// глобальный подсчёт блоков И
					andTull[k].startDrag();
					addEventListener(MouseEvent.MOUSE_MOVE, dragConnect);
					if(leftAndHit[k])
						stage.addEventListener(MouseEvent.MOUSE_MOVE, dragContactsAnd);
					if (rightAndHit[k])
						stage.addEventListener(MouseEvent.MOUSE_MOVE, dragContactsAnd);
					if(!leftAndHit[k]&&!rightAndHit[k])
						stage.addEventListener(MouseEvent.MOUSE_MOVE, dragCircle);
				}
				if (andRight[k]==e.target )
				{
					flag = 1;
					myVar = k;
					andRight[k].startDrag();
					setChildIndex(andRight[k], numChildren - 1);
				}
				if ( andLeft[k]==e.target )
				{
					flag = 1;
					myVar = k;
					andLeft[k].startDrag();
					setChildIndex(andLeft[k], numChildren - 1);
				}	
				if (e.target == andLineL[k])
				{
					flag = 1;
					myVar = k;
					for (var i:int = 0; i < andTull.length;i++)
					{
						if (lineLAddAnd[i])
							{
								lineLAddAnd[i] = false;
								removeChild(additLineLAnd[i]);
								if (i == myVar)
								{
									complite = 1;
								}
								else
								{
									complite = 0;
								}
							}
						if (lineRAddAnd[i])
							{
								lineRAddAnd[i] = false;
								removeChild(additLineRAnd[i]);
								complite = 0;
							}
					}
					for (i = 0; i < notTull.length; i++)
					{
						if (lineRAddNot[i])
							{
								lineRAddNot[i] = false;
								removeChild(additLineRNot[i]);
								complite3 = 0;
							}
					}
					for (i = 0; i < orTull.length; i++)
					{
						if (lineLAddOr[i])
							{
								lineLAddOr[i] = false;
								removeChild(additLineLOr[i]);
								complite2 = 0;
							}
						if (lineRAddOr[i])
							{
								lineRAddOr[i] = false;
								removeChild(additLineROr[i]);
								complite2 = 0;
							}
					}
					
					if(!complite)
					{
						flag = 1;
						myVar = k;
						lineLAddAnd[k] = true;
						setChildIndex(andLeft[k], numChildren - 1);
						additLine.graphics.lineStyle(6, 0x00CCFF);
						additLine.graphics.moveTo(andTull[k].x, andTull[k].y+5);
						additLine.graphics.curveTo(andTull[k].x+20+(andLeft[k].x + 7-andTull[k].x)/2,andLeft[k].y - 23,andLeft[k].x + 7,andLeft[k].y - 3);
						additLineLAnd[k] = additLine;
						addChild(additLineLAnd[k]);
						complite = 1;
					}
					else
						complite = 0;
				}
				if (e.target == andLineR[k])
				{
					flag = 1;
					myVar = k;
					for (i = 0; i < andTull.length;i++)
					{
						if (lineRAddAnd[i])
							{
							lineRAddAnd[i] = false;
							removeChild(additLineRAnd[i]);
							if (i == myVar)
							{
								complite = 1;
							}
							else
							{
								complite = 0;
							}
						}
						if (lineLAddAnd[i])
							{
								lineLAddAnd[i] = false;
								removeChild(additLineLAnd[i]);
								complite = 0;
							}
					}
					for (i = 0; i < notTull.length; i++)
					{
						if (lineRAddNot[i])
							{
								lineRAddNot[i] = false;
								removeChild(additLineRNot[i]);
								complite3 = 0;
							}
					}
					for (i = 0; i < orTull.length; i++)
					{
						if (lineLAddOr[i])
							{
								lineLAddOr[i] = false;
								removeChild(additLineLOr[i]);
								complite2 = 0;
							}
						if (lineRAddOr[i])
							{
								lineRAddOr[i] = false;
								removeChild(additLineROr[i]);
								complite2 = 0;
							}
					}
					if(!complite)
					{
						flag = 1;
						myVar = k;
						lineRAddAnd[k] = true;
						setChildIndex(andRight[k], numChildren - 1);
						additLine.graphics.lineStyle(6, 0x00CCFF);
						additLine.graphics.moveTo(andTull[k].x, andTull[k].y+25);
						additLine.graphics.curveTo(andTull[k].x+20+(andRight[k].x + 7-andTull[k].x)/2,andRight[k].y + 17,andRight[k].x + 7,andRight[k].y - 3);
						additLineRAnd[k] = additLine;
						addChild(additLineRAnd[k]);
						complite = 1;
					}
					else
						complite = 0;
				}
			}			
			
		}
		//===================================================
		public function controlWire(e:Event):void
		{
			for (var i:int = 0; i < numAnd; i++)
			{
				wireL(e,i);
				wireR(e,i);
			}
		}
		//===================================================
		public function dragCircle(event:MouseEvent):void 
		{ 
			var x1:int = andLeft[myVar].x;
			var y1:int=andLeft[myVar].y;
			var x2:int=andRight[myVar].x;
			var y2:int = andRight[myVar].y;
			if (myVar >= 0)
			{
				andAim[myVar].x = andTull[myVar].x + 50; 
				andAim[myVar].y = andTull[myVar].y + 15;
				andLineAim[myVar].x = andTull[myVar].x - 350;
				andLineAim[myVar].y = andTull[myVar].y - 10;
				andLeft[myVar].x = andTull[myVar].x - 20; 
				andLeft[myVar].y = andTull[myVar].y -5;
				andRight[myVar].x = andTull[myVar].x - 20; 
				andRight[myVar].y = andTull[myVar].y + 30;
				wireL(event,myVar);
				wireR(event,myVar);
				event.updateAfterEvent(); 
			}

		} 	
		//====================================================
		public function dragContactsAnd(event:MouseEvent):void 
		{
			if (myVar >= 0)
			{
			andAim[myVar].x = andTull[myVar].x + 50; 
			andAim[myVar].y = andTull[myVar].y + 15;
			andLineAim[myVar].x = andTull[myVar].x - 350;
			andLineAim[myVar].y = andTull[myVar].y - 10;
			if (!leftAndHit[myVar])
			{
				andLeft[myVar].x = andTull[myVar].x - 20; 
				andLeft[myVar].y = andTull[myVar].y - 5;
			}
			
			if (!rightAndHit[myVar])
			{
				andRight[myVar].x = andTull[myVar].x - 20; 
				andRight[myVar].y = andTull[myVar].y + 30;
			}
			//if (leftAndHit[myVar] && rightAndHit[myVar])
			
			wireL(event,myVar);
			wireR(event,myVar);
			event.updateAfterEvent(); 
			}
		}
		//===================================================
		public function dragConnect(event:MouseEvent):void
		{
			moveconnect(event, myVar, andAim);
		}
		//=====================================================
		public function dragConnectOr(event:MouseEvent):void
		{
			moveconnect(event, myVar2, orAim);
		}
		//======================================================
		public function dragConnectNot(event:MouseEvent):void
		{
			moveconnect(event, myVar3, notAim);
		}
		//===================================================
		public function moveconnect(e:MouseEvent,n:int, aim:Array):void
		{
			var flag:int = 1;
			for (var i:int = 0; i < andTull.length&&flag; i++)
			{
				if (andLeft[i].hitTestObject(aim[n]))
				{
					andLeft[i].x = aim[n].x;
					andLeft[i].y = aim[n].y;
					flag = 0;
				}
				if (andRight[i].hitTestObject(aim[n]))
				{
					andRight[i].x = aim[n].x;
					andRight[i].y = aim[n].y;
					flag = 0;
				}
			}
			for (i = 0; i < orTull.length&&flag; i++)
			{
				if (orLeft[i].hitTestObject(aim[n]))
				{
					orLeft[i].x = aim[n].x;
					orLeft[i].y = aim[n].y;
					flag = 0;
				}
				if (orRight[i].hitTestObject(aim[n]))
				{
					orRight[i].x = aim[n].x;
					orRight[i].y = aim[n].y;
					flag = 0;
				}
			}
			for (i = 0; i < notTull.length&&flag; i++)
			{
				if (notRight[i].hitTestObject(aim[n]))
				{
					notRight[i].x = aim[n].x;
					notRight[i].y = aim[n].y;
					flag = 0;
				}
			}
			e.updateAfterEvent(); 
		}
		//===================================================
		public function up(e:Event):void
		{
			var flag:int = 0;
			var k:int = 0;
			var vs:Sprite = new Sprite();//вспомогательная переменная
			var vs2:Boolean;
			if (e.target == andLeft[myVar])
				{
					andLeft[myVar].stopDrag();
					for (k = 0; k < 9; k++)
					{
						if (andLeft[myVar].hitTestObject(circle_lamp_Green[k]))
							{
								andLeft[myVar].x = circle_lamp_Green[k].x;
								andLeft[myVar].y = circle_lamp_Green[k].y;
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (andLeft[myVar].hitTestObject(andAim[k]))
						{
							andLeft[myVar].x = andAim[k].x;
							andLeft[myVar].y = andAim[k].y;
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (andLeft[myVar].hitTestObject(orAim[k]))
						{
							andLeft[myVar].x = orAim[k].x;
							andLeft[myVar].y = orAim[k].y;
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (andLeft[myVar].hitTestObject(notAim[k]))
						{
							andLeft[myVar].x = notAim[k].x;
							andLeft[myVar].y = notAim[k].y;
						}
					}
					
				}
				if (e.target == andRight[myVar])
				{
					andRight[myVar].stopDrag();
					for (k = 0; k < 9; k++)
					{
						if (andRight[myVar].hitTestObject(circle_lamp_Green[k]))
							{
								andRight[myVar].x = circle_lamp_Green[k].x;
								andRight[myVar].y = circle_lamp_Green[k].y;
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (andRight[myVar].hitTestObject(andAim[k]))
						{
							andRight[myVar].x = andAim[k].x;
							andRight[myVar].y = andAim[k].y;
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (andRight[myVar].hitTestObject(orAim[k]))
						{
							andRight[myVar].x = orAim[k].x;
							andRight[myVar].y = orAim[k].y;
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (andRight[myVar].hitTestObject(notAim[k]))
						{
							andRight[myVar].x = notAim[k].x;
							andRight[myVar].y = notAim[k].y;
						}
					}
				}
				if(e.target==andTull[myVar])
				{
					andTull[myVar].stopDrag();
					stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragCircle);
					removeEventListener(MouseEvent.MOUSE_MOVE, dragConnect);
					if(leftAndHit[k])
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragContactsAnd);
					if (rightAndHit[k])
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragContactsAnd);
					if(!leftAndHit[k]&&!rightAndHit[k])
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragCircle);
				}
			
			if (myVar >= 0)// дополнительная проверка, так как при добавлении кнопки срабатывает функция up,
						   //а переменная ещё не изменилась
			{
				if(andTull[myVar].hitTestObject(bin))//Удаление
					{
						removeChild(andLeft[myVar]);
						removeChild(andRight[myVar]);
						removeChild(andAim[myVar]);
						removeChild(andTull[myVar]);
						removeChild(andLineAim[myVar]);
						removeChild(andLineL[myVar]);
						removeChild(andLineR[myVar]);
						if (lineLAddAnd[myVar])
							removeChild(additLineLAnd[myVar]);
						if (lineRAddAnd[myVar])
							removeChild(additLineRAnd[myVar]);
						flag = 1;
					}
				if (flag)
				{
					flag = 0;
					vs = andTull[myVar];
					andTull[myVar] = andTull[andTull.length - 1];
					andTull[andTull.length - 1] = vs;
				
					vs = andAim[myVar];
					andAim[myVar] = andAim[andAim.length - 1];
					andAim[andAim.length - 1] = vs;
					
					vs = andLeft[myVar];
					andLeft[myVar] = andLeft[andLeft.length - 1];
					andLeft[andLeft.length - 1] = vs;
				
					vs = andRight[myVar];
					andRight[myVar] = andRight[andRight.length - 1];
					andRight[andRight.length - 1] = vs;
					
					vs = andLineAim[myVar];
					andLineAim[myVar] = andLineAim[andLineAim.length - 1];
					andLineAim[andLineAim.length - 1] = vs;
					
					vs = andLineL[myVar];
					andLineL[myVar] = andLineL[andLineL.length - 1];
					andLineL[andLineL.length - 1] = vs;
					
					vs = andLineR[myVar];
					andLineR[myVar] = andLineR[andLineR.length - 1];
					andLineR[andLineR.length - 1] = vs;
					
					vs2 = andLeftResult[myVar];
					andLeftResult[myVar] = andLeftResult[andLeftResult.length - 1];
					andLeftResult[andLeftResult.length - 1] = vs2;
					
					vs2 = andRightResult[myVar];
					andRightResult[myVar] = andRightResult[andRightResult.length - 1];
					andRightResult[andRightResult.length - 1] = vs2;
					
					vs2 = leftAndHit[myVar];
					leftAndHit[myVar] = leftAndHit[leftAndHit.length - 1];
					leftAndHit[leftAndHit.length - 1] = vs2;
					
					vs2 = rightAndHit[myVar];
					rightAndHit[myVar] = rightAndHit[rightAndHit.length - 1];
					rightAndHit[rightAndHit.length - 1] = vs2;
					
					//if ( lineLAddAnd[myVar])
					//{
						vs = additLineLAnd[myVar];
						additLineLAnd[myVar] = additLineLAnd[additLineLAnd.length - 1];
						additLineLAnd[additLineLAnd.length - 1] = vs;
						additLineLAnd.pop();
					//	trace(1);
					//}
					//if ( lineLAddAnd[myVar])
					//{
						vs2 = lineLAddAnd[myVar];
						lineLAddAnd[myVar] = lineLAddAnd[lineLAddAnd.length - 1];
						lineLAddAnd[lineLAddAnd.length - 1] = vs2;
						lineLAddAnd.pop();
					//	trace(2);
					//}
					
					//if ( lineRAddAnd[myVar])
					//{
						vs = additLineRAnd[myVar];
						additLineRAnd[myVar] = additLineRAnd[additLineRAnd.length - 1];
						additLineRAnd[additLineRAnd.length - 1] = vs;
						additLineRAnd.pop();
					//}
					//if ( lineRAddAnd[myVar])
					//{
						vs2 = lineRAddAnd[myVar];
						lineRAddAnd[myVar] = lineRAddAnd[lineRAddAnd.length - 1];
						lineRAddAnd[lineRAddAnd.length - 1] = vs2;
						lineRAddAnd.pop();
					//}
					
					
					andTull.pop();
					andAim.pop();
					andLeft.pop();
					andRight.pop();
					andLineAim.pop();
					andLineL.pop();
					andLineR.pop();
					andLeftResult.pop();
					andRightResult.pop();
					rightAndHit.pop();
					leftAndHit.pop();
					
					myVar--;
					NumberBlokcs--;
					numAnd--;
				}
			}
		}
		//===================================================
		public function controllaContatto(e:Event):void
		{
			var flag:int = 1;
			var unit1:int = 1; var unit1b:int = 1;
			var unit2:int = 1; var unit2b:int = 1;
			var unit3:int = 1; var unit3b:int = 1;
			var unit4:int = 1; var unit4b:int = 1;
			for (var i:int = 0; i < andRight.length; i++)
			{
				for (var k:int = 0; k < 9;k++)
					{
						if(andRight[i].hitTestObject(circle_lamp_Green[k]))
							{
								unit1 = 0;
								rightAndHit[i] = true;
								andRightResult[i] = circle_lamp_Green[k].visible;
							}
						if(andLeft[i].hitTestObject(circle_lamp_Green[k]))
							{
								unit1b = 0;
								leftAndHit[i] = true;
								andLeftResult[i] = circle_lamp_Green[k].visible;
							}
					}
				for (k = 0; k < andTull.length; k++)
					{
						if (andRight[i].hitTestObject(andAim[k]))
							{
								unit2 = 0;
								rightAndHit[i] = true;
								andRightResult[i] = andAimResult[k];
							}
						if (andLeft[i].hitTestObject(andAim[k]))
							{
								unit2b = 0;
								leftAndHit[i] = true;
								andLeftResult[i] = andAimResult[k];
							}
					}
				for (k = 0; k < orTull.length;k++)
					{
						if (andRight[i].hitTestObject(orAim[k]))
							{
								unit3 = 0;
								rightAndHit[i] = true;
								andRightResult[i] = orAimResult[k];
							}
						if (andLeft[i].hitTestObject(orAim[k]))
							{
								unit3b = 0;
								leftAndHit[i] = true;
								andLeftResult[i] = orAimResult[k];
							}
					}
				for (k = 0; k < notTull.length; k++)
				{
					if (andRight[i].hitTestObject(notAim[k]))
							{
								unit4 = 0;
								rightAndHit[myVar] = true;
								andRightResult[i] = notAimResult[k];
							}
					if (andLeft[i].hitTestObject(notAim[k]))
							{
								unit4b = 0;
								leftAndHit[myVar] = true;
								andLeftResult[i] = notAimResult[k];
							}
				}						
				andAimResult[i] = andLeftResult[i] && andRightResult[i];
				if (unit1 && unit2 && unit3 && unit4)
					{
						rightAndHit[i] = false;
					}
				if (unit1b && unit2b && unit3b && unit4b)
					{
						leftAndHit[i] = false;
					}
			}
			/*for (i = 0; i < 10; i++)
			{
				for (k = 0; k < andTull.length&&flag; k++)
				{
					if (circle_lamp_Green_prov[i].hitTestObject(andAim[k]))
					{
						circle_lamp_Green_prov[i].visible = andAimResult[k];
						flag = 0;
					}
					else
					{
						circle_lamp_Green_prov[i].visible = false;
					}
				}
				flag = 1;
			}*/
		}
		//===================================================
		public function Createor(e:Event):void 
		{
			del_result(e);
			timer.stop();
            var tull:Sprite = createRect( 0x807080, 30, 30); //тело
		    var leftc:Sprite = createCircle(0x235B30, 7);// левый контакт
		    var rightc:Sprite = createCircle(0x235B30, 7);// правый контакт
		    var aimc:Sprite = createCircle(0x200321, 7);	//		итоговый контакт
			tull.x = 350;
			tull.y = 10;
			leftc.x = 330;
			leftc.y = 10;
			rightc.x = 330;
			rightc.y = 35;
			aimc.x = 400;
			aimc.y = 25;
			
			orTull.push(tull);
			orLeft.push(leftc);
			orRight.push(rightc);
			orAim.push(aimc);
			
			addChild(leftc);
			addChild(tull);	
			addChild(rightc);
			addChild(aimc);
			
			createLine(tull.x, tull.y, aimc.x, aimc.y, orLineAim,30,15,numOr);
			createBezie(tull.x, tull.y, leftc.x + 7, leftc.y - 3, orLineL, 0, 5,20,numOr);
			createBezie(tull.x, tull.y, rightc.x + 7, rightc.y + 3,orLineR,0,25,-20,numOr);
			
			addEventListener(MouseEvent.MOUSE_DOWN, downor);
			addEventListener(MouseEvent.MOUSE_UP,  upor);
			addEventListener(Event.ENTER_FRAME, controllaContattoor);
			addEventListener(Event.ENTER_FRAME, controlWireOr);
			
			NumberBlokcs++;
			numOr++;
		}
		//===================================================
		public function wireRor(e:Event,n:int):void
		{   
			removeChild(orLineR[n]);
			var line:Sprite = new Sprite();
			var additLine:Sprite = new Sprite();
			if (orRightResult[n] == true)
				{
					line.graphics.lineStyle(3, 0xFF0000);
				}
			else
				{
					line.graphics.lineStyle(3, 0x0000CC);
				}
			if (lineRAddOr[n])
				{
					removeChild(additLineROr[n]);
					additLine.graphics.lineStyle(6, 0x00CCFF);
					additLine.graphics.moveTo(orTull[n].x, orTull[n].y+25);
					additLine.graphics.curveTo(orTull[n].x+20+(orRight[n].x + 7-orTull[n].x)/2,orRight[n].y + 17,orRight[n].x + 7,orRight[n].y - 3);
					additLineROr[n] = additLine;
					addChild(additLineROr[n]);
				}
			line.graphics.moveTo(orTull[n].x, orTull[n].y+25);
			line.graphics.curveTo(orTull[n].x+20+(orRight[n].x + 7-orTull[n].x)/2,orRight[n].y + 17,orRight[n].x + 7,orRight[n].y - 3);
			addChild(line);
			orLineR[n] = line;
		}
		//=======================================================
		public function wireLor(e:Event,n:int):void
		{   
			removeChild(orLineL[n]);
			var line:Sprite = new Sprite();
			var additLine:Sprite = new Sprite();
			if (orLeftResult[n] == true)
				{
					line.graphics.lineStyle(3, 0xFF0000);
				}
			else
				{
					line.graphics.lineStyle(3, 0x0000CC);
				}
			if (lineLAddOr[n])
				{
					removeChild(additLineLOr[n]);
					additLine.graphics.lineStyle(6, 0x00CCFF);
					additLine.graphics.moveTo(orTull[n].x, orTull[n].y+5);
					additLine.graphics.curveTo(orTull[n].x+20+(orLeft[n].x + 7-orTull[n].x)/2,orLeft[n].y - 23,orLeft[n].x + 7,orLeft[n].y - 3);
					additLineLOr[n] = additLine;
					addChild(additLineLOr[n]);
				}
			line.graphics.moveTo(orTull[n].x, orTull[n].y+5);
			line.graphics.curveTo(orTull[n].x+20+(orLeft[n].x + 7-orTull[n].x)/2,orLeft[n].y - 23,orLeft[n].x + 7,orLeft[n].y - 3);
			addChild(line);
			orLineL[n] = line;
		}
		//===================================================
		public function controlWireOr(e:Event):void
		{
			for (var i:int = 0; i < numOr; i++)
			{
				wireLor(e,i);
				wireRor(e,i);
			}
		}
		//======================================================
		public function downor(e:Event):void
		{
			var flag : int = 0 ;
			var k: int = 0;
			var additLine:Sprite = new Sprite();
			for (k = 0;k < 30 && flag==0; k++)
			{
				if(orTull[k]==e.target)
				{
					myVar2 = k;
					flag = 1;
					setChildIndex(orTull[k], numChildren - 1);
					orTull[k].startDrag();
					addEventListener(MouseEvent.MOUSE_MOVE, dragConnectOr);
					if(leftOrHit[k])
						stage.addEventListener(MouseEvent.MOUSE_MOVE, dragContactsOr);
					if (rightOrHit[k])
						stage.addEventListener(MouseEvent.MOUSE_MOVE, dragContactsOr);
					if(!leftOrHit[k]&&!rightOrHit[k])
						stage.addEventListener(MouseEvent.MOUSE_MOVE, dragCircleor);
				}
				if (orRight[k]==e.target )
				{
					flag = 1;
					myVar2 = k;
					setChildIndex(orRight[k], numChildren - 1);
					orRight[k].startDrag();
				}
				if ( orLeft[k]==e.target )
				{
					flag = 1;
					myVar2 = k;
					setChildIndex(orLeft[k], numChildren - 1);
					orLeft[k].startDrag();
				}	
				if (e.target == orLineL[k])
				{
					flag = 1;
					myVar2 = k;
					for (var i:int = 0; i < orTull.length;i++)
					{
						if (lineLAddOr[i])
							{
								lineLAddOr[i] = false;
								removeChild(additLineLOr[i]);
								if (i == myVar2)
								{
									complite2 = 1;
								}
								else
								{
									complite2 = 0;
								}
							}
						if (lineRAddOr[i])
							{
								lineRAddOr[i] = false;
								removeChild(additLineROr[i]);
								complite2 = 0;
							}
					}
					for (i = 0; i < notTull.length; i++)
					{
						if (lineRAddNot[i])
							{
								lineRAddNot[i] = false;
								removeChild(additLineRNot[i]);
								complite3 = 0;
							}
					}
					for (i = 0; i < andTull.length; i++)
					{
						if (lineLAddAnd[i])
							{
								lineLAddAnd[i] = false;
								removeChild(additLineLAnd[i]);
								complite = 0;
							}
						if (lineRAddAnd[i])
							{
								lineRAddAnd[i] = false;
								removeChild(additLineRAnd[i]);
								complite = 0;
							}
					}
					
					if(!complite2)
					{
						flag = 1;
						myVar2 = k;
						lineLAddOr[k] = true;
						setChildIndex(orLeft[k], numChildren - 1);
						additLine.graphics.lineStyle(6, 0x00CCFF);
						additLine.graphics.moveTo(orTull[k].x, orTull[k].y+25);
						additLine.graphics.curveTo(orTull[k].x+20+(orLeft[k].x + 7-orTull[k].x)/2,orLeft[k].y + 17,orLeft[k].x + 7,orLeft[k].y - 3);
						additLineLOr[k] = additLine;
						addChild(additLineLOr[k]);
						complite2 = 1;
					}
					else
						complite2 = 0;
				}
				if (e.target == orLineR[k])
				{
					flag = 1;
					myVar2 = k;
					for (i = 0; i < orTull.length;i++)
					{
						if (lineRAddOr[i])
							{
								lineRAddOr[i] = false;
								removeChild(additLineROr[i]);
								if (i == myVar2)
								{
									complite2 = 1;
								}
								else
								{
									complite2 = 0;
								}
							}
						if (lineLAddOr[i])
							{
								lineLAddOr[i] = false;
								removeChild(additLineLOr[i]);
								complite2 = 0;
							}
					}
					for (i = 0; i < notTull.length; i++)
					{
						if (lineRAddNot[i])
							{
								lineRAddNot[i] = false;
								removeChild(additLineRNot[i]);
								complite3 = 0;
							}
					}
					for (i = 0; i < andTull.length; i++)
					{
						if (lineLAddAnd[i])
							{
								lineLAddAnd[i] = false;
								removeChild(additLineLAnd[i]);
								complite = 0;
							}
						if (lineRAddAnd[i])
							{
								lineRAddAnd[i] = false;
								removeChild(additLineRAnd[i]);
								complite = 0;
							}
					}
					
					if(!complite2)
					{
						flag = 1;
						myVar2 = k;
						lineRAddOr[k] = true;
						setChildIndex(orRight[k], numChildren - 1);
						additLine.graphics.lineStyle(6, 0x00CCFF);
						additLine.graphics.moveTo(orTull[k].x, orTull[k].y+25);
						additLine.graphics.curveTo(orTull[k].x+20+(orRight[k].x + 7-orTull[k].x)/2,orRight[k].y + 17,orRight[k].x + 7,orRight[k].y - 3);
						additLineROr[k] = additLine;
						addChild(additLineROr[k]);
						complite2 = 1;
					}
					else
						complite2 = 0;
				}

			}			
			
		}
		//===================================================
		public function dragCircleor(event:MouseEvent):void 
		{ 
			if (myVar2 >= 0)
			{
				orLeft[myVar2].x = orTull[myVar2].x -20; 
				orLeft[myVar2].y = orTull[myVar2].y -5;
				orRight[myVar2].x = orTull[myVar2].x - 20; 
				orRight[myVar2].y = orTull[myVar2].y +30;
				orAim[myVar2].x = orTull[myVar2].x + 50; 
				orAim[myVar2].y = orTull[myVar2].y +15;
				orLineAim[myVar2].x = orTull[myVar2].x - 350;
				orLineAim[myVar2].y = orTull[myVar2].y - 10;
				wireLor(event,myVar2);
				wireRor(event,myVar2);
				event.updateAfterEvent(); 
			}
		} 
		//====================================================
		public function dragContactsOr(event:MouseEvent):void 
		{ 

			if (!leftOrHit[myVar2])
			{
				orLeft[myVar2].x = orTull[myVar2].x -20; 
				orLeft[myVar2].y = orTull[myVar2].y -5;
			}
			if (!rightOrHit[myVar2])
			{
				orRight[myVar2].x = orTull[myVar2].x - 20; 
				orRight[myVar2].y = orTull[myVar2].y +30;
			}
			orAim[myVar2].x = orTull[myVar2].x + 50; 
			orAim[myVar2].y = orTull[myVar2].y +15;
			orLineAim[myVar2].x = orTull[myVar2].x - 350;
			orLineAim[myVar2].y = orTull[myVar2].y - 10;
			wireLor(event,myVar2);
			wireRor(event,myVar2);
			event.updateAfterEvent(); 
		} 
		//===================================================
		public function upor(e:Event):void
		{
			var flag:int = 0;
			var k:int = 0;
			var vs2:Sprite = new Sprite();
			var vs:Boolean;
			if (e.target == orLeft[myVar2])
				{
					orLeft[myVar2].stopDrag();
					for (k = 0; k < 9; k++)
					{
						if (orLeft[myVar2].hitTestObject(circle_lamp_Green[k]))
							{
								orLeft[myVar2].x = circle_lamp_Green[k].x;
								orLeft[myVar2].y = circle_lamp_Green[k].y;
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (orLeft[myVar2].hitTestObject(andAim[k]))
						{
							orLeft[myVar2].x = andAim[k].x;
							orLeft[myVar2].y = andAim[k].y;
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (orLeft[myVar2].hitTestObject(orAim[k]))
						{
							orLeft[myVar2].x = orAim[k].x;
							orLeft[myVar2].y = orAim[k].y;
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (orLeft[myVar2].hitTestObject(notAim[k]))
						{
							orLeft[myVar2].x = notAim[k].x;
							orLeft[myVar2].y = notAim[k].y;
						}
					}
				}
				if (e.target == orRight[myVar2])
				{
					orRight[myVar2].stopDrag();
					for (k = 0; k < 9; k++)
					{
						if (orRight[myVar2].hitTestObject(circle_lamp_Green[k]))
							{
								orRight[myVar2].x = circle_lamp_Green[k].x;
								orRight[myVar2].y = circle_lamp_Green[k].y;
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (orRight[myVar2].hitTestObject(andAim[k]))
						{
							orRight[myVar2].x = andAim[k].x;
							orRight[myVar2].y = andAim[k].y;
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (orRight[myVar2].hitTestObject(orAim[k]))
						{
							orRight[myVar2].x = orAim[k].x;
							orRight[myVar2].y = orAim[k].y;
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (orRight[myVar2].hitTestObject(notAim[k]))
						{
							orRight[myVar2].x = notAim[k].x;
							orRight[myVar2].y = notAim[k].y;
						}
					}
				}
				if(e.target==orTull[myVar2])
				{
					orTull[myVar2].stopDrag();
					removeEventListener(MouseEvent.MOUSE_MOVE, dragConnectOr);
					if(leftOrHit[k])
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragContactsOr);
					if (rightOrHit[k])
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragContactsOr);
					if(!leftOrHit[k]&&!rightOrHit[k])
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragCircleor);
					
				}
			//stage.removeEventListener(MouseEvent.MOUSE_MOVE, distanceOr); 
			if (myVar2 >= 0)
			{
				if(orTull[myVar2].hitTestObject(bin))//Удаление
					{
						
						removeChild(orLeft[myVar2]);
						removeChild(orRight[myVar2]);
						removeChild(orAim[myVar2]);
						removeChild(orTull[myVar2]);
						removeChild(orLineAim[myVar2]);
						removeChild(orLineR[myVar2]);
						removeChild(orLineL[myVar2]);
						if (lineLAddOr[myVar2])
							removeChild(additLineLOr[myVar2]);
						if (lineRAddOr[myVar2])
							removeChild(additLineROr[myVar2]);
						flag = 1;
						
					}
				if (flag)
				{
					flag = 0;
					vs2 = orTull[myVar2];
					orTull[myVar2] = orTull[orTull.length - 1];
					orTull[orTull.length - 1] = vs2;
				
					vs2 = orAim[myVar2];
					orAim[myVar2] = orAim[orAim.length - 1];
					orAim[orAim.length - 1] = vs2;
				
					vs2 = orLeft[myVar2];
					orLeft[myVar2] = orLeft[orLeft.length - 1];
					orLeft[orLeft.length - 1] = vs2;
				
					vs2 = orRight[myVar2];
					orRight[myVar2] = orRight[orRight.length - 1];
					orRight[orRight.length - 1] = vs2;
					
					vs2 = orLineAim[myVar2];
					orLineAim[myVar2] = orLineAim[orLineAim.length - 1];
					orLineAim[orLineAim.length - 1] = vs2;
					
					vs2 = orLineR[myVar2];
					orLineR[myVar2] = orLineR[orLineR.length - 1];
					orLineR[orLineR.length - 1] = vs2;
					
					vs2 = orLineL[myVar2];
					orLineL[myVar2] = orLineL[orLineL.length - 1];
					orLineL[orLineL.length - 1] = vs2;
					
					vs = orLeftResult[myVar2];
					orLeftResult[myVar2] = orLeftResult[orLeftResult.length - 1];
					orLeftResult[orLeftResult.length - 1] = vs;
					
					vs = orRightResult[myVar2];
					orRightResult[myVar2] = orRightResult[orRightResult.length - 1];
					orRightResult[orRightResult.length - 1] = vs;
					
					vs2 = additLineROr[myVar2];
					additLineROr[myVar2] = additLineROr[additLineROr.length - 1];
					additLineROr[additLineROr.length - 1] = vs2;
					additLineROr.pop();
					
					vs = lineRAddOr[myVar2];
					lineRAddOr[myVar2] = lineRAddOr[lineRAddOr.length - 1];
					lineRAddOr[lineRAddOr.length - 1] = vs;
					lineRAddOr.pop();
					
					vs2 = additLineLOr[myVar2];
					additLineLOr[myVar2] = additLineLOr[additLineLOr.length - 1];
					additLineLOr[additLineLOr.length - 1] = vs2;
					additLineLOr.pop();
					
					vs = lineLAddOr[myVar2];
					lineLAddOr[myVar2] = lineLAddOr[lineLAddOr.length - 1];
					lineLAddOr[lineLAddOr.length - 1] = vs;
					lineLAddOr.pop();
					
					
					orTull.pop();
					orAim.pop();
					orLeft.pop();
					orRight.pop();
					orLineAim.pop()
					orLineL.pop();
					orLineR.pop();
					orLeftResult.pop();
					orRightResult.pop();
					myVar2--;
					NumberBlokcs--;
					numOr--;
				}
			}
		}
		//===================================================
		public function controllaContattoor(e:Event):void
		{
			var flag:int = 1;
			var unit1:int = 1; var unit1b:int = 1;
			var unit2:int = 1; var unit2b:int = 1;
			var unit3:int = 1; var unit3b:int = 1;
			var unit4:int = 1; var unit4b:int = 1;
			for (var i:int = 0; i < orRight.length; i++)
			{
				for (var k:int = 0; k < 9;k++)
					{
						if (orRight[i].hitTestObject(circle_lamp_Green[k]))
						{
							orRightResult[i] = circle_lamp_Green[k].visible;
							unit1 = 0;
							rightOrHit[i] = true;
						}
						if(orLeft[i].hitTestObject(circle_lamp_Green[k]))
							{
								unit1b = 0;
								leftOrHit[i] = true;
								orLeftResult[i] = circle_lamp_Green[k].visible;
							}
					}
				for (k = 0; k < orTull.length; k++)
					{
						if (orRight[i].hitTestObject(orAim[k]))
							{
								unit2 = 0;
								rightOrHit[i] = true;
								orRightResult[i] = orAimResult[k];
							}
						if (orLeft[i].hitTestObject(orAim[k]))
							{
								unit2b = 0;
								leftOrHit[i] = true;
								orLeftResult[i] = orAimResult[k];
							}
					}
				for (k = 0; k < andTull.length;k++)
					{
						if (orRight[i].hitTestObject(andAim[k]))
							{
								unit3 = 0;
								rightOrHit[i] = true;
								orRightResult[i] = andAimResult[k];
							}
						if (orLeft[i].hitTestObject(andAim[k]))
							{
								unit3b = 0;
								leftOrHit[i] = true;
								orLeftResult[i] = andAimResult[k];
							}
					}
				for (k = 0; k < notTull.length; k++)
					{
						if (orRight[i].hitTestObject(notAim[k]))
							{
								unit4 = 0;
								rightOrHit[i] = true;
								orRightResult[i] = notAimResult[k];
							}
						if (orLeft[i].hitTestObject(notAim[k]))
							{
								unit4b = 0;
								leftOrHit[i] = true;
								orLeftResult[i] = notAimResult[k];
							}
					}
				
				orAimResult[i] = orLeftResult[i] || orRightResult[i];
				if (unit1 && unit2 && unit3 && unit4)
					{
						rightOrHit[i] = false;
					}
				if (unit1b && unit2b && unit3b && unit4b)
					{
						leftOrHit[i] = false;
					}
			}
			/*for (i = 0; i < 10; i++)
				{
					for (k = 0; k < orTull.length&&flag; k++)
					{
						if (circle_lamp_Green_prov[i].hitTestObject(orAim[k]))
						{
							circle_lamp_Green_prov[i].visible = orAimResult[k];
							flag = 0;
						}
						else
						{
							circle_lamp_Green_prov[i].visible = false;
						}
					}
					flag = 1;
				}*/
		}
		//===================================================
		public function Createnot(e:Event):void 
		{
			del_result(e);
			timer.stop();
            var tull:Sprite = createRect( 0x808060, 30, 30); //тело
		    var rightc:Sprite = createCircle(0x220B00, 7);//  контакт
		    var aimc:Sprite = createCircle(0x200321, 7);	//		итоговый контакт
			tull.x = 350;
			tull.y = 10;
			rightc.x = 330;
			rightc.y = 25;
			aimc.x = 400;
			aimc.y = 25;
			
			notTull.push(tull);
			notRight.push(rightc);
			notAim.push(aimc);
			
			addChild(tull);	
			addChild(rightc);
			addChild(aimc);
			
			createLine(tull.x, tull.y, aimc.x, aimc.y, notLineAim,30,15,numNot);
			createBezie(tull.x, tull.y+10, rightc.x + 7, rightc.y - 3, notLineR, 0, 5,35,numNot);
			
			addEventListener(MouseEvent.MOUSE_DOWN, downnot);
			addEventListener(MouseEvent.MOUSE_UP,  upnot);
			addEventListener(Event.ENTER_FRAME, controllaContattonot);
			addEventListener(Event.ENTER_FRAME, controlWireNot);
						
			NumberBlokcs++;
			numNot++;
		}
		//===================================================
		public function wireNot(e:Event,n:int):void
		{
			removeChild(notLineR[n]);
			var line:Sprite = new Sprite();
			var additLine:Sprite = new Sprite();
			if (notRightResult[n] == true)
				{
					line.graphics.lineStyle(3, 0xFF0000);
				}
			else
				{
					line.graphics.lineStyle(3, 0x0000CC);
				}
			if (lineRAddNot[n])
				{
					removeChild(additLineRNot[n]);
					additLine.graphics.lineStyle(6, 0x00CCFF);
					additLine.graphics.moveTo(notTull[n].x, notTull[n].y+15);
					additLine.graphics.curveTo(notTull[n].x+20+(notRight[n].x -notTull[n].x)/2,notRight[n].y - 35,notRight[n].x + 7,notRight[n].y - 3);
					additLineRNot[n] = additLine;
					addChild(additLineRNot[n]);
				}
			line.graphics.moveTo(notTull[n].x, notTull[n].y+15);
			line.graphics.curveTo(notTull[n].x+20+(notRight[n].x -notTull[n].x)/2,notRight[n].y - 35,notRight[n].x + 7,notRight[n].y - 3);
			addChild(line);
			notLineR[n] = line;
		}
		//=====================================================
		public function downnot(e:Event):void
		{
			var flag : int = 0 ;
			var k: int = 0;
			var additLine:Sprite = new Sprite();
			for (k = 0;k < 30 && flag==0; k++)
			{
				if(notTull[k]==e.target)
				{
					myVar3 = k;
					flag = 1;
					setChildIndex(notTull[k], numChildren - 1);
					notTull[k].startDrag();
					addEventListener(MouseEvent.MOUSE_MOVE, dragConnectNot);
					if (rightNotHit[k])
						stage.addEventListener(MouseEvent.MOUSE_MOVE, dragContactsNot);
					if(!rightNotHit[k])
						stage.addEventListener(MouseEvent.MOUSE_MOVE, dragCirclenot);	
				}
				if (notRight[k]==e.target )
				{
					flag = 1;
					myVar3 = k;
					setChildIndex(notRight[k], numChildren - 1);
					notRight[k].startDrag();
				}	
				if (e.target == notLineR[k])
				{
					flag = 1;
					myVar3 = k;
					for (var i:int = 0; i < notTull.length;i++)
					{
						if (lineRAddNot[i])
						{
							lineRAddNot[i] = false;
							removeChild(additLineRNot[i]);
							if (i == myVar3)
							{
								complite3 = 1;
							}
							else
							{
								complite3 = 0;
							}
						}
					}
					for (i = 0; i < orTull.length; i++)
					{
						if (lineLAddOr[i])
							{
								lineLAddOr[i] = false;
								removeChild(additLineLOr[i]);
								complite2 = 0;
							}
						if (lineRAddOr[i])
							{
								lineRAddOr[i] = false;
								removeChild(additLineROr[i]);
								complite2 = 0;
							}
					}
					for (i = 0; i < andTull.length; i++)
					{
						if (lineLAddAnd[i])
							{
								lineLAddAnd[i] = false;
								removeChild(additLineLAnd[i]);
								complite = 0;
							}
						if (lineRAddAnd[i])
							{
								lineRAddAnd[i] = false;
								removeChild(additLineRAnd[i]);
								complite = 0;
							}
					}
					if(!complite3)
					{
						flag = 1;
						myVar3 = k;
						lineRAddNot[k] = true;
						setChildIndex(notRight[k], numChildren - 1);
						additLine.graphics.lineStyle(6, 0x00CCFF);
						additLine.graphics.moveTo(notTull[k].x, notTull[k].y+15);
						additLine.graphics.curveTo(notTull[k].x+20+(notRight[k].x -notTull[k].x)/2,notRight[k].y - 35,notRight[k].x + 7,notRight[k].y - 3);
						additLineRNot[k] = additLine;
						addChild(additLineRNot[k]);
						complite3 = 1;
					}
					else
						complite3 = 0;
				}
			}
		}
		//===================================================
		public function dragCirclenot(event:MouseEvent):void 
		{ 
			if (myVar3 >= 0)
			{
				notAim[myVar3].x = notTull[myVar3].x +50; 
				notAim[myVar3].y = notTull[myVar3].y + 15;
				notLineAim[myVar3].x = notTull[myVar3].x - 350;
				notLineAim[myVar3].y = notTull[myVar3].y - 10;
				notRight[myVar3].x = notTull[myVar3].x - 20; 
				notRight[myVar3].y = notTull[myVar3].y + 15;
				wireNot(event,myVar3);
				event.updateAfterEvent(); 
			}
		} 
		//===================================================
		public function controlWireNot(e:Event):void
		{
			for (var i:int = 0; i < numNot; i++)
			{
				wireNot(e,i);
			}
		}
		//=====================================================
		public function dragContactsNot(event:MouseEvent):void 
		{ 
			if (!rightNotHit[myVar3])
			{
				notRight[myVar3].x = notTull[myVar3].x - 20; 
				notRight[myVar3].y = notTull[myVar3].y + 15;
			}
			notAim[myVar3].x = notTull[myVar3].x +50; 
			notAim[myVar3].y = notTull[myVar3].y + 15;
			notLineAim[myVar3].x = notTull[myVar3].x - 350;
			notLineAim[myVar3].y = notTull[myVar3].y - 10;
			wireNot(event,myVar3);
			event.updateAfterEvent();
		} 
		//===================================================
		public function upnot(e:Event):void
		{
			var flag:int = 0;
			var k:int = 0;
			var vs2:Sprite = new Sprite();
			var vs:Boolean;
			if (e.target == notRight[myVar3])
			{
				notRight[myVar3].stopDrag();
				for (k = 0; k < 9; k++)
					{
						if (notRight[myVar3].hitTestObject(circle_lamp_Green[k]))
							{
								notRight[myVar3].x = circle_lamp_Green[k].x;
								notRight[myVar3].y = circle_lamp_Green[k].y;
								//wireNot(e);
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (notRight[myVar3].hitTestObject(andAim[k]))
						{
							notRight[myVar3].x = andAim[k].x;
							notRight[myVar3].y = andAim[k].y;
							//wireNot(e);
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (notRight[myVar3].hitTestObject(orAim[k]))
						{
							notRight[myVar3].x = orAim[k].x;
							notRight[myVar3].y = orAim[k].y;
							//wireNot(e);
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (notRight[myVar3].hitTestObject(notAim[k]))
						{
							notRight[myVar3].x = notAim[k].x;
							notRight[myVar3].y = notAim[k].y;
							//wireNot(e);
						}
					}
			}
			if(e.target==notTull[myVar3])
			{
				notTull[myVar3].stopDrag();
				removeEventListener(MouseEvent.MOUSE_MOVE, dragConnectNot);
				if (rightNotHit[k])
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragContactsNot);
					if(!rightNotHit[k])
						stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragCirclenot);	
			}
			//stage.removeEventListener(MouseEvent.MOUSE_MOVE, distanceNot); 
			if (myVar3 >= 0)
			{
				if(notTull[myVar3].hitTestObject(bin))//Удаление
					{
						
						removeChild(notLineAim[myVar3]);
						removeChild(notRight[myVar3]);
						removeChild(notAim[myVar3]);
						removeChild(notTull[myVar3]);
						removeChild(notLineR[myVar3]);
						if (lineRAddNot[myVar3])
							removeChild(additLineRNot[myVar3]);
						flag = 1;
						
					}
				if (flag)
				{
					flag = 0;
					vs2 = notTull[myVar3];
					notTull[myVar3] = notTull[notTull.length - 1];
					notTull[notTull.length - 1] = vs2;
				
					vs2 = notAim[myVar3];
					notAim[myVar3] = notAim[notAim.length - 1];
					notAim[notAim.length - 1] = vs2;
				
					vs2 = notRight[myVar3];
					notRight[myVar3] = notRight[notRight.length - 1];
					notRight[notRight.length - 1] = vs2;
					
					vs2 = notLineAim[myVar3];
					notLineAim[myVar3] = notLineAim[notLineAim.length - 1];
					notLineAim[notLineAim.length - 1] = vs2;
					
					vs2 = notLineR[myVar3];
					notLineR[myVar3] = notLineR[notLineR.length - 1];
					notLineR[notLineR.length - 1] = vs2;
					
					vs = notRightResult[myVar3];
					notRightResult[myVar3] = notRightResult[notRightResult.length - 1];
					notRightResult[notRightResult.length - 1] = vs;
					
					vs2 = additLineRNot[myVar3];
					additLineRNot[myVar3] = additLineRNot[additLineRNot.length - 1];
					additLineRNot[additLineRNot.length - 1] = vs2;
					additLineRNot.pop();
					
					vs = lineRAddNot[myVar3];
					lineRAddNot[myVar3] = lineRAddNot[lineRAddNot.length - 1];
					lineRAddNot[lineRAddNot.length - 1] = vs;
					lineRAddNot.pop();
					
					
					notTull.pop();
					notAim.pop();
					notRight.pop();
					notLineR.pop();
					notLineAim.pop();
					notRightResult.pop();
					myVar3--;
					NumberBlokcs--;
					numNot--;
				}
			}
		}
		//===================================================
		public function controllaContattonot(e:Event):void
		{
			var flag:int = 1;
			var unit1:int = 1;
			var unit2:int = 1;
			var unit3:int = 1;
			var unit4:int = 1;

			for (var i:int = 0; i < notRight.length; i++)
			{
				for (var k:int = 0; k < 9;k++)
					{
						if(notRight[i].hitTestObject(circle_lamp_Green[k]))
							{
								unit1 = 0;
								rightNotHit[i] = true;
								notRightResult[i] = circle_lamp_Green[k].visible;
							}
					}
				for (k = 0; k < andTull.length; k++)
					{
						if (notRight[i].hitTestObject(andAim[k]))
							{
								unit2 = 0;
								rightNotHit[i] = true;
								notRightResult[i] = andAimResult[k];
							}
					}
				for (k = 0; k < orTull.length;k++)
					{
						if (notRight[i].hitTestObject(orAim[k]))
							{
								unit3 = 0;
								rightNotHit[i] = true;
								notRightResult[i] = orAimResult[k];
							}
					}
				for (k = 0; k < notTull.length; k++)
				{
					if (notRight[i].hitTestObject(notAim[k]))
							{
								unit4 = 0;
								rightNotHit[i] = true;
								notRightResult[i] = notAimResult[k];
							}
				}
				
				notAimResult[i] = !notRightResult[i];
				if (unit1 && unit2 && unit3 && unit4)
					rightNotHit[i] = false;
			}
			
			/*for (i = 0; i < 10; i++)
				{
					for (k = 0; k < notTull.length&&flag; k++)
					{
						if (circle_lamp_Green_prov[i].hitTestObject(notAim[k]))
						{
							circle_lamp_Green_prov[i].visible = notAimResult[k];
							flag = 0;
						}
						else
						{
							circle_lamp_Green_prov[i].visible = false;
						}
					}
					flag = 1;
				}*/
		}
		//===================================================
		public function createBin():void
		{
			bin.x = 30;
			bin.y = 400;
			addChild(bin);
			var line:Shape = new Shape();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(30, 400);
			line.graphics.lineTo(35, 450);
			addChild(line);
			line.graphics.moveTo(35, 400);
			line.graphics.lineTo(40, 450);
			addChild(line);
			line.graphics.moveTo(40, 400);
			line.graphics.lineTo(45, 450);
			addChild(line);
			line.graphics.moveTo(45, 400);
			line.graphics.lineTo(45, 450);
			addChild(line);
			line.graphics.moveTo(50, 400);
			line.graphics.lineTo(43, 450);
			addChild(line);
			line.graphics.moveTo(55, 400);
			line.graphics.lineTo(50, 450);
			addChild(line);
			line.graphics.moveTo(60, 400);
			line.graphics.lineTo(55, 450);
			addChild(line);
		}
		//========================================================
	}
}