# A Mesos framework for Apache Flink

This project is based on the [mesos-framework-boilerplate](https://github.com/tobilg/mesos-framework-boilerplate) project. It was customized to to create a Apache Flink HA cluster, consisting of 3 JobManagers and initially 2 TaskManagers.
 
## Usage

You can specify the following environment variables:

* `ZK_URL`: The ZooKeeper URL for the Mesos cluster (e.g. `192.168.0.1:2181,192.168.0.2:2181,192.168.0.3:2181`).
* `TASKMANAGER_MEM`: The amount of memory the TaskManagers should be able to use (in MB). The default is `1536`.
* `LOG_LEVEL`: The log level, e.g. `info` or `debug`. The default is `info`.
* `CLUSTER_NAME`: The name of the cluster, which will be appended to the framework name.

### Launching via Marathon

You can launch the scheduler like this:

```javascript
{
  "id": "/flink-framework",
  "container": {
    "docker": {
      "image": "mesoshq/flink-framework:1.1.2",
      "network": "HOST",
      "forcePullImage": true
    },
    "type": "DOCKER"
  },
  "cpus": 0.5,
  "mem": 256,
  "instances": 1,
  "healthChecks": [
    {
      "path": "/health",
      "protocol": "HTTP",
      "gracePeriodSeconds": 30,
      "intervalSeconds": 10,
      "timeoutSeconds": 20,
      "maxConsecutiveFailures": 3,
      "ignoreHttp1xx": false,
      "portIndex": 0
    }
  ],
  "ports": [0],
  "env": {
    "ZK_URL": "172.17.10.101:2181,172.17.10.102:2181,172.17.10.103:2181",
    "LOG_LEVEL": "debug"
  }
}
```

### UI

The scheduler UI can be accessed through the Mesos Master UI's frameworks tab. The TaskManagers can be scaled via this scheduler UI.