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

