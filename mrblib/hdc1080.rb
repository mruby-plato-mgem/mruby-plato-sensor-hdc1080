#
# PlatoDevice::HDC1080 class
#
module PlatoDevice
  class HDC1080 < Plato::Sensor
    I2CADDR = 0b1000000
    REG_TEMP = 0
    REG_HUMI = 1

    def initialize(addr=I2CADDR, ndigits=3, unit=:C)
      @i2c = Plato::I2C.open(addr)
      @ndig = ndigits
      @unit = unit
    end

    def temperature(unit=nil)
      uint = @unit unless unit
      tmpary = @i2c.read(REG_TEMP, 2)
      t = (tmpary[0] << 8) | tmpary[1]
      # temp * 165 / 2 ** 16 - 40
      temp = (t * 165.0 / 65536.0 - 40.0)
      temp = (temp * 1.8) + 32.0 if unit == :F   # Celsius temp. -> Fahrenheit temp.
      temp.round(@ndig)
    end

    def humidity
      humary = @i2c.read(REG_HUMI, 2)
      humi = (humary[0] << 8) | humary[1]
      # humi * 100 / 2 ** 16
      (humi * 100.0 / 65536.0).round(@ndig)
    end

    def read
      [temperature, humidity]
    end

    def unit=(u)
      @unit = u
    end
  end
end
