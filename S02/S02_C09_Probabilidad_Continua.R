#Probabilidad Continua

#En la unidad de visualización en la funcion de distribucion acumulariba, explicamos por qué al resumir una lista de valores numéricos, como alturas, no es útil construir una distribución que defina una proporción para cada resultado posible. Por ejemplo, si medimos a cada persona en una población muy grande de tamaño n con una precisión extremadamente alta, ya que no hay dos personas que tengan exactamente la misma altura, necesitamos asignar la proporción 1/n a cada valor observado y no obtener ningún resumen útil en absoluto. De manera similar, al definir distribuciones de probabilidad, no es útil asignar una probabilidad muy pequeña a cada altura individual.

#Al igual que cuando se usan distribuciones para resumir datos numéricos, es mucho más práctico definir una función que opere en intervalos en lugar de valores únicos. La forma estándar de hacer esto es usando la función de distribución acumulativa (CDF).

#Describimos la función de distribución acumulada empírica (eCDF) en la Sección de visualizacion como un resumen básico de una lista de valores numéricos. Como ejemplo, anteriormente definimos la distribución de altura para estudiantes varones adultos. Aquí, definimos el vector x para que contenga estas alturas:

library(tidyverse)
library(dslabs)
data(heights)
x <- heights %>% filter(sex=="Male") %>% pull(height)

#Definimos la función de distribución empírica como:

F <- function(a) mean(x<=a)

#que, para cualquier valor a, da la proporción de valores en la lista x que son menores o iguales que a.

#Tenga en cuenta que aún no hemos introducido la probabilidad en el contexto de las CDF. Hagámoslo preguntando lo siguiente: 

#si elijo a uno de los estudiantes varones al azar, ¿cuál es la probabilidad de que mida más de 70,5 pulgadas? Debido a que todos los estudiantes tienen las mismas posibilidades de ser elegidos, la respuesta a esto es equivalente a la proporción de estudiantes que miden más de 70,5 pulgadas. Usando el CDF obtenemos una respuesta escribiendo:

F(70)

#Una vez que se define una CDF, podemos usarla para calcular la probabilidad de cualquier subconjunto. Por ejemplo, la probabilidad de que un estudiante esté entre la altura a y la altura b es:

#F(b)-F(a)

#Debido a que podemos calcular la probabilidad de cualquier evento posible de esta manera, la función de probabilidad acumulada define la distribución de probabilidad para elegir una altura al azar de nuestro vector de alturas x.

#Distribuciones continuas teóricas

#En la Sección de visualizacion de datos presentamos la distribución normal como una aproximación útil a muchas distribuciones naturales, incluida la de altura. 

#La distribución acumulada para la distribución normal se define mediante una fórmula matemática que en R se puede obtener con la función pnorm. Decimos que una cantidad aleatoria se distribuye normalmente con promedio m y desviación estándar s si su distribución de probabilidad está definida por:

#F(a) = pnorm(a, m, s)


#Esto es útil porque si estamos dispuestos a usar la aproximación normal para, por ejemplo, la altura, no necesitamos el conjunto de datos completo para responder preguntas como: ¿cuál es la probabilidad de que un estudiante seleccionado al azar sea más alto que 70 pulgadas? Solo necesitamos la altura promedio y la desviación estándar:

m <- mean(x)
s <- sd(x)
1 - pnorm(70.5, m, s)

#Distribuciones teóricas como aproximaciones

#La distribución normal se deriva matemáticamente: no necesitamos datos para definirla. Para los científicos de datos practicantes, casi todo lo que hacemos involucra datos. Los datos son siempre, técnicamente hablando, discretos. Por ejemplo, podríamos considerar nuestros datos de altura categóricos con cada altura específica en una categoría única. La distribución de probabilidad se define por la proporción de estudiantes que reportan cada altura. Aquí hay una gráfica de esa distribución de probabilidad:


#Geometria de frecuencias

#Mientras que la mayoría de los estudiantes redondearon sus estaturas a la pulgada más cercana, otros informaron los valores con mayor precisión. Un estudiante informó que su altura era 69.6850393700787, que son 177 centímetros. La probabilidad asignada a esta altura es 0,001 o 1 en 812. La probabilidad para 70 pulgadas es mucho más alta en 0,106, pero ¿realmente tiene sentido pensar que la probabilidad de tener exactamente 70 pulgadas es diferente de 69,6850393700787? Claramente, es mucho más útil para propósitos de análisis de datos tratar este resultado como una variable numérica continua, teniendo en cuenta que muy pocas personas, o quizás ninguna, miden exactamente 70 pulgadas, y que la razón por la que obtenemos más valores en 70 es porque las personas redondea a la pulgada más cercana.

#Con distribuciones continuas, la probabilidad de un valor singular ni siquiera está definida. Por ejemplo, no tiene sentido preguntar cuál es la probabilidad de que un valor normalmente distribuido sea 70. En su lugar, definimos probabilidades para intervalos. Así podríamos preguntarnos cuál es la probabilidad de que alguien esté entre 69,5 y 70,5.

#En casos como la altura, en los que se redondean los datos, la aproximación normal es especialmente útil si se trata de intervalos que incluyen exactamente un número redondo. Por ejemplo, la distribución normal es útil para aproximar la proporción de estudiantes que informan valores en intervalos como los siguientes tres:


mean(x <= 68.5) - mean(x <= 67.5)
#> [1] 0.115
mean(x <= 69.5) - mean(x <= 68.5)
#> [1] 0.119
mean(x <= 70.5) - mean(x <= 69.5)
#[1] 0.1219212


#Tenga en cuenta lo cerca que estamos con la aproximación normal:

pnorm(68.5, m, s) - pnorm(67.5, m, s) 
#> [1] 0.103
pnorm(69.5, m, s) - pnorm(68.5, m, s) 
#> [1] 0.11
pnorm(70.5, m, s) - pnorm(69.5, m, s) 
#[1] 0.108

#Sin embargo, la aproximación no es tan útil para otros intervalos. Por ejemplo, observe cómo la aproximación se descompone cuando tratamos de estimar:

mean(x <= 70.9) - mean(x<=70.1)
#> [1] 0.0222

#con

pnorm(70.9, m, s) - pnorm(70.1, m, s)
#> [1] 0.0836

#En general, a está situación la llamamos discretización. 

#Aunque la distribución de la altura real es continua, las alturas reportadas tienden a ser más comunes en valores discretos, en este caso, debido al redondeo. 

#Mientras seamos conscientes de cómo afrontar esta realidad, la aproximación normal puede seguir siendo una herramienta muy útil.


#La densidad de probabilidad

#Para distribuciones categóricas, podemos definir la probabilidad de una categoría. Por ejemplo, una tirada de un dado, llamémoslo X , puede ser 1,2,3,4,5 o 6. La probabilidad de 4 se define como:

#Pr(X=4) = 1/6

#El CDF se puede definir fácilmente:

#F(4)=Pr(X≤4)=Pr(X=4)+Pr(X=3)+Pr(X=2)+Pr(X=1)

#Aunque para distribuciones continuas la probabilidad de un solo valor PR(X=X) no está definido, hay una definición teórica que tiene una interpretación similar. La densidad de probabilidad en X se define como la función F(a) tal que:

#F(a)=Pr(X≤a)=∫a−∞f(x)dx

#Para los que saben de cálculo, recuerden que la integral está relacionada con una suma: es la suma de barras con anchos aproximados a 0. Si no saben de cálculo, pueden pensar en f(x) como una curva para la cual el área debajo de esa curva hasta el valor a, le da la probabilidad Pr(X≤a) .

#Por ejemplo, para usar la aproximación normal para estimar la probabilidad de que alguien mida más de 76 pulgadas, usamos:

1 - pnorm(76, m, s)
#[1] 0.03206008


#que matemáticamente es el área gris a continuación:

#Geomerica Integrales


#La curva que ves es la densidad de probabilidad de la distribución normal. En R, obtenemos esto usando la función dnorm.

#Aunque puede que no sea inmediatamente obvio por qué es útil conocer las densidades de probabilidad, comprender este concepto será esencial para aquellos que deseen ajustar modelos a datos para los que no se dispone de funciones predefinidas.


#Simulaciones de Montecarlo para variables continuas

#R proporciona funciones para generar resultados normalmente distribuidos. Específicamente, la función rnorm toma tres argumentos: tamaño, promedio (predeterminado en 0) y desviación estándar (predeterminado en 1) y produce números aleatorios. Aquí hay un ejemplo de cómo podríamos generar datos que se parecen a nuestras alturas informadas:

n <- length(x)
m <- mean(x)
s <- sd(x)
simulated_heights <- rnorm(n, m, s)

#No sorprende que la distribucion parezca normal

hist(simulated_heights)

#Esta es una de las funciones más útiles en R, ya que nos permitirá generar datos que imitan eventos naturales y responde preguntas relacionadas con lo que podría suceder por casualidad al ejecutar simulaciones de Monte Carlo.

#Si, por ejemplo, elegimos 800 hombres al azar, ¿cuál es la distribución de la persona más alta? ¿Qué tan raro es un apersona con siete pies en un grupo de 800 hombres? 

#La siguiente simulación de Monte Carlo nos ayuda a responder esa pregunta:


B <- 10000
tallest <- replicate(B, {
  simulated_data <- rnorm(800, m, s)
  max(simulated_data)
})

#Tener dentro de una muestra una pesona mayor de 7 pies es bastante raro

mean(tallest >= 7*12)

#Aqui podemos ver su distribucion

hist(tallest)

#Tenga en cuenta que no se ve una distribucion normal.


##Distribuciones Continuas


#Presentamos la distribución normal en la Sección de visualización de datos y la usamos como ejemplo anterior. 

#La distribución normal no es la única distribución teórica útil. 

#Otras distribuciones continuas que podemos encontrar son la t de Student, Chi-cuadrado, exponencial, gamma, beta y beta-binomial. 

#R proporciona funciones para calcular la densidad, los cuantiles, las funciones de distribución acumulativa y generar simulaciones de Monte Carlo. 

#R usa una convención que nos permite recordar los nombres, a saber, usar las letras d, q, p y r delante de una abreviatura para la distribución. Ya hemos visto las funciones dnorm, pnorm y rnorm para la distribución normal. Las funciones qnorm nos dan los cuantiles. Por lo tanto, podemos dibujar una distribución como esta:

x <- seq(-4, 4, length.out = 100)
qplot(x, f, geom = "line", data = data.frame(x, f = dnorm(x)))

#Para Student-t, la describiremos mas adelante, se usa la abreviatura t, de modo que las funciones son dt para la densidad, qt para los cuantiles, pt para la función de distribución acumulativa y rt para la simulación Monte Carlo.

