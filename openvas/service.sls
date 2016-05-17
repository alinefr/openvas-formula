# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "openvas/map.jinja" import openvas with context %}
{% set openvas_dir = '/var/lib/openvas/' %}
{% set certdir = openvas_dir + 'CA/' %}
{% set plugins = openvas_dir + 'plugins/' %}

openvas-setup:
  cmd.run:
{% if openvas.manager_default.manager_password is defined %}
    - name: 'openvas-setup && openvasmd --user=admin --new-password={{ openvas.manager_default.manager_password }}'
{% endif %}
    - unless: 'test $(find {{ plugins }} -name "*nasl" | wc -l) -gt 10'

openvas-manager:
  pkg:
    - installed

  service.running:
    - enable: True
{% if grains['init'] == "systemd" %}
    - provider: systemd
{% endif %}
    - require:
      - cmd: openvas-setup

openvas-scanner:
  pkg:
    - installed

  service.running:
    - enable: True
{% if grains['init'] == "systemd" %}
    - provider: systemd
{% endif %}

greenbone-security-assistant:
  pkg:
    - installed
  
  service.running:
    - enable: True
{% if grains['init'] == "systemd" %}
    - provider: systemd
{% endif %}

openvas-restart:
  cmd.wait:
    - name: 'openvas-stop && openvas-start'
    - watch:
      - file: manager-default
      - file: scanner-default
      - file: greenbone-default
