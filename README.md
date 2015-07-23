# [GrayLog](http://graylog.org) plugin for [Fluentd](http://fluentd.org) [![Build Status](https://circleci.com/gh/FundingCircle/fluent-plugin-graylog/tree/master.svg?style=shield&circle-token=532f50099abc19d39f00c89faa39e4d85de12788)](https://circleci.com/gh/FundingCircle/fluent-plugin-graylog/tree/master)

[fluentd](http://fluentd.org) output plugin for GrayLog.

## Installation

This plugin is not available as a Gem.

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
