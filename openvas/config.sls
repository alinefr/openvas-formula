# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "openvas/map.jinja" import openvas, openvas_manager, openvas_scanner, greenbone with context %}

manager-default:
  file.managed:
    - name: /etc/systemd/system/{{ greenbone.service }}/local.conf
    - source: salt://openvas/files/openvas-manager.service
    - makedirs: True
    - mode: 644
    - template: jinja
    - context:
      openvas_manager: {{ openvas_manager }}
    - watch_in:
      - service: openvas-manager
      - service: openvas-scanner
      - service: {{ greenbone.service }}

scanner-default:
  file.managed:
    - name: /etc/systemd/system/openvas-scanner.service.d/local.conf
    - source: salt://openvas/files/openvas-scanner.service
    - makedirs: True
    - mode: 644
    - template: jinja
    - context:
      openvas_scanner: {{ openvas_scanner }}
    - watch_in:
      - service: openvas-manager
      - service: openvas-scanner
      - service: {{ greenbone.service }}

greenbone-default:
  file.managed:
    - name: /etc/systemd/system/greenbone-security-assistant.service.d/local.conf
    - source: salt://openvas/files/greenbone.service
    - makedirs: True
    - mode: 644
    - template: jinja
    - context:
      greenbone: {{ greenbone }}
      openvas_manager: {{ openvas_manager }}
    - watch_in:
      - service: openvas-manager
      - service: openvas-scanner
      - service: {{ greenbone.service }}
