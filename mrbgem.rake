MRuby::Gem::Specification.new('mruby-plato-sensor-hdc1080') do |spec|
  spec.license = 'MIT'
  spec.authors = 'Plato developers'
  spec.description = 'PlatoDevice::HDC1080 class (AE-HDC1080 - Integrated low power humidity and temperature digital sensor)'

  spec.add_dependency('mruby-plato-i2c')
  spec.add_dependency('mruby-plato-sensor')
end
