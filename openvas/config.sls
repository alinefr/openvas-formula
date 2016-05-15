# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "openvas/map.jinja" import openvas with context %}

manager-default:
  file.managed:
    - name: /etc/systemd/system/openvas-manager.service.d/local.conf
    - source: salt://openvas/files/openvas-manager.service
    - makedirs: True
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - context:
      manager_default: {{ openvas.manager_default }}

scanner-default:
  file.managed:
    - name: /etc/systemd/system/openvas-scanner.service.d/local.conf
    - source: salt://openvas/files/openvas-scanner.service
    - makedirs: True
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - context:
      scanner_default: {{ openvas.scanner_default }}

greenbone-default:
  file.managed:
    - name: /etc/systemd/system/greenbone-security-assistant.service.d/local.conf
    - source: salt://openvas/files/greenbone-security-assistant.service
    - makedirs: True
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    - context:
      greenbone_default: {{ openvas.greenbone_default }}
      manager_default: {{ openvas.manager_default }}
