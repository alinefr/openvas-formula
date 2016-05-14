# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "openvas/map.jinja" import openvas with context %}

openvas-pkg:
  pkg.installed:
    - name: {{ openvas.pkg }}
