Kisphp Ecommerce System
=======================

[![Build Status](https://travis-ci.org/kisphp/shop-standard.svg?branch=master)](https://travis-ci.org/kisphp/shop-standard)
[![codecov](https://codecov.io/gh/kisphp/shop-standard/branch/master/graph/badge.svg)](https://codecov.io/gh/kisphp/shop-standard)

----

![Zac and Rio](app/web/zac-and-rio.jpg)

# Install

```bash

# Download the repository:
git clone https://github.com/kisphp/shop-standard.git

# Go in repository directory:
cd shop-standard

# Install vagrant development machine (This requires Virtual Box and Vagrant installed)
git clone https://github.com/kisphp/symfony-vagrant.git _vm

# go into _vm directory
cd _vm

# create virtual machine
vagrant up

# login inside virtual machine
vagrant ssh
```

Next steps will be taken inside virtual machine:

```bash

# Run automatic installation for development
./build.sh dev
```

To view your local environment in the browser, add the next line in your `/etc/hosts` file:

```bash
10.10.0.80 dev.local
```

And then open your browser on address [http://dev.local](http://dev.local)



