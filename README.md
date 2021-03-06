SpreeOneUseCodePromotionRule
============================

A rule to limit a promotion use to once per account.

Installation
------------

Add spree_one_use_code_promotion_rule to your Gemfile:

```ruby
gem 'spree_one_use_code_promotion_rule', github: "Hates/spree_one_use_code_promotion_rule"
```

Bundle your dependencies and run the installation generator:

```shell
bundle
bundle exec rails g spree_one_use_code_promotion_rule:install
```

Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

```shell
bundle
bundle exec rake test_app
bundle exec rspec spec
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_one_use_code_promotion_rule/factories'
```
