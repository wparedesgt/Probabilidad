#Reglas de adicion y multiplicacion

#Regla de Multiplicación

#Si queremos saber la probabilidad de dos eventos, digamos A y B podemos usar la regla de la multiplicación:

#Pr(A and B) = Pr (A)Pr(B∣A)

#Usemos Blackjack como ejemplo. En Blackjack, se le asignan dos cartas al azar. Después de ver lo que tienes, puedes pedir más. El objetivo es acercarse al 21, sin pasarse. Las figuras valen 10 puntos y los ases valen 11 o 1 (usted elige).

#Entonces, en un juego de Blackjack, para calcular las posibilidades de obtener un 21 sacando un As y luego una figura, calculamos la probabilidad de que el primero sea un As y la multiplicamos por la probabilidad de sacar una figura o un 10 dado que el primero fue un As: 

#1/13×16/51≈0.025

#La regla de la multiplicación también se aplica a más de dos eventos. Podemos usar la inducción para expandirnos a más eventos:

#Pr(A and B and C) = Pr(A)Pr(B∣A)Pr(C∣A and B)


#Regla de multiplicación bajo independencia

#Cuando tenemos eventos independientes, la regla de la multiplicación se simplifica:

#Pr(A and B and C)= Pr(A)Pr(B)Pr(C)

#Pero debemos tener mucho cuidado antes de usar esto, ya que asumir la independencia puede dar como resultado cálculos de probabilidad muy diferentes e incorrectos cuando en realidad no tenemos independencia.

#Como ejemplo, imagine un caso judicial en el que se describe que el sospechoso tiene bigote y barba. El acusado tiene bigote y barba y la fiscalía trae a un “experto” para que testifique que 1/10 de los hombres tienen barba y 1/5 tienen bigote, por lo que usando la regla de la multiplicación concluimos que solo 1/10×1/5 o 0.02 tiene ambos.

#¡Pero para multiplicarnos así necesitamos asumir la independencia! 

#Digamos que la probabilidad condicional de que un hombre tenga bigote condicional a que tenga barba es .95. 

#Entonces la probabilidad de cálculo correcto es mucho mayor: 1/10×95/100=0.095.

#La regla de la multiplicación también nos da una fórmula general para calcular las probabilidades condicionales:

#Pr(B|A)= Pr(A and B)/ Pr(A)


#Regla de Adicion

#La regla de la suma nos dice que:


#Pr(A o B) = Pr(A)+Pr(B)-Pr(A and B)


#Esta regla es intuitiva: piensa en un diagrama de Venn. Si simplemente sumamos las probabilidades, contamos la intersección dos veces, por lo que debemos restar una instancia.


#Para ilustrar cómo usamos estas fórmulas y conceptos en la práctica, usaremos varios ejemplos relacionados con los juegos de cartas.

