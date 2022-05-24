workspace 'miniaudio'
  configurations {
    'debug',
    'release'
  }

MINIAUDIO_INCLUDE = path.getabsolute('.')

project 'miniaudio'
  kind 'StaticLib'
  language 'C'
  staticruntime 'On'

  targetdir('%{wks.location}/lib')
  objdir('%{wks.location}/obj/%{cfg.buildcfg}/%{prj.name}')

  files {
    'miniaudio.h',
    'miniaudio.c'
  }

  includedirs {
    '.'
  }

  filter {'not system:windows'}
    buildoptions {
      '-std=c17',
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
      '/std=c99',
      '/W4',
      '/WX',
      '/wd4100',
    }

  filter 'configurations:debug'
    symbols 'On'

  filter 'configurations:release'
    optimize 'On'

