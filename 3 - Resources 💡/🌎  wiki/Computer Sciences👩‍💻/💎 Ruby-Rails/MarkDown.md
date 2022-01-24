Tags : #markdown #Rails6 #active-record #javascript #vueJS 
Title : **Create a drag-and-drop markdown editor in Rails 6 (using Active Storage, SimpleMDE and Inline Attachment)**
Date: 2022-01-17 - 14:17
Related to : [[2022-01-17 - Weekly meetings]]
Time Estimated: start: {{date }} 14:17 - end {{ date }} -14:17

### For VueJs 
Refer to this site 
[vuejs_simplemde](https://bestofvue.com/repo/F-loat-vue-simplemde-vuejs-markdown)

```bash
yarn install install vue-simplemde --save
```

Vue 3
[vue 3 markdown-it](https://github.com/JanGuillermo/vue3-markdown-it)

```bash
`$ yarn add vue3-markdown-it`!
````

### Todo
To install Markdown : 
```bash
#Installation of required js module
yarn add simplemde
yarn add inline-attachment
```

# Overview
It is a memo when creating a Markdown editor that can drag and drop images like the post screen of Qiita in Rails6.

[Click here for reference code](https://github.com/nobu17/rails_markdown_drag_and_drop)

# environment
Mac OS 10.15.4 Ruby 2.6.3p62 Rails 6.0.2.2
# About the function to use
It is implemented mainly using three OSS and functions.

-   SimpleMDE
-   Inline Attachment
-   Active Storage

**SimpleMDE**

A great OSS that turns the textarea tag on your browser into a Markdown editor. It is also equipped with various functions such as an automatic save function.
[Simplemde Js](https://simplemde.com/)

**Inline Attachment**

It easily implements file transmission with Ajax by dragging and dropping from the browser. In combination with SimpleMDE, dragged and dropped images are sent asynchronously and the uploaded result is reflected in the editor.

[Inline Attachment](https://github.com/Rovak/InlineAttachment)
Active Storage

File upload functionality built into Rails. You can easily implement the file upload function by using this, and it is an excellent one that also supports uploading to cloud storage such as AWS, Azure, GCP.

# procedure

## Creation of PJ and various installations

```bash
#Rails project creation
rails new markdown_drag_and_drop

#Install active storage
rails active_storage:install
rails db:migrate

#Installation of required js module
yarn add simplemde
yarn add inline-attachment
```

## Disable turbolinks

By default, Rails includes turbolinks that force regular websites into partial DOM changes like SPA for speed. However, it is often bad for implementation with js, so I disabled it this time.

#### **`app/javascript/packs/application.js`**

```js
//Invalidation
// require("turbolinks").start()
```

#### **`erb:app/views/layouts/application.html.erb`**

```
<!-- 'data-turbolinks-track': 'reload'Delete-->
<%= stylesheet_link_tag 'application', media: 'all' %>
<%= javascript_pack_tag 'application' %>
```

## Creating models, controllers and views

Create a template with scaffold. The content is a field that saves Markdown as a string.

```bash
rails g scaffold article content:text
```

Place a textarea on the form screen that will be the Markdown editor.

#### **`erb:app/views/articles/_from.html.erb`**

```
<!--Js used on the screen(Described later) -->
<%= javascript_pack_tag 'article' %>

<%= form_with(model: article, local: true) do |form| %>
 <!--Abbreviation-->

<div class="field">
    <%= form.label :content %>
    <%= form.text_area :content, { id: "editor"} %>
</div>

<div class="actions">
    <%= form.submit %>
</div>
<% end %>

```

Create js to read on the screen.

--Textarea editor --Setting to communicate with ajax when dragged and dropped in the editor

to hold. The process to communicate with ajax will be created later.

#### **`app/javascript/packs/article.js`**

```js


import "inline-attachment/src/inline-attachment";
import "inline-attachment/src/codemirror-4.inline-attachment";
import 'simplemde/dist/simplemde.min.css'
import SimpleMDE from "simplemde";
import Rails from '@rails/ujs'

window.onload = function () {
  //Make textarea a Markdown editor
  const simplemde = new SimpleMDE({
    element: document.getElementById("editor"),
  });
  //Drag the image into the editor&Processing when dropped
  inlineAttachment.editors.codemirror4.attach(simplemde.codemirror, {
    uploadUrl: "/articles/attach", //Destination URL to POST
    uploadFieldName: "image", //File field name(Key when fetching with params)
    allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
    extraHeaders: { "X-CSRF-Token": Rails.csrfToken() }, //CSRF measures
  });
};

```

## Creating a process for sending a file

Create a model for sending files with Active Storage.

```bash
rails g model attachment
```

#### **`app/models/attachment.rb`**

```ruby

class Attachment < ApplicationRecord
    has_one_attached :image
end
```

Add the process for ajax communication to the controller created by scaffold. Save the image and return the URL in JSON. Since filename is a parameter that inlineAttachment receives by default, match it.

#### **`app/controllers/articles_controller.rb`**

```ruby

class ArticlesController < ApplicationController
  ...
  def attach
    attachment = Attachment.create! image: params[:image]
    render json: { filename: url_for(attachment.image) }
  end
  ...
end

```

Add to the routing.

#### **`routes.rb`**

```ruby

  post 'articles/attach', to: 'articles#attach'
```

## Operation check

If you execute it, drag and drop it into the editor, and Markdown for the image link is output, it is successful.

```bash
rails db:migrate
rails s
```

## Image resizing

Instead of returning the uploaded image as it is If you want to use what you want to resize, you can also return the compressed version with variant. Active Storage also does compression, so it's easy.

#### **`app/models/attachment.rb`**

```ruby

class Attachment < ApplicationRecord
  has_one_attached :image

  def image_compressed
    if image.attached?
      image.variant(resize_to_fit: [700, 600]).processed
    end
  end
end
```

## Summary and impressions

I showed you how to create a Markdown editor that allows you to drag and drop images in Rails 6. I recently started using Rails, and although I have to remember various implicit rules, it's easy because various processes can be easily implemented.

## reference
https://github.com/sparksuite/simplemde-markdown-editor/issues/328


### Research
[Installation Guide](https://linuxtut.com/en/01eb99ab8bc0f5873571/)

---
  
Recommended Posts

[Create a drag-and-drop markdown editor in Rails 6 (using Active Storage, SimpleMDE and Inline Attachment)](https://linuxtut.com/en/01eb99ab8bc0f5873571)

[[Rails] Show avatars in posts using Active Storage](https://linuxtut.com/en/a8a7ac52939b248410f1)

[A memo to simply create a form using only HTML and CSS in Rails 6](https://linuxtut.com/en/70b7246bcd1894dccfe3)

[[Rails API + Vue] Upload and display images using Active Storage](https://linuxtut.com/en/2987cd9b4ab29691eb77)

[[Implementation procedure] Create a user authentication function using sorcery in Rails](https://linuxtut.com/en/56c3913299e6d6b346dc)

[Create a new app in Rails](https://linuxtut.com/en/6a4b6062df6cf7a12ef4)

[Install Rails in the development environment and create a new application](https://linuxtut.com/en/be2859b5e57b92fd7bc8)

[[rails6.0.0] How to save images using Active Storage in wizard format](https://linuxtut.com/en/ff891b498f4e535637a3)

[How to create a query using variables in GraphQL [Using Ruby on Rails]](https://linuxtut.com/en/344d78257ca3bbee8b2a)

[How to implement image posting function using Active Storage in Ruby on Rails](https://linuxtut.com/en/7101eb19fd9bda8925cf)

[Create authentication function in Rails application using devise](https://linuxtut.com/en/0e5e218481b06baf880c)

[[Rails] How to create a graph using lazy_high_charts](https://linuxtut.com/en/31ac1bcc46159c4877e6)

[How to easily create a pull-down in Rails](https://linuxtut.com/en/a652571abc3d81076b70)

[Place "Create a to-do list using Rails API mode and React Hooks" on docker](https://linuxtut.com/en/e1fec90edcceaea6ca8a)

[How to implement a circular profile image in Rails using CarrierWave and R Magick](https://linuxtut.com/en/e48b4fe2a47494e8bb27)

[Create a portfolio app using Java and Spring Boot](https://linuxtut.com/en/008a383204f9c3d95436)

[How to convert A to a and a to A using AND and OR in Java](https://linuxtut.com/en/b030e88b45c1012d7c2f)

[[Rails] Create sitemap using sitemap_generator and deploy to GAE](https://linuxtut.com/en/c4bb00ea202d21dbbbe2)

[[Rails 6] Add images to seed files (using Active Storage)](https://linuxtut.com/en/c9bc319fc448959c2c92)

[Let's create a file upload system using Azure Computer Vision API and Azure Storage Java SDK](https://linuxtut.com/en/7d7392e6cfd78335daad)

[Click the [rails] button to create a random alphanumeric password and enter it in the password field](https://linuxtut.com/en/ce94d28a8a473c3c6194)
### Reviews
**Others Source or other ways**
- [Gem Redcarpet](https://github.com/vmg/redcarpet)
- [With Rails 6 and Action Text](https://blog.saeloun.com/2019/10/01/rails-6-action-text.html)