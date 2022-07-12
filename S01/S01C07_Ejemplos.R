#Ejemplos

#En esta sección, describimos dos ejemplos populares de probabilidad discreta: el problema de Monty Hall y el problema del cumpleaños. Usamos R para ayudar a ilustrar los conceptos matemáticos.

#Problema de Monty Hall

#En la década de 1970, hubo un programa de juegos llamado "Hagamos un trato" y Monty Hall fue el presentador. En algún momento del juego, se pidió a los concursantes que eligieran una de las tres puertas. Detrás de una puerta había un premio. Las otras puertas tenían una cabra detrás de ellas para mostrarle al concursante que habían perdido. Después de que el concursante eligiera una puerta, antes de revelar si la puerta elegida contenía un premio, Monty Hall abría una de las dos puertas restantes y le mostraba al concursante que no había ningún premio detrás de esa puerta. Luego preguntaba "¿Quieres cambiar de puerta?" ¿Qué harías?
  
#Podemos usar la probabilidad para mostrar que si se queda con la elección de la puerta original, sus posibilidades de ganar un premio siguen siendo de 1 en 3. Sin embargo, si cambia a la otra puerta, ¡sus posibilidades de ganar se duplican a 2 en 3! Esto parece contradictorio. Mucha gente piensa incorrectamente que ambas posibilidades son 1 en 2 ya que está eligiendo entre 2 opciones. Puede ver una explicación matemática detallada en Khan Academy49 o leer una en Wikipedia50. A continuación, usamos una simulación de Monte Carlo para ver qué estrategia es mejor. Tenga en cuenta que este código está escrito más largo de lo que debería ser con fines pedagógicos.

#Comencemos con la estrategia del palo:

B <- 10000
monty_hall <- function(strategy){
  doors <- as.character(1:3)
  prize <- sample(c("carro", "cabra", "cabra"))
  prize_door <- doors[prize == "carro"]
  my_pick  <- sample(doors, 1)
  show <- sample(doors[!doors %in% c(my_pick, prize_door)],1)
  stick <- my_pick
  stick == prize_door
  switch <- doors[!doors%in%c(my_pick, show)]
  choice <- ifelse(strategy == "stick", stick, switch)
  choice == prize_door
}
stick <- replicate(B, monty_hall("stick"))
mean(stick)
#> [1] 0.342
switch <- replicate(B, monty_hall("switch"))
mean(switch)


#A medida que escribimos el código, notamos que las líneas que comienzan con my_pick y show no tienen influencia en la última operación lógica cuando nos atenemos a nuestra elección original de todos modos.

#A partir de esto debemos darnos cuenta de que la probabilidad es de 1 en 3, con lo que comenzamos. Cuando cambiamos, la estimación de Monte Carlo confirma el cálculo de 2/3. 

#Esto nos ayuda a obtener una idea al mostrar que estamos eliminando una puerta, muestra, que definitivamente no es un ganador de nuestras elecciones. 

#También vemos que a menos que lo hagamos bien cuando elegimos por primera vez, usted gana: 1 - 1/3 = 2/3.


#Problema de cumpleaños

#Supongamos que estás en un salón de clases con 50 personas. Si asumimos que este es un grupo de 50 personas seleccionado al azar, ¿cuál es la probabilidad de que al menos dos personas tengan el mismo cumpleaños? Aunque es algo avanzado, podemos deducirlo matemáticamente. Haremos esto más tarde. Aquí usamos una simulación de Monte Carlo. Para simplificar, asumimos que nadie nació el 29 de febrero. En realidad, esto no cambia mucho la respuesta.

#Primero, tenga en cuenta que los cumpleaños se pueden representar como números entre 1 y 365, por lo que una muestra de 50 cumpleaños se puede obtener así:


n <- 50
bdays <- sample(1:365, n, replace = TRUE)


#Para verificar si en este conjunto particular de 50 personas tenemos al menos dos con el mismo cumpleaños, podemos usar la función duplicate, que devuelve VERDADERO siempre que un elemento de un vector sea un duplicado. Aquí hay un ejemplo:

duplicated(c(1,2,3,1,4,3,5))

#La segunda vez que aparecen 1 y 3, obtenemos un VERDADERO. Entonces, para verificar si dos cumpleaños fueron iguales, simplemente usamos las funciones any y duplicated como esta:

any(duplicated(bdays))

#En este caso, vemos que sí sucedió. Al menos dos personas tenían el mismo cumpleaños.

#Para estimar la probabilidad de un cumpleaños compartido en el grupo, repetimos este experimento muestreando conjuntos de 50 cumpleaños una y otra vez:


B <- 10000

same_birthday <- function(n){
  bdays <- sample(1:365, n, replace=TRUE)
  any(duplicated(bdays))
}

results <- replicate(B, same_birthday(50))

mean(results)


#¿Esperabas que la probabilidad fuera tan alta?
  
#La gente tiende a subestimar estas probabilidades. Para tener una intuición de por qué es tan alto, piense en lo que sucede cuando el tamaño del grupo es cercano a 365. En esta etapa, nos quedamos sin días y la probabilidad es uno.

#Digamos que queremos usar este conocimiento para apostar con amigos sobre dos personas que tienen el mismo cumpleaños en un grupo de personas. ¿Cuándo son las posibilidades mayores al 50%? ¿Más grande que el 75%?
  
 #Vamos a crear una tabla de búsqueda. Podemos crear rápidamente una función para calcular esto para cualquier tamaño de grupo:

compute_prob <- function(n, B=10000){
  results <- replicate(B, same_birthday(n))
  mean(results)
}

#Usando la función sapply, podemos realizar operaciones por elementos en cualquier función:

n <- seq(1,60)
prob <- sapply(n, compute_prob)


#Ahora podemos hacer una gráfica de las probabilidades estimadas de que dos personas tengan el mismo cumpleaños en un grupo de tamaño n:

library(tidyverse)
prob <- sapply(n, compute_prob)
qplot(n, prob)


#Ahora calculemos las probabilidades exactas en lugar de usar aproximaciones de Monte Carlo. No solo obtenemos la respuesta exacta usando matemáticas, sino que los cálculos son mucho más rápidos ya que no tenemos que generar experimentos.

#Para simplificar las matemáticas, en lugar de calcular la probabilidad de que suceda, calcularemos la probabilidad de que no suceda. Para esto, usamos la regla de la multiplicación.

#Comencemos con la primera persona. La probabilidad de que la persona 1 tenga un cumpleaños único es 1. La probabilidad de que la persona 2 tenga un cumpleaños único, dado que la persona 1 ya cumplió uno, es 364/365. Luego, dado que las dos primeras personas tienen cumpleaños únicos, la persona 3 tiene 363 días para elegir. Continuamos de esta manera y encontramos que las posibilidades de que las 50 personas tengan un cumpleaños único son:

#1*364/365*363/365.....365-n+1/365

#Podemos escribir una función que haga esto para cualquier número:

exact_prob <- function(n){
  prob_unique <- seq(365,365-n+1)/365 
  1 - prod( prob_unique)
}

eprob <- sapply(n, exact_prob)

qplot(n, prob) + geom_line(aes(n, eprob), col = "red")


#Esta gráfica muestra que la simulación de Monte Carlo proporcionó una muy buena estimación de la probabilidad exacta. Si no hubiera sido posible calcular las probabilidades exactas, aún habríamos podido estimar con precisión las probabilidades.

