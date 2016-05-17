# -*- coding: utf-8 -*-
# vim: ft=sls

{% import "openvas/map.jinja" as map with context %}

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
    - pkgs: 
      - {{ map.openvas.pkg }}
      - {{ map.openvas_manager.pkg }}
      - {{ map.openvas_scanner.pkg }}
      - {{ map.greenbone.pkg }}
    - refresh: True

