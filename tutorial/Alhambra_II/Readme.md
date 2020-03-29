# README

Tutorial ports to [Alhambra II board](https://alhambrabits.com/alhambra/). Now using [nextpnr](https://github.com/YosysHQ/nextpnr) instead of `arachne`. This is the list of the updated tutorials:

  - [x] T01-setbit
  - [x] T02-Fport

:warning: The rest of the tutorials could damage your board, as the pinout is still not updated!

## Requisites

Apart from the tools described in the tutorials, you need to install nextpnr. Steps:

Install the dependencies:

```bash
$ sudo apt install python3-dev
$ sudo apt install libboost-dev libboost-filesystem-dev libboost-thread-dev libboost-program-options-dev libboost-python-dev libboost-iostreams-dev libboost-dev
$ sudo apt install libeigen3-dev
$ sudo apt install qt5-default
```

Now compile & install `nextpnr`:

```bash
$ cmake -DARCH=ice40 .
$ make -j$(nproc)
$ sudo make install
```
