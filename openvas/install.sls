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
      - {{ map.openvas_gsa.pkg }}
    - refresh: True

{% if grains['init'] == "systemd" %}
/lib/systemd/system/{{ map.openvas_manager.service }}.service:
  file.managed:
    - source: salt://openvas/files/openvas-manager.service
    - require: 
      - pkg: openvas-pkg

/etc/init.d/{{ map.openvas_manager.service }}:
  file.absent

/lib/systemd/system/{{ map.openvas_scanner.service }}.service:
  file.managed:
    - source: salt://openvas/files/openvas-scanner.service
    - require:
      - pkg: openvas-pkg

/etc/init.d/{{ map.openvas_scanner.service }}:
  file.absent

/lib/systemd/system/{{ map.openvas_gsa.service }}.service:
  file.managed:
    - source: salt://openvas/files/openvas-gsa.service
    - require:
      - pkg: openvas-pkg

/etc/init.d/{{ map.openvas_gsa.service }}:
  file.absent
{% endif %}
