#Introduccion 


#En los juegos de asar, la probabilidad es una definicion vastante intuitiva. Por ejemplo, conocemos que la 
#probabilidad de que caiga 7 es en proporcion de 1 a 6 si lanzamos un par de dados.

#La teoria de la probabilidad es usada hoy en dia en muchos contextos, en particular en las areas que dependen de como los datos son afectados de una manera u otra. 

#El conocimiento de la probabilidad es indispenciable en la ciencia de datos.

## Probabilidad Discreta ###

#Vamos a iniciar cubineo algunos principios basicos relacionados los datos categoricos. En consecuencia a esto describiremos commo probabilidad discreta.

#Esto nos ayudara a enter la teoria de la probabilidad el cual nos ayudará a introducirnos mas tarde a los numeros y data continua, que es mucho mas comun en las aplicaciones de ciencia de datos.

#La probabilidad discreta es mas util en los juegos de carta en donde veremos y usaremos algunos ejemplos.


##Frecuencia Relativa##

#En el mundo la probabilidad es unsada en el lenguaje diario. Responder preguntas hacerca de la probabilidad a menudo es dificil, pero no imposible. 

#Vamos a discutir sobre la definicion matematica de probabilidad que nos permitira obtener respuestas presisas hacia ciertas preguntas.


#Por ejemplo, si yo tengo 2 cuentas rojas y 3 azules dentro de una botella y tomo una de manera aleatoria cual es la probabilidad de que tome una roja?

#Nuestra intuicion nos dice que la respuesta es que 2/5 = 40%.


#Se puede dar una definición precisa al notar que hay cinco resultados posibles, de los cuales dos satisfacen la condición necesaria para el evento "elige una cuenta roja". Dado que cada uno de los cinco resultados tiene la misma probabilidad de ocurrir, concluimos que la probabilidad es de 0,4 para el rojo y de 0,6 para el azul.

#Una forma más tangible de pensar en la probabilidad de un evento es como la proporción de veces que ocurre el evento cuando repetimos el experimento un número infinito de veces, independientemente y bajo las mismas condiciones.

##Simulaciones de Monte Carlo con datos categoricos##


#Las computadoras brindan una forma de realizar el experimento aleatorio simple descrito anteriormente: elegir una cuenta al azar de una bolsa que contiene tres cuentas azules y dos rojas. Los generadores de números aleatorios nos permiten imitar el proceso de elegir al azar.

#Un ejemplo es la función "sample" en R. Demostramos su uso en el siguiente código. Primero, usamos la función "rep" para generarla.

muestras <- rep(c("Rojas", "Azules"), times = c(2,3))
muestras

#Esta lina de codigo produce una salida aleatoria

sample(muestras, 1)


#Si deseamos repetir el experimento un numero infinito de veces, pero es imposible repetirlo asi.

#Sin embargo si lo repetimos un numero lo suficientemente grande de veces, equivaldria por asi decirlo a un numero infinito (ley de numero grandes)

#Ejemplo de una simulacion de Monte Carlo

#Vamos a usar la funcion replicate, que nos permitira repetir la misma tarea un numero determinado de veces.

#El evento aleatorio de repeticiones será igual a 10000 y le asignaremos este numero al objeto "b"

B <- 10000
eventos <- replicate(B, sample(muestras, 1))

#Ahora podemos ver si nuestra definición realmente está de acuerdo con esta aproximación de simulación de Monte Carlo.

#Vamos a usar la funcion "table" para ver la distribucion.

tab <- table(eventos)
tab

#Ahora usaremos la funcion "prop.table" que nos da las proporciones

prop.table(tab)


#Los números anteriores son las probabilidades estimadas proporcionadas por esta simulación de Monte Carlo. La teoría estadística, no cubierta aquí, nos dice que como B aumenta, las estimaciones se acercan a 3/5=.6 y 2/5=.4.

#Aunque este es un ejemplo simple y no muy útil, usaremos simulaciones de Monte Carlo para estimar probabilidades en casos en los que es más difícil calcular las exactas. Antes de profundizar en ejemplos más complejos, usamos algunos simples para demostrar las herramientas informáticas disponibles en R.


#Usamos generadores de números aleatorios. Esto implica que muchos de los resultados presentados pueden cambiar por casualidad, lo que sugiere que una versión congelada puede mostrar un resultado diferente al que obtiene cuando intenta codificar como se muestra. 

#Esto está realmente bien ya que los resultados son aleatorios y cambian de vez en cuando. Sin embargo, si desea asegurarse de que los resultados sean exactamente los mismos cada vez que los ejecuta, puede establecer la semilla de generación de números aleatorios de R en un número específico. 


set.seed(1996, kind = NULL, normal.kind = NULL, sample.kind = NULL)

#Arriba lo configuramos en 1996. Queremos evitar usar la misma semilla cada vez. Una forma popular de recoger la semilla es el año - mes - día. Por ejemplo, elegimos 1996 el 24 de febrero de 2022:

2022-02-24


#Con o sin reemplazo

#La función "sample" tiene un argumento que nos permite elegir más de un elemento de la muestra. Sin embargo, por defecto, esta selección ocurre sin reemplazo: después de seleccionar una cuenta, no se vuelve a colocar. Observe lo que sucede cuando le pedimos que seleccione al azar cinco cuentas:


sample(muestras, 5)
sample(muestras, 5)
sample(muestras, 5)

#Esto da como resultado reordenamientos que siempre tienen tres cuentas azules y dos rojas. Si pedimos que se seleccionen seis cuentas, obtenemos un error:

sample(muestras, 6)


#Sin embargo, la función de "sample" se puede usar directamente, sin el uso de "replicate", para repetir el mismo experimento de escoger 1 de las 5 cuentas, continuamente, bajo las mismas condiciones. Para hacer esto, tomamos una muestra con reemplazo: devuelva la cuenta después de seleccionarla. Podemos decirle a sample que haga esto cambiando el argumento de reemplazo, que por defecto es FALSO, para reemplazar = VERDADERO.


eventos <- sample(muestras, B, replace = TRUE)

prop.table(table(eventos))

#Sin sorpresas los resultados son similares con los obtenidos anteriormente.


