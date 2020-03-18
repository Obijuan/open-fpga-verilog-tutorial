## Descripción
Contador de 26 bits. Ejemplo de un circuito secuencial "hola mundo"

## Simulación

Para realizar la simulacion entrar en el directorio y ejecutar:

```bash
$ make sim
```

Automaticamente se invocará al icarus verilog para hacer la compilacion / simulación y al gtkwave para ver el resultado de la simulacion gráficamente

## Síntesis

Para implementar el diseño en la FPGA ejecutamos el comando:

```bash
$ make sint
```

Se nos genera el fichero setbit.bin que contiene la conguración de la FPGA para que se nos implemente nuestro circuito digital.

Lo descargamos en la fpga mediante el comando:

```bash
sudo iceprog counter.bin
```

## Verificación

The module can be verified using `yosys-smtbmc`.

```bash
$ make formal
```

You may need some dependencies, perhaps a solver like Z3 or yices. Some helpful installation snippets can be found on the (SymbiYosys getting started page](https://symbiyosys.readthedocs.io/en/latest/quickstart.html), SymbiYosys is not required though.