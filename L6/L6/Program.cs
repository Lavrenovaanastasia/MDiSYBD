using System;
using System.Data;
using System.Data.SqlClient;

namespace ConsoleAppDatabase
{
    class Program
    {
        private static string connectionString = @"Server=LAPTOP-FIHH2CU6\SQLEXPRES;Database=MDiSUBD;Trusted_Connection=True;";
        private static bool isAuthenticated = false;  // Флаг авторизован ли пользователь
        private static bool isAdmin = false;          // Флаг пользователь администратор

        static void Main(string[] args)
        {
            Console.WriteLine("Добро пожаловать в систему управления базой данных!");

            while (true)
            {
                if (!isAuthenticated)
                {
                    Console.WriteLine("\nДоступные команды:");
                    Console.WriteLine("1. Регистрация");
                    Console.WriteLine("2. Авторизация");
                    Console.WriteLine("3. Выйти");
                }
                else
                {
                    if (isAdmin)
                    {

                        Console.WriteLine("\nДоступные команды:");
                        Console.WriteLine("1. Просмотреть все услуги");
                        Console.WriteLine("2. Просмотреть все заказы");
                        Console.WriteLine("3. Добавить промокод");
                        Console.WriteLine("4. Добавить вопрос");
                        Console.WriteLine("5. Добавить отзыв");
                        Console.WriteLine("6. Просмотр таблиц");
                        Console.WriteLine("7. Просмотр всех вакансий");
                        Console.WriteLine("8. Просмотреть отчет о продажах");
                        Console.WriteLine("9. Просмотр полного анализа продаж");
                        Console.WriteLine("10. Выйти");
                   
                    }
                    else
                    {
                        Console.WriteLine("\nДоступные команды:");
                        Console.WriteLine("1. Просмотреть все услуги");
                        Console.WriteLine("2. Сделать заказ");
                        Console.WriteLine("3. Добавить отзыв");
                        Console.WriteLine("4. Просмотр отзывов и среднего рейтинга");
                        Console.WriteLine("5. Просмотр всех вакансий");
                        Console.WriteLine("6. Просмотр часто задаваемых вопросов (FAQ)");
                        Console.WriteLine("7. Просмотр актуальных скидок");
                        Console.WriteLine("8. Просмотр филиалов");
                        Console.WriteLine("9. Просмотр поставщиков");
                        Console.WriteLine("10. Просмотр моих заказов");
                        Console.WriteLine("11. Выйти");
                    }
                }

                Console.Write("\nВведите номер команды: ");
                var command = Console.ReadLine();

                if (!isAuthenticated)
                {
                    switch (command)
                    {
                        case "1":
                            RegisterUser();
                            break;
                        case "2":
                            AuthenticateUser();
                            break;
                        case "3":
                            Console.WriteLine("Выход из программы.");
                            return;
                        default:
                            Console.WriteLine("Неверная команда. Попробуйте снова.");
                            break;
                    }
                }
                else
                {
                    switch (command)
                    {
                        case "1":
                            ViewAllCars();
                            break;
                        case "2":
                            if (!isAdmin)
                            {
                                CreateOrder();
                            }
                            else
                            {
                                ViewAllOrders();
                            }
                            break;
                        case "3":
                            if (isAdmin)
                            {
                                AddPromoCode();
                            }
                            else
                            {
                                AddReview();
                            }
                            break;
                        case "4":
                            if (isAdmin)
                            {
                                AddQuestion();
                            }
                            else
                            {
                                ViewReviewsAndAverageRating(); 
                                break;
                            }
                            break;
                        case "5":
                            if (isAdmin)
                            {
                                ViewLogs();
                            }
                            else
                            {
                                ViewVacancies();
                            }
                            break;

                        case "6":
                            if (isAdmin)
                            {
                                Console.WriteLine("Введите имя таблицы для редактирования (например, 'Cars', 'Sales' и т.д.): ");
                            string tableName = Console.ReadLine();
                            ViewTableData(tableName);
                            }
                            else
                            {
                                ViewFAQ(); 
                               
                            }
                            break;
                        case "7":
                            if (isAdmin)
                            {
                                ViewVacancies();
                            }
                            else
                            {
                                ViewPromotions();
                                
                            }
                            break;
                        case "8":
                            if (isAdmin)
                            {
                                ViewSalesReport();
                               
                            }
                            else
                            {
                                ViewAllDepartments();
                            }
                            break;
                        case "9":
                            if (isAdmin)
                            {
                                ViewFullSalesAnalysis();
                               
                            }
                            else
                            {
                                ViewAllSuppliers(); 
                            }
                            break;
                        case "10":
                            if (isAdmin)
                            {
                                Console.WriteLine("Выход из программы.");
                                return;
                            }
                            else
                            {
                                ViewUserOrders();
                            }
                            break;
                        case "11":
                            Console.WriteLine("Неверная команда. Попробуйте снова.");
                            break;
                        default:
                            Console.WriteLine("Выход из программы.");
                            return;
                            //Console.WriteLine("Неверная команда. Попробуйте снова.");
                            //break;
                    }
                }
            }
        }
              
        private static void ViewAllCars()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Car_ID, Cars_name, Description FROM Cars";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nСписок всех услуг:");
                while (reader.Read())
                {
                    Console.WriteLine($"ID: {reader["Car_ID"]}, Название: {reader["Cars_name"]}, Описание: {reader["Description"]}");
                }
                reader.Close();
            }
        }

        private static void CreateOrder()
        {
            Console.Write("Введите ID услуги: ");
            int carId = int.Parse(Console.ReadLine());
            Console.Write("Введите количество: ");
            int quantity = int.Parse(Console.ReadLine());
            Console.Write("Введите дату заказа (yyyy-MM-dd): ");
            string orderDate = Console.ReadLine();

            // Получаем цену за единицу из таблицы Sales
            float pricePerUnit = GetCarPrice(carId);
            if (pricePerUnit == -1)
            {
                Console.WriteLine("Ошибка: Услуга с таким ID не найдена или цена не установлена.");
                return;
            }

            float totalPrice = pricePerUnit * quantity;

            Console.WriteLine($"Цена за единицу: {pricePerUnit}, Общее количество: {quantity}, Общая цена: {totalPrice}");

            // Запрашиваем промокод
            Console.Write("Введите промокод (если есть): ");
            string promoCode = Console.ReadLine();

            if (!string.IsNullOrEmpty(promoCode))
            {
                // Применение скидки по промокоду
                int discount = GetDiscountForPromoCode(promoCode);
                if (discount > 0)
                {
                    float discountAmount = totalPrice * discount / 100;
                    totalPrice -= discountAmount;
                    Console.WriteLine($"Применена скидка: {discount}%. Новая общая цена: {totalPrice}");
                }
                else
                {
                    Console.WriteLine("Неверный промокод.");
                }
            }

            // Вставляем заказ в базу данных
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO Sales (User_ID, Car_ID, Dep_ID, Data, Quantity, Price) 
                         VALUES (@userId, @carId, @depId, @orderDate, @quantity, @price)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userId", currentUserId); 
                command.Parameters.AddWithValue("@carId", carId);
                command.Parameters.AddWithValue("@depId", 1); 
                command.Parameters.AddWithValue("@orderDate", orderDate);
                command.Parameters.AddWithValue("@quantity", quantity);
                command.Parameters.AddWithValue("@price", totalPrice);

                connection.Open();
                int result = command.ExecuteNonQuery();
                Console.WriteLine(result > 0 ? "Заказ успешно создан!" : "Ошибка создания заказа.");
            }
        }

        private static int GetDiscountForPromoCode(string promoCode)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Discount FROM PromoCode WHERE Code = @promoCode";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@promoCode", promoCode);

                connection.Open();
                object result = command.ExecuteScalar(); 

                if (result != null)
                {
                    return Convert.ToInt32(result); 
                }
                else
                {
                    return 0; 
                }
            }
        }

        private static float GetCarPrice(int carId)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Price FROM Sales WHERE Car_ID = @carId ORDER BY Sale_ID DESC"; 
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@carId", carId);

                connection.Open();
                object result = command.ExecuteScalar(); // Получаем значение из базы данных

                if (result != null)
                {
                    return Convert.ToSingle(result); 
                }
                else
                {
                    return -1; // Возвращаем -1, если услуга с таким ID не найден в таблице Sales
                }
            }
        }

        // Просмотр всех заказов  для администратора
        private static void ViewAllOrders()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Sale_ID, User_ID, Car_ID, Quantity, Price, Data FROM Sales";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nСписок всех заказов:");
                while (reader.Read())
                {
                    Console.WriteLine($"ID: {reader["Sale_ID"]}, Пользователь: {reader["User_ID"]}, Услуга: {reader["Car_ID"]}, Количество: {reader["Quantity"]}, Цена: {reader["Price"]}, Дата: {reader["Data"]}");
                }
                reader.Close();
            }
        }

        private static void RegisterUser()
        {
            Console.Write("Введите имя пользователя: ");
            string userName = Console.ReadLine();
            Console.Write("Введите пароль: ");
            string password = Console.ReadLine();
            Console.Write("Введите email: ");
            string email = Console.ReadLine();
            Console.Write("Введите статус (например, 'active' или 'inactive'): ");
            string status = Console.ReadLine();
            Console.Write("Введите имя: ");
            string firstName = Console.ReadLine();
            Console.Write("Введите фамилию: ");
            string lastName = Console.ReadLine();
            Console.Write("Введите возраст: ");
            int age = int.Parse(Console.ReadLine());
            Console.Write("Введите телефон: ");
            string phone = Console.ReadLine();
            Console.Write("Введите адрес: ");
            string address = Console.ReadLine();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"INSERT INTO [User] (User_Name, PasswordHash, [Status], Email, FirstName, LastName, Age, Phone, Adress) 
                         VALUES (@userName, @password, @status, @Email, @FirstName, @LastName, @Age, @Phone, @Adress)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userName", userName);
                command.Parameters.AddWithValue("@password", password); 
                command.Parameters.AddWithValue("@status", status);
                command.Parameters.AddWithValue("@Email", email);
                command.Parameters.AddWithValue("@FirstName", firstName);
                command.Parameters.AddWithValue("@LastName", lastName);
                command.Parameters.AddWithValue("@Age", age);
                command.Parameters.AddWithValue("@Phone", phone);
                command.Parameters.AddWithValue("@Adress", address);

                connection.Open();
                int result = command.ExecuteNonQuery();
                Console.WriteLine(result > 0 ? "Регистрация успешна!" : "Ошибка регистрации.");
            }
        }

        private static int currentUserId;  // Переменная для хранения текущего User_ID

        private static void AuthenticateUser()
        {
            Console.Write("Введите имя пользователя: ");
            string userName = Console.ReadLine();
            Console.Write("Введите пароль: ");
            string password = Console.ReadLine();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT User_ID, PasswordHash FROM [User] WHERE User_Name = @userName";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userName", userName);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    string storedPassword = reader["PasswordHash"].ToString(); 
                    currentUserId = (int)reader["User_ID"]; // Сохраняем ID пользователя

                    if (storedPassword == password)
                    {
                        isAuthenticated = true;
                        isAdmin = userName.ToLower() == "admin";
                        Console.WriteLine("Авторизация успешна!");
                    }
                    else
                    {
                        Console.WriteLine("Неверный пароль.");
                    }
                }
                else
                {
                    Console.WriteLine("Пользователь не найден.");
                }
            }
        }

        // Просмотр заказов текущего пользователя
        private static void ViewUserOrders()
        {
            if (!isAuthenticated)
            {
                Console.WriteLine("Пожалуйста, авторизуйтесь для просмотра заказов.");
                return;
            }

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT Sale_ID, Car_ID, Quantity, Price, Data FROM Sales WHERE User_ID = @userId";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userId", currentUserId);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    Console.WriteLine("\nВаши заказы:");
                    while (reader.Read())
                    {
                        Console.WriteLine($"ID заказа: {reader["Sale_ID"]}, Услуга: {reader["Car_ID"]}, Количество: {reader["Quantity"]}, Цена: {reader["Price"]}, Дата: {reader["Data"]}");
                    }
                }
                else
                {
                    Console.WriteLine("У вас нет заказов.");
                }

                reader.Close();
            }
        }


        private static void AddQuestion()
        {
            Console.Write("Введите текст вопроса: ");
            string question = Console.ReadLine();
            Console.Write("Введите ответ: ");
            string answer = Console.ReadLine();
            Console.Write("Введите дату (yyyy-MM-dd): ");
            string date = Console.ReadLine();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Questions (Questions, Answer, Questions_Data) VALUES (@question, @answer, @date)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@question", question);
                command.Parameters.AddWithValue("@answer", answer);
                command.Parameters.AddWithValue("@date", date);

                connection.Open();
                int result = command.ExecuteNonQuery();
                Console.WriteLine(result > 0 ? "Вопрос успешно добавлен!" : "Ошибка добавления вопроса.");
            }
        }

        private static void ViewVacancies()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Vacancy";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nСписок вакансий:");
                while (reader.Read())
                {
                    Console.WriteLine($"ID: {reader["Vacancy_ID"]}, Название: {reader["Vacancy_name"]}, Описание: {reader["Vacancy_discriprion"]}, Востребованность: {reader["Need"]}");
                }
                reader.Close();
            }
        }


        private static void AddPromoCode()
        {
            Console.Write("Введите код промокода: ");
            string code = Console.ReadLine();
            Console.Write("Введите скидку (число): ");
            int discount = int.Parse(Console.ReadLine());

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO PromoCode (Code, Discount) VALUES (@code, @discount)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@code", code);
                command.Parameters.AddWithValue("@discount", discount);

                connection.Open();
                int result = command.ExecuteNonQuery();
                Console.WriteLine(result > 0 ? "Промокод успешно добавлен!" : "Ошибка добавления промокода.");
            }
        }

        private static void AddReview()
        {
            Console.Write("Введите ID пользователя: ");
            int userId = int.Parse(Console.ReadLine());
            Console.Write("Введите заголовок отзыва: ");
            string title = Console.ReadLine();
            Console.Write("Введите рейтинг (число от 1 до 5): ");
            int rating = int.Parse(Console.ReadLine());
            Console.Write("Введите текст отзыва: ");
            string reviewText = Console.ReadLine();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Исправленный запрос
                string query = "INSERT INTO Review (User_ID, Title, Rating, Need, Reviews_Data) VALUES (@userId, @title, @rating, @reviewText, @reviewDate)";
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@userId", userId);
                command.Parameters.AddWithValue("@title", title);
                command.Parameters.AddWithValue("@rating", rating);
                command.Parameters.AddWithValue("@reviewText", reviewText);
                command.Parameters.AddWithValue("@reviewDate", DateTime.Now);

                connection.Open();
                int result = command.ExecuteNonQuery();
                Console.WriteLine(result > 0 ? "Отзыв успешно добавлен!" : "Ошибка добавления отзыва.");
            }
        }

        private static void ViewReviewsAndAverageRating()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // Выводим все отзывы
                string query = "SELECT r.Title, r.Rating, r.Reviews_Data, u.User_Name FROM Review r JOIN [User] u ON r.User_ID = u.User_ID";
                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nОтзывы о сервисе:");
                while (reader.Read())
                {
                    Console.WriteLine($"Заголовок: {reader["Title"]}, Рейтинг: {reader["Rating"]}, Дата: {reader["Reviews_Data"]}, Пользователь: {reader["User_Name"]}");
                }
                reader.Close();

                query = "SELECT AVG(Rating) FROM Review";
                command = new SqlCommand(query, connection);
                object avgResult = command.ExecuteScalar();
                if (avgResult != DBNull.Value)
                {
                    Console.WriteLine($"\nСредний рейтинг: {avgResult}");
                }
            }
        }


        private static void ViewLogs()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM LogTable";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nЛоги действий:");
                while (reader.Read())
                {
                    Console.WriteLine($"ID: {reader["Log_ID"]}, Действие: {reader["Action"]}, Детали: {reader["Details"]}, Время: {reader["Timestamp"]}");
                }
                reader.Close();
            }
        }

        // Метод для просмотра всех записей в таблице
        private static void ViewTableData(string tableName)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = $"SELECT * FROM {tableName}";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine($"\nСодержимое таблицы {tableName}:");
                while (reader.Read())
                {
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        Console.Write($"{reader.GetName(i)}: {reader[i]} | ");
                    }
                    Console.WriteLine();
                }
                reader.Close();
            }
        }
    
        private static void ViewFAQ()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Questions, Answer, Questions_Data FROM Questions";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nЧасто задаваемые вопросы (FAQ):");
                while (reader.Read())
                {
                    Console.WriteLine($"Вопрос: {reader["Questions"]}");
                    Console.WriteLine($"Ответ: {reader["Answer"]}");
                    Console.WriteLine($"Дата добавления: {reader["Questions_Data"]}");
                    Console.WriteLine();
                }
                reader.Close();
            }
        }

        private static void ViewPromotions()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Code, Discount FROM PromoCode";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nАктуальные скидки:");
                while (reader.Read())
                {
                    Console.WriteLine($"Код: {reader["Code"]}, Скидка: {reader["Discount"]}%");
                }
                reader.Close();
            }
        }
   
        private static void ViewAllDepartments()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Dep_ID, Number, Dep_adress, [Open], [Close] FROM Department";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nСписок всех филиалов:");
                while (reader.Read())
                {
                    Console.WriteLine($"ID: {reader["Dep_ID"]}, Номер: {reader["Number"]}, Адрес: {reader["Dep_adress"]}, Часы работы: {reader["Open"]} - {reader["Close"]}");
                }
                reader.Close();
            }
        }
       
        private static void ViewAllSuppliers()
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Suppiier_ID, Name, Adress, Phone FROM Suppiier";
                SqlCommand command = new SqlCommand(query, connection);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nСписок всех поставщиков:");
                while (reader.Read())
                {
                    Console.WriteLine($"ID: {reader["Suppiier_ID"]}, Название: {reader["Name"]}, Адрес: {reader["Adress"]}, Телефон: {reader["Phone"]}");
                }
                reader.Close();
            }
        }



        //Хранимые процедуры
        private static void ViewSalesReport()
        {
            Console.Write("Введите начальную дату (2024-01-01): ");
            string startDateInput = Console.ReadLine();
            Console.Write("Введите конечную дату (2024-12-31): ");
            string endDateInput = Console.ReadLine();

            // Преобразуем строки в тип DateTime
            DateTime startDate = DateTime.Parse(startDateInput);
            DateTime endDate = DateTime.Parse(endDateInput);

            // Вызов хранимой процедуры SalesReport2
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("SalesReport2", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                // Добавляем параметры хранимой процедуры
                command.Parameters.AddWithValue("@StartDate", startDate);
                command.Parameters.AddWithValue("@EndDate", endDate);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nОтчёт о продажах:");

                while (reader.Read())
                {
                    Console.WriteLine($"Продажа ID: {reader["Sale_ID"]}, Пользователь: {reader["User_Name"]}, Адрес отдела: {reader["Dep_adress"]}, Услуга: {reader["Cars_name"]}, Количество: {reader["Quantity"]}, Цена: {reader["Price"]}, Дата: {reader["Data"]}");
                }

                reader.Close();
            }
        }

        private static void ViewFullSalesAnalysis()
        {
            Console.Write("Введите начальную дату (2024-01-01): ");
            string startDateInput = Console.ReadLine();
            Console.Write("Введите конечную дату (2024-12-20): ");
            string endDateInput = Console.ReadLine();

            // Преобразуем строки в тип DateTime
            DateTime startDate = DateTime.Parse(startDateInput);
            DateTime endDate = DateTime.Parse(endDateInput);

            // Вызов хранимой процедуры FullSalesAnalysis
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand("FullSalesAnalysis", connection)
                {
                    CommandType = CommandType.StoredProcedure
                };

                // Добавляем параметры хранимой процедуры
                command.Parameters.AddWithValue("@StartDate", startDate);
                command.Parameters.AddWithValue("@EndDate", endDate);

                connection.Open();
                SqlDataReader reader = command.ExecuteReader();

                Console.WriteLine("\nОтчёт о продажах:");

                // Чтение данных от хранимой процедуры SalesReport (первая часть)
                while (reader.Read())
                {
                    Console.WriteLine($"Продажа ID: {reader["Sale_ID"]}, Пользователь: {reader["User_Name"]}, Адрес отдела: {reader["Dep_adress"]}, Услуга: {reader["Cars_name"]}, Количество: {reader["Quantity"]}, Цена: {reader["Price"]}, Дата: {reader["Data"]}");
                }

                // Переход к следующему результату (для общей суммы продаж)
                if (reader.NextResult())
                {
                    // Чтение данных по общей сумме продаж
                    if (reader.Read())
                    {
                        double totalSales = reader.GetDouble(0); 
                        Console.WriteLine($"\nОбщая сумма продаж: {totalSales}");
                    }
                }

                reader.Close();
            }
        }
    }
}
