# Uploading release binaries

Linux, OS X: [![Build Status](https://travis-ci.org/forexample/github-binary-release.svg)](https://travis-ci.org/forexample/github-binary-release/builds)

Windows: [![Build status](https://ci.appveyor.com/api/projects/status/ug6pklya81ytwp4b/branch/master?svg=true)](https://ci.appveyor.com/project/ruslo/github-binary-release/branch/master)

## Travis

#### Create token

Create GitHub token with name like "Token for Travis CI deployment" and select `public_repo` (or `repo`). Keep in mind that this token is a **private sensitive** data! See:
  * [Creating an access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use)

#### Encrypt token

[Encrypt your token](http://docs.travis-ci.com/user/encryption-keys) using Travis CLI:

```bash
> sudo gem install travis
> which travis
/usr/bin/travis
> sudo travis login --pro # required for a pro Travis CI account
> sudo travis encrypt -r username/reponame abc..YOUR.TOKEN.HERE...123

  secure: "...."
```

#### Add token

Copy `secure: "..."` string to `.travis.yml`:

```
before_deploy:
  - export FILE_TO_UPLOAD=$(ls _builds/*/Foo-*.tar.gz)

deploy:
  provider: releases
  api_key:
    - secure: "Encrypted GITHUB OAUTH TOKEN"
  file_glob: true
  file: "${FILE_TO_UPLOAD}"
  skip_cleanup: true
  on:
    tags: true
```

* [Travis GitHub deploy](http://docs.travis-ci.com/user/deployment/releases/)
* [Deploy with wildcards](http://stackoverflow.com/a/28579635/2288008)

#### Enable Multi-OS

* [Travis CI Multi-OS](http://docs.travis-ci.com/user/multi-os/)

```
os:
  - linux
  - osx
```

## AppVeyor

Create GitHub token with name like "Token for AppVeyor CI deployment" and select `public_repo` (or `repo`). Keep in mind that this token is a **private sensitive** data! See:
  * [Creating an access token](https://help.github.com/articles/creating-an-access-token-for-command-line-use)

#### Encrypt token

Encrypt your token using form on [appveyor.com](https://ci.appveyor.com/tools/encrypt).

#### Add token

Copy `secure: "..."` string to `appveyor.yml`:

```
artifacts:
  - path: _builds\*\Foo-*.tar.gz
    name: Releases

deploy:
  provider: GitHub
  auth_token:
    secure: "Encrypted GITHUB OAUTH TOKEN"
  artifact: /Foo-.*\.tar.gz/
  draft: false
  prerelease: false
  on:
    appveyor_repo_tag: true
```

## Deploy

```bash
> git tag vA.B.C
> git push --tags
```

Travis will deploy artifacts from Linux and OS X, AppVeyor will deploy artifacts from Windows.
