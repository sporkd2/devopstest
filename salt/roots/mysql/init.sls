mysql-server:
  pkg:
    - installed

MySQL-python:
  pkg.installed

mysqld:
  service:
    - running
    - enable: True

/etc/salt/minion.d/mysql_mod_minion:
  file.managed:
    - source: salt://mysql_mod_minion

create_database:
  cmd.run:
    - name: "salt-call mysql.db_create 'devopstest'"
    - require:
      - service: mysqld
      - pkg: MySQL-python

create_mysql_user:
  cmd.run:
    - name: "salt-call mysql.user_create 'devops' 'localhost' 'devopspass'"
    - require:
      - cmd: create_database
      - service: mysqld

grant_mysql_priv:
  cmd.run:
    - name: "salt-call mysql.grant_add 'ALL' 'devopstest.*' 'devops' 'localhost'"
    - require:
      - cmd: create_mysql_user
      - service: mysqld


