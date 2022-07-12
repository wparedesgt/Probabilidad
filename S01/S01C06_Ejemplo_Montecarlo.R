#Ejemplo de Monte Carlo



#En lugar de usar combinaciones para deducir la probabilidad exacta de un Natural 21, podemos usar un Monte Carlo para estimar esta probabilidad. En este caso, sacamos dos cartas una y otra vez y hacemos un seguimiento de cuántos 21 tenemos. Podemos usar la función sample  para escoger dos cartas sin reemplazos:


mano <- sample(deck, 2)
mano

#Y luego verifique si una carta es un As y la otra una carta con figuras o un 10. En el futuro, incluimos 10 cuando decimos cartas con figuras. Ahora tenemos que comprobar ambas posibilidades:

(manos[1] %in% ases & manos[2] %in% facecard) | 
  (manos[2] %in% ases & manos[1] %in% facecard)

#Si repetimos esto 10.000 veces, obtenemos una muy buena aproximación de la probabilidad de un Natural 21.

#Comencemos escribiendo una función que dibuje una mano y devuelva VERDADERO si obtenemos un 21. La función no necesita ningún argumento porque usa objetos definidos en el entorno global.

blackjack <- function(){
  mano <- sample(deck, 2)
  (manos[1] %in% ases & manos[2] %in% facecard) | 
    (manos[2] %in% ases & manos[1] %in% facecard)
}

#Aquí sí tenemos que comprobar ambas posibilidades: As primero o As segundo porque no estamos usando la función de combinaciones. La función devuelve VERDADERO si obtenemos un 21 y FALSO en caso contrario:

blackjack()

#Ahora podemos jugar este juego, digamos, 10,000 veces:

B <- 10000
results <- replicate(B, blackjack())
mean(results)
