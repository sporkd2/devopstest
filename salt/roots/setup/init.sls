include:
  - git
  - ruby

bundle_install:
  cmd.run:
    - name: 'bundle install'
    - cwd: /source_code_repo
    - user: vagrant
    - require:
      - sls: git
      - sls: ruby
      - cmd: export PATH=/usr/local/bin:$PATH

change_path_old:
  cmd.run:
    - name: export PATH=/usr/local/bin:$PATH
    
migrate_db:
  cmd.run:
    - name: 'bundle exec rake db:migrate'
    - cwd: /source_code_repo
    - user: vagrant
    - require:
      - cmd: bundle_install

seed_db:
  cmd.run:
    - name: 'bundle exec rake db:seed'
    - cwd: /source_code_repo
    - user: vagrant
    - require:
      - cmd: bundle_install
      - cmd: migrate_db

start_rails:
  cmd.run:
    - name: 'bundle exec rails s -d'
    - cwd: /source_code_repo
    - user: vagrant
    - require:
      - cmd: bundle_install
      - cmd: migrate_db
      - cmd: seed_db
