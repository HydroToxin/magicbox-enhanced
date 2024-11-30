class Base
  attr_accessor :device

  def initialize(device)
    @device = device
  end

  def self.call(*args)
    MB_LOGGER.info "# Platform check for Script: #{self.name}"
    @platform_supported = false

    case RUBY_PLATFORM
    when /linux/
      @platform_supported = true
    when /darwin/
      @platform_supported = false
    when /win32/, /mingw32/
      @platform_supported = false
    else
      @platform_supported = false
    end

    unless @platform_supported
      MB_LOGGER.info ' -> failed    : Current Platform not supported.'
      return
    end

    new(*args).perform
  end

  def perform
    raise NotImplementedError,
          "Please implement #{self.class.name}##{__method__}"
  end
end
