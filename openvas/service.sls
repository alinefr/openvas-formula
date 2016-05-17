# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "openvas/map.jinja" import openvas_manager, greenbone with context %}
{% set openvas_plugins = '/var/lib/openvas/plugins' %}

openvas-setup:
  cmd.run:
{% if openvas_manager.password is defined %}
    - name: 'openvas-setup && openvasmd --user=admin --new-password={{ openvas_manager.password }}'
{% endif %}
    - unless: 'test $(find {{ openvas_plugins }} -name "*nasl" | wc -l) -gt 10'

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

{{ greenbone.pkg }}:
  pkg:
    - installed
  
  service.running:
    - name: {{ greenbone.service }}
    - enable: True
{% if grains['init'] == "systemd" %}
    - provider: systemd
{% endif %}
