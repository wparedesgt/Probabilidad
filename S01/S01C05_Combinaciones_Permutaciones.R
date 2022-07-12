#Combinaciones y permutaciones

#En nuestro primer ejemplo, imaginamos una urna con cinco cuentas. Como recordatorio, para calcular la distribución de probabilidad de un sorteo, simplemente enumeramos todas las posibilidades. Eran 5 y entonces, para cada evento, contamos cuantas de estas posibilidades estaban asociadas al evento. La probabilidad resultante de elegir una cuenta azul es 3/5 porque de los cinco resultados posibles, tres eran azules.

#Para casos más complicados, los cálculos no son tan sencillos. Por ejemplo, ¿cuál es la probabilidad de que si saco cinco cartas sin reposición, saque todas las cartas del mismo palo, lo que se conoce como “color” en el póquer? En un curso de probabilidad discreta, aprende la teoría sobre cómo hacer estos cálculos. Aquí nos enfocamos en cómo usar el código R para calcular las respuestas.

#Primero, construyamos una baraja de cartas. Para ello, utilizaremos las funciones expand.grid y paste. Usamos pegar para crear cadenas uniendo cadenas más pequeñas. Para hacer esto, tomamos el número y el palo de una carta y creamos el nombre de la carta así:

number <- "Tres"
suit <- "Corazones"
paste(number, suit)

#La funcion paste, también funciona en pares de vectores realizando la operación por elementos:

paste(letters[1:5], as.character(1:5))

#La función expand.grid nos da todas las combinaciones de entradas de dos vectores. Por ejemplo, si tienes pantalones azules y negros y camisas blancas, grises y de cuadros, todas tus combinaciones son:


expand.grid(pantalones = c("Azul", "Negro"), camisas = c("Blanca", "Gris", "Cuadros"))


#Ejercicio generar una baraja de cartas con estas funciones


tipos <- c("Diamantes", "Treboles", "Corazones", "Espadas")
numeros <- c("As", "Dos", "Tres", "Cuatro", "Cinco", "Seis", "Siete", 
             "Ocho", "Nueve", "Diez", "Jack", "Reina", "Rey")
deck <- expand.grid(numero=numeros, tipo=tipos)
deck <- paste(deck$numero, deck$tipo)

#Con la baraja construida, podemos comprobar que la probabilidad de que salga un rey en la primera carta sea 1/13 calculando la proporción de resultados posibles que satisfacen nuestra condición:


reyes <- paste("Rey", tipos)
mean(deck %in% reyes)

#Ahora, ¿qué tal la probabilidad condicional de que la segunda carta sea un rey dado que la primera fue un rey? Anteriormente, deducimos que si un Rey ya está fuera de la baraja y quedan 51, entonces esta probabilidad es 3/51. Confirmemos enumerando todos los resultados posibles.

#Para hacer esto, podemos usar la función de permutations del paquete gtools. Para cualquier lista de tamaño n, esta función calcula todas las diferentes combinaciones que podemos obtener cuando seleccionamos r elementos. Aquí están todas las formas en que podemos elegir dos números de una lista que consta de 1,2,3:

library(gtools)
permutations(3, 2)

#Tenga en cuenta que el orden importa aquí: 3,1 es diferente de 1,3. Además, tenga en cuenta que (1,1), (2,2) y (3,3) no aparecen porque una vez que elegimos un número, no puede volver a aparecer.


#Ejercicio agregar un vector. Deseamos ver cinco números de teléfono aleatorios de siete dígitos de todos los números de teléfono posibles (sin repeticiones):

#En lugar de usar los números del 1 al 10, el valor predeterminado, usa lo que proporcionamos a través de v: los dígitos del 0 al 9.

todos_numeros_telefonos <- permutations(10, 7, v = 0:9)
n <- nrow(todos_numeros_telefonos)
index <- sample(n, 5)
todos_numeros_telefonos[index,]



#Para calcular todas las formas posibles en que podemos elegir dos cartas cuando el orden es importante, escribimos:

manos <- permutations(52, 2, v= deck)

#Está es una matriz con dos columnas y 2652 filas. Con una matriz podemos obtener la primera y la segunda carta así:

primera_carta <- manos[,1]
segunda_carta <- manos[,2]

#Ahora los casos en los que la primera mano fue un rey se pueden calcular así:

reyes <- paste("Rey", tipos)
sum(primera_carta %in% reyes)

#Para obtener la probabilidad condicional, calculamos qué fracción de estas tienen un Rey en la segunda carta:

sum(primera_carta %in% reyes & segunda_carta %in% reyes) / sum(primera_carta %in% reyes)


#Que es exactamente 3/51, como ya habíamos deducido. Tenga en cuenta que el código anterior es equivalente a:

mean(primera_carta %in% reyes & segunda_carta %in% reyes) / mean(primera_carta %in% reyes)

#que usa media en lugar de suma y es una versión R de:

#Pr(A and B)/ Pr(A)

#¿Qué tal si el orden no importa? Por ejemplo, en Blackjack, si obtiene un As y una figura en el primer sorteo, se llama Natural 21 y gana automáticamente. Si quisiéramos calcular la probabilidad de que esto suceda, enumeraríamos las combinaciones, no las permutaciones, ya que el orden no importa.

combinations(3,2)

#En la segunda línea, el resultado no incluye (2,1) porque (1,2) ya se enumeró. Lo mismo se aplica a (3,1) y (3,2).

#Entonces, para calcular la probabilidad de un Natural 21 en Blackjack, podemos hacer esto:


ases <- paste("As", tipos)

facecard <- c("Rey", "Reina", "Jack", "Diez")
facecard <- expand.grid(numero = facecard, tipo = tipos)
facecard <- paste(facecard$numero, facecard$tipo)

manos <- combinations(52, 2, v = deck)
mean(manos[,1] %in% ases & manos[,2] %in% facecard)


#En la última línea, asumimos que el As viene primero. Esto es solo porque conocemos la forma en que la combinación enumera las posibilidades y enumerará este caso primero. Pero para estar seguros, podríamos haber escrito esto y producido la misma respuesta:

mean((manos[,1] %in% ases & manos[,2] %in% facecard) |
       (manos[,2] %in% ases & manos[,1] %in% facecard))


