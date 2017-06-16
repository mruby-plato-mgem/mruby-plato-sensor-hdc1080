# mruby-plato-sensor-hdc1080   [![Build Status](https://travis-ci.org/mruby-plato/mruby-plato-sensor-hdc1080.svg?branch=master)](https://travis-ci.org/mruby-plato/mruby-plato-sensor-hdc1080)
PlatoDevice::HDC1080 class (AE-HDC1080 - Integrated low power humidity and temperature digital sensor)
## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

  # ... (snip) ...

  conf.gem :git => 'https://github.com/mruby-plato/mruby-plato-i2c'
  conf.gem :git => 'https://github.com/mruby-plato/mruby-plato-sensor'
  conf.gem :git => 'https://github.com/mruby-plato/mruby-plato-sensor-hdc1080'
end
```

## example
```ruby
s = Plato::Sensor.new
puts s.read
```

## License
under the MIT License:
- see LICENSE file
