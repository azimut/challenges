# Dia π

## Desafío 1: Basic Fibbonacci

Given an integer n being `0 <= n <= 40`. Return the number in nth fibbonacci number.

eg: given `n=10` return `55`

### Output

``` shell
$ time ./1.dc
Enter desired nth fibonacci number: 40
102334155
./1.dc  317,20s user 0,09s system 99% cpu 5:19,73 total
```

### scratchpad

```
0 1 1 2 3 5 8 13 21 34 55 89

[ 0]  ?  ? =  0
[ 1]  ?  ? =  1
[ 2]  0  1 =  1
[ 3]  1  1 =  2
[ 4]  1  2 =  3
[ 5]  2  3 =  5
[ 6]  3  5 =  8
[ 7]  5  8 = 13
[ 8]  8 13 = 21
[ 9] 13 21 = 34
[10] 21 34 = 55
```

## Desafío 2: Fibonacci Optimizado

Optimiza el cálculo del n-ésimo término de Fibonacci utilizando memoización o programación dinámica.
**Entrada**: Un número entero n (0 <= n <= 10^6)
**Salida**: El n-ésimo término de Fibonacci módulo 10^9+7
Ejemplo:
```
**Entrada** 1000000
**Salida**: ??? (gran número)
```
> Restricciones: La solución debe ejecutrase en O(log n) o mejor

## Desafío 3: Suma de Dígitos en la Expansión de π

Calcula la suma de los primeros n dígitos de la expansión edcimal de π  (sin incluir el "3.").
**Entrada**: Un número entero n (1 <= n <= 10^4)
**Salida**: La suma de los primeros n dígitos después del punto decimal.
Ejemplo:
```
**Entrada**: 5
**Salida**: 23 (porque 14159 -> 1+4+1+5+9 = 23)
```
> Restricciones: NO PUEDES usar librerías que directamente devuelvan los dígitos de π, debes calcularlos.

## Desafío 4: Aprox. de π con Monte Carlo

Estima el valor de π usando el método de Monte Carlo con n puntos aleatorios.
**Entrada**: Un número entero n (10^4 <= n <= 10^8)
**Salida**: Una estimación de π con al menos 5 decimales correctos.
Ejemplo:
```
**Entrada**: 1000000
**Salida**: 3.14159
```
> Restricciones: La solución debe ejecutarse en tiempo razonable para n = 10^8

## Desafío 5: π en la Transformada de Fourier

Se te da una señal de audio discretizada en N puntos. Usa la Transformada Rápida de Fourier (FFT) para encontrar la frecuencia dominante y verificar si está relacionada con π.
**Entrada**: Un número entero N (1024 <= N <= 2^16), seguido de N valores que representan una señal.
**Salida**: La frecuencia dominante y un mensaje indicando si está relacionada con π.
Ejmeplo:
```
**Entrada**:
1024
0.0 1.0 0.0 -1.0 0.0 1.0 ... (senoidal)
Salida:
Frecuencia dominante 314.159 Hz
Está relacionada con π
```
> Restricciones Debes implementar FFT en O(N log N)
