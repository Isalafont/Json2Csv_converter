Tags : #rails #frontend #backend #webpack #javascript
Title: Updatin Rails project to 6.0.4.1 -  Ruby on Rails guide  
Subject: Upgrading a Rails project.
When: 2021-10-25 - 13:00
- Change ruby version to 2.7.3 and rails version to ``gem 'rails', '~> 6.0.3', '>= 6.0.4.1' `` in Gemfile

```shell

$ bundle update
````

- then run 
```shell 
$ bundle install
````

```shell
$       

yarn install --check-files
````

- remove the following files / folder 
```bash
/node_modules
/tmp/cache
yarn.lock
Gemfile.lock
```

and then run:

```bash
bundle install

yarn add @rails/webpacker

rails assets:precompile
rails webpacker:compile
```

then you will have this message when launching localhost : 
```
undefined method `javascript_pack_tag' for #<#<Class:0x00007f9a5d08ad78>:0x00007f9a5d089388>
Did you mean?  javascript_path
               javascript_tag
```

go to ``
app/views/layouts/application.html.erb`` and change 
```rails
<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
```
by : 
```rails

<%= javascript_tag 'application', 'data-turbolinks-track': 'reload', defer: true %>
```

Et voilà !! 