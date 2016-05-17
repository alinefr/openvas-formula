# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "openvas/map.jinja" import openvas with context %}

openvas-pkg:
{% if grains['os'] == 'Ubuntu' %}
  pkgrepo.managed:
    - ppa: mrazavi/openvas

  file.managed:
    - name: /usr/local/bin/openvas-setup
    - source: salt://openvas/files/openvas-setup
    - mode: 755
{% endif %}

  pkg.installed:
    - name: {{ openvas.pkg }}
    - refresh: True
