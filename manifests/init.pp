class rubybuild(
  $repo_path         = "git://github.com/sstephenson/ruby-build.git",
  $install_dir       = "/usr/local",
  $ruby_version      = "2.1.1",
  $ruby_install_dir  = "/opt",
  $ruby_path         = "/opt/ruby",
  $version_in_dir    = true,
  $required_packages = ["build-essential", "libreadline6-dev", "zlib1g-dev", "libssl-dev"],
  $install_ruby      = true
) {

  require git

  $ruby_build = "${install_dir}/bin/ruby-build"
  $tmp_folder = "/tmp/benben-rubybuild"

  package { $required_packages:
    ensure => "latest",
  } ->

  exec { "rubybuild fetch":
    command => "/usr/bin/git clone ${repo_path} ${tmp_folder}",
    before  => Exec["rubybuild install"],
    creates => $tmp_folder,
  } ->

  exec { "rubybuild update":
    cwd     => $tmp_folder,
    command => "/usr/bin/git pull",
    onlyif  => "/usr/bin/test -f ${ruby_build}",
    unless  => "${ruby_build} --definitions | grep '^${ruby_version}$'",
  }

  exec { "rubybuild install":
    cwd     => $tmp_folder,
    command => "${tmp_folder}/install.sh",
    subscribe => Exec["rubybuild update"],
    creates => $ruby_build,
    user    => "root",
  }

  if $install_ruby {

    if $version_in_dir {
      $ruby_install_path = "${ruby_install_dir}/${ruby_version}"
    } else {
      $ruby_install_path = "${ruby_install_dir}"
    }

    exec { "rubybuild install-ruby":
      command => "${ruby_build} ${ruby_version} ${$ruby_install_path}",
      creates => "${ruby_install_dir}/${ruby_version}",
      timeout => 0,
      subscribe => Exec["rubybuild install"],
    } ->

    file { "link ruby path":
      path   => $ruby_path,
      ensure => "link",
      target => $ruby_install_path,
    }
  }
}
