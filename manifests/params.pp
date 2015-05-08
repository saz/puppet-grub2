# class: grub2::params: See README for documentation
class grub2::params {

  $badram                = ''
  $config_template       = 'grub2/default_grub.erb'
  $cmdline_linux         = ''
  $cmdline_linux_default = ''
  $default_entry         = 0
  $device_install        = ''
  $disable_recovery      = false
  $disable_submenu       = false
  $disable_uuid          = false
  $gfxmode               = ''
  $install_grub          = false
  $package_ensure        = 'present'
  $serial_command        = ''
  $terminal              = ''
  $timeout               = 5
  $tune                  = ''
  $update_grub           = true

  case $::osfamily {
    'Debian': {
      $config_file       = '/etc/default/grub'
      $distributor       = 'Debian'
      $install_binary    = '/usr/sbin/grub-install'
      $package_name      = [ 'grub-pc', 'grub-common' ]
      $update_binary     = '/usr/sbin/update-grub'
    }
    'Redhat': {
      $config_file       = '/etc/default/grub'
      $distributor       = "$(sed 's, release .*$,,g' /etc/system-release)"
      $install_binary    = '/usr/sbin/grub2-install'
      $package_name      = [ 'grub2', 'grub2-tools' ]
      $update_binary     = '/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg'
    }
    default: {
      fail("The ${module_name} module is not supported on ${::operatingsystem}")
    }
  }

}
