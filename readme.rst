Multi-application web server template
=====================================

A template for mono-repo multi-application Debian web servers using:

- docker-compose
- nginx
- Python

Applying the template
---------------------

Replace all occurences of "example.com" with your domain name:

.. code:: sh

    grep -RIl 'example.com' | xargs sed -i 's/example.com/DOMAIN/g'

Server configuration
--------------------

.. code:: sh

    cd server
    scp user-setup root@DOMAIN:~
    ssh root@DOMAIN
        chmod +x user-setup
        ./user-setup USER
        rm user-setup
        exit

    chmod +x ssh-setup
    ./ssh-setup USER DOMAIN

    scp files/* DOMAIN:~
    ssh DOMAIN
        chmod +x build
        ./build USER
        rm *
