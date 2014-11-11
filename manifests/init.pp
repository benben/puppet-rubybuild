class rubybuild(
  $repo_path         = "git://github.com/sstephenson/ruby-build.git",
  $install_dir       = "/usr/local",
  $ruby_version      = "2.1.3",
  $ruby_install_dir  = "/opt",
  $ruby_path         = "/opt/ruby",
  $version_in_dir    = true,
  $required_packages = ["libreadline6-dev", "zlib1g-dev", "libssl-dev"],
  $install_ruby      = true
) {

  include git
  include gcc

  $ruby_build = "${install_dir}/bin/ruby-build"
  $tmp_folder = "/tmp/benben-rubybuild"

  package { $required_packages:
    ensure => "latest",
  } ->

  exec { "rubybuild fetch":
    command => "/usr/bin/git clone ${repo_path} ${tmp_folder}",
    before  => Exec["rubybuild install"],
    require => Class["git"],
    creates => $tmp_folder,
  } ->

  exec { "rubybuild update":
    cwd     => $tmp_folder,
    command => "/usr/bin/git pull",
    unless  => "/usr/bin/test -f ${ruby_build} && ${ruby_build} --definitions | grep '^${ruby_version}$'",
  }

  exec { "rubybuild install":
    cwd       => $tmp_folder,
    command   => "/bin/rm -rf ${install_dir}/share/ruby-build/ ${install_dir}/bin/ruby-build ${install_dir}/bin/rbenv-install ${install_dir}/bin/rbenv-uninstall && ${tmp_folder}/install.sh",
    require   => [Class["gcc"], Exec["rubybuild update"]],
    unless    => "/usr/bin/test -f ${ruby_build} && ${ruby_build} --definitions | grep '^${ruby_version}$'",
    user      => "root",
  }

  if $install_ruby {

    if $version_in_dir {
      $ruby_install_path = "${ruby_install_dir}/${ruby_version}"
    } else {
      $ruby_install_path = "${ruby_install_dir}"
    }

    exec { "rubybuild install-ruby":
      command => "${ruby_build} ${ruby_version} ${$ruby_install_path}",
      creates => "${ruby_install_path}",
      timeout => 0,
      require => Exec["rubybuild install"],
    } ->

    file { "link ruby path":
      path   => $ruby_path,
      ensure => "link",
      target => $ruby_install_path,
    }
  }
}
