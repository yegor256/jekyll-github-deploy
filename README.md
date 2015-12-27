[![DevOps By Rultor.com](http://www.rultor.com/b/hovancik/middleman-github-deploy)](http://www.rultor.com/p/hovancik/middleman-github-deploy)

[![Build Status](https://travis-ci.org/hovancik/middleman-github-deploy.svg)](https://travis-ci.org/hovancik/middleman-github-deploy)
[![Gem Version](https://badge.fury.io/rb/mgd.svg)](http://badge.fury.io/rb/mgd)
[![Dependency Status](https://gemnasium.com/hovancik/middleman-github-deploy.svg)](https://gemnasium.com/hovancik/middleman-github-deploy)
[![Code Climate](http://img.shields.io/codeclimate/github/hovancik/middleman-github-deploy.svg)](https://codeclimate.com/github/hovancik/middleman-github-deploy)

# What is mgd ?

mgd stands for middleman-github-deploy and is a fork of [jgd](https://github.com/yegor256/jekyll-github-deploy).  

mgd will automatically build your Middleman blog and push it to your gh-pages
branch (or branch of your choice).

# Installation and Usage

It is assumed that your blog is in the home directory of your repo.

Install it first:

```bash
gem install mgd
```

Run it locally:

```bash
mgd
```

Now your site is deployed to `gh-pages` branch of your repo. Done.

PS. You can also specify target branch, with is `gh-pages` by default. Use
`--branch` command line option.

# Deploying with Travis

This is how you might configure your blog
to be deployed automatically by [travis-ci](http://www.travis-ci.org):

```yaml
branches:
  only:
    - master
env:
  global:
    - secure: ...
install:
  - bundle
script: mgd -u http://yourname:$PASSWORD@github.com/yourname/blog.git
```

The environment variable `$PASSWORD` is set through
`env/global/secure`, as explained
[here](http://docs.travis-ci.com/user/encryption-keys/).

Don't forget to add `gem require 'mgd'` to your `Gemfile`.

You can use SSH key instead. First, you should [encrypt](https://docs.travis-ci.com/user/encrypting-files/) it:

```bash
$ travis encrypt-file id_rsa --add
```

Then, use the URI that starts with `git@`:

```yaml
script:
  - mgd -u git@github.com:yourname/blog.git
```

Read also [this article](http://www.yegor256.com/2014/06/22/jekyll-github-deploy.html).
