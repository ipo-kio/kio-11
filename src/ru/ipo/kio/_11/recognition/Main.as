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
		
		
		public const offsetX:Number = 20; // отступ для общего движения блока
		public const offsetY:Number = 0;// 
		public const offsetX2:Number = 20;// 
		public const offsetY2:Number = -50;//
		public const offsetX3:Number = -70;// 
		public const offsetY3:Number = -25;//
		public const offsetY4:Number = -25;// 
		public const stepAimX:Number = 50;//
		public const stepAimY:Number = 25;//
		
		public var myVar:int = 0;// xитрая глобальная переменная(костыль для программы) 
		public var myVar2:int = 0;// xитрая глобальная переменная(костыль для программы)
		public var myVar3:int = 0;// xитрая глобальная переменная(костыль для программы)
				
		public var NumberBlokcs:int = 0;//количество используемых блоков
		public var Result:int = 0; // Переменная содержащая результат 
		public var t_result:TextField = new TextField();// Текстовое поле для результата
		public var t_nB:TextField = new TextField();//Текстовое поле для количествва блоков
		public var text_lvl_1:TextField = new TextField();//Текстовое поле для уровня
		
		public var NUM_first_Break_lamp:int = 11; 
		public var NUM_second_Break_lamp:int = 11;
		
		public var numAnd:int = 0;
		public var numOr:int = 0;
		public var numNot:int = 0;
		
		
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
			//--------------------------------------------------------
			//линия разграничения
			var line:Shape = new Shape();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(120, 0);
			line.graphics.lineTo(120, 500);
			addChild(line);
			//-----------------------------------------------------
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
			text_result.text = "Результат:";
			text_result.x = 500;
			text_result.y = 400;			
			addChild(text_result);
			
			
			t_result.autoSize = TextFieldAutoSize.LEFT;
			t_result.text =  '  '+Result;
			t_result.x = 550;
			t_result.y = 400;			
			addChild(t_result);				
			
			//-------------------------------------------------------------
			
			var text_bin:TextField = new TextField();
			text_bin.autoSize = TextFieldAutoSize.LEFT;
			text_bin.text = "Корзина";
			text_bin.x = 30;
			text_bin.y = 300;			
			addChild(text_bin);
			
			//-----------------------------------------------------------------
			// текстовые поля вывода количества блоков
			var text_numberBlokcs:TextField = new TextField();
			text_numberBlokcs.autoSize = TextFieldAutoSize.LEFT;
			text_numberBlokcs.text = "Количество блоков:";
			text_numberBlokcs.x = 500;
			text_numberBlokcs.y = 450;			
			addChild(text_numberBlokcs);
			
			
			t_nB.autoSize = TextFieldAutoSize.LEFT;
			t_nB.text =  '  '+NumberBlokcs;
			t_nB.x = 600;
			t_nB.y = 450;			
			addChild(t_nB);
			//--------------------------------------------------------------
									
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
		if (i ==9)
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
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
			 rect_lamp_Green[4].visible = false;
			 circle_lamp_Green[4].visible = false;				 
			}
		}	
		get_result(NUM);
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
			// get_result(NUM);
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
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
			 rect_lamp_Green[4].visible = false;
			 circle_lamp_Green[4].visible = false;				 
			}
		}	
		get_result(NUM);
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
		if (NUM_1==9)
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
				rect_lamp_Green[8].visible = false;
				circle_lamp_Green[8].visible = false;
			}
			else
			{
			 rect_lamp_Green[4].visible = false;
			 circle_lamp_Green[4].visible = false;				 
			}
		}
			 get_result(NUM_1);
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
			
			//---------------------------------------------------------------------------
			
			var text_test:TextField = new TextField();
			text_test.autoSize = TextFieldAutoSize.LEFT;
			text_test.text = "Проверки:";
			text_test.x = 150;
			text_test.y = 300;			
			addChild(text_test);
			//кнопка пошаговая проверка
			var But_test_step:SimpleButton = createButtons("Пошаговая");
			But_test_step.x = 150;
			But_test_step.y = 350;
			addChild(But_test_step);
			But_test_step.addEventListener(MouseEvent.CLICK,test_step);
			myVar = 0;
			
			//кнопка проверка
			var But_test_continius:SimpleButton = createButtons("Мгновенная");
			But_test_continius.x = 250;
			But_test_continius.y = 350;
			addChild(But_test_continius);
			But_test_continius.addEventListener(MouseEvent.CLICK, test_continius);
						
			//кнопка Прверка с задержкой
			var But_test:SimpleButton = createButtons("С задержкой");
			But_test.x = 350;
			But_test.y = 350;
			addChild(But_test);
			But_test.addEventListener(MouseEvent.CLICK, test);
			//-------------------------------------------------------------------------------
			// кнопка сброса решения
			var Del_result:SimpleButton = createButtons("Сбросить");
			Del_result.x = 700;
			Del_result.y = 450;
			addChild(Del_result);
			Del_result.addEventListener(MouseEvent.CLICK, del_result);
			
			//-----------------------------------------------------------------------------------
		    //кнопка для убирания одной лапочки			
			Del_1_lamp.x = 150;
			Del_1_lamp.y = 450;
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
			for (i = 0; i < 10; i++) 
			{
				var c_lamp_Green_prov:Sprite = createCircle( 0x00ff00, 10);
				circle_lamp_Green_prov[i] = c_lamp_Green_prov;
			}
			
			
			//---------------------------------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------
			for (i = 0; i < 10; i++) 
			{
				var c_lamp_Red_prov:Sprite = createCircle( 0xff0000, 10);
				circle_lamp_Red_prov[i] = c_lamp_Red_prov;
			}
			// красные лампочки
			circle_lamp_Red_prov[0].x = 760;
			circle_lamp_Red_prov[0].y = 30;
			addChild(circle_lamp_Red_prov[0]);
			
			circle_lamp_Red_prov[1].x = 760;
			circle_lamp_Red_prov[1].y = 70;
			addChild(circle_lamp_Red_prov[1]);
			
			circle_lamp_Red_prov[2].x = 760;
			circle_lamp_Red_prov[2].y = 110;
			addChild(circle_lamp_Red_prov[2]);
			
			circle_lamp_Red_prov[3].x = 760;
			circle_lamp_Red_prov[3].y = 150;
			addChild(circle_lamp_Red_prov[3]);
			
			circle_lamp_Red_prov[4].x = 760;
			circle_lamp_Red_prov[4].y = 190;
			addChild(circle_lamp_Red_prov[4]);
			
			circle_lamp_Red_prov[5].x = 760;
			circle_lamp_Red_prov[5].y = 230;
			addChild(circle_lamp_Red_prov[5]);
			
			circle_lamp_Red_prov[6].x = 760;
			circle_lamp_Red_prov[6].y = 270;
			addChild(circle_lamp_Red_prov[6]);
			
			circle_lamp_Red_prov[7].x = 760;
			circle_lamp_Red_prov[7].y = 310;
			addChild(circle_lamp_Red_prov[7]);
			
			circle_lamp_Red_prov[8].x = 760;
			circle_lamp_Red_prov[8].y = 350;
			addChild(circle_lamp_Red_prov[8]);
			
			circle_lamp_Red_prov[9].x = 760;
			circle_lamp_Red_prov[9].y = 390;
			addChild(circle_lamp_Red_prov[9]);
			//---------------------------------------------------------------------------------
			// зеленые лампочки
			circle_lamp_Green_prov[0].x = 760;
			circle_lamp_Green_prov[0].y = 30;
			addChild(circle_lamp_Green_prov[0]);
			circle_lamp_Green_prov[0].visible = false;
			var text_f_7:TextField = new TextField();
			text_f_7.autoSize = TextFieldAutoSize.LEFT;
			text_f_7.text = "0";
			text_f_7.x = 780;
			text_f_7.y = 25;			
			addChild(text_f_7);
			
			circle_lamp_Green_prov[1].x = 760;
			circle_lamp_Green_prov[1].y = 70;
			addChild(circle_lamp_Green_prov[1]);
			circle_lamp_Green_prov[1].visible = false;
			var text_f_8:TextField = new TextField();
			text_f_8.autoSize = TextFieldAutoSize.LEFT;
			text_f_8.text = "1";
			text_f_8.x = 780;
			text_f_8.y = 65;			
			addChild(text_f_8);
			
			circle_lamp_Green_prov[2].x = 760;
			circle_lamp_Green_prov[2].y = 110;
			addChild(circle_lamp_Green_prov[2]);
			circle_lamp_Green_prov[2].visible = false;
			var text_f_9:TextField = new TextField();
			text_f_9.autoSize = TextFieldAutoSize.LEFT;
			text_f_9.text = "2";
			text_f_9.x = 780;
			text_f_9.y = 105;			
			addChild(text_f_9);
			
			circle_lamp_Green_prov[3].x = 760;
			circle_lamp_Green_prov[3].y = 150;
			addChild(circle_lamp_Green_prov[3]);
			circle_lamp_Green_prov[3].visible = false;
			var text_f_10:TextField = new TextField();
			text_f_10.autoSize = TextFieldAutoSize.LEFT;
			text_f_10.text = "3";
			text_f_10.x = 780;
			text_f_10.y = 145;			
			addChild(text_f_10);
			
			circle_lamp_Green_prov[4].x = 760;
			circle_lamp_Green_prov[4].y = 190;
			addChild(circle_lamp_Green_prov[4]);
			circle_lamp_Green_prov[4].visible = false;
			var text_f_11:TextField = new TextField();
			text_f_11.autoSize = TextFieldAutoSize.LEFT;
			text_f_11.text = "4";
			text_f_11.x = 780;
			text_f_11.y = 185;			
			addChild(text_f_11);
			
			circle_lamp_Green_prov[5].x = 760;
			circle_lamp_Green_prov[5].y = 230;
			addChild(circle_lamp_Green_prov[5]);
			circle_lamp_Green_prov[5].visible = false;
			var text_f_12:TextField = new TextField();
			text_f_12.autoSize = TextFieldAutoSize.LEFT;
			text_f_12.text = "5";
			text_f_12.x = 780;
			text_f_12.y = 225;			
			addChild(text_f_12);
			
			circle_lamp_Green_prov[6].x = 760;
			circle_lamp_Green_prov[6].y = 270;
			addChild(circle_lamp_Green_prov[6]);
			circle_lamp_Green_prov[6].visible = false;
			var text_f_13:TextField = new TextField();
			text_f_13.autoSize = TextFieldAutoSize.LEFT;
			text_f_13.text = "6";
			text_f_13.x = 780;
			text_f_13.y = 265;			
			addChild(text_f_13);
			
			circle_lamp_Green_prov[7].x = 760;
			circle_lamp_Green_prov[7].y = 310;
			addChild(circle_lamp_Green_prov[7]);
			circle_lamp_Green_prov[7].visible = false;
			var text_f_14:TextField = new TextField();
			text_f_14.autoSize = TextFieldAutoSize.LEFT;
			text_f_14.text = "7";
			text_f_14.x = 780;
			text_f_14.y = 305;			
			addChild(text_f_14);
			
			circle_lamp_Green_prov[8].x = 760;
			circle_lamp_Green_prov[8].y = 350;
			addChild(circle_lamp_Green_prov[8]);
			circle_lamp_Green_prov[8].visible = false;
			var text_f_15:TextField = new TextField();
			text_f_15.autoSize = TextFieldAutoSize.LEFT;
			text_f_15.text = "8";
			text_f_15.x = 780;
			text_f_15.y = 345;			
			addChild(text_f_15);
			
			circle_lamp_Green_prov[9].x = 760;
			circle_lamp_Green_prov[9].y = 390;
			addChild(circle_lamp_Green_prov[9]);
			circle_lamp_Green_prov[9].visible = false;
			var text_f_16:TextField = new TextField();
			text_f_16.autoSize = TextFieldAutoSize.LEFT;
			text_f_16.text = "9";
			text_f_16.x = 780;
			text_f_16.y = 385;			
			addChild(text_f_16);

		}
		//===================================================================================================
		public function createCont():void //функция создающая контакты
		{
			var i:int = 0;
			var a:int = 30;
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
		a = 30;
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
			rect.y = 10;
			addChild(rect);			
			
			for (i = 0; i < 9; i++) 
			{
				var lamp_Green:Sprite = createRect( 0x00ff00, 60, 15);
				rect_lamp_Green[i] = lamp_Green;
			}			
			// местоположение зеленых горизонтальных ламп
			//верхний
			rect_lamp_Green[1].x = 170; 
			rect_lamp_Green[1].y = 20;			
			addChild(rect_lamp_Green[1]);
			//средний
			rect_lamp_Green[3].x = 170; 
			rect_lamp_Green[3].y = 100;
			addChild(rect_lamp_Green[3]);
			//нижний
			rect_lamp_Green[5].x = 170; 
			rect_lamp_Green[5].y = 175;
			addChild(rect_lamp_Green[5]);
			
			// местоположение зеленых вертикальных ламп
			//правый верхний
			rect_lamp_Green[0].x = 160; 
			rect_lamp_Green[0].y = 35;
			rect_lamp_Green[0].rotation = 90;
		    addChild(rect_lamp_Green[0]);
			//правый нижний
			rect_lamp_Green[4].x = 160; 
			rect_lamp_Green[4].y = 115;
			rect_lamp_Green[4].rotation = 90;
			addChild(rect_lamp_Green[4]);
			//левый верхний
			rect_lamp_Green[2].x = 255; 
			rect_lamp_Green[2].y = 35;
			rect_lamp_Green[2].rotation = 90;
			addChild(rect_lamp_Green[2]);
			//левый нижний
			rect_lamp_Green[6].x = 255; 
			rect_lamp_Green[6].y = 115;
			rect_lamp_Green[6].rotation = 90;
			addChild(rect_lamp_Green[6]);
			if ( level == 2)
			{
		    //диагональный верхний
			rect_lamp_Green[7].x = 172; 
			rect_lamp_Green[7].y = 82;
			rect_lamp_Green[7].rotation = -45;
			addChild(rect_lamp_Green[7]);
			//диагональный нижний
			rect_lamp_Green[8].x = 172; 
			rect_lamp_Green[8].y = 162;
			rect_lamp_Green[8].rotation =-45;
			addChild(rect_lamp_Green[8]);
			// текстовые поля вывода подписей на лампах
			var num8:TextField = new TextField();
			num8.autoSize = TextFieldAutoSize.LEFT;
			num8.text = "8";
			num8.x = 192;
			num8.y = 57;			
			addChild(num8);
			
			var num9:TextField = new TextField();
			num9.autoSize = TextFieldAutoSize.LEFT;
			num9.text = "9";
			num9.x = 192;
			num9.y = 137;			
			addChild(num9);			
			}			
			// текстовые поля вывода подписей на лампах
			var num1:TextField = new TextField();
			num1.autoSize = TextFieldAutoSize.LEFT;
			num1.text = "1";
			num1.x = 148;
			num1.y = 58;			
			addChild(num1);
			
			var num2:TextField = new TextField();
			num2.autoSize = TextFieldAutoSize.LEFT;
			num2.text = "2";
			num2.x = 195;
			num2.y = 19;			
			addChild(num2);
			
			var num3:TextField = new TextField();
			num3.autoSize = TextFieldAutoSize.LEFT;
			num3.text = "3";
			num3.x = 243;
			num3.y = 58;			
			addChild(num3);
			
			var num4:TextField = new TextField();
			num4.autoSize = TextFieldAutoSize.LEFT;
			num4.text = "4";
			num4.x = 195;
			num4.y = 99;			
			addChild(num4);			
			
			var num5:TextField = new TextField();
			num5.autoSize = TextFieldAutoSize.LEFT;
			num5.text = "5";
			num5.x = 148;
			num5.y = 138;			
			addChild(num5);
			
			var num6:TextField = new TextField();
			num6.autoSize = TextFieldAutoSize.LEFT;
			num6.text = "6";
			num6.x = 195;
			num6.y = 174;			
			addChild(num6);
			
			var num7:TextField = new TextField();
			num7.autoSize = TextFieldAutoSize.LEFT;
			num7.text = "7";
			num7.x = 243;
			num7.y = 138;			
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
			//trace(n);
			var i:int = 0;
			var flag:int = 1;
			var a:int = 0;
			for ( i = 0 ; i < 10 ; i++)
			{
				if (i != n  && circle_lamp_Green_prov[i].visible == true)
				{
					flag = 0;
				}
				if (circle_lamp_Green_prov[i].visible == true && i == n  && flag != 0)
				{
					a = 1;
				}
			}
			if (a && flag)
				Result++;
			t_result.text =  '  ' + Result;
			t_nB.text =  '  ' + NumberBlokcs;
			
			
		}		
	    //===================================================
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
			//addEventListener(MouseEvent.DOUBLE_CLICK, dragContactsAnd);
			addEventListener(MouseEvent.MOUSE_DOWN, down);
			addEventListener(MouseEvent.MOUSE_UP,  up);
			
			addEventListener(Event.ENTER_FRAME, controllaContatto);
			NumberBlokcs++;
			numAnd++;
			//trace (NumberBlokcs);
		}
		//======================================================
		public function createLine(x1:int, y1:int, x2:int, y2:int,arr:Array, stepX:int, stepY:int,n:int):void
		{
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(x1+stepX, y1+stepY);
			line.graphics.lineTo(x2,y2);
			//line.graphics.curveTo(x1+20+(x2-x1)/2,y2-20,x2,y2);
			addChild(line);
			arr[n]=line;
		}
		//==================================================
		public function createBezie(x1:int, y1:int, x2:int, y2:int, arr:Array, stepX:int, stepY:int,stepYAnchor:int,n:int):void
		{
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(x1+stepX, y1+stepY);
			line.graphics.curveTo(x1+20+(x2-x1)/2,y2-stepYAnchor,x2,y2);
			addChild(line);
			arr[n]=line;
		}
		//===================================================
		public function wireL(e:Event):void
		{   
			removeChild(andLineL[myVar]);
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(andTull[myVar].x, andTull[myVar].y+5);
			line.graphics.curveTo(andTull[myVar].x+20+(andLeft[myVar].x + 7-andTull[myVar].x)/2,andLeft[myVar].y - 23,andLeft[myVar].x + 7,andLeft[myVar].y - 3);
			addChild(line);
			andLineL[myVar] = line;
		}
		//=====================================================
		public function wireR(e:Event):void
		{   
			removeChild(andLineR[myVar]);
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(andTull[myVar].x, andTull[myVar].y+25);
			line.graphics.curveTo(andTull[myVar].x+20+(andRight[myVar].x + 7-andTull[myVar].x)/2,andRight[myVar].y + 17,andRight[myVar].x + 7,andRight[myVar].y - 3);
			addChild(line);
			andLineR[myVar] = line;
		}
		//====================================================
		public function down(e:Event):void
		{
			var vs:Sprite = new Sprite();
			var flag : int = 0 ;
			var k: int = 0;
			for (k = 0;k < 30 && flag==0; k++)
			{
				if(andTull[k]==e.target)
				{
					setChildIndex(andTull[k], numChildren - 1);
					flag = 1;
					andTull[k].startDrag();
					
					
					stage.addEventListener(MouseEvent.MOUSE_MOVE, dragCircle);
					myVar = k;// глобальный подсчёт блоков И
					/*removeChild(andLineL[k]);
					delete(andLineL[k]);
					removeChild(andLineR[k]);
					delete(andLineR[k]);*/
				}
				if (andRight[k]==e.target )
				{
					flag = 1;
					myVar = k;
					andRight[k].startDrag();
					setChildIndex(andRight[k], numChildren - 1);
					/*removeChild(andLineR[k]);
					delete(andLineR[k]);*/
					addEventListener(MouseEvent.MOUSE_MOVE, wireR);
				}
				if ( andLeft[k]==e.target )
				{
					flag = 1;
					myVar = k;
					andLeft[k].startDrag();
					setChildIndex(andLeft[k], numChildren - 1);
					addEventListener(MouseEvent.MOUSE_MOVE, wireL);
					/*removeChild(andLineL[k]);
					delete(andLineL[k]); */
				}				
			}			
			
		}
		//===================================================
		//===================================================
		public function dragCircle(event:MouseEvent):void 
		{ 
			andAim[myVar].x = andTull[myVar].x + 50; 
			andAim[myVar].y = andTull[myVar].y + 15;
			//andLeft[myVar].x = andTull[myVar].x - 20; 
			//andLeft[myVar].y = andTull[myVar].y - 5;
			//andRight[myVar].x = andTull[myVar].x -20; 
			//andRight[myVar].y = andTull[myVar].y + 30;
			andLineAim[myVar].x = andTull[myVar].x - 350;
			andLineAim[myVar].y = andTull[myVar].y - 10;
			//andLineL[myVar].x = andTull[myVar].x - 350;
			//andLineL[myVar].y = andTull[myVar].y -12;
			wireL(event);
			wireR(event);
			event.updateAfterEvent(); 

		} 	
		//====================================================
		public function dragContactsAnd(e:Event):void 
		{
			var k:int;
			var flag:int = 1;
			trace(1);
			for (k = 0; k < 30 && flag; k++)
			{
				if (andTull[k] == e.target)
				{
					flag = 0;
					andLeft[k].x = andTull[k].x - offsetX; 
					andLeft[k].y = andTull[k].y - offsetY;
					andRight[k].x = andTull[k].x - offsetX2; 
					andRight[k].y = andTull[k].y - offsetY2;
				}
			}
		}
		//===================================================
		public function up(e:Event):void
		{
			var flag:int = 0;
			var k:int = 0;
			var vs:Sprite = new Sprite();//вспомогательная переменная
			if (e.target == andLeft[myVar])
				{
					andLeft[myVar].stopDrag();
					//trace(2);
					removeEventListener(MouseEvent.MOUSE_MOVE, wireL);
					//trace(3);
					//createLine(andTull[myVar].x, andTull[myVar].y, andLeft[myVar].x+7, andLeft[myVar].y - 3,andLineL,0,5,myVar);
					for (k = 0; k < 9; k++)
					{
						if (andLeft[myVar].hitTestObject(circle_lamp_Green[k]))
							{
								andLeft[myVar].x = circle_lamp_Green[k].x;
								andLeft[myVar].y = circle_lamp_Green[k].y;
								wireL(e);
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (andLeft[myVar].hitTestObject(andAim[k]))
						{
							andLeft[myVar].x = andAim[k].x;
							andLeft[myVar].y = andAim[k].y;
							wireL(e);
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (andLeft[myVar].hitTestObject(orAim[k]))
						{
							andLeft[myVar].x = orAim[k].x;
							andLeft[myVar].y = orAim[k].y;
							wireL(e);
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (andLeft[myVar].hitTestObject(notAim[k]))
						{
							andLeft[myVar].x = notAim[k].x;
							andLeft[myVar].y = notAim[k].y;
							wireL(e);
						}
					}
					
				}
				if (e.target == andRight[myVar])
				{
					andRight[myVar].stopDrag();
					removeEventListener(MouseEvent.MOUSE_MOVE, wireR);
					//createLine(andTull[myVar].x, andTull[myVar].y, andRight[myVar].x+7, andRight[myVar].y - 3,andLineR,0,45,myVar);
					for (k = 0; k < 9; k++)
					{
						if (andRight[myVar].hitTestObject(circle_lamp_Green[k]))
							{
								andRight[myVar].x = circle_lamp_Green[k].x;
								andRight[myVar].y = circle_lamp_Green[k].y;
								wireR(e);
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (andRight[myVar].hitTestObject(andAim[k]))
						{
							andRight[myVar].x = andAim[k].x;
							andRight[myVar].y = andAim[k].y;
							wireR(e);
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (andRight[myVar].hitTestObject(orAim[k]))
						{
							andRight[myVar].x = orAim[k].x;
							andRight[myVar].y = orAim[k].y;
							wireR(e);
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (andRight[myVar].hitTestObject(notAim[k]))
						{
							andRight[myVar].x = notAim[k].x;
							andRight[myVar].y = notAim[k].y;
							wireR(e);
						}
					}
				}
				if(e.target==andTull[myVar])
				{
					andTull[myVar].stopDrag();
					//createLine(andTull[myVar].x, andTull[myVar].y, andLeft[myVar].x + 7, andLeft[myVar].y + 3, andLineL, 0, 5,myVar);
					//createLine(andTull[myVar].x, andTull[myVar].y, andRight[myVar].x+7, andRight[myVar].y - 3,andLineR,0,45,myVar);
				}
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragCircle); 
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
					
					andTull.pop();
					andAim.pop();
					andLeft.pop();
					andRight.pop();
					andLineAim.pop();
					andLineL.pop();
					andLineR.pop();
					myVar--;
					NumberBlokcs--;
					numAnd--;
				}
			}
		}
		//===================================================
		public function controllaContatto(e:Event):void
		{
			for (var i:int = 0; i < andRight.length; i++)
			{
				for (var k:int = 0; k < 9;k++)
					{
						if(andRight[i].hitTestObject(circle_lamp_Green[k]))
							andRightResult[i] = circle_lamp_Green[k].visible;
						if(andLeft[i].hitTestObject(circle_lamp_Green[k]))
							andLeftResult[i] = circle_lamp_Green[k].visible;
					}
				for (k = 0; k < andTull.length; k++)
					{
						if (andRight[i].hitTestObject(andAim[k]))
							andRightResult[i] = andAimResult[k];
						if (andLeft[i].hitTestObject(andAim[k]))
							andLeftResult[i] = andAimResult[k];
					}
				for (k = 0; k < orTull.length;k++)
					{
						if (andRight[i].hitTestObject(orAim[k]))
							andRightResult[i] = orAimResult[k];
						if (andLeft[i].hitTestObject(orAim[k]))
							andLeftResult[i] = orAimResult[k];
					}
				for (k = 0; k < notTull.length; k++)
				{
					if (andRight[i].hitTestObject(notAim[k]))
							andRightResult[i] = notAimResult[k];
					if (andLeft[i].hitTestObject(notAim[k]))
							andLeftResult[i] = notAimResult[k];
				}						
				andAimResult[i] = andLeftResult[i] && andRightResult[i];
				for (k = 0; k < 10; k++)
					{
						if (andAim[i].hitTestObject(circle_lamp_Green_prov[k]))
						{
							circle_lamp_Green_prov[k].visible = andAimResult[i];
						}
					}
			}
			//trace(1);
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
			
			NumberBlokcs++;
			numOr++;
			//trace (NumberBlokcs);
		}
		//===================================================
		public function wireRor(e:Event):void
		{   
			removeChild(orLineR[myVar2]);
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(orTull[myVar2].x, orTull[myVar2].y+25);
			line.graphics.curveTo(orTull[myVar2].x+20+(orRight[myVar2].x + 7-orTull[myVar2].x)/2,orRight[myVar2].y + 17,orRight[myVar2].x + 7,orRight[myVar2].y - 3);
			addChild(line);
			orLineR[myVar2] = line;
		}
		//=======================================================
		public function wireLor(e:Event):void
		{   
			removeChild(orLineL[myVar2]);
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(orTull[myVar2].x, orTull[myVar2].y+5);
			line.graphics.curveTo(orTull[myVar2].x+20+(orLeft[myVar2].x + 7-orTull[myVar2].x)/2,orLeft[myVar2].y - 23,orLeft[myVar2].x + 7,orLeft[myVar2].y - 3);
			addChild(line);
			orLineL[myVar2] = line;
		}
		//===================================================
		public function downor(e:Event):void
		{
			var flag : int = 0 ;
			var k: int = 0;
			for (k = 0;k < 30 && flag==0; k++)
			{
				if(orTull[k]==e.target)
				{
					myVar2 = k;
					flag = 1;
					setChildIndex(orTull[k], numChildren - 1);
					orTull[k].startDrag();
					stage.addEventListener(MouseEvent.MOUSE_MOVE, dragCircleor); 
					/*removeChild(orLineL[k]);
					orLineL.pop();
					removeChild(orLineR[k]);
					orLineR.pop();*/
				}
				if (orRight[k]==e.target )
				{
					flag = 1;
					setChildIndex(orRight[k], numChildren - 1);
					orRight[k].startDrag();
					addEventListener(MouseEvent.MOUSE_MOVE, wireRor);
					/*removeChild(orLineR[k]);
					orLineR.pop();*/
				}
				if ( orLeft[k]==e.target )
				{
					flag = 1;
					setChildIndex(orLeft[k], numChildren - 1);
					orLeft[k].startDrag();
					addEventListener(MouseEvent.MOUSE_MOVE, wireLor);
					/*removeChild(orLineL[k]);
					orLineL.pop();*/
				}				

			}			
			
		}
		//===================================================
		public function dragCircleor(event:MouseEvent):void 
		{ 

			orLeft[myVar2].x = orTull[myVar2].x -20; 
			orLeft[myVar2].y = orTull[myVar2].y -5;
			orRight[myVar2].x = orTull[myVar2].x - 20; 
			orRight[myVar2].y = orTull[myVar2].y +30;
			orAim[myVar2].x = orTull[myVar2].x + 50; 
			orAim[myVar2].y = orTull[myVar2].y +15;
			orLineAim[myVar2].x = orTull[myVar2].x - 350;
			orLineAim[myVar2].y = orTull[myVar2].y - 10;
			wireLor(event);
			wireRor(event);
			event.updateAfterEvent(); 

		} 
		//====================================================
	
		//===================================================
		public function upor(e:Event):void
		{
			var flag:int = 0;
			var k:int = 0;
			var vs2:Sprite = new Sprite();
			if (e.target == orLeft[myVar2])
				{
					orLeft[myVar2].stopDrag();
					removeEventListener(MouseEvent.MOUSE_MOVE, wireLor);
					//createLine(orTull[myVar2].x, orTull[myVar2].y, orLeft[myVar2].x + 7, orLeft[myVar2].y - 3, orLineL, 0, 5);
					for (k = 0; k < 9; k++)
					{
						if (orLeft[myVar2].hitTestObject(circle_lamp_Green[k]))
							{
								orLeft[myVar2].x = circle_lamp_Green[k].x;
								orLeft[myVar2].y = circle_lamp_Green[k].y;
								wireLor(e);
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (orLeft[myVar2].hitTestObject(andAim[k]))
						{
							orLeft[myVar2].x = andAim[k].x;
							orLeft[myVar2].y = andAim[k].y;
							wireLor(e);
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (orLeft[myVar2].hitTestObject(orAim[k]))
						{
							orLeft[myVar2].x = orAim[k].x;
							orLeft[myVar2].y = orAim[k].y;
							wireLor(e);
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (orLeft[myVar2].hitTestObject(notAim[k]))
						{
							orLeft[myVar2].x = notAim[k].x;
							orLeft[myVar2].y = notAim[k].y;
							wireLor(e);
						}
					}
				}
				if (e.target == orRight[myVar2])
				{
					orRight[myVar2].stopDrag();
					removeEventListener(MouseEvent.MOUSE_MOVE, wireRor);
					//createLine(orTull[myVar2].x, orTull[myVar2].y, orRight[myVar2].x + 7, orRight[myVar2].y - 3, orLineR, 0, 45);
					for (k = 0; k < 9; k++)
					{
						if (orRight[myVar2].hitTestObject(circle_lamp_Green[k]))
							{
								orRight[myVar2].x = circle_lamp_Green[k].x;
								orRight[myVar2].y = circle_lamp_Green[k].y;
								wireRor(e);
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (orRight[myVar2].hitTestObject(andAim[k]))
						{
							orRight[myVar2].x = andAim[k].x;
							orRight[myVar2].y = andAim[k].y;
							wireRor(e);
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (orRight[myVar2].hitTestObject(orAim[k]))
						{
							orRight[myVar2].x = orAim[k].x;
							orRight[myVar2].y = orAim[k].y;
							wireRor(e);
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (orRight[myVar2].hitTestObject(notAim[k]))
						{
							orRight[myVar2].x = notAim[k].x;
							orRight[myVar2].y = notAim[k].y;
							wireRor(e);
						}
					}
				}
				if(e.target==orTull[myVar2])
				{
					orTull[myVar2].stopDrag();
					/*createLine(orTull[myVar2].x, orTull[myVar2].y, orLeft[myVar2].x + 7, orLeft[myVar2].y - 3, orLineL, 0, 5);
					createLine(orTull[myVar2].x, orTull[myVar2].y, orRight[myVar2].x + 7, orRight[myVar2].y - 3, orLineR, 0, 45);*/
				}
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragCircleor); 
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
								
					orTull.pop();
					orAim.pop();
					orLeft.pop();
					orRight.pop();
					orLineAim.pop()
					orLineL.pop();
					orLineR.pop();
					myVar2--;
					NumberBlokcs--;
					numOr--;
				}
			}
		}
		//===================================================
		public function controllaContattoor(e:Event):void
		{
			for (var i:int = 0; i < orRight.length; i++)
			{
				for (var k:int = 0; k < 9;k++)
					{
						if(orRight[i].hitTestObject(circle_lamp_Green[k]))
							orRightResult[i] = circle_lamp_Green[k].visible;
						if(orLeft[i].hitTestObject(circle_lamp_Green[k]))
							orLeftResult[i] = circle_lamp_Green[k].visible;
					}
				for (k = 0; k < orTull.length; k++)
					{
						if (orRight[i].hitTestObject(orAim[k]))
							orRightResult[i] = orAimResult[k];
						if (orLeft[i].hitTestObject(orAim[k]))
							orLeftResult[i] = orAimResult[k];
					}
				for (k = 0; k < andTull.length;k++)
					{
						if (orRight[i].hitTestObject(andAim[k]))
							orRightResult[i] = andAimResult[k];
						if (orLeft[i].hitTestObject(andAim[k]))
							orLeftResult[i] = andAimResult[k];
					}
				for (k = 0; k < notTull.length; k++)
				{
					if (orRight[i].hitTestObject(notAim[k]))
							orRightResult[i] = notAimResult[k];
					if (orLeft[i].hitTestObject(notAim[k]))
							orLeftResult[i] = notAimResult[k];
				}
					
				orAimResult[i] = orLeftResult[i] || orRightResult[i];
				for (k = 0; k < 10; k++)
					{
						if (orAim[i].hitTestObject(circle_lamp_Green_prov[k]))
						{
							circle_lamp_Green_prov[k].visible = orAimResult[i];
						}
					}
			
			}
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
			
			NumberBlokcs++;
			numNot++;
		}
		//===================================================
		public function wireNot(e:Event):void
		{
			removeChild(notLineR[myVar3]);
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(notTull[myVar3].x, notTull[myVar3].y+15);
			line.graphics.curveTo(notTull[myVar3].x+20+(notRight[myVar3].x -notTull[myVar3].x)/2,notRight[myVar3].y - 35,notRight[myVar3].x + 7,notRight[myVar3].y - 3);
			addChild(line);
			notLineR[myVar3] = line;
		}
		//=====================================================
		public function downnot(e:Event):void
		{
			var flag : int = 0 ;
			var k: int = 0;
			for (k = 0;k < 30 && flag==0; k++)
			{
				if(notTull[k]==e.target)
				{
					myVar3 = k;
					flag = 1;
					setChildIndex(notTull[k], numChildren - 1);
					notTull[k].startDrag();
					stage.addEventListener(MouseEvent.MOUSE_MOVE, dragCirclenot); 
					//removeChild(notLineR[k]);
					//notLineR.pop();
				}
				if (notRight[k]==e.target )
				{
					flag = 1;
					setChildIndex(notRight[k], numChildren - 1);
					notRight[k].startDrag();
					addEventListener(MouseEvent.MOUSE_MOVE, wireNot);
					//removeChild(notLineR[k]);
					//notLineR.pop();
					
				}		
				
			}			
			
		}
		//===================================================
		public function dragCirclenot(event:MouseEvent):void 
		{ 
			notRight[myVar3].x = notTull[myVar3].x - 20; 
			notRight[myVar3].y = notTull[myVar3].y + 15;
			notAim[myVar3].x = notTull[myVar3].x +50; 
			notAim[myVar3].y = notTull[myVar3].y + 15;
			notLineAim[myVar3].x = notTull[myVar3].x - 350;
			notLineAim[myVar3].y = notTull[myVar3].y - 10;
			wireNot(event);
			event.updateAfterEvent(); 

		} 
		//===================================================
		public function upnot(e:Event):void
		{
			var flag:int = 0;
			var k:int = 0;
			var vs2:Sprite = new Sprite();
			if (e.target == notRight[myVar3])
			{
				notRight[myVar3].stopDrag();
				removeEventListener(MouseEvent.MOUSE_MOVE, wireNot);
				//createLine(notTull[myVar3].x, notTull[myVar3].y, notRight[myVar3].x + 7, notRight[myVar3].y, notLineR, 0, 25);
				for (k = 0; k < 9; k++)
					{
						if (notRight[myVar3].hitTestObject(circle_lamp_Green[k]))
							{
								notRight[myVar3].x = circle_lamp_Green[k].x;
								notRight[myVar3].y = circle_lamp_Green[k].y;
								wireNot(e);
							}
					}
					for (k = 0; k < andTull.length; k++)
					{
						if (notRight[myVar3].hitTestObject(andAim[k]))
						{
							notRight[myVar3].x = andAim[k].x;
							notRight[myVar3].y = andAim[k].y;
							wireNot(e);
						}
					}
					for (k = 0; k < orTull.length; k++)
					{
						if (notRight[myVar3].hitTestObject(orAim[k]))
						{
							notRight[myVar3].x = orAim[k].x;
							notRight[myVar3].y = orAim[k].y;
							wireNot(e);
						}
					}
					for (k = 0; k < notTull.length; k++)
					{
						if (notRight[myVar3].hitTestObject(notAim[k]))
						{
							notRight[myVar3].x = notAim[k].x;
							notRight[myVar3].y = notAim[k].y;
							wireNot(e);
						}
					}
			}
			if(e.target==notTull[myVar3])
			{
				notTull[myVar3].stopDrag();
				//createLine(notTull[myVar3].x, notTull[myVar3].y, notRight[myVar3].x + 7, notRight[myVar3].y, notLineR, 0, 25);
			}
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, dragCirclenot); 
			if (myVar3 >= 0)
			{
				if(notTull[myVar3].hitTestObject(bin))//Удаление
					{
						
						removeChild(notLineAim[myVar3]);
						removeChild(notRight[myVar3]);
						removeChild(notAim[myVar3]);
						removeChild(notTull[myVar3]);
						removeChild(notLineR[myVar3]);
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
					
					notTull.pop();
					notAim.pop();
					notRight.pop();
					notLineR.pop();
					notLineAim.pop();
					myVar3--;
					NumberBlokcs--;
					numNot--;
				}
			}
		}
		//===================================================
		public function controllaContattonot(e:Event):void
		{
			
			for (var i:int = 0; i < notRight.length; i++)
			{
				for (var k:int = 0; k < 9;k++)
					{
						if(notRight[i].hitTestObject(circle_lamp_Green[k]))
							notRightResult[i] = circle_lamp_Green[k].visible;
					}
				for (k = 0; k < andTull.length; k++)
					{
						if (notRight[i].hitTestObject(andAim[k]))
							notRightResult[i] = andAimResult[k];
					}
				for (k = 0; k < orTull.length;k++)
					{
						if (notRight[i].hitTestObject(orAim[k]))
							notRightResult[i] = orAimResult[k];
					}
				for (k = 0; k < notTull.length; k++)
				{
					if (notRight[i].hitTestObject(notAim[k]))
							notRightResult[i] = notAimResult[k];
				}
				notAimResult[i] = !notRightResult[i];
				for (k = 0; k < 10; k++)
					{
						if (notAim[i].hitTestObject(circle_lamp_Green_prov[k]))
						{
							circle_lamp_Green_prov[k].visible = notAimResult[i];
						}
					}		
			}
		}
		//===================================================
		public function createBin():void
		{
			bin.x = 30;
			bin.y = 420;
			addChild(bin);
			var line:Shape = new Shape();
			line.graphics.lineStyle(1);
			line.graphics.moveTo(30, 420);
			line.graphics.lineTo(35, 470);
			addChild(line);
			line.graphics.moveTo(35, 420);
			line.graphics.lineTo(40, 470);
			addChild(line);
			line.graphics.moveTo(40, 420);
			line.graphics.lineTo(45, 470);
			addChild(line);
			line.graphics.moveTo(45, 420);
			line.graphics.lineTo(45, 470);
			addChild(line);
			line.graphics.moveTo(50, 420);
			line.graphics.lineTo(43, 470);
			addChild(line);
			line.graphics.moveTo(55, 420);
			line.graphics.lineTo(50, 470);
			addChild(line);
			line.graphics.moveTo(60, 420);
			line.graphics.lineTo(55, 470);
			addChild(line);
		}
		//========================================================
	}
}