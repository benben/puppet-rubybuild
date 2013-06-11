class rubybuild {
  $repo_path         = "git://github.com/sstephenson/ruby-build.git"
  $install_dir       = "/usr/local"
  $ruby_version      = "2.0.0-p195"
  $ruby_install_dir  = "/opt"
  $required_packages = ["build-essential", "libreadline6-dev", "zlib1g-dev", "libssl-dev"]

  require git

  package {$required_packages: ensure => "installed", before => Exec["ruby-build fetch"] }

  exec { "ruby-build fetch":
    command => "/usr/bin/git clone ${repo_path} /tmp/benben-rubybuild",
    creates => "/tmp/benben-rubybuild",
    before  => Exec["ruby-build install"],
  }

  exec { "ruby-build install":
    cwd     => "/tmp/benben-rubybuild",
    command => "/tmp/benben-rubybuild/install.sh",
    creates => "${install_dir}/bin/ruby-build",
    user    => "root",
    before  => Exec["ruby-build install-ruby"],
  }

  exec { "ruby-build install-ruby":
    command => "${install_dir}/bin/ruby-build ${ruby_version} ${ruby_install_dir}/${ruby_version}",
    creates => "${ruby_install_dir}/${ruby_version}",
    timeout => 0,
  }
}
