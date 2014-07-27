clone-git-repo:
  git.latest:
    - name: https://github.com/sporkd2/devopstest
    - target: /source_code_repo
    - user: vagrant
    - require:
      - file: /source_code_repo

/source_code_repo:
  file.directory:
    - user: vagrant
    - mode: 755
    - runas: root

