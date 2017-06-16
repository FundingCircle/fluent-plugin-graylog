# [Graylog][graylog] plugin for [Fluentd][fluentd]

[![Build Status](https://circleci.com/gh/FundingCircle/fluent-plugin-graylog/tree/master.svg?style=shield&circle-token=532f50099abc19d39f00c89faa39e4d85de12788)](https://circleci.com/gh/FundingCircle/fluent-plugin-graylog/tree/master)
[![Code Climate](https://codeclimate.com/github/FundingCircle/fluent-plugin-graylog/badges/gpa.svg)](https://codeclimate.com/github/FundingCircle/fluent-plugin-graylog)
[![Test Coverage](https://codeclimate.com/github/FundingCircle/fluent-plugin-graylog/badges/coverage.svg)](https://codeclimate.com/github/FundingCircle/fluent-plugin-graylog/coverage)

A [Fluentd](http://fluentd.org) output plugin for [Graylog][graylog].

[fluentd]: http://fluentd.org
[graylog]: http://graylog.org

## Installation

    gem install fluent-plugin-graylog

## Configuration

Example

```
<match tag>
  type graylog
  host graylog.example.com # Required
  port 12201               # Default

  # BufferedOutput config
  flush_interval 30
  num_threads 2
  # ...
</match>
```

## License

Copyright © 2015 Funding Circle Ltd.

Distributed under the BSD 3-Clause License.
