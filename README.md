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

 •   username vatchat, NOT NULL -  имя пользователя (е может быть пустым, должно быть уникальным);

• password vatchat, NOT NULL - хэшированный пароль пользователя (не может быть пустым)

• address: string - адрес электронной почты

• status: string - статус пользователя (позволяет разграничивать уровни доступа)

• age: int - возраст пользователя ( для успешной регистрации должен быть больше 18)

• phone: string - номер телефона пользователя

2)




