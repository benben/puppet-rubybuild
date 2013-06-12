# puppet-rubybuild

ruby-build standalone as puppet module.

It can be used to install ruby-build (https://github.com/sstephenson/ruby-build)
and the latest ruby.

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

    class { "rubybuild":
      $repo_path         = "git://github.com/sstephenson/ruby-build.git"
      $install_dir       = "/usr/local"
      $ruby_version      = "2.0.0-p195"
      $ruby_install_dir  = "/opt"
      $required_packages = ["build-essential", "libreadline6-dev", "zlib1g-dev", "libssl-dev"]
      $install_ruby      = true
    }

If you dont want to change anything, its enough to do

    include rubybuild

or

    class { "rubybuild": }

If you only want to install the standalone ruby-build without installing ruby,
set `$install_ruby` to `false`.
