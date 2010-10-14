# Refinery CMS Galleries

A plugin for galleries management for [Refinery CMS](http://refinerycms.com/)

## Installation

Add the following line to your `Gemfile` file:

    gem 'refinerycms-galleries', '= 0.4', :require => 'galleries', :git => 'git://github.com/Vizzuality/refinerycms-galleries.git'

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
  - `entry_type` (_integer_)

`entry_type` field allows you to have images or videos. If you want the entry be a video you have to add an image as the thumbnail of the video and use the description to embed a video.

