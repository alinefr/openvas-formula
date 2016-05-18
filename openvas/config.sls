# -*- coding: utf-8 -*-
# vim: ft=sls

{% import "openvas/map.jinja" as map with context %}

manager-custom:
  file.managed:
    - name: /etc/systemd/system/{{ map.openvas_manager.service }}.service.d/local.conf
    - source: salt://openvas/files/openvas-manager.local.service
    - makedirs: True
    - mode: 644
    - template: jinja
    - context:
      openvas_manager: {{ map.openvas_manager }}
    - watch_in:
      - service: {{ map.openvas_manager.service }}
      - service: {{ map.openvas_scanner.service }}
      - service: {{ map.openvas_gsa.service }}

scanner-custom:
  file.managed:
    - name: /etc/systemd/system/{{ map.openvas_scanner.service }}.service.d/local.conf
    - source: salt://openvas/files/openvas-scanner.local.service
    - makedirs: True
    - mode: 644
    - template: jinja
    - context:
      openvas_scanner: {{ map.openvas_scanner }}
    - watch_in:
      - service: {{ map.openvas_manager.service }}
      - service: {{ map.openvas_scanner.service }}
      - service: {{ map.openvas_gsa.service }}

gsa-custom:
  file.managed:
    - name: /etc/systemd/system/{{ map.openvas_gsa.service }}.service.d/local.conf
    - source: salt://openvas/files/openvas-gsa.local.service
    - makedirs: True
    - mode: 644
    - template: jinja
    - context:
      openvas_gsa: {{ map.openvas_gsa }}
      openvas_manager: {{ map.openvas_manager }}
    - watch_in:
      - service: {{ map.openvas_manager.service }}
      - service: {{ map.openvas_scanner.service }}
      - service: {{ map.openvas_gsa.service }}
