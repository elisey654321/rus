
//@skip-check module-structure-method-in-regions
//@skip-check module-unused-method
Процедура СозданиеПервичныхДокументов() экспорт
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
	|	КОЛИЧЕСТВО(УстановкаТарифаНаУслугу.Ссылка) КАК Ссылка
	|ИЗ
	|	Документ.УстановкаТарифаНаУслугу КАК УстановкаТарифаНаУслугу";
	Выборка = Запрос.Выполнить().Выбрать();
	Выборка.Следующий();
	Если Выборка.Ссылка = 0 тогда
			
		НачатьТранзакцию();
		//@skip-check empty-except-statement
		Попытка
			СоздатьДокументУстановкиЦен(Справочники.ТипыГрузовызРазмещений.КГТ,Справочники.Услуги.Хранение,10,20);
			СоздатьДокументУстановкиЦен(Справочники.ТипыГрузовызРазмещений.МГТ,Справочники.Услуги.Хранение,10,20);
			СоздатьДокументУстановкиЦен(Справочники.ТипыГрузовызРазмещений.Хаб,Справочники.Услуги.Хранение,10,20);
			СоздатьДокументУстановкиЦен(Справочники.ТипыГрузовызРазмещений.Шины,Справочники.Услуги.Хранение,10,20);
			
			СоздатьДокументУстановкиЦен(Справочники.ТипыГрузовызРазмещений.КГТ,Справочники.Услуги.Обработка,100,200);
			СоздатьДокументУстановкиЦен(Справочники.ТипыГрузовызРазмещений.МГТ,Справочники.Услуги.Обработка,10,20);
			СоздатьДокументУстановкиЦен(Справочники.ТипыГрузовызРазмещений.Шины,Справочники.Услуги.Обработка,50,100);
			
			СоздатьДокументУстановкиЦенХаб();

			ЗафиксироватьТранзакцию();
		Исключение
			ОтменитьТранзакцию();
		КонецПопытки;
	КонецЕсли;
КонецПроцедуры

//@skip-check module-structure-top-region
#Область СлужебныеМеханизмы

Процедура СоздатьДокументУстановкиЦен(ТипаОбработки,Услуга,ЦенаДень,ЦенаВыходной)
	
	нДок = Документы.УстановкаТарифаНаУслугу.СоздатьДокумент();
	//@skip-check use-non-recommended-method
	нДок.Дата = НачалоГода(ТекущаяДата());
	нДок.УстановитьНовыйНомер();
	нДок.Услуга = Услуга;
	нДок.ТипГрузовогоМеста = ТипаОбработки;
	
	нСтр = нДок.Цены.Добавить();
	нСтр.Цена = ЦенаДень;
	нСтр.ТипДня = Перечисления.ТипыДней.Рабочий;
	
	нСтр = нДок.Цены.Добавить();
	нСтр.Цена = ЦенаВыходной;
	нСтр.ТипДня = Перечисления.ТипыДней.Выходной;
	
	нДок.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

Процедура СоздатьДокументУстановкиЦенХаб()
	
	нДок = Документы.УстановкаТарифаНаУслугу.СоздатьДокумент();
	//@skip-check use-non-recommended-method
	нДок.Дата = НачалоГода(ТекущаяДата());
	нДок.УстановитьНовыйНомер();
	нДок.Услуга = Справочники.Услуги.Обработка;
	нДок.ТипГрузовогоМеста = Справочники.ТипыГрузовызРазмещений.Хаб;
	
	ЗаполнитьНовуюСтроку(нДок,500,0,500);
	ЗаполнитьНовуюСтроку(нДок,200,500,1000);
	ЗаполнитьНовуюСтроку(нДок,100,1000,2000);
	ЗаполнитьНовуюСтроку(нДок,70,2000,5000);
	ЗаполнитьНовуюСтроку(нДок,50,5000,0);
	
	нДок.Записать(РежимЗаписиДокумента.Проведение);
	
КонецПроцедуры

Процедура ЗаполнитьНовуюСтроку(нДок,Цена,КоличествоОт = 0,КоличествоДо = 0)
	нСтр = нДок.Цены.Добавить();
	нСтр.Цена = Цена;
	нСтр.ТипДня = Перечисления.ТипыДней.Рабочий;
	нСтр.КоличествоОт = КоличествоОт;
	нСтр.КоличествоДо = КоличествоДо;
	
	нСтр = нДок.Цены.Добавить();
	нСтр.Цена = Цена*2;
	нСтр.ТипДня = Перечисления.ТипыДней.Выходной;
	нСтр.КоличествоОт = КоличествоОт;
	нСтр.КоличествоДо = КоличествоДо;
КонецПроцедуры

#КонецОбласти