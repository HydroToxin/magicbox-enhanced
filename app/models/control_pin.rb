# frozen_string_literal: true

# ControlPin Model
class ControlPin < ApplicationRecord
  belongs_to :component

  validates :name, presence: true
  validates :pin_number, presence: true
  enum pin_function: {
    # General GPIO Functions
    gpio: 'GPIO',

    # Power Supply and Ground
    ground: 'GND',
    dc: 'DC Power',
    ioref: 'IOREF',
    aref: 'AREF',

    # I2C Communication
    sda: 'SDA',
    scl: 'SCL',
    i2c_epreom: 'I2C_EPREOM',

    # SPI Communication
    mosi: 'MOSI',
    miso: 'MISO',
    clk: 'CLK',
    sclk: 'SCLK',
    ss: 'SS',
    ce0: 'CE0',
    ce1: 'CE1',

    # Serial Communication
    txd: 'TXD',
    rxd: 'RXD',

    # PWM and Clock
    pwm_0: 'PWM_0',
    pwm_1: 'PWM_1',
    gpclk0: 'GPCLK0',

    # PCM Audio
    pcm_fs: 'PCM_FS',
    pcm_din: 'PCM_DIN',
    pcm_clk: 'PCM_CLK',
    pcm_dout: 'PCM_DOUT',

    # Other Special Functions
    scx: 'SCX',
    sdx: 'SDX',
    rst: 'RST',
    ax: 'AX',
    id_sd: 'ID_SD',
    intx: 'INTX'
  }

  enum signal_type: {
    digital_input: 'Digital Input',
    digital_output: 'Digital Output',
    digital_io: 'Digital Input/Output',
    analog_input: 'Analog Input',
    analog_output: 'Analog Output',
    pwm: 'PWM',
    interrupt: 'Interrupt'
  }

  enum signal_mode: {
    io: 'Input/Output',
    input: 'Input',
    output: 'Output',
    input_pullup: 'Input-Pullup',
    input_pulldown: 'Input-Pulldown'
  }

  enum pull_resistor: {
    pull_none: 'None',
    pull_up: 'Pull-Up',
    pull_down: 'Pull-Down'
  }

  enum initial_state: {
    low: 'Low',
    high: 'High'
  }

  def self.pin_function_descriptions
    {
      gpio: 'General Purpose Input/Output pin for flexible use',
      ground: 'Ground reference point for electrical circuit',
      v3_3: '3.3V power supply pin',
      v5: '5V power supply pin',
      i2c_sda: 'I2C Serial Data Line for communication',
      i2c_scl: 'I2C Serial Clock Line for communication',
      spi_mosi: 'SPI Master Out Slave In data line',
      spi_miso: 'SPI Master In Slave Out data line',
      spi_sclk: 'SPI Serial Clock line',
      uart_tx: 'UART Transmit data line',
      uart_rx: 'UART Receive data line',
      i2c_mux: 'I2C Multiplexer control pin',
      ss_cs: 'Slave Select/Chip Select pin',
      can_rx: 'CAN Bus Receive pin',
      can_tx: 'CAN Bus Transmit pin',
      nc: 'Normally Closed - A contact that is closed when the relay is not energized',
      com: 'Common - A standard reference point in electrical connections',
      power_enable: 'Power enable/disable control pin',
      reset: 'Device reset control pin',
      clkin: 'Clock input pin',
      address: 'Address configuration pin'
    }
  end

  def self.signal_type_descriptions
    {
      digital_input: 'A digital pin that can read binary states (on/off)',
      digital_output: 'A digital pin that can set binary states (on/off)',
      analog_input: 'A pin capable of reading continuous voltage levels',
      analog_output: 'A pin capable of generating continuous voltage levels',
      pwm: 'Pulse Width Modulation pin for controlling device intensity',
      interrupt: 'A pin that can trigger an interrupt routine'
    }
  end

  def self.signal_mode_descriptions
    {
      input: 'Configure pin as an input receiver',
      output: 'Configure pin as an output sender',
      input_pullup: 'Input pin with internal pull-up resistor activated',
      input_pulldown: 'Input pin with internal pull-down resistor activated'
    }
  end

  def self.pull_resistor_descriptions
    {
      none: 'No internal resistor connection',
      pull_up: 'Internal resistor pulls signal to high state',
      pull_down: 'Internal resistor pulls signal to low state'
    }
  end

  def self.initial_state_descriptions
    {
      low: 'Initial pin state set to low voltage level',
      high: 'Initial pin state set to high voltage level'
    }
  end

  def pin_name
    "#{name} (#{self.pin_function_before_type_cast})"
  end

end