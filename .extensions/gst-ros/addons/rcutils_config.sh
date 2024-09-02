#!/usr/bin/env bash
# Created by Jonathan Mikler on 03/July/24

# Taken from: https://docs.ros.org/en/humble/Tutorials/Demos/Logging-and-logger-configuration.html#console-output-formatting
# export RCUTILS_CONSOLE_OUTPUT_FORMAT="[{severity} {time}] [{name}]: {message} ({function_name}() at {file_name}:{line_number})"

export RCUTILS_CONSOLE_OUTPUT_FORMAT="[{severity} {time}] [{name}]: {message}"
export RCUTILS_COLORIZED_OUTPUT=1