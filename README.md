# Middleman Build Info

`middleman-build-info` is an extension for the [Middleman] static site generator that mantains an incremental build number and date on a JSON file inside your project.

Once the extension is activated It will run and update the build file every time you build your project.

![IMAGE]

[![Gem Version](https://badge.fury.io/rb/middleman-build-info.png)](http://badge.fury.io/rb/middleman-build-info) [![Code Climate](https://codeclimate.com/github/mcavallo/middleman-build-info.png)](https://codeclimate.com/github/mcavallo/middleman-build-info)

## Dependencies

* middleman-core (3.3+)

## Installation
Add to your `Gemfile` and then run `bundle install`:

```ruby
gem 'middleman-build-info'
```

Then activate the extension in your `config.rb` file:

```ruby
activate :build_info
```

## Configuration

There are a couple of settings you can override from your `config.rb` file:

```ruby
activate :build_info do |option|
  # Name of the build info file (default: 'build.json')
  option.filename = 'build.json'

  # Relative path to build file from MM root (default: '')
  option.relative_path = ''

  # Print build info after a successful build (default: true)
  option.display_info_after_build = true
end
```

## Helper

The `build_info` helper is available to use in your views. You can pass a key to retrieve a single value or without parameters to retrieve the full hash.

```erb
<p class="build-number"><%= build_info(:number) %></p>
```

It's worth mentioning that:
* During **development** this helper will return the information about the current build.
* During the **build** process it will return the information about the new build instead.

## Upcoming Features

I'm thinking about adding some Git information to the file as well like last commit hash, branch and committer at the time of the build. But I'm open to suggestions and pull requests.

[CHANGELOG]

## License

Copyright (c) 2014 Mariano Cavallo. MIT Licensed, see [LICENSE] for details.

[middleman]: http://middlemanapp.com
[IMAGE]: https://raw.githubusercontent.com/mcavallo/middleman-build-info/master/middleman-build-info.png
[CHANGELOG]: https://github.com/mcavallo/middleman-build-info/blob/master/CHANGELOG.md
[LICENSE]: https://github.com/mcavallo/middleman-build-info/blob/master/LICENSE.md
