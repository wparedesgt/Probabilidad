#casos de estudio

##La gran apuesta

###Tipos de interés explicados con modelo de probabilidad

#Los bancos también utilizan versiones más complejas de los modelos de muestreo que hemos analizado para decidir las tasas de interés. Suponga que dirige un pequeño banco que tiene un historial de identificación de posibles propietarios de viviendas en los que se puede confiar para realizar pagos. 

#De hecho, históricamente, en un año determinado, solo el 2% de sus clientes incumplen, lo que significa que no devuelven el dinero que les prestó. 

#Sin embargo, eres consciente de que si simplemente prestas dinero a todo el mundo sin intereses, terminarás perdiendo dinero debido a este 2%. 

#Aunque sabe que el 2% de sus clientes probablemente incumplirán, no sabe cuáles. Sin embargo, al cobrarles a todos un poco más de interés, puede compensar las pérdidas sufridas debido a ese 2% y también cubrir sus costos operativos. 

#También puede obtener ganancias, pero si establece las tasas de interés demasiado altas, sus clientes se irán a otro banco. Usamos todos estos hechos y alguna teoría de probabilidad para decidir qué tasa de interés debe cobrar.

#Suponga que su banco otorgará 1,000 préstamos por $180,000 este año. 

#Además, después de sumar todos los costos, suponga que su banco pierde $200,000 por ejecución hipotecaria. Para simplificar, asumimos que esto incluye todos los costos operativos. Un modelo de muestreo para este escenario se puede codificar así:

n <- 1000
perdidas_por_hipotecas <- -200000
p <- 0.02 
defaults <- sample( c(0,1), n, prob=c(1-p, p), replace = TRUE)
sum(defaults * perdidas_por_hipotecas)

#Tenga en cuenta que la pérdida total definida por la suma final es una variable aleatoria. Cada vez que ejecuta el código anterior, obtiene una respuesta diferente. Podemos construir fácilmente una simulación de Monte Carlo para tener una idea de la distribución de esta variable aleatoria.


B <- 10000

perdidas <- replicate(B, {
  defaults <- sample( c(0,1), n, prob=c(1-p, p), replace = TRUE) 
  sum(defaults * perdidas_por_hipotecas)
})


#Sin embargo, realmente no necesitamos una simulación de Monte Carlo. Usando lo que hemos aprendido, el CLT nos dice que debido a que nuestras pérdidas son una suma de sorteos independientes, su distribución es aproximadamente normal con valor esperado y errores estándar dados por:


n*(p*perdidas_por_hipotecas + (1-p)*0)
sqrt(n)*abs(perdidas_por_hipotecas)*sqrt(p*(1-p))


#Ahora podemos establecer una tasa de interés para garantizar que, en promedio, alcancemos el punto de equilibrio. Básicamente, necesitamos agregar una cantidad x a cada préstamo, que en este caso están representados por sorteos, de modo que el valor esperado sea 0. Si definimos que "l" es la pérdida por ejecución hipotecaria, necesitamos:

#lp+x(1−p)=0

#Lo que implica que x es:

-perdidas_por_hipotecas*p/(1-p)

#o una tasa de interés de 0.023.

#Sin embargo, todavía tenemos un problema. 

#Aunque esta tasa de interés garantiza que, en promedio, alcancemos el punto de equilibrio, existe un 50% de posibilidades de que perdamos dinero. 

#Si nuestro banco pierde dinero, tenemos que cerrarlo. Por lo tanto, debemos elegir una tasa de interés que haga que sea poco probable que esto suceda. 

#Al mismo tiempo, si la tasa de interés es demasiado alta, nuestros clientes se irán a otro banco por lo que debemos estar dispuestos a correr algunos riesgos. 

#Entonces, digamos que queremos que nuestras posibilidades de perder dinero sean de 1 en 100, ¿cuál debe ser la cantidad x ahora? 

#Este es un poco más difícil. Queremos que la suma S tenga:

#Pr(S<0)=0.01

#Sabemos que S es aproximadamente normal. El valor esperado de S es

#E[S]={lp+x(1−p)}n

#con n el número de retiros, que en este caso representa préstamos. El error estándar es

#SD[S]=|x−l|√np(1−p).

#Porque x es positivo y l negativo |x−l|=x−l. Tenga en cuenta que estas son solo una aplicación de las fórmulas mostradas anteriormente, pero usando símbolos más compactos.

#Ahora vamos a utilizar un “truco” matemático muy común en estadística. Sumamos y restamos las mismas cantidades a ambos lados del evento S<0 para que la probabilidad no cambie y terminamos con una variable aleatoria normal estándar a la izquierda, que luego nos permitirá escribir una ecuación con solo x como un desconocido. 

#Este “truco” es el siguiente:

#Si Pr(S<0)= 0.01

#Entonces Pr(S−E[S]SE[S]< − E[S]SE[S])


#Y recuerda que E[S] y SE[S] son el valor esperado y el error estándar de S, respectivamente. 

#Todo lo que hicimos arriba fue sumar y dividir por la misma cantidad en ambos lados. Hicimos esto porque ahora el término de la izquierda es una variable aleatoria normal estándar, a la que cambiaremos el nombre de Z. 

#Ahora llenamos los espacios en blanco con la fórmula real para el valor esperado y el error estándar:


#Pr(Z<−{lp+x(1−p)}n(x−l)√np(1−p))=0.01

#Puede parecer complicado, pero recuerda que l, p y n son cantidades conocidas, así que eventualmente las reemplazaremos con números.

#Ahora, debido a que la Z es aleatoria normal con valor esperado 0 y error estándar 1, significa que la cantidad en el lado derecho del signo < debe ser igual a:

qnorm(0.01)

#para que la ecuación se cumpla. Recuerda que z= qnorm(0.01) nos da el valor de z para el cual:

#Pr(Z≤z)=0.01

#Esto significa que el lado derecho de la complicada ecuación debe ser z = qnorm(0.01).

#−{lp+x(1−p)}n(x−l)√np(1−p)=z

#El truco funciona porque terminamos con una expresión que contiene x que conocemos tiene que ser igual a una cantidad conocida z. Resolver para x ahora es simplemente álgebra:


#x=−lnp−z√np(1−p)n(1−p)+z√np(1−p)

#Que en R es:

l <- perdidas_por_hipotecas
z <- qnorm(0.01)
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))
x


#Nuestra tasa de interés ahora sube a 0.035. Esta sigue siendo una tasa de interés muy competitiva. Al elegir esta tasa de interés, ahora tenemos una ganancia esperada por préstamo de:

perdidas_por_hipotecas*p + x*(1-p)

#que es una ganancia total esperada de aproximadamente:

n*(perdidas_por_hipotecas*p + x*(1-p)) 

#Dolares

#Podemos ejecutar una simulación de Monte Carlo para verificar dos veces nuestras aproximaciones teóricas:


B <- 100000
ganancias <- replicate(B, {
  draws <- sample( c(x, perdidas_por_hipotecas), n, 
                   prob=c(1-p, p), replace = TRUE) 
  sum(draws)
})

mean(ganancias)
mean(ganancias<0)


