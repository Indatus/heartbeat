heartbeat Cookbook
==================
Chef cookbook to install and configure heartbeat on Debian / Ubuntu

Requirements
------------
This cookbook doesn't have any dependencies.

Attributes
----------

#### heartbeat::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['conf_dir']</tt></td>
    <td>String</td>
    <td>Location where config files are installed.</td>
    <td><tt>/etc/ha.d</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['watchdog']</tt></td>
    <td>String</td>
    <td>The watchdog directive configures Heartbeat to use a watchdog device.  It is the purpose of a watchdog device to shut the machine down if Heartbeat does not hear its own heartbeats as often as it thinks it should. This keeps things like scheduler bugs from becoming split-brain configurations.</td>
    <td><tt>/dev/watchdog</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['logfile']</tt></td>
    <td>String</td>
    <td>The logfile directive configures a log file. All non-debug messages from Heartbeat will go into this file.</td>
    <td><tt>/var/log/ha-log</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['debugfile']</tt></td>
    <td>String</td>
    <td>The debugfile directive specifies the file Heartbeat will write debug messages to.</td>
    <td><tt>/var/log/ha-debug</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['deadtime']</tt></td>
    <td>Integer</td>
    <td>The deadtime directive is used to specify how quickly Heartbeat should decide that a node in a cluster is dead. Setting this value too low will cause the system to falsely declare itself dead. Setting it too high will delay takeover after the failure of a node in the cluster.</td>
    <td><tt>5</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['warntime']</tt></td>
    <td>Integer</td>
    <td>The warntime directive is used to specify how quickly Heartbeat should issue a "late heartbeat" warning.</td>
    <td><tt>10</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['initdead']</tt></td>
    <td>Integer</td>
    <td>The initdead parameter is used to set the time that it takes to declare a cluster node dead when Heartbeat is first started. This parameter generally needs to be set to a higher value, because experience suggests that it sometimes takes operating systems many seconds for their communication systems before they operate correctly.</td>
    <td><tt>15</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['bcast']</tt></td>
    <td>String</td>
    <td>The bcast directive is used to configure which interfaces Heartbeat sends UDP broadcast traffic on.</td>
    <td><tt>eth0</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['auto_failback']</tt></td>
    <td>Boolean</td>
    <td>The auto_failback option determines whether a resource will automatically fail back to its "primary" node, or remain on whatever node is serving it until that node fails, or an administrator intervenes.</td>
    <td><tt>true</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['keepalive']</tt></td>
    <td>Integer</td>
    <td>The keepalive directive sets the interval between heartbeat packets.</td>
    <td><tt>2</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['udpport']</tt></td>
    <td>Integer</td>
    <td>The udpport directive specifies which port Heartbeat will use for its UDP intra-cluster communication.</td>
    <td><tt>694</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['nodes']</tt></td>
    <td>Array</td>
    <td>An array of hostnames defining the nodes that are in the cluster.  The <b>first</b> node is assumed to be the primary.</td>
    <td><tt>[]</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['shared_ip']</tt></td>
    <td>String</td>
    <td>The IP address that is shared between all cluster nodes.</td>
    <td><tt>Nil</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['active_key']</tt></td>
    <td>Integer</td>
    <td>Which authentication key to use for signing outgoing packets.</td>
    <td><tt>1</tt></td>
  </tr>

  <tr>
    <td><tt>['heartbeat']['config']['authkeys']</tt></td>
    <td>Array</td>
    <td>An array of SHA1 hashes used for packet signing.</td>
    <td><tt>["yourpasswordhere"]</tt></td>
  </tr>

</table>


Usage
-----
#### heartbeat::default

Just include `heartbeat` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[heartbeat]"
  ]
}
```

Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Brian Webb
