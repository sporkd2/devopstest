httpd:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - watch:
      - file: /etc/httpd/conf.d/app.conf

/etc/httpd/conf.d/app.conf:
  file.managed:
    - source: salt://apache/files/app.conf
    - require:
      - pkg: httpd 
