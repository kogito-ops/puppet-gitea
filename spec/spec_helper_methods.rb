def os_specific_options(facts)
  case facts[:osfamily]
  when 'RedHat'
    {
      package: 'gitea',
    }
  when 'Debian'
    {
      package: 'gitea',
    }
  else
    {
      package: 'gitea',
    }
  end
end
