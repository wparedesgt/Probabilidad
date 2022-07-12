#Infinito en la practica

#La teoría descrita aquí requiere repetir experimentos una y otra vez para siempre. 

#En la práctica no podemos hacer esto. En los ejemplos anteriores, usamos B = 10,000 en los experimentos de Monte Carlo y resultó que esto proporcionó estimaciones precisas. 

#Cuanto mayor sea este número, más precisa será la estimación hasta que la aproximación sea tan buena que su computadora no pueda notar la diferencia. 

#Pero en cálculos más complejos, 10.000 puede no ser suficiente. Además, para algunos cálculos, 10 000 experimentos podrían no ser computacionalmente factibles. 

#En la práctica, no sabremos cuál es la respuesta, por lo que no sabremos si nuestra estimación de Monte Carlo es precisa. Sabemos que cuanto mayor sea B, mejor será la aproximación. Pero, ¿qué tan grande necesitamos que sea? En realidad, esta es una pregunta desafiante y responderla a menudo requiere una formación estadística teórica avanzada.

#Un enfoque práctico que describiremos aquí es verificar la estabilidad de la estimación. El siguiente es un ejemplo con el problema del cumpleaños para un grupo de 25 personas.

library(tidyverse)

B <- 10^seq(1, 5, len = 100)

same_birthday <- function(n){
  bdays <- sample(1:365, n, replace=TRUE)
  any(duplicated(bdays))
}

compute_prob <- function(B, n=25){
  same_day <- replicate(B, same_birthday(n))
  mean(same_day)
}

prob <- sapply(B, compute_prob)

qplot(log10(B), prob, geom = "line")

#En este gráfico, podemos ver que los valores comienzan a estabilizarse (es decir, varían menos de .01) alrededor de 1000. Tenga en cuenta que la probabilidad exacta, que conocemos en este caso, es 0.569.
