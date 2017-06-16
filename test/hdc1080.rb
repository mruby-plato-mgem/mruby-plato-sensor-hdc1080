# PlatoDevice::HDC1080 class

class I
  attr_accessor :data
  def initialize(addr)
    @addr = addr
    @data = []
  end
  def read(reg, len, type=:as_array)
    d = []
    len.times {d << @data.shift}
    return d if type == :as_array
    s = ''
    d.each {|b| s << b.chr}
    s
  end
  def write(reg, data); data; end
end
module PlatoDevice
  class HDC1080
    attr_reader :i2c
  end
end

assert('HDC1080', 'class') do
  assert_equal(PlatoDevice::HDC1080.class, Class)
end

assert('HDC1080', 'superclass') do
  assert_equal(PlatoDevice::HDC1080.superclass, Plato::Sensor)
end

assert('HDC1080', 'new') do
  Plato::I2C.register_device(I)
  h1 = PlatoDevice::HDC1080.new
  h2 = PlatoDevice::HDC1080.new(1)
  h3 = PlatoDevice::HDC1080.new(PlatoDevice::HDC1080::I2CADDR, 5)
  h4 = PlatoDevice::HDC1080.new(PlatoDevice::HDC1080::I2CADDR, 3, :F)
  assert_true(h1 && h2 && h3 && h4)
end

assert('HDC1080', 'new - argument error') do
  Plato::I2C.register_device(I)
  assert_raise(ArgumentError) {PlatoDevice::HDC1080.new(1, 2, 3, 4)}
end

assert('HDC1080', 'temperature') do
  Plato::I2C.register_device(I)
  sen = PlatoDevice::HDC1080.new
  sen.i2c.data = [0x60, 0, 0x70, 0]  # 21.875, 32.1875
  assert_equal(sen.temperature, 21.875)
  assert_equal(sen.temperature(:F), 89.938)
end

assert('HDC1080', 'humidity') do
  Plato::I2C.register_device(I)
  sen = PlatoDevice::HDC1080.new
  sen.i2c.data = [0x50, 0x00]  # 31.25
  assert_equal(sen.humidity, 31.25)
end

assert('HDC1080', 'read') do
  Plato::I2C.register_device(I)
  sen = PlatoDevice::HDC1080.new(0, 1)
  sen.i2c.data = [0x60, 0, 0x80, 0]  # 21.875, 50.0
  assert_equal(sen.read, [21.9, 50.0])
end
