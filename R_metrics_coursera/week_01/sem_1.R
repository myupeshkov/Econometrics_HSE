# задаём векторы:
x <- c(23, 15, 46, 5)
z <- c(5, 6, NA, 8)

# NA — пропущенное значение

# среднее арифметическое
mean(x)
mean(z)

# среднее арифметическое с удалением пропущенных значений
mean(x, na.rm = TRUE)
mean(z, na.rm = TRUE)

# сумма всех элементов вектора
sum(x)
sum(z, na.rm = TRUE)

# создаем табличку с данными с именем d
d <- data.frame(rost = x, ves = z)
d


d[4, 1]  # элемент в 4-ой строке и 1-м столбце
d[3, 1]

d[2, ]  # вся вторая строка
d[, 2]  # весь второй столбец

d$rost  # столбец rost
d$ves  # столбец ves

# создаем список из трёх совершенно различных объектов
my_list <- list(a = 7, b = 10:20, table = d)

# достаем из списка объекты по имени
my_list$a
my_list$b
my_list$table
d$rost

# список немного отличается от вектора выбрать второй элемент списка:
my_list[[2]]

#работа с данными 

library(tidyverse) # графики + манипуляции с данными, включает dplyr, ggplot2, ...
library(skimr) # описательные статистики — стильная замена для psych
library(GGally)  # ещё графики
library(psych)

d <- cars  # встроенный набор данных по машинам
glimpse(d)  # что там?
help(cars)  # справка. действует для встроенных наборов данных
head(d)  # начало таблички d (первые 6 строк)
tail(d)  # хвостик таблички d
skim(d)  # среднее, мода, медиана и другое
describe(d) # тоже самое, только из пакета psych
ncol(d)  # число столбцов
nrow(d)  # число строк
str(d)  # структура (похоже на glimpse)

# среднее арифметическое
mean(d$speed)

# создадим новую переменные и поместим их все в табличку d2
d2 <- mutate(d, speed = 1.61 * speed, dist = 0.3 * dist, ratio = dist/speed)
glimpse(d2)

# графики
qplot(data = d2, dist)
qplot(data = d2, dist, xlab = "Длина тормозного пути (м)", ylab = "Число машин",
      main = "Данные по машинам 1920х")

qplot(data = d2, speed, dist)

# оценим модель парной регрессии y_i = \beta_1 + \beta_2 x_i + \varepsilon_i
model <- lm(data = d2, dist ~ speed)
model

coef(model)  # оценки бет
residuals(model)  # остатки (эпсилон с крышкой)
y_hat <- fitted(model)  # прогнозы (игрек с крышкой)
y <- d2$dist  # значения зависимой переменной

RSS <- deviance(model)  # так называют RSS
TSS <- sum((y - mean(y))^2)  # TSS
TSS
R2 <- 1 - RSS/TSS
R2
cor(y, y_hat)^2  # квадрат выборочной корреляции

X <- model.matrix(model)  # матрица регрессоров
X

# создаем новый набор данных
nd <- data.frame(speed = c(40, 60))
nd

# прогнозируем
predict(model, nd)

# добавляем на график линию регрессии
qplot(data = d2, speed, dist) + stat_smooth(method = "lm")


t <- swiss  # встроенный набор данных по Швейцарии
help(swiss)
glimpse(t)
describe(t)
ggpairs(t)  # все диаграммы рассеяния на одном графике

# множественная регрессия
model2 <- lm(data = t, Fertility ~ Agriculture + Education + Catholic)
coef(model2)  # оценки бет
fitted(model2)  # прогнозы
residuals(model2)  # остатки
deviance(model2)  # RSS

report <- summary(model2)
report
report$r.squared  # R^2

# второй способ расчета R^2
cor(t$Fertility, fitted(model2))^2

# создаем новый набор данных
nd2 <- data.frame(Agriculture = 0.5, Catholic = 0.5, Education = 20)
# прогнозируем
predict(model2, nd2)

