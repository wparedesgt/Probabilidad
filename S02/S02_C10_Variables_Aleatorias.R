#Variables Aleatorias

#Las variables aleatorias son resultados numéricos resultantes de procesos aleatorios. Podemos generar fácilmente variables aleatorias usando algunos de los ejemplos simples que hemos mostrado. Por ejemplo, defina X como 1 si una cuenta es azul y roja de lo contrario:

cuentas <- rep( c("rojas", "azules"), times = c(2,3))
X <- ifelse(sample(cuentas, 1) == "azules", 1, 0)

#Aquí X es una variable aleatoria: cada vez que seleccionamos una nueva cuenta, el resultado cambia aleatoriamente. Vea abajo:

ifelse(sample(cuentas, 1) == "azules", 1, 0)
#> [1] 1
ifelse(sample(cuentas, 1) == "azules", 1, 0)
#> [1] 0
ifelse(sample(cuentas, 1) == "azules", 1, 0)
#> [1] 0

#A veces es 1 a veces es 0

##Modelos de Muestreo

#Muchos procedimientos de generación de datos, aquellos que producen los datos que estudiamos, pueden modelarse bastante bien como si fueran sacados de una urna. Por ejemplo, podemos modelar el proceso de sondeo de votantes probables extrayendo 0 (republicanos) y 1 (demócratas) de una urna que contiene el código 0 y 1 para todos los votantes probables. 

#En los estudios epidemiológicos, a menudo asumimos que los sujetos de nuestro estudio son una muestra aleatoria de la población de interés. Los datos relacionados con un resultado específico se pueden modelar como una muestra aleatoria de una urna que contiene el resultado de toda la población de interés. 

#De manera similar, en la investigación experimental, a menudo asumimos que los organismos individuales que estamos estudiando, por ejemplo, gusanos, moscas o ratones, son una muestra aleatoria de una población más grande. 

#Los experimentos aleatorios también se pueden modelar mediante sorteos de una urna dada la forma en que los individuos se asignan a los grupos: cuando se asigna, se extrae el grupo al azar. 

#Por lo tanto, los modelos de muestreo son omnipresentes en la ciencia de datos. Los juegos de casino ofrecen una gran cantidad de ejemplos de situaciones del mundo real en las que se utilizan modelos de muestreo para responder preguntas específicas. Por lo tanto, comenzaremos con tales ejemplos.


#Supongamos que un casino muy pequeño lo contrata para consultar si deben instalar ruedas de ruleta. Para simplificar el ejemplo, supondremos que jugarán 1000 personas y que el único juego que puede jugar en la rueda de la ruleta es apostar al rojo o al negro. 

#El casino quiere que pronostiques cuánto dinero ganarán o perderán. Quieren un rango de valores y, en particular, quieren saber cuál es la probabilidad de perder dinero. Si esta probabilidad es demasiado alta, dejarán de instalar ruedas de ruleta.

#Vamos a definir una variable aleatoria S que representará las ganancias totales del casino. 

#Comencemos construyendo la urna. 

#Una rueda de ruleta tiene 18 casillas rojas, 18 casillas negras y 2 verdes. Así que jugar un color en un juego de ruleta es equivalente a sacar de esta urna:

color <- rep(c("Negras", "Rojas", "Verdes"), c(18, 18, 2))


#Los 1000 resultados de 1000 personas jugando son sorteos independientes de esta urna. Si sale rojo, el jugador gana y el casino pierde un dólar, por lo que sacamos -$1. 

#De lo contrario, el casino gana un dólar y nosotros sacamos $1. Para construir nuestra variable aleatoria S, podemos usar este código:

n <- 1000
X <- sample(ifelse(color == "Rojas", -1, 1),  n, replace = TRUE)
X[1:10]

#Como conocemos las proporciones de 1 y -1, podemos generar todo con una línea de código, sin definir el color:

X <- sample(c(-1,1), n, replace = TRUE, prob=c(9/19, 10/19))

#Llamamos a esto un modelo de muestreo ya que estamos modelando el comportamiento aleatorio de la ruleta con el muestreo de los sorteos de una urna. Las ganancias totales S, son simplemente la suma de estos 1000 sorteos independientes:

X <- sample(c(-1,1), n, replace = TRUE, prob=c(9/19, 10/19))
S <- sum(X)
S

##La distribución de probabilidad de una variable aleatoria


#Si ejecuta el código anterior, verá que S cambia cada vez. 

#Esto se debe, por supuesto, a que S es una variable aleatoria. 

#La distribución de probabilidad de una variable aleatoria nos dice la probabilidad de que el valor observado caiga en cualquier intervalo dado. 

#Entonces, por ejemplo, si queremos saber la probabilidad de que perdamos dinero, estamos preguntando la probabilidad de que S esté en el intervalo S<0. 

#Tenga en cuenta que si podemos definir una función de distribución acumulativa F(a)=Pr(S≤a), entonces podremos responder cualquier pregunta relacionada con la probabilidad de los eventos definidos por nuestra variable aleatoria S, incluido el evento S<0 . 

#Llamamos a esta F la función de distribución de la variable aleatoria.

#Podemos estimar la función de distribución de la variable aleatoria S usando una simulación de Monte Carlo para generar muchas realizaciones de la variable aleatoria. Con este código, ejecutamos el experimento de hacer que 1000 personas jueguen a la ruleta, una y otra vez, específicamente B=10000 veces:


n <- 1000
B <- 10000
ganadores_ruleta <- function(n){
  X <- sample(c(-1,1), n, replace = TRUE, prob=c(9/19, 10/19))
  sum(X)
}

S <- replicate(B, ganadores_ruleta(n))

#Ahora podemos preguntarnos lo siguiente: en nuestras simulaciones, ¿con qué frecuencia obtuvimos sumas menores o iguales a a?

#mean(S <= a)

#Esta será una muy buena aproximación de F(a) y podemos responder fácilmente a la pregunta del casino: ¿qué probabilidad hay de que perdamos dinero?

#Podemos ver que es bastante bajo:

mean(S<0)

#Podemos visualizar la distribución de S creando un histograma que muestre la probabilidad F(b)−F(a) para varios intervalos (a,b] :

Fa <- mean(S<0) #Probabilidad de Perder
Fb <- mean(S>0) #Probabilidad de Ganar

#Grafico Histograma 

hist(S)


#Vemos que la distribución parece ser aproximadamente normal. Una gráfica qq confirmará que la aproximación normal es casi una aproximación perfecta para esta distribución. 

#Si, de hecho, la distribución es normal, entonces todo lo que necesitamos para definir la distribución es el promedio y la desviación estándar. Debido a que tenemos los valores originales a partir de los cuales se crea la distribución, podemos calcularlos fácilmente con mean(S) y sd(S). La curva azul que ve añadida al histograma de arriba es una densidad normal con este promedio y desviación estándar.

#Este promedio y esta desviación estándar tienen nombres especiales. Se conocen como el valor esperado y el error estándar de la variable aleatoria S. 

#Hablaremos más sobre esto en la siguiente sección.

#La teoría estadística proporciona una forma de derivar la distribución de variables aleatorias definidas como sorteos aleatorios independientes de una urna.

#Específicamente, en nuestro ejemplo anterior, podemos mostrar que (S+n)/2 sigue una distribución binomial. Por lo tanto, no necesitamos ejecutar simulaciones de MonteCarlo para conocer la distribución de probabilidad de S. 

#Hicimos esto con fines ilustrativos.

#Podemos usar la función dbinom y pbinom para calcular las probabilidades exactamente. Por ejemplo, para calcular Pr(S<0) observamos que:

#Pr(S<0)=Pr((S+n)/2<(0+n)/2)

#Y podemos usar pbinom para calcular

#Pr(S≤0)

n <- 1000
pbinom(n/2, size = n, prob = 10/19)

#Debido a que esta es una función de probabilidad discreta, para obtener Pr(S<0) en lugar de Pr(S≤0), escribimos:

pbinom(n/2-1, size = n, prob = 10/19)


#Para los detalles de la distribución binomial, puede consultar cualquier libro de probabilidad básica o incluso Wikipedia.

#Aquí no cubrimos estos detalles. 

#En cambio, discutiremos una aproximación increíblemente útil proporcionada por la teoría matemática que se aplica generalmente a sumas y promedios de extracciones de cualquier urna: 

#El Teorema del Límite Central (CLT).


###Distribuciones versus distribuciones de probabilidad


#Antes de continuar, hagamos una importante distinción y conexión entre la distribución de una lista de números y una distribución de probabilidad. 

#En el capítulo de visualización, describimos cómo cualquier lista de números x1,…,xn tiene una distribución. 
#La definición es bastante sencilla. 

#Definimos F(a) como la función que nos dice qué proporción de la lista es menor o igual que a. Debido a que son resúmenes útiles cuando la distribución es aproximadamente normal, definimos el promedio y la desviación estándar. Estos se definen con una operación directa del vector que contiene la lista de números x:

m <- sum(X)/length(X)
s <- sqrt(sum((X - m)^2) / length(X))

#Una variable aleatoria X tiene una función de distribución. Para definir esto, no necesitamos una lista de números. Es un concepto teórico. En este caso, definimos la distribución como la F(a) que responde a la pregunta: 

#¿cuál es la probabilidad de que X sea menor o igual que a?
  
#No hay lista de números.

#Sin embargo, si X se define sacando de una urna con números, entonces hay una lista: la lista de números dentro de la urna. 

#En este caso, la distribución de esa lista es la distribución de probabilidad de X y el promedio y la desviación estándar de esa lista son el valor esperado y el error estándar de la variable aleatoria.

#Otra forma de pensar que no involucra una urna es ejecutar una simulación de Monte Carlo y generar una lista muy grande de resultados de X. 

#Estos resultados son una lista de números. La distribución de esta lista será una muy buena aproximación de la distribución de probabilidad de X.

#Cuanto más larga sea la lista, mejor será la aproximación. El promedio y la desviación estándar de esta lista se aproximarán al valor esperado y al error estándar de la variable aleatoria.


###Notación para variables aleatorias

#En los libros de texto de estadística, las letras mayúsculas se utilizan para indicar variables aleatorias y aquí seguimos esta convención. 

#Se utilizan letras minúsculas para los valores observados. 

#Verá una notación que incluye ambos. 

#Por ejemplo, verá eventos definidos como X≤x. 

#Aquí X es una variable aleatoria, por lo que es un evento aleatorio, y x es un valor arbitrario y no aleatorio. 

#Entonces, por ejemplo, X podría representar el número en una tirada de dado y x representará un valor real, vemos 1, 2, 3, 4, 5 o 6. 

#Entonces, en este caso, la probabilidad de X = x es 1/6 independientemente del valor observado x. 

#Esta notación es un poco extraña porque, cuando hacemos preguntas sobre probabilidad, X no es una cantidad observada. 

#En cambio, es una cantidad aleatoria que veremos en el futuro. Podemos hablar sobre lo que esperamos que sea, qué valores son probables, pero no qué es. 

#Pero una vez que tenemos datos, vemos una realización de X. Entonces, los científicos de datos hablan de lo que podría haber sido después de ver lo que realmente sucedió.

###El valor esperado y el error estándar

#Hemos descrito modelos de muestreo para sorteos. 

#Ahora repasaremos la teoría matemática que nos permite aproximar las distribuciones de probabilidad para la suma de sorteos. 

#Una vez que hagamos esto, podremos ayudar al casino a predecir cuánto dinero ganarán. 

#El mismo enfoque que usamos para la suma de los sorteos será útil para describir la distribución de los promedios y la proporción que necesitaremos para comprender cómo funcionan las encuestas.

#El primer concepto importante a aprender es el valor esperado. En los libros de estadística, es común usar la letra E así:

#E[X]

#para denotar el valor esperado de la variable aleatoria X

#Una variable aleatoria variará alrededor de su valor esperado de tal manera que si toma el promedio de muchos, muchos sorteos, el promedio de los sorteos se aproximará al valor esperado, acercándose cada vez más a medida que haga más sorteos.

#La estadística teórica proporciona técnicas que facilitan el cálculo de los valores esperados en diferentes circunstancias. Por ejemplo, una fórmula útil nos dice que el valor esperado de una variable aleatoria definida por un sorteo es el promedio de los números en la urna. En la urna que se usa para modelar las apuestas al rojo en la ruleta, tenemos 20 dólares de uno y 18 dólares de uno menos. El valor esperado es así:

#E[X]=(20+−18)/38

#que es alrededor de 5 centavos. 

#Es un poco contradictorio decir que X varía alrededor de 0,05, cuando los únicos valores que toma son 1 y -1.

#Una forma de dar sentido al valor esperado en este contexto es darse cuenta de que si jugamos una y otra vez, el casino gana, en promedio, 5 centavos por juego. Una simulación de Monte Carlo lo confirma:

B <- 10^6
x <- sample(c(-1,1), B, replace = TRUE, prob=c(9/19, 10/19))
mean(x)

#En general, si la urna tiene dos resultados posibles, digamos a y b, con proporciones p y 1−p respectivamente, el promedio es:


#E[X]=ap+b(1−p)

#Para ver esto, observe que si hay n cuentas en la urna, entonces tenemos np como y n(1−p) bs y como el promedio es la suma, n×a×p+n×b×(1−p ), dividido por el total n, obtenemos que la media es ap+b(1−p).

A#hora, la razón por la que definimos el valor esperado es porque esta definición matemática resulta útil para aproximar las distribuciones de probabilidad de la suma, que luego es útil para describir la distribución de promedios y proporciones. 

#El primer dato útil es que el valor esperado de la suma de los sorteos es:

#número de sorteos × promedio de los números en la urna

#Entonces, si 1000 personas juegan a la ruleta, el casino espera ganar, en promedio, alrededor de 1000 × $0,05 = $50. Pero este es un valor esperado. ¿Qué tan diferente puede ser una observación del valor esperado? El casino realmente necesita saber esto. ¿Cuál es el abanico de posibilidades? Si los números negativos son demasiado probables, no instalarán ruedas de ruleta.

#La teoría estadística responde una vez más a esta pregunta. El error estándar (SE) nos da una idea del tamaño de la variación alrededor del valor esperado. En los libros de estadística, es común usar:

#SE[X]

#para denotar el error estándar de una variable aleatoria.

#Si nuestros sorteos son independientes, entonces el error estándar de la suma viene dado por la ecuación:

#raiz cuadrada del número de sorteos × desviación estándar de los números en la urna

#Usando la definición de desviación estándar, podemos deducir, con un poco de matemática, que si una urna contiene dos valores a y b con proporciones p y (1−p), respectivamente, la desviación estándar es:


#∣b−a∣√p( 1 − p).


#Entonces, en nuestro ejemplo de la ruleta, la desviación estándar de los valores dentro de la urna es:

#∣1−( − 1)∣√10/ 1 9×9/19

#o:

2 * sqrt(90)/19


#El error estándar nos dice la diferencia típica entre una variable aleatoria y su expectativa. Dado que un sorteo es obviamente la suma de un solo sorteo, podemos usar la fórmula anterior para calcular que la variable aleatoria definida por un sorteo tiene un valor esperado de 0.05 y un error estándar de aproximadamente 1. 

#Esto tiene sentido ya que obtenemos 1 o -1, con 1 ligeramente favorecido sobre -1.

#Usando la fórmula anterior, la suma de 1000 personas jugando tiene un error estándar de alrededor de $32:

n <- 1000
sqrt(n) * 2 * sqrt(90)/19

#Como resultado, cuando 1000 personas apuestan al rojo, se espera que el casino gane $50 con un error estándar de $32. Por lo tanto, parece una apuesta segura. Pero aún no hemos respondido a la pregunta: 

#¿qué probabilidad hay de perder dinero? Aquí el CLT ayudará. Central Limit Theorem

#Nota avanzada: antes de continuar, debemos señalar que los cálculos de probabilidad exactos para las ganancias del casino se pueden realizar con la distribución binomial. 

#Sin embargo, aquí nos enfocamos en el CLT, que generalmente se puede aplicar a sumas de variables aleatorias de una manera que la distribución binomial no puede.

###Desviacion Estandar de la poblacion vrs la Desviacion Estardard de la Muestra 

#La desviación estándar de una lista x (abajo usamos alturas como ejemplo) se define como la raíz cuadrada del promedio de las diferencias al cuadrado:

library(dslabs)
x <- heights$height
m <- mean(x)
s <- sqrt(mean((x-m)^2))

#Sin embargo, tenga en cuenta que la función sd devuelve un resultado ligeramente diferente:

identical(s, sd(x))
#> [1] <FALSE
s-sd(x)

#Esto se debe a que la función sd R no devuelve la sd de la lista, sino que utiliza una fórmula que estima las desviaciones estándar de una población a partir de una muestra aleatoria X1,…,XN que, por razones no discutidas aquí, divide la suma de los cuadrados por el N−1.


#Puede ver que este es el caso escribiendo:

n <- length(x)
s-sd(x)*sqrt((n-1) / n)

#Para toda la teoría discutida aquí, debe calcular la desviación estándar real como se define:

sqrt(mean((x-m)^2))

#Así que tenga cuidado al usar la función sd en R. 

#Sin embargo, tenga en cuenta que a lo largo del libro a veces usamos la función sd cuando realmente queremos la SD real. 

#Esto se debe a que cuando el tamaño de la lista es grande, estos dos son prácticamente equivalentes ya que √(N−1)/N≈1.

###Teorema del límite central CLT


#El teorema del límite central (CLT) nos dice que cuando el número de sorteos, también llamado tamaño de la muestra, es grande, la distribución de probabilidad de la suma de los sorteos independientes es aproximadamente normal. 

#Debido a que los modelos de muestreo se utilizan para tantos procesos de generación de datos, el CLT se considera una de las ideas matemáticas más importantes de la historia.

#Anteriormente, discutimos que si sabemos que la distribución de una lista de números se aproxima a la distribución normal, todo lo que necesitamos para describir la lista es el promedio y la desviación estándar.

#También sabemos que lo mismo se aplica a las distribuciones de probabilidad. Si una variable aleatoria tiene una distribución de probabilidad que se aproxima a la distribución normal, todo lo que necesitamos para describir la distribución de probabilidad es el promedio y la desviación estándar, denominados valor esperado y error estándar.

#Anteriormente ejecutamos esta simulación de Monte Carlo:

n <- 1000
B <- 10000
ganadores_ruleta <- function(n){
  X <- sample(c(-1,1), n, replace = TRUE, prob=c(9/19, 10/19))
  sum(X)
}
S <- replicate(B, ganadores_ruleta(n))

#El Teorema del Límite Central (CLT) nos dice que la suma S se aproxima mediante una distribución normal.

#Usando las fórmulas anteriores, sabemos que el valor esperado y el error estándar son:

n * (20-18)/38 
#> [1] 52.6
sqrt(n) * 2 * sqrt(90)/19 
#> [1] 31.6

#Los valores teóricos anteriores coinciden con los obtenidos con la simulación Monte Carlo:

mean(S)
#> [1] 52.2
sd(S)

#Usando el CLT, podemos omitir la simulación de Monte Carlo y en su lugar calcular la probabilidad de que el casino pierda dinero usando esta aproximación:

mu <- n * (20-18)/38
se <-  sqrt(n) * 2 * sqrt(90)/19 
pnorm(0, mu, se)
#> [1] 0.0478

 
#Que también está muy de acuerdo con nuestro resultado de Monte Carlo:

mean(S < 0)

####¿Qué tan grande es grande en el teorema del límite central?

#El CLT funciona cuando el número de sorteos es grande. Pero grande es un término relativo. En muchas circunstancias, tan solo 30 sorteos son suficientes para que el CLT sea útil. En algunos casos específicos, tan solo 10 es suficiente. Sin embargo, estas no deben considerarse reglas generales. Tenga en cuenta, por ejemplo, que cuando la probabilidad de éxito es muy pequeña, necesitamos tamaños de muestra mucho más grandes.

#A modo de ilustración, consideremos la lotería, no en la de feria de cartones sino en las nacionales que hacen en los paises. En la lotería, las posibilidades de ganar son menos de 1 en un millón. Miles de personas juegan por lo que el número de sorteos es muy grande. Sin embargo, el número de ganadores, la suma de los sorteos, oscila entre 0 y 4. Esta suma ciertamente no se aproxima bien mediante una distribución normal, por lo que la CLT no se aplica, incluso con un tamaño de muestra muy grande. Esto es generalmente cierto cuando la probabilidad de éxito es muy baja. En estos casos, la distribución de Poisson es más adecuada, tambien la veremos mas adelante, al principio no estaba tomada en cuenta pero es necesario que la estudiemos.

#Puede examinar las propiedades de la distribución de Poisson utilizando dpois y ppois. Puede generar variables aleatorias siguiendo esta distribución con rpois. 



###Ley de numeros grandes

#Una implicación importante del resultado final es que el error estándar del promedio se vuelve cada vez más pequeño a medida que n crece. Cuando n es muy grande, entonces el error estándar es prácticamente 0 y el promedio de los sorteos converge al promedio de la urna. Esto se conoce en los libros de texto de estadística como la ley de los grandes números o la ley de los promedios.


####Mal interpretando la ley de los promedios


#La ley de los promedios a veces se malinterpreta. Por ejemplo, si lanza una moneda 5 veces y ve cara cada vez, es posible que escuche a alguien argumentar que el siguiente lanzamiento probablemente sea cruz debido a la ley de los promedios: en promedio, deberíamos ver 50 % de cara y 50 % de cruz. Un argumento similar sería decir que el rojo "vence" en la rueda de la ruleta después de ver aparecer el negro cinco veces seguidas. Estos eventos son independientes, por lo que la posibilidad de que una moneda caiga cara es del 50 %, independientemente de los 5 anteriores. Este también es el caso del resultado de la ruleta. La ley de los promedios se aplica solo cuando el número de sorteos es muy grande y no en muestras pequeñas. Después de un millón de lanzamientos, definitivamente verá alrededor del 50 % de caras, independientemente del resultado de los primeros cinco lanzamientos.

#Otro uso indebido divertido de la ley de los promedios es en los deportes cuando los comentaristas deportivos de televisión predicen que un jugador está a punto de tener éxito porque ha fallado varias veces seguidas.


