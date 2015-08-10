### Uploading release binaries

[![Build Status](https://travis-ci.org/forexample/github-binary-release.svg)](https://travis-ci.org/forexample/github-binary-release/builds)

#### Create token

Create GitHub token with name like "Token for Travis CI deployment" and select `public_repo` (or `repo`). Keep in mind that this token is a **private sensitive** data! See:
  * [Creating an access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use)

#### Encrypt token

[Encrypt your token](http://docs.travis-ci.com/user/encryption-keys) using Travis CLI:

```bash
> sudo gem install travis
> which travis
/usr/bin/travis
> sudo travis encrypt -r username/reponame abc..YOUR.TOKEN.HERE...123

  secure: "...."
```

#### Update Travis config

Copy `secure: "..."` string to `.travis.yml`:

```
before_deploy:
  - export FILE_TO_UPLOAD=$(ls _builds/default-Release/Foo-*.tar.gz)

deploy:
  provider: releases
  api_key:
    - secure: "encrypted GITHUB OAUTH TOKEN"
  file_glob: true
  file: "${FILE_TO_UPLOAD}"
  skip_cleanup: true
  on:
    tags: true
```

* [Travis GitHub deploy](http://docs.travis-ci.com/user/deployment/releases/)
* [Deploy with wildcards](http://stackoverflow.com/a/28579635/2288008)

#### Deploy Linux

```bash
> git checkout master
> git tag vA.B.C
> git push --tags
```

#### Deploy OS X

```bash
> git checkout osx
> git tag vA.B.C
> git push --tags
```
