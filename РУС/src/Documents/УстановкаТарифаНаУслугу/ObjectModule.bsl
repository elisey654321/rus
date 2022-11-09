
//@skip-check module-structure-method-in-regions
Процедура ОбработкаПроведения(Отказ, РежимПроведения)
	НаборЗаписей = РегистрыСведений.ЦеныНаУслуги.СоздатьНаборЗаписей();
	НаборЗаписей.Отбор.Регистратор.Установить(Ссылка);
	НаборЗаписей.Прочитать();
	НаборЗаписей.Очистить();
	
	Для каждого Строка из Цены цикл
		нСтр = НаборЗаписей.Добавить();
		нСтр.Регистратор 		= Ссылка;
		нСтр.Услуга 			= Услуга;
		нСтр.ТипГрузовогоМеста 	= ТипГрузовыхМест;
		нСтр.КоличествоОт 		= Строка.КоличествоОт;
		нСтр.КоличествоДо 		= Строка.КоличествоДо;
		нСтр.ТипДня 			= Строка.ТипДня;
		нСтр.Цена 				= Строка.Цена;
		нСтр.Период				= Дата;
	КонецЦикла;
	НаборЗаписей.Записать();
КонецПроцедуры
