# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "openvas/map.jinja" import openvas with context %}
{% set openvas_dir = '/var/lib/openvas/' %}
{% set certdir = openvas_dir + 'CA/' %}
{% set plugins = openvas_dir + 'plugins/' %}

openvas-setup:
  cmd.run:
    - unless: "test -d {{ plugins }}"

openvas-create-cert:
  cmd.run:
    - name: openvas-mkcert -q -f
    - unless: "test -f {{ certdir }}servercert.pem || openssl verify -CAfile {{ certdir }}cacert.pem {{ certdir }}servercert.pem |grep -q ^error"

openvas-nvt-sync:
  cmd.run:
    - unless: 'test $(find {{ plugins }} -name "*nasl" | wc -l) -gt 10'

openvas-client-cert:
  cmd.run:
    - name: openvas-mkcert-client -n -i
    - unless: "test -f {{ certdir }}clientcert.pem"

openvas-dbnvt-count:
  cmd.run: 
    - name: openvasmd --rebuild
    - unless: 'test $(sqlite3 {{ openvas.manager_default.manager_database }} "select count(*) from nvts;") -gt 20000'

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
      - cmd: openvas-create-cert
      - cmd: openvas-nvt-sync
      - cmd: openvas-client-cert
      - cmd: openvas-dbnvt-count

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
