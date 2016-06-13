# -*- coding: utf-8 -*-
# vim: ft=sls

{% import "openvas/map.jinja" as map with context %}
{% set openvas_plugins = '/var/lib/openvas/plugins' %}

openvas-setup:
  cmd.run:
{% if map.openvas_manager.password is defined %}
    - name: 'openvas-setup && openvasmd --user=admin --new-password={{ map.openvas_manager.password }}'
{% endif %}
    - unless: 'test $(find {{ openvas_plugins }} -name "*nasl" | wc -l) -gt 10'

{{ map.openvas_manager.service }}:
  service.running:
    - enable: True
{% if grains['init'] == "systemd" %}
    - provider: systemd
{% endif %}
    - require:
      - cmd: openvas-setup

{{ map.openvas_scanner.service }}:
  service.running:
    - enable: True
{% if grains['init'] == "systemd" %}
    - provider: systemd
{% endif %}

{{ map.openvas_gsa.service }}:
  service.running:
    - enable: True
{% if grains['init'] == "systemd" %}
    - provider: systemd
{% endif %}
