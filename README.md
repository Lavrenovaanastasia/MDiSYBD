# Лавренова Анастасия, 253504
## Тема: Автосервис
### Функциональные требования к проекту:

 Будет представленно 2 различных уровня доступа к сайту (2 роли):
 
•	администратор;

•	пользователь с регистрацией.

### Присутствует регистрация и аутентификация пользователей (регистрация только у пользователя).
### Возможности пользователя:

 •  авторизация и регистрация в системе 
 
 • вход в систему с использованием логина и пароля
 
 • просмотр краткой информации о компании

 • просмотр последних новостей
 
 • просмотр доступных вакансий
 
 • возможность оставить отзыв и прочитать отзывы других
 
 • простмотр частозадаваемых вопросов и ответов на них

 • просмотр страницы с актуальными скидками
 
 • поиск и фильтрация предоставляемых компанией услуг
 
 • просмотр филиалов
 
 • оформление заказов 
 
 • добавление услгу в корзину, а также удаление из неё
 
 • применение промокода при оформлении заказа

 • возможность выхода из системы

 ### Возможности администратора:

 • авторизация в системе 
 
 • CRUD-операции с контактами автосервиса, услугами, поставщиками, филиалами 
 
 • просмотр журнала заказов пользователей 

 • простомтр статистики по продажам, клиентам, графики выручки
 
 • возможность выхода из системы

## Список сущностей:

### 1) User - идентификатор пользователя

 •    id (PK, INT) - уникальный идентификатор

 •   username vatchat, NOT NULL -  имя пользователя (е может быть пустым, должно быть уникальным);

• password vatchat, NOT NULL - хэшированный пароль пользователя (не может быть пустым)

• address: string - адрес электронной почты

• status: string - статус пользователя (позволяет разграничивать уровни доступа)

• age: int - возраст пользователя ( для успешной регистрации должен быть больше 18)

• phone: string - номер телефона пользователя

### 2)Vacancy - вакансии

• name: string - название вакансии

• discription: string - описание вакансии

•  need: string - востребованность 


### 3) Review - отзывы

 • id (PK, INT) - уникальный идентификатор

 • title: string - название отзыва

 • rating: int - оценка

 • text: string - текст отзыва

 • data: detetimefield - дата оставления отзыва

 •  user: User[1] - ссылка на запись в таблице "User". Это поле указывает на пользователя, который оставил отзыв. "[1]" означает, что в каждой записи указан только один пользователь


### 4) Questions - частозадаваемые вопросы


 • question: string - содержимое вопроса

 • answer: string - ответ

 • date: datetimefiled - хранит дату и время 

### 5) CompanyImfo - информация о компании
   
 • text: string - описание

 • logo: imagefield - фотография


### 6) Contact - связь с компанией
   
• discription: string -  описание менеждера/работника и тд

 • user: User[1] - ссылка на запись в таблице "User". Это поле указывает на сотрудника, с которым будет соврешаться связь. "[1]" означает, что в каждой записи указан только один сотрудник

 • photo: imagefiled - фотография сотрудника

• phone_worker: string - номер телефона сотрудника

### 7) News - новости 

• title: string - название новости

• content: string- содержание новости

• image: imagefile- фотография

• date: datetimefiled - хранит дату и время создания новости

### 8) Sale -  предназначена для хранения информации о продажах услуг

• data: detetimefield- хранит дату и время совершения продажи

• promocode: Promocode[1] - ссылка на запись в таблице "Promocode". Это поле указывает на промокод, который был использован при совершении продажи. "[1]" означает, что к каждой продаже может быть применен только один промокод. Если промокод не использовался, это поле может быть пустым или иметь значение "NULL".

• user: User[1] - ссылка на запись в таблице "User". Это поле указывает на пользователя, который совершил покупку. "[1]" означает, что в каждой записи указан только один покупатель.

• department: Departmet - отдел, к которому относится проданный автомобиль

• car: Car - указывает на услугу, которая была продана

• quantity: int - целочисленный тип данных, хранящий количество проданных услуг

• prise: float - тип данных с плавающей точкой, хранящий цену за услугу
 
• use_discount: void -  функция, которая применяет скидку к цене

•subtotal: int -  целочисленный тип данных, хранящий итоговую стоимость покупки

### 9 ) Department - хранит информацию об отделах

•no: string - уникальный номер (или идентификатор) отдела

•address: string - адрес, где расположен отдел

•open: timefield - время открытия отдела

•close: timefield - время закрытия отдела

### 10) DepartmentCar - хранит информацию о количестве услуг каждого типа
    
• department: Departmet - ссылка на запись в таблице "Departmet". Это поле указывает на отдел, в котором предоставляется та или иная услуга

• car: Car[1] - ссылка на запись в таблице "Car".  Это поле указывает на тип автомобиля (модель, марка, год выпуска и т.д.),  количество которого  указано  в  таблице.  "[1]" означает, что  в  таблице  "DepartmentCar"  для  каждого отдела  указано  только  одно  количество  для  каждого типа  автомобиля

• quantity: iny - целое число - количество услуг  указанного типа  в  отделе.

### 11) Cars - содержит информацию об услугах, доступных для продажи

• name: string - наименование услуги

• code: string  -  уникальный код,  используемый для  внутренней  идентификации услуги

• instruction: string - краткое описание о процессе оказываемой услуги

 • description: string - опсание требуемых деталей 

• photo: imagefield - фотография

• categories: Categories - ссылка на запись в таблице "Categories". Это поле указывает на категорию услуг

• suppliers: Suppliers - ссылка на запись в таблице "Suppliers".  Это поле указывает на поставщика деталей

• get_absolute_url: string - поле  используеться  для  перехода  к  детальной  информации

• _str_: string - строковое представление  объекта  "Cars"  в  виде  названия  модели.  Это  поле  используется  для  вывода  наименования услуги  в  списках  и  других  местах,  где  требуется  строковое  представление. 

### 12) Categories - категории

• name: string - название

### 13) Promocode промокод

•code: string - уникальный код промокода

•discount: int - размер скидки, предоставляемый промокодом

### 14) Supplier - хранит информацию о поставщиках 

• name: string - название  поставщика

• address: string +cars: Cars[1..*] - позволяет  узнать  физическое  местоположение  филиала, в который поставляет данный постащик (один  поставщик  может  поставлять  в разные филиалы)

• phone: string - телефон  поставщика



### 15) Supply  - отражает  отношения  между поставщиками и  услугами

•supplier: Supplier[1] -ссылка на запись в таблице "Supplier".  Это  поле  указывает  на  конкретного  поставщика,  который  поставляет  детали.  "[1]" означает, что  для  каждой  записи  в  таблице  "Supply"  указан  только  один  поставщик. 

•car: Cars[1] - ссылка на запись в таблице "Cars".  Это  поле  указывает  на  конкретный  тип  деталей,  который  поставляет  поставщик.  "[1]" означает, что  для  каждой  записи  в  таблице  "Supply"  указан  только  один  тип  услуг
