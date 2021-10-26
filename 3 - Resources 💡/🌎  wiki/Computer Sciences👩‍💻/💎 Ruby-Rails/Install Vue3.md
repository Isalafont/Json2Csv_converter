Tags : #rails #frontend #backend #vueJS #webpack #javascript
Title: Vue.js /JavaScript and Ruby on Rails guide  
Subject: Install Vue3 on a Rails project.
When: 2021-10-25 - 13:00

# Create a new Rails App with Vue3
**Set up**
Rails 6.0.4.1
Yarn 1.22.17
webpack 4.46.0
node v16.11.1

**create app with postgresql and Vue3**
```bash
$ rails new nomApp --webpack:install:vue
--postgreSQL
```

**initialize db**
```bash
$ bundle install
$ rails db:setup
```

**Config Webpack**
Add to *`application/view/layout`* the 2 javascript pack tag.

`<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>`
`<%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>`

Copy the  `Stylesheet directory` from assets into Javascript directory
The assets is used with Sprocket but with new webpack, we don't need Sprocket anymore and all can pass by javascript.

**Config Environment**
Add in `app/config/environment/development`
```ruby
config.action_mailer.default_url_options = { host: "http://localhost:3000" }
```

Add in `app/config/environment/production`
```ruby
config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }
```

**Create a controler** 
```bash
$ rails g controler pages
```

```bash
$ nano config/routes.rb
```

Find the following line:
~/rails-newApp/config/routes.rb
```bash
. . .
root 'sharks#index'
. . .
```
and change it by 
```bash
. . .
root 'home#index'
. . .
```

**Install bootstrap 4**
[Article to install bootstrap on Digital ocean blog](https://www.digitalocean.com/community/tutorials/how-to-add-bootstrap-to-a-ruby-on-rails-application)

```bash
$ yarn add bootstrap jquery popper.js
``````

**Config Webpack environment**
Do not forget to link the loaders into webpack/environments.
If not, you will have 
```bash
$ nano config/webpack/environment.js
```

```ruby
const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

const webpack = require("webpack");
// Preventing Babel from transpiling NodeModules packages
environment.loaders.delete('nodeModules');
// Bootstrap 4 has a dependency over jQuery & Popper.js:
environment.plugins.append("Provide",
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
  })
 );
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
module.exports = environment
```

Next, open your main webpack entry point file, `app/javascript/packs/application.js`:

```bash
$ nano app/javascript/packs/application.js
```

```javascript
. . .
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import "bootstrap"
import "../stylesheets/application"
. . .
```

Next, create a `stylesheets` directory for your application style sheet:

```bash
$ mkdir app/javascript/stylesheets
```

Open the custom styles file:

```bash
$ nano app/javascript/stylesheets/application.scss
```

This is an `scss` file, which uses [Sass](https://sass-lang.com/) instead of [CSS](https://en.wikipedia.org/wiki/Cascading_Style_Sheets). Sass, or Syntactically Awesome Style Sheets, is a CSS extension language that lets developers integrate programming logic and conventions like shared variables into styling rules.

In the file, add the following statements to import the custom Bootstrap `scss` styles and Google fonts for the project:

`~/rails-newApp/app/javascript/stylesheets/application.scss`

```scss
@import "~bootstrap/scss/bootstrap";
@import url('https://fonts.googleapis.com/css?family=Merriweather:400,700');
```

**It's all set** 
Run `rails s` to launch the server

*==You can now install Devise if you want to==*

**==List all Rails commands==**
```bash
$ rails -T
```

``` bash
rails about # List versions of all Rails frameworks and ...
rails action_mailbox:ingress:exim # Relay an inbound email from Exim to Action...
rails action_mailbox:ingress:postfix # Relay an inbound email from Postfix to Act...
rails action_mailbox:ingress:qmail # Relay an inbound email from Qmail to Actio...
rails action_mailbox:install # Copy over the migration
rails action_text:install # Copy over the migration, stylesheet, and J...
rails active_storage:install # Copy over the migration needed to the appl...
rails app:template # Applies the template supplied by LOCATION=...
rails app:update # Update configs and some other initially ge...
rails assets:clean[keep] # Remove old compiled assets
rails assets:clobber # Remove compiled assets
rails assets:environment # Load asset compile environment
rails assets:precompile # Compile all the assets named in config.ass...
rails autoprefixer:info # Show selected browsers and prefixed CSS pr...
rails cache_digests:dependencies # Lookup first-level dependencies for TEMPLA...
rails cache_digests:nested_dependencies # Lookup nested dependencies for TEMPLATE (l...
rails db:create # Creates the database from DATABASE_URL or ...
rails db:drop # Drops the database from DATABASE_URL or co...
rails db:environment:set # Set the environment value for the database
rails db:fixtures:load # Loads fixtures into the current environmen...
rails db:migrate # Migrate the database (options: VERSION=x, ...
rails db:migrate:status # Display status of migrations
rails db:prepare # Runs setup if database does not exist, or ...
rails db:rollback # Rolls the schema back to the previous vers...
rails db:schema:cache:clear # Clears a db/schema_cache.yml file
rails db:schema:cache:dump # Creates a db/schema_cache.yml file
rails db:schema:dump # Creates a db/schema.rb file that is portab...
rails db:schema:load # Loads a schema.rb file into the database
rails db:seed # Loads the seed data from db/seeds.rb
rails db:seed:replant # Truncates tables of each database for curr...
rails db:setup # Creates the database, loads the schema, an...
rails db:structure:dump # Dumps the database structure to db/structu...
rails db:structure:load # Recreates the databases from the structure...
rails db:version # Retrieves the current schema version number
rails log:clear # Truncates all/specified *.log files in log...
rails middleware # Prints out your Rack middleware stack
rails restart # Restart app by touching tmp/restart.txt
rails secret # Generate a cryptographically secure secret...
rails spec # Run all specs in spec directory (excluding...
rails stats # Report code statistics (KLOCs, etc) from t...
rails test # Runs all tests in test folder except syste...
rails test:db # Run tests quickly, but also reset db
rails test:system # Run system tests only
rails time:zones[country_or_offset] # List all time zones, list by two-letter co...
rails tmp:clear # Clear cache, socket and screenshot files f...
rails tmp:create # Creates tmp directories for cache, sockets...
rails webpacker # Lists all available tasks in Webpacker
rails webpacker:binstubs # Installs Webpacker binstubs in this applic...
rails webpacker:check_binstubs # Verifies that webpack & webpack-dev-server...
rails webpacker:check_node # Verifies if Node.js is installed
rails webpacker:check_yarn # Verifies if Yarn is installed
rails webpacker:clean[keep] # Remove old compiled webpacks
rails webpacker:clobber # Remove the webpack compiled output directory
rails webpacker:compile # Compile JavaScript packs using webpack for...
rails webpacker:info # Provide information on Webpacker's environ...
rails webpacker:install # Install Webpacker in this application
rails webpacker:install:angular # Install everything needed for Angular
rails webpacker:install:coffee # Install everything needed for Coffee
rails webpacker:install:elm # Install everything needed for Elm
rails webpacker:install:erb # Install everything needed for Erb
rails webpacker:install:react # Install everything needed for React
rails webpacker:install:stimulus # Install everything needed for Stimulus
rails webpacker:install:svelte # Install everything needed for Svelte
rails webpacker:install:typescript # Install everything needed for Typescript
rails webpacker:install:vue # Install everything needed for Vue
rails webpacker:verify_install # Verifies if Webpacker is installed
rails webpacker:yarn_install # Support for older Rails versions
rails yarn:install # Install all JavaScript dependencies as spe...
rails zeitwerk:check # Checks project structure for Zeitwerk comp...
```
# Resources
*Youtube Video*
[Add Vue To Your Rails 6 App Using This One Simple Webpack Command | Ruby on Rails Webpacker Tutorial](https://www.youtube.com/watch?v=VLNOfRIiiYk&ab_channel=Deanin)

*To create a set up install *
[Install from le Wagon](https://github.com/lewagon/rails-templates/blob/master/devise.rb)

*To install boostrap*
[Install bootstrap on Digital ocean blog](https://www.digitalocean.com/community/tutorials/how-to-add-bootstrap-to-a-ruby-on-rails-application)