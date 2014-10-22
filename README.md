CONTENT
=======

This artifact contains scripts and configuration files stored in remote machines.

```
remote/             ==> the main folder equivalent to /opt/shared/ folder in lustre
   scripts/         ==> contains start scripts
   configuration/   ==> contains configuration files for logging, localization, etc.
```

BRANCHES
========

There exist 4 branches

* **master**: all development does here
* **env/dev**: what you merge here goes to dev environment
* **env/tqa**: what you merge here goes to tqa environment
* **env/prd**: what you merge here goes to prd environment

RELEASE PROCEDURE
=================

1) Make your changes in master branch
2) Merge the changes to related environment branch when completed
3) Check bamboo to see if it deploys successfully