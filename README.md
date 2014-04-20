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
script: jgd --url=http://yegor256:${PASSWORD}@github.com/yegor256/blog.git
```
