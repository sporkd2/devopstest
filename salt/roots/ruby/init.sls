include:
  - git
  - mysql

build_packages:
  pkg.installed:
    - pkgs:
      - gcc-c++ 
      - glibc-headers 
      - openssl-devel 
      - readline 
      - libyaml-devel 
      - readline-devel 
      - zlib 
      - zlib-devel
      - mysql-devel

ruby_repo:
  git.latest:
    - name: https://github.com/ruby/ruby
    - target: /tmp/ruby_git
    - rev: v2_0_0_353
    - unless: "/usr/local/bin/ruby -v"


change_path:
  cmd.run:
    - name: export PATH=/usr/bin:$PATH

autoconf:
  cmd.run:
    - cwd: /tmp/ruby_git
    - user: root
    - unless: "/usr/local/bin/ruby -v"
    - require:
      - pkg: build_packages
      - cmd: export PATH=/usr/bin:$PATH

./configure:
  cmd.run:
    - cwd: /tmp/ruby_git
    - user: root
    - unless: "/usr/local/bin/ruby -v"
    - require:
      - cmd: autoconf
      - cmd: export PATH=/usr/bin:$PATH

make:
  cmd.run:
    - cwd: /tmp/ruby_git
    - user: root
    - unless: "/usr/local/bin/ruby -v"
    - require:
      - cmd: ./configure
      - cmd: export PATH=/usr/bin:$PATH

make install:
  cmd.run:
    - cwd: /tmp/ruby_git
    - user: root
    - unless: "/usr/local/bin/ruby -v"
    - require:
      - cmd: make
      - cmd: export PATH=/usr/bin:$PATH
    

rubygems:
  pkg.installed

bundler:
  cmd.run:
    - name: 'gem install bundler'
    - user: root
    - cwd: /
    - unless: which bundler
