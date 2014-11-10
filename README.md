# puppet-rubybuild

ruby-build standalone as puppet module.

It can be used to install ruby-build (https://github.com/sstephenson/ruby-build)
and the latest ruby without rbenv.

Only tested on Ubuntu 12.04.2 LTS 64bit.

## Installation

### with puppet(forge)

    $ puppet module install benben-rubybuild

### with librarian

Put this in your `Puppetfile`:

    mod "benben/rubybuild"

and run

    $ librarian-puppet

### with git

cd to your module folder and run

    $ git clone git@github.com:benben/puppet-rubybuild rubybuild

## Configuration

The following config options are possible. The values are shown here are the
default values.

    $repo_path         = "git://github.com/sstephenson/ruby-build.git" # which git repo to use for cloning ruby-build
    $install_dir       = "/usr/local" # where ruby-build will be installed
    $ruby_version      = "2.1.3" # desired ruby version
    $ruby_install_dir  = "/opt" # where ruby will be installed
    $ruby_path         = "/opt/ruby" #where the current ruby will be linked to, so you can point all your stuff to this and always have the right version
    $version_in_dir    = true, # if true it will install to '$ruby_install_dir/$ruby_version' otherwise '$ruby_install_dir' only
    $required_packages = ["libreadline6-dev", "zlib1g-dev", "libssl-dev"] # which packages should be installed before compiling ruby
    $install_ruby      = true # set this to false if you only want to install ruby-build but no ruby

If you dont want to change anything, its enough to do

    include rubybuild

or

    class { "rubybuild": }

If you only want to install the standalone ruby-build without installing ruby,
set `$install_ruby` to `false`.

    class { "rubybuild":
      install_ruby => false,
    }

## Update

I will release a new version of this module everytime there is a new Ruby version.
Simply upgrade this module to get the new Ruby version automatically.

If you want to upgrade without upgrading Ruby, just specify your desired Ruby
version when you declare the class (see above for configuration options).

If you want to upgrade Ruby without upgrading this module, just specify your
desired Ruby version when you declare the class. ATTENTION: This will only work
with versions of this module >=0.1.0.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2013 Benjamin Knofe http://benjaminknofe.com

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
