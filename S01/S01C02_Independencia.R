#Independencia

#Decimos que dos eventos son independientes si el resultado de uno no afecta al otro. El ejemplo clásico son los lanzamientos de monedas. Cada vez que lanzamos una moneda justa, la probabilidad de ver cara es 1/2, independientemente de lo que hayan revelado los lanzamientos anteriores. Lo mismo ocurre cuando sacamos cuentas de una urna con reemplazo. En el ejemplo anterior, la probabilidad de que salga rojo es 0,40 independientemente de los sorteos anteriores.

#Muchos ejemplos de eventos que no son independientes provienen de los juegos de cartas. Cuando repartimos la primera carta, la probabilidad de sacar un Rey es 1/13 ya que hay trece posibilidades: As, Dos, Tres, ...

#, Diez, Jota, Reina, Rey y As. Ahora bien, si repartimos un Rey por la primera carta y no la reemplazamos en la baraja, las probabilidades de que una segunda carta sea un Rey son menores porque solo quedan tres Reyes: la probabilidad es 3 de 51. Estos eventos por lo tanto, no son independientes: el primer resultado afectó al siguiente.

#Para ver un caso extremo de eventos no independientes, considere nuestro ejemplo de sacar cinco cuentas al azar sin reemplazo:

beads <- rep(c("red", "blue"), times = c(2,3))
x <- sample(beads, 5)


#Si tiene que adivinar el color de la primera cuenta, predecirá el azul, ya que el azul tiene un 60 % de posibilidades. Pero si te muestro el resultado de los últimos cuatro resultados:

x[2:5]

#¿Seguirías adivinando el azul? Por supuesto que no. Ahora sabes que la probabilidad de que salga roja es 1 ya que la única cuenta que queda es roja. Los eventos no son independientes, por lo que las probabilidades cambian.

