*****************************
How to start with docker-data
*****************************

What you can do with this docker container
==========================================

The **docker-data** project can be your base data container volume to add data from scratch to GeoServer and PostGIS and then make them persisted when you want to stop your current containers.

Quick introduction on creating persisted storage in Docker
==========================================================

Data persistence strategies
---------------------------

The most commonly used approches in `Docker`_ are `Data volumes`_ and `Data volume containers`_ which essentially create a file system data volume rather than a dedicated data volume container.  

.. _Docker: https://www.docker.com/technologies/overview

.. warning:: If you want to follow this readme and run the docker command you have to make sure that your docker host environent has been already set and your docker default machine has been started.

In order to verify such prerequirements please run this commands below:

.. code-block:: console

    $ docker-machine env

which should output something similar:

.. code-block:: console

    export DOCKER_TLS_VERIFY="1"
    export DOCKER_HOST="tcp://192.168.99.100:2376"
    export DOCKER_CERT_PATH="<user home>/.docker/machine/machines/default"
    export DOCKER_MACHINE_NAME="default"

and then configure your shell environment

.. code-block:: console

    $ eval $(docker-machine env)

Data volumes
------------

You can easily add a data volume to a container using the option `-v` with the command `run` as the example below:

.. code-block:: console

    $ docker run -d -P --name geonode-data-container -v /data geonode/geonode-data touch /data/test.txt

Which creates a data volume within the new container in the `/data` directory. Data volumes are very useful because can be shared and included into other containers. It can be also remarked that the volume created will persist the `test.txt` file.

Host data volumes
^^^^^^^^^^^^^^^^^

You can also mount a directory from your Docker daemon’s host into a container and this could be very useful for testing but even for production in case your host machine can share a storage mount point like a network file system (*NFS*). This approach despite its ease to implement nature has actually an heavy constraint that you have to pre-configure the mount point in your docker host.
This breaks two of the biggest Docker advantages: **container portability** and **applications run anywhere**. 

.. code-block:: console

    $ docker run -d -P --name geonode-data-container -v /geonode_data/data:/data geonode/geonode-data touch /data/test.txt

In case of the GeoNode *data* for example you cannot start from scratch in development like you actually do with

.. code-block:: console

    (venv)$ paver reset_hard

Data volume containers
----------------------

A data volume container is essentially a docker image that defines storage space. The container itself just defines a place inside docker's virtual file system where data is stored. The container doesn’t run a process and in fact *stops* immediately after `docker run` is called as the container exists in a stopped state, so along with its data.

So let's create a dedicated container that holds all of GeoNode persistent shareable data resources, mounting the data inside of it and then eventually into other containers once created and setup:

.. code-block:: console

    $ docker create -v /geonode-store --name geonode-data-container geonode/geonode-data /bin/true

.. note:: `/bin/true` returns a `0` and does nothing if the command was successful.

And the with the option `--volumes-from` you can mount the created volume `/geonode-store` within other containers by running:

.. code-block:: console

    $ docker run -d --volumes-from geonode-data-container --name geoserver geonode/geonode-data

.. hint:: Notice that if you remove containers that mount volumes, the volume store and its data will not be deleted since docker preserves that.

To completely delete a volume from the file system you have to run:

.. code-block:: console

    $ docker rm -v geoserver

How to start with docker-compose for geonode data volume container
==================================================================




