# puppet-rubybuild

ruby-build standalone as puppet module.

It can be used to install ruby-build (https://github.com/sstephenson/ruby-build)
and the latest ruby without rbenv.

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

The following config options are possible.

    $repo_path         = "git://github.com/sstephenson/ruby-build.git"
    $install_dir       = "/usr/local"
    $ruby_version      = "2.0.0-p195"
    $ruby_install_dir  = "/opt"
    $required_packages = ["build-essential", "libreadline6-dev", "zlib1g-dev", "libssl-dev"]
    $install_ruby      = true

If you dont want to change anything, its enough to do

    include rubybuild

or

    class { "rubybuild": }

If you only want to install the standalone ruby-build without installing ruby,
set `$install_ruby` to `false`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2013 Benjamin Knofe

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
