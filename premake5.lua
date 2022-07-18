MINIAUDIO_INCLUDE = path.getabsolute('.')

project 'miniaudio'
  kind 'StaticLib'
  language 'C++'
  staticruntime 'On'

  targetdir('%{wks.location}/bin/%{cfg.buildcfg}/%{prj.name}')
  objdir('%{wks.location}/obj/%{cfg.buildcfg}/%{prj.name}')

  files {
    'miniaudio.h',
    'miniaudio.cpp'
  }

  includedirs {
    '.'
  }

  filter {'not system:windows'}
    buildoptions {
      '-std=c++17',
      '-Wpedantic',
      '-Wall',
      '-Wextra',
      '-Werror',

      '-Wno-deprecated-declarations',
      '-Wno-unused-but-set-variable',
      '-Wno-unused-parameter',
    }

  filter 'system:macosx'
    system 'macosx'

  filter 'system:linux'
    system 'linux'

  filter 'system:windows'
    system 'windows'
    buildoptions {
      '/W4',
      '/WX',
      '/wd4100',
    }

  filter 'configurations:debug'
    symbols 'On'

  filter 'configurations:release'
    optimize 'On'

