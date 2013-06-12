class rubybuild(
  $repo_path         = "git://github.com/sstephenson/ruby-build.git",
  $install_dir       = "/usr/local",
  $ruby_version      = "2.0.0-p195",
  $ruby_install_dir  = "/opt",
  $required_packages = ["build-essential", "libreadline6-dev", "zlib1g-dev", "libssl-dev"],
  $install_ruby      = true
) {

  require git

  $ruby_build = "${install_dir}/bin/ruby-build"

  package {$required_packages: ensure => "installed", before => Exec["rubybuild fetch"] }

  exec { "rubybuild fetch":
    command => "/usr/bin/git clone ${repo_path} /tmp/benben-rubybuild",
    creates => "/tmp/benben-rubybuild",
    before  => Exec["rubybuild install"],
    unless  => "/usr/bin/test -f ${ruby_build}",
  }

  exec { "rubybuild install":
    cwd     => "/tmp/benben-rubybuild",
    command => "/tmp/benben-rubybuild/install.sh",
    creates => $ruby_build,
    user    => "root",
  }

  if $install_ruby {
    exec { "rubybuild install-ruby":
      command => "${ruby_build} ${ruby_version} ${ruby_install_dir}/${ruby_version}",
      creates => "${ruby_install_dir}/${ruby_version}",
      timeout => 0,
      require => Exec["rubybuild install"],
    }
  }
}
