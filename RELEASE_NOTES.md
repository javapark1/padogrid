# PadoGrid Release Notes

©2020-2022 Netcrest Technologies, LLC. All rights reserved.

https://github.com/padogrid

## Version 0.9.23-SNAPSHOT

### Release Date: 11/29/22

- The `install_bundle` command now includes the `-overwrite-workspace` option for overwriting an existing workspace with bundle workspace contents.
- `create_workspace` now includes a workspace `README.md` file, which serves as your workspace document. Its content should be replaced with your workspace descriptions.
- Added `install_padogrid -version` for installing a specific product version.
- Added `create_workspace -headless` for excluding workspace header artifacts.
- `install_bundle` now requires the `-init` option to trigger the `.init_workspace.sh` script.
- Added the `-init`, `-overwrite-workspace` options to `install_rwe` and `install_bundle`. The `-init` option initializes bundle workspaces and the `-overwrite-workspace` overwrites existing workspaces.

---

## Version 0.9.22

### Release Date: 11/20/22

- Added support for Confluent Platform. You can now install Confluent Platform by running `install_padogrid -product confluent`. Confluent and Kafka share the same cluster commands. The `CLUSTER_TYPE` value of `kraft` has been replaced with `kafka` and `confluent`. PadoGrid now supports Kafka, Confluent Community, and Confluent Commertial versions.
- Updated RWE and workspace commands to properly handle file permissions enforced when multitenancy is enabled.
- Added `perf_test` to Kafka. The `perf_test` for Kafka includes the `test_group` command for ingesting Avro-based blob and mock data into Kafka and the `subscribe_topic` command for listening on topics. It also includes support for ingesting mock data directly into databases. See [Kafka `perf_test` App](https://github.com/padogrid/padogrid/blob/develop/padogrid-deployment/src/main/resources/kafka/apps/perf_test/README.md) for details.
- Excluded `log4j` from the cluster class paths to prevent version conflicts. Due to the recent security updates made by `log4j`, many of the products are fragile to `log4j` versions other than the versions included in their distributions. PadoGrid now includes `log4j` binary for running client apps only.
- Fixed Kafka cluster log file name to `kafkaServer.out`. Both `server.log` and `kafkaServer.out` names were used previously.
- Added bundle support for Kafka and Confluent. See [Kafka Confluent Bundle Catalog](https://github.com/padogrid/catalog-bundles/blob/master/confluent-catalog.md)
- Added support for viewing Jupyter log files in `show_jupyter`. Use the `-port` option to view the specific server's log file or `-all` to view all active server log files.
- Added `-simulate` option in `start_mc` to support simulation of the Hazelcast Management Center bootstrap process. As with members, you can now view the Management Center bootstrap details without actually starting it. 
- Added native support for Prometheus and Grafana. They are now part of the growing list of products supported by PadoGrid. To install them use `install_padogrid` and `update_products`. To start them, first create the `grafana` app and then run `start_prometheus` and `start_grafana` found in the `grafana` app's `bin_sh` directory. For details, please see [Geode Grafana App](https://github.com/padogrid/padogrid/blob/develop/padogrid-deployment/src/main/resources/geode/apps/grafana/README.md) and [Hazelcast Grafana App](https://github.com/padogrid/padogrid/blob/develop/padogrid-deployment/src/main/resources/hazelcast/apps/grafana/README.md).
- Added native support for Derby DB. Like Prometheus and Grafana, Derby DB can now be launched as an app. Please see [Derby App](https://github.com/padogrid/padogrid/blob/develop/padogrid-deployment/src/main/resources/common/apps/derby/README.md) for details.
- Updated `start_mc` to support Hazelcast Management Center 5.2.0+ which now uses Spring bootstrap. You must upgrade to PadoGrid 0.9.22+ for `start_mc` to work with Hazelcast Management Center 5.2.0+.
- Jupyter commands now display URLs in the proper form supporting both `http` and `https`.
- Added auto-completion support to Hazelcast 5 commands.
- Added JupyterLab in the PadoGrid Docker image. Starting PadoGrid 0.9.22, you can now access PadoGrid workspaces from the browser. Please see the [Docker](https://github.com/padogrid/padogrid/wiki/Docker) section in the manual for details.

---

## Version 0.9.21

### Release Date: 10/01/22

- This release has been tested with multi-tenant workspaces. Please see the manual sections [Multitenancy](https://github.com/padogrid/padogrid/wiki/Multitenancy) and [Multitenancy Best Practices](https://github.com/padogrid/padogrid/wiki/Multitenancy-Best-Practices) for details.
- Fixed backward compatibility issues introduced by multitenancy. The previous release introduced support for multitenancy which moved workspace metadata to `~/.padogrid`. This broke the bundles that rely on workspace embedded metadata. Please upgrade to v0.9.21 to remedy this issue.
- Added `groups` in tree views. The `show_workspace` and `show_rwe` commands now include `groups` in their views.
- Updated Jupyter commands to comply with the latest JupyterLab (v3.4.7). JupyterLab is still evolving with many changes that are impacting PadoGrid. Some versions of JupyterLab found to be inconsistent with other versions in terms of import/export support. This release of PadoGrid has been tested with JupyterLab v3.4.7.
- Fixed a delete bug in Geode `DebeziumKafkaSinkTask` that generated NPE.
- Fixed a `test_group` bug in Geode `perf_test` that threw NPE when ingesting mock data into database.
- Fixed the wrong VM workspace name set in `vmenv.sh` by `install_bundle`. `vmenv.sh` was introduced in v0.9.20 which holds VM specific variables. The `VM_PADOGRID_WORKSPACE` variable was incorrectly set if the `-workspace` or `-checkout` option specified for the `install_bundle` commadn.
- Replaced the option `-host` with `-ip` in the `open_jupyter` and `start_jupyter` commands to bind a specific IP address.
- Fixed a primary and data node pod memory sizing issue. Previous versions incorrectly had primary memory set to data memory and vice versa.
- Updated `install_padogrid` to default to the cached product versions downloaded from the PadoGrid's `nightly` release. Prior to this change, the downloadable product versions were scanned resulting a long delay. You can still scan product versions by specifying the `-scan` option. Please see the usage by specifying `-?`.

---

## Version 0.9.20

### Release Date: 09/14/22

- Overhauled support for VM clusters by adding an extensive product validation process and refactoring common routines. The `vm_install`, `vm_sync`, and `vm_test` commands are now generic and support all products. These enhancements are incorporated into workspaces, simplifying multi-tenant workspace management in particular. Please see [Geode/GemFire on AWS EC2 Instances](https://github.com/padogrid/padogrid/wiki/Geode-on-AWS-EC2) and [Hazelcast on AWS EC2](https://github.com/padogrid/padogrid/wiki/Hazelcast-on-AWS-EC2) for examples.
- Added support for multitenancy. You can now sandbox workspaces by user groups. This capability allows the `padogrid` administrator to grant or revoke workspace privileges by adding/removing a user to/from the workspace group. For example, the user `foo` belongs to the `finance` group has access to the workspaces owned by that group. A user can belong to one or more groups and have access to workspaces across multiple groups. All other workspaces owned by groups that the user does not belong to are not viewable or accessible. Please see the [Multitenancy](https://github.com/padogrid/padogrid/wiki/Multitenancy) section in the manual for details.
- Added support for the `padogrid.rwe` marker for VMs and Vagrant pods. The previous version (v0.9.19) added this marker to uniquely identify running processes throughout RWEs. With that change, v0.9.19 is broken. It is unable to detect VM and Vagrant pod processes.
- Fixed Geode/GemFire locator issues in pods. Locators were not properly identified in pod VMs.
- Added support for `LOCATOR_JAVA_OPTS` and `MEMBER_JAVA_OPTS` for Geode/GemFire clusters. These variables can be set in `bin_sh/setenv.sh`.
- Added support for creating empty groups. Prior to this release, the `creat_group` command created at least one (1) cluster. You can now create an empty group and then add existing clusters to the group.
- Updated the Jupyter commands to bind to `0.0.0.0`. It was binding to `localhost` previously if the `-host` option is not specified to `start_jupyter` or `open_jupyter`.
- Added support for `PADOGRID_CHARSET` for displaying nested structures in `unicode`. Set this environment variable to `unicode` for the nested structure displaying commands like `show_rwe` if they display control characters.

```bash
export PADOGRID_CHARSET="unicode"
```

- Added Manager URL in `show_cluster -long` display for Geode/GemFire clusters.
- Fixed `create_workspace` and `create_cluster` that incorrectly always defaulted to the cluster type `geode` that prevented creating GemFire clusters.
- Excluded PadoGrid's slf4j from Geode/GemFire to remove warning messages. PadoGrid now uses slf4j included in Geode/GemFire distributions.
- Added experimental Geode/GemFire split-brain diagnostic scripts ported from [bundle-geode-1-app-perf_test_sb-cluster-sb](https://github.com/padogrid/bundle-geode-1-app-perf_test_sb-cluster-sb). Please see the link for details. 

| Script                                   | Description                                                                  |
| ---------------------------------------- | ---------------------------------------------------------------------------- |
| t_revoke_all_missing_disk_stores         | Iteratively revoke all missing data stores                                   |
| t_show_all_suspect_node_pairs            | Find the specified suspect node from all log files                           |
| t_show_all_unexpectedly_left_members     | Display unexpectedly left members in chronological order                     |
| t_show_all_unexpectedly_shutdown_removal | Find the members that unexpectedly shutdown for removal from the cluster     |
| t_show_cluster_views                     | Display cluster views in chronological order                                 |
| t_show_member_join_requests              | Display member join requests received by the locators in chronological order |
| t_show_membership_service_failure        | Display membership service failure and restarted messages from locators      |
| t_show_missing_disk_stores               | Display missing disk stores                                                  |
| t_show_offline_members                   | Display offline regions per member                                           |
| t_show_quorum_check                      | Display quorum check status if any                                           |
| t_show_recovery_steps                    | Display recovery steps for the specfied type                                 |
| t_show_stuck_threads                     | Find stuck threads                                                           |
| t_show_suspect_node_pair                 | Find the specified suspect node pair from the log files                      |
| t_show_type                              | Determine the network partition type                                         |

---

## Version 0.9.19

### Release Date: 07/09/22

- Removed log4j settings from Geode locators as a workaround to Log4J NPE raised by Geode v1.15.0. Without this fix, locators will not start for Geode v1.15.0.
- Fixed `CLUSTER_TYPE` incorrectly set for geode and gemfire. This fix effectively drops `CLUSTER_TYPE` support for older versions of PadoGrid.
- Extended `none` bundles to include any products.
- Added support for `-force` in `install_bundle` to override required products. If this options is specified, then the bundle installs regardless of whether the required products are installed.
- Added the `-all` option to `install_bundle` for installing all online bundles with a single command.

  ```bash
  # To download and install all bundles (git disabled)
  install_bundle -all -download -workspace
  install_bundle -all -download -workspace -force

  # To checkout and install all bundles (git enabled)
  install_bundle -all -checkout
  install_bundle -all -checkout -force
  ```
- Tidied up scripts by refactoring scripts and added missing scripts.
- Replaced `jps` with `ps` for searching for running processes. `jps` is no longer used in PadoGrid.
- Added the `padogrid.rwe` system property to span the active cluster search to RWEs. With this support, all clusters are now uniquely identifiable across RWEs.
- `clean_cluster` is now available for all products including Hadoop, Spark, and Kafka. 
- Fixed `show_products` which failed to show some active products. It now supports all products including Coherence.
- Added `SPARK_DIST_CLASSPATH` support for Hadoop-free Spark versions. With this support, you can now include your own versions of Hadoop in PadoGrid Spark clusters.
- Added `hazelcast.yaml` config files for all versions of Hazelcast.
- Updated `kill_cluster` and `stop_cluster` to bypass pod clusters.
- Fixed empty workspace status display issues when running `kill_workspace` and `stop_workspace`.
- Added `SSH_CONNECT_TIME` to timeout ssh commands. The default timeout is 2 seconds.

### Known Issues

- This version is broken for running clusters on VMs and Vagrant pods. It does not recognize the new marker that uniquely identifies running processes on VMs and Vagrant pods. Please use v0.9.20+ if you are running PadoGrid clusters on VMs or Vagrant pods.

---

## Version 0.9.18

### Release Date: 06/27/22

- Added initial support for Redis. Redis joins the growing list of data grid products supported by PadoGrid. Redis OSS is installable with [`install_padogrid`](https://raw.githubusercontent.com/padogrid/padogrid/develop/padogrid-deployment/src/main/resources/common/bin_sh/install_padogrid). Note that Redis OSS comes in the form of source code only. You must manually build upon installation by running the **`make`** command. The `install_padogrid` command provides details.
- PadoGrid automates boostrapping of Redis replicas with fully integrate support for distributed workspaces.
- Added Redisson addon for creating Java apps for Redis. Ported `perf_test` using Redisson.
- Added Vagrant VM support for Redis.
- `perf_test` now includes the `create_csv` script for consolidating test results into CSV files.
- `perf_test` now includes the `clean_results` script for removing results files.
- Along with the release, [`bundle-none-imdg-benchmark-tests`](https://github.com/padogrid/bundle-none-imdg-benchmark-tests) is made available for conducting benchmark tests on IMDG products.

---

## Version 0.9.17

### Release Date: 06/15/22

- Fixed `install_bundle` to correctly install a workspace bundle.
- Updated `perf_test` README.md files.
- Added entity relationship (ER) support for Geode `perf_test` that generates customer mock data.
- Added support for **padolite** clusters. This support enables normal Geode/GemFire clusters to accept Pado client connections. The immediate benefit of **padolite** is that the users can now use Pado tools such as Pado Desktop and PadoWeb to navigate and monitor Geode/GemFire clusters. To create a normal cluster with Pado enabled, execute `create_cluster -type padolite`. You can also enable/disable PadoLite by setting the `padolite.enabled` property in the `etc/cluster.properties` file. PadoLite allows connections by any Geode/GemFire clients including Pado clients.
- Added `MultiInitializer` for configuring multiple Geode/GemFire initializers. This addon lifts the single initializer limitation in Geode/GemFire.
- Added support for installing PadoGrid SNAPSHOT releases in [`install_padogrid`](https://raw.githubusercontent.com/padogrid/padogrid/develop/padogrid-deployment/src/main/resources/common/bin_sh/install_padogrid). If your PadoGrid version is older than this release, then you must download the updated `install_padogrid` script as described in the [PadoGrid Manual](https://github.com/padogrid/padogrid/wiki/Quick-Start#install-padogrid). PadoGrid snapshots are now automatically built whenever there are changes made in the `RELEASE_NOTES.md` file. You can download the latest snapshot by running the `install_padogrid` command shown below. Note that `install_padogrid` does not remove the existing snapshot installation. It simply overwrites it. Furthermore, **the downloadable snapshots do not include man pages and Coherence addons.**
- Added support for Hazelcast OSS in building PadoGrid pods. Prior to this, only Hazelcast Enterprise was supported in building PadoGrid pods.
- Fixed PadoGrid pod relevant commands that improperly handled the Management Center.
- Added PadoGrid pod support in `shutdown_cluster`.
- Fixed `show_bundle` to pagenate all bundles in GitHub. Prior to this fix, only the first page of 30 bundles were shown.

```bash
install_padogrid -product padogrid
```

- Added `unstall_product` for uninstalling products. By default, the `uninstall_product` command uninstalls the specified product version only if the product version is not in use. You can override it by specifying the `-force` option.

---

## Version 0.9.16

### Release Date: 05/30/22

- Fixed a Pado enablement bug. Without this fix, WAN enabled Geode/GemFire clusters may not start.
- Fixed `show_products` to include HazelcastDesktop.
- Replaced the Hibernate connection pool from dbcp to c3p0. The previous built-in dbcp pool is not for production use.
- Added initial support for bootstrapping Geode/GemFire clusters with the Spring Container. To use Spring, after creating a Geode/GemFire cluster, run the `bin_sh/build_app` to download the Spring Data GemFire packages into the workspace. Edit the `setenv.sh` file and set SPRING_BOOTSTRAP_ENABLED="true". For details, run `build_app -?` to display the usage.

---

## Version 0.9.15

### Release Date: 05/06/22

- Updated Hazelcast OSS and Enterprise download URLs for `install_padogrid`. Hazelcast has changed the download URLs.
- Updated Coherence port number and http blocker for Maven build.
- Added support for gemfire and coherence products in `update_products`.
- Added timestamps to `nw` data classes for Hibernate to auto-update timestamps in databases. For non-database apps, the timestamps are set when they are created in the JVM.
- Added desktop support for Hazecast 5.x.
- Added ER support for Hazelcast rmap, cache, queue, topic, rtopic, and (i)map. The `test_group` command in the `perf_test` app now includes support for recursively ingesting mock data with entity relationships.
- HazelcastDesktop is now part of PadoGrid. You can install it by running `install_padogrid -product hazelcast-desktop` and update your workspaces by running `update_products -product hazelcast-desktop`. Once installed, run `create_app -app desktop` to create a desktop app instance.

---

## Version 0.9.14

### Release Date: 03/04/22

- Upgraded library versions including log4j that fixes security issues.
- Fixed `find_padogrid` to properly handle component types.
- Fixed `install_bundle` which set the wrong current workspace name when the `-download` option is specified.
- `show_jupyter` now executes `jupyter notebook list` instead of `jupyter lab list` which no longer works.

---

## Version 0.9.13

### Release Date: 01/16/22

- Added support for installing downloaded zip bundles. You can now download online bundles in the form of zip files and install them using `install_bundle`.
- Added support for installing PadoGrid without products. Previously, PadoGrid required at least one supported product locally installed before it can be operational. Starting this release, products are not required when installing PadoGrid and creating workspaces. This means you can now install and run applications on Kubernetes, Docker, and Vagrant VMs without having to locally install the corresponding products. Unfortunately, however, this also means the workspaces created with the previous releases are no longer compatible. You must manually migrate the existing workspaces by following the instructions provided in the [Migrating Workspaces](https://github.com/padogrid/padogrid/wiki/Migrating-Workspaces) of the PadoGrid manual.

----

## Version 0.9.12

### Release Date: 11/10/21

- Added support for stanalone cache servers in Geode/GemFire. The `start_member` script now includes `-standalone` option to start standalone members requiring no locators. The `standalone.enabled` property is also available in the `etc/cluster.properties` file. This options is particularly useful for launching standalone servers in edge devices that are unable to reach locators.
- Added installation support for Pado, PadoDesktop, and PadoWeb. This support is also available in the 0.9.11 release build.
- Fixed a bug in `stop_*` and `kill_*` commands that failed to execute remote commands in Vagrant pod VMs.
- Added the `subscribe_topic` script in the Hazelcast `perf_test` app for listening on topic messages.
- By default, `read_cache` and `subscribe_topic` now fail if the specified data structure name does not exist in the cluster. You can create non-existent data structures by specifying the `-create-map` or `-create-topic` option.
- Fixed a Java 11+ debug enablement issue. Previous versions supported only Java 8.

----

## Version 0.9.11

### Release Date: 09/25/21

- Updated most of the online bundles to support Hazelcast 5.x.
- Added support for Hazelcast 5.x. Hazelcast 5.x unifies IMDG and Jet into a single product. With this support, PadoGrid also combines IMDG and Jet specifics into a single library. PadoGrid supports Hazelcast 3.x, 4.x, and 5.x as well as Jet 3.x and 4.x.
- For Hazelcast 5.x, the cluster type is now always "hazelcast". The "imdg" and "jet" cluster types are no longer supported for Hazelcast 5.x clusters.
- Added Hazelcast app instance names. You can now see PadoGrid apps in the management center as `PadoGrid-perf_test` and `hazelcast-desktop`.
- Refactored initialization scripts.
- Added PadoWeb support that includes the new commands, `start_padoweb`, `stop_padoweb`, and `show_padoweb`. These commands are accessible from the Geode/GemFire clusters only. The `update_products` command now includes support for PadoWeb. PadoWeb provides IBiz web services to Pado clients.
- Added preliminary support for PadoDesktop which can now be installed by running `create_app -app padodesktop`.
- The Hazelcast management center (mc) and padoweb commands now pertain to their relevant clusters. For example, `start_mc -cluster mygeode` will fail if the specified cluster, `mygeode`, is not a Hazelcast cluster.
- Fixed Vagrant VM member numbering issues. The member numbers were incorrectly incremented which led to non-default port numbers and missing working directories.
- Fixed the `start_mc` command that ignored HTTPS configuration. This was due to a typo in the script.

----

## Version 0.9.10

### Release Date: 08/26/21

- Fixed a bug that improperly initialized PadoGrid. In the previous release, if an app is run immediately after the rwe `initenv.sh` is directly sourced in from `.bashrc`, for example, then the app does not recognize the cluster product and fails with a "not found" error. This fix only applies to new RWEs created by this release. If you have existing RWE's then you must append the following at the end of their `initenv.sh` file.

```bash
if [ -f "$PADOGRID_WORKSPACE/.workspace/workspaceenv.sh" ]; then
   . "$PADOGRID_WORKSPACE/.workspace/workspaceenv.sh"
fi
if [ -f "$PADOGRID_WORKSPACE/clusters/$CLUSTER/.cluster/clusterenv.sh" ]; then
   . "$PADOGRID_WORKSPACE/clusters/$CLUSTER/.cluster/clusterenv.sh"
fi
export CLUSTER
export CLUSTER_TYPE
export POD
export PRODUCT
```
- Fixed a Linux bug in `update_products` that printed the following message.
  ```console
  sed: can't read 0: No such file or directory
  ```

----

## Version 0.9.9

### Release Date: 08/16/21

- Added preliminary support for Kafka. Kafka support is limited to the new RAFT mode and hence requires Kafka 2.8.0 or a later version. Kafka support is limited to local clusters.
- Added preliminary support for Hadoop running in the semi-pseudo mode with support for mutiple data nodes. Hadoop support is limited to local clusters.
- Added java support in `update_products`, which is now preferred over `change_version`.
- Reassigned default ports to prevent port conficts between clusters. See [**Default Port Numbers**](https://github.com/padogrid/padogrid/wiki/Default-Port-Numbers) for details.
- Added full support for Jupyter and VS Code. They are no longer expermimental. Please see the [Integrated Tools](https://github.com/padogrid/padogrid/wiki/Integrated-Tools) section for details.
- The `list_*` commands now support `-rwe` for listing components in a specific RWE and workspace.

----

## Version 0.9.8

### Release Date: 07/24/21

- `padogrid -?` now displays a complete list of commands grouped by components with short descriptions.
- Added the `-product` option to `create_docker`,`create_k8s`, and `create_app` to target a specific product.
- Added support for managing cluster groups. With this support, a group of clusters can be created and managed using the new `_group` commands. These commands are particularly useful for managing Pado (federated grids) or dependent clusters. Heterogeneous products are allowed in a group.
- Added the entry point, `init_bundle.sh`, for intializing bundle during installation. If this script exists in the root directory of the bundle then the `install_bundle` triggers it upon completion of bundle installation. Note that this applies to workspace bundles only, i.e., bundles must be installed by using `install_bundle -checkout` or `install_bundle -workspace -download`.
- Added the `open_vscode` command that integrates PadoGrid workspaces with Visual Studio Code.
- Docker cluster support is now compliant with Hazelcast 4.x changes.

----

## Version 0.9.7

### Release Date: 06/27/21

- Added experimental Jupyter commands for creating a PadoGrid/Jupyter workspace integrated environment. These commands are subject to change in future releases.
- Added support for installing bundles with multiple products and versions. The new bundle installation mechanism introduces the `required_products.txt` file for listing product versions. You must now provide a complete list of products and their versions that are required to install and run the bundle in this file. The previous file name based, single product installation method has been deprecated and its support will eventually be dropped. 
- Added `update_products` for interatively updating product versions.
- Fixed the logic that incorrectly set the cluster type when creating a Geode/GemFire cluster.
- Product paths are now correctly reset for workspaces hosting heterogeneous products. Prior to this fix, the switched workspace continue to use the previous workspace's products even though it may not have defined them.

----

## Version 0.9.6

### Release Date: 05/31/21

- Added support for managing Pado. In anticipation of the upcoming release of Pado that runs on the latest versions of Geode and GemFire, PadoGrid now includes support for managing Pado grids.
- Added `make_cluster` for creating a cluster with a product of your choice. Unlike `create_cluster` which is product specific, `make_cluster` allows you to specify any of the supported products.
- Added `show_products` for displaying installed product versions with the current workspace version hightlighted.
- Added the `install_padogrid` command for automatically installing one or more products. By default, it runs in the interactive mode, providing product version lists from which you can select products to install. For auto-installation, run `install_padogrid -quiet` which non-interactively installs PadoGrid along with all the latest downlodable products. Note that it also creates a new RWE if you are installing PadoGrid for the first time in the specified PadoGrid environment base path.
- Added `switch_pod` and `pwd_pod` for pod context switching.
- Added support for running heterogeneous cluster products in a single workspace. With this support, you can now create clusters for any products in a local workspace and run them concurrently, provided that there are no port conflicts. Please see the [**Default Port Numbers**](https://github.com/padogrid/padogrid/wiki/Default-Port-Numbers) section in the manual for details.
- Added lifecycle management support for Spark which joins the growing list of clustering products natively supported by PadoGrid out of the box. This release supports the Spark's "standalone" deployment option.
- The pod VMs are now configured without the Avahi network discovery service by default. To enable Avahi, specify the `-avahi` option when executing the `create_pod` command.
- Added pod management commands, `show_pod`, `list_pods`, `switch_pod`, `cd_pod`. With these commands, you can now manage pods like other first-class components, i.e., clusters, workspaces and RWEs.
- Clusters created in the VM-enabled workspaces can now seamlessly run with or without pods. If a cluster is attached to a pod, then it automatcially inherits the workspace's VM configuration, allowing you to manage clusters from either the host OS or any of the guest OS VMs.
- Vagrant VMs can now be logged in without password. Examples: `ssh vagrant@pnode.local`, `ssh vagrant@node-01.local`, etc.
- Vagrant pods are now configured as VMs.

### Known Issues

- For cluster management, Cygwin support is limited to Hazelcast and Coherence. The other products may not work due to limitations and bugs in their respective scripts. To support the remaining products, PadoGrid will include extended product scripts in the next lrease. Note that non-cluster features are fully supported for all products on Cygwin.
- This release may not be fully compatible with the previous releases. You might encounter cluster and auto-completion issues if your workspaces were created prior to this release. This is due to the addition of the new support for hosting heterogeneous products per workspace. To avoid this problem, please migrate your workspaces to this release by following the instructions provided in the [**Migrating Workspaces**]((https://github.com/padogrid/padogrid/wiki/Migrating-Workspaces) section of the PadoGrid manual.
- `start_pod` cannot be restarted pods. The pod managment facility is currently undergoing strutural changes to provide additional commands that can be executed outside of the pods. You will need to remove and rebuild the pod until this bug is fixed.

----

## Version 0.9.5

### Release Date: 03/18/21

- Changed local settings of Vagrant pods to run as VMs.
- Fixed the command completion ending issue. The command completion now blocks if all options have been exhausted.
- Added support for naming workspaces for `install_bundle` and `create_bundle`. Using the `-workspace` option you can now set a workspace name when you install or create a bundle.
- Tidied up command auto-completion with additional support for changing directory for `cd_*` and `switch_*` commands. You can now drill into the target directory by hitting the \<tab\> key. 
- `show_bundle` now prints the bundle URLs. You can click on the URLs to view the bundle instructions in the web browser. macOS: Command-Mouse, Windows: Control-Mouse.
- Added PDX/Avro code generator for Geode/GemFire.
- Added Kryo/Avro support for Geode/GemFire.
- Merged Debezium JSON support between Hazelcast and Geode.
- Added `find_padogrid` for searching files in PadoGrid. You can now perform a global search on your RWEs for any files that are part of workspace installations.
- Added support for DB ingestion and updated `test_group` with `clear` support in Geode.

----

## Version 0.9.4

### Release Date: 01/10/21

- Fixed a VM synchronization and vm key bug.
- RWE now selects the first workspace found as the default workspace if the default workspace is not defined.
- Added Jet core module that includes support for Kafka stream aggregator. The aggregator is a Jet sink job capable of transforming Kafka events from multiple topics into an object graph based on temporal entity relationships.
- `perf_test` now supports data structures other than Hazelcast IMap. Supported data structures are IMap, ReplicatedMap, ICache, ITopic, ReplicatedTopic, and IQueue.
- `perf_test` now supports the `sleep` operation for simulating workflows.
- Added integrated support for Pado. You can now create a Pado cluster using the `create_cluster -type pado` command, which creates a Pado cluster that includes the ETL, security and test tools.
- Pado Desktop is also available for managing Pado clusters.
  
----

## Version 0.9.3

### Release Date: 09/23/20

- Added support for all JDK version. Further tests required.
- Added support for generating '-all' dependencies. Each product module now has a `padogrid-<product>-all-*.jar` file containing a complete set compiled classes. You can now include just a single `-all` jar file in your class path.
- Added the `-workspace` option to `install_bundle` for checking out bundles in the form of workspaces. With this option, you can now develop and test online bundles from workspaces and check in your changes directly from there.
- Added support for Hazelcast ReplicatedMap in the Debezium connector.
  
----

## Version 0.9.2

### Release Date: 07/25/20

- Added AVRO and Kryo code generators for Hazelcast.
- Added cluster support for SnappyData/ComputeDB.
- Added cluster support for Coherence.
- Added support for Gitea. You can now create catalogs in private Gitea repos
- Added Minishift support for Hazelcast.
- Added OpenShift support for Hazelcast.
- Added Jet 4.x support for the `jet_demo` app.

----

## Version 0.9.1

### Release Date: 04/20/20

- Initial consolidated release.
- Most of the merged features have been tested and fully operational.
- In need of additional clean up in the area of docs, VMs, and common commands.
- This version serves as the base version for supporting additional products other than Geode/GemFire and Hazelcast/Jet.
