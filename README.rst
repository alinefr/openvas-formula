===========================
openvas-formula |travis-ci|
===========================
.. |travis-ci| image:: https://travis-ci.org/alinefr/openvas-formula.svg?branch=master
    :target: https://travis-ci.org/alinefr/openvas-formula

A saltstack formula for installing and configuring openvas.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``openvas``
------------

Installs the openvas package, and starts the associated openvas service.

``openvas.install``
------------------

Installs the openvas package.

``openvas.config``
------------------

Apply custom configuration from pillar. Check `pillar.example`_ for usage.

.. _pillar.example: pillar.example

``openvas.service``

Ensures openvas daemons are up and running.
