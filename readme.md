# Refinery CMS Galleries

A plugin for galleries management for [Refinery CMS](http://refinerycms.com/)

## Installation

Add the following line to your `Gemfile` file:

    gem 'refinerycms-galleries', '= 0.1', :require => 'galleries', :git => 'git://github.com/Vizzuality/refinerycms-galleries.git'

And then run `bundle install`.

Now you'll be able to use the generator `refinery_galleries`:

    script/rails generate refinery_galleries

This will create a migration and a `seeds` file.

Then run:

    rake db:migrate

And the plugin will be ready to use.

## Data model

A `gallery` is a very simple model:

  - `title` (_string_)
  - `description` (_text_)

A `gallery` can have many `gallery_entries`.

A `gallery_entry` is composed of:

  - `title` (_string_)
  - `description` (_text_)
  - `image_id` (_integer_)
  - `gallery_id` (_integer_)