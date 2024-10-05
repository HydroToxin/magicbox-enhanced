# MagicBox Enhanced Edition

Based on the original [MagicBox](https://github.com/nark/magicbox/) project developed by Nark. Initially designed to assist home growers in monitoring and fine-tuning their indoor growing operations, it provides an open indoor growing platform. The original project has not been maintained for over three years, and I have made numerous improvements to expand its functionality and usability.

## Overview of Adjustments:

- Fixed a multitude of bugs.
- Added several missing implementations.
- Added missing handling of data types.
- Hidden non-functional and unknown modules.
- Enhanced user interfaces.
- New features include support for the DHT22 sensor and digitally switchable power strips (e.g., Gembird Silvershield) for real-time display of sensor values on the dashboard.

## Roadmap:

- Migration to Ruby 3.x and Rails 7.x.
- Integration of Rubocop for code quality assurance.
- Consolidation and refactoring of the code.
- Migration for operation on a 64-bit operating system. Currently, the system runs only on a 32-bit OS. I was unable to get it running on a 64-bit system because some gems, such as the rpi_gpio gem, couldn't compile natively. However, with some effort, it should be possible.
- Simplify installation and add Docker support.

## Future Features:

- Tracking and management of fertilizers.
- Watering plan overview with information about genetics, water, and fertilizer usage.
- AI-assisted support through ChatGPT for monitoring growth and watering plans and intervening when issues arise.
- Alerting functionality with SMS delivery.
- Smartphone-optimized web app for mobile access.
- Support for expanders like the MCP23017 to connect additional devices or sensors.

## Contributing:

Feedback, bugs, suggestions, and contributions via pull requests or discussions are warmly welcomed to help advance the system. Your input can greatly contribute to the development and improvement of this project.
On GitHub at: [https://github.com/HydroToxin/magicbox](https://github.com/HydroToxin/magicbox)


## License:

The author of the original project has unfortunately not specified a license.

## Credits:

Inspired by [https://github.com/nark/magicbox/](https://github.com/nark/magicbox/)

This version of MagicBox includes comprehensive updates and is ready to support home growers more effectively.
