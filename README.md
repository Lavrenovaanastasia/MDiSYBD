# Лавренова Анастасия, 253504
## Тема: Автосервис Функциональные требования к проекту:
### Будет представленно 2 различных доступа к сайту (2 роли):
 
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

### Список сущностей:

 1) User - идентификатор пользователя

 •    id (PK, INT) - уникальный идентификатор

 •   username vatchat, NOT NULL -  имя пользователя (е может быть пустым, должно быть уникальным);

• password vatchat, NOT NULL - хэшированный пароль пользователя (не может быть пустым)

• address: string - адрес электронной почты

• status: string - статус пользователя (позволяет разграничивать уровни доступа)

• age: int - возраст пользователя ( для успешной регистрации должен быть больше 18)

• phone: string - номер телефона пользователя

2)Vacancy - вакансии

• name: string - название вакансии

• discription: string - описание вакансии

•  need: string - востребованность 


3) Review -

 • id (PK, INT) - уникальный идентификатор

 • title: string - название отзыва

 • rating: int - оценка

 • text: string - текст отзыва

 • data: detetimefield - дата оставления отзыва

 •  user: User[1] - внешний ключ, ссылающийся на пользователя ( один к одному)


4) Questions - частозадаваемые вопросы


 • question: string - содержимое вопроса

 • answer: string - ответ

 • date: datetimefiled - время создания

5) CompanyImfo - информация о компании
   
 • text: string - описание

 • logo: imagefield - фотография


7) Contact - связь с компанией
   
•discription: string -  описание менеждера/работника и тд

 • user: User[1] - идентефикатор сотрудника

 • photo: imagefiled - фотография сотрудника

• phone_worker: string - номер телефона сотрудника

9) News - новости 

• title: string - название новости

• content: string- содержание новости

• image: imagefile- фотография

• date: datetimefiled - время создания

10) Sale

+data: detetimefield- время 
+promocode: Promocode[1]
+user: User[1]
+department: Departmet
+car: Car
+quantity: int
+prise: float
+use_discount: void
+subtotal: int

11 )Department
+no: string
+address: string +open: timefield +close: timefield 



12) DepartmentCar
+department: Departmet
+car: Car[1]
+quantity: iny

13) Cars


+name: string +code: string +instruction: string +description: string +photo: imagefield +categories: Categories+ +suppliers: Suppliers
+get_absolute_url: string +_str_: string


14) Categories

+name: string


15) Promocode

+code: string
+discount: int



16) Supplier


+name: string
+address: string +cars: Cars[1..*]
+phone: string



17) Supply


+supplier: Supplier[1]
+car: Cars[1]
