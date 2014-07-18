[![Gem Version](https://badge.fury.io/rb/jgd.svg)](http://badge.fury.io/rb/jgd)

It is assumed that your blog is in the home directory of your repo.

Install it first:

```bash
gem install jgd
```

Run it locally:

```bash
jgd
```

Now your site is deployed to `gh-pages` branch of your repo. Done.

This is how I configure [my Jekyll blog](https://github.com/yegor256/blog)
to be deployed automatically by
[travis-ci](http://www.travis-ci.org):

```yaml
branches:
  only:
    - master
env:
  global:
    - secure: ...
install:
  - bundle
script: jgd -u http://yegor256:$PASSWORD@github.com/yegor256/blog.git
```

The environment variable `$PASSWORD` is set through
`env/global/secure`, as explained
[here](http://docs.travis-ci.com/user/encryption-keys/).

Don't forget to add `gem require 'jgd'` to your `Gemfile`.

Read also [this article](http://www.yegor256.com/2014/06/22/jekyll-github-deploy.html).
