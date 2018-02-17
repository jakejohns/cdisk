## NAME
    cdisk - Manage encrypted disk images

## USAGE
    cdisk create NAME SIZE
    cdisk open NAME
    cdisk close NAME
    cdisk destroy NAME
    cdisk list
    cdisk list-open

## COMMANDS
    create NAME SIZE
        Create a new encrypted image
        NAME    name of disk
        SIZE    size of disk

    open NAME
        Open and mount a disk
        NAME    name of disk

    close NAME
        Unmount and close a disk
        NAME    name of disk

    destroy NAME
        Destroy disk image
        NAME    name of disk

    list
        list disks

    list-open
        list opened disks

## CONFIGURATION
    The global configuration script will be sourced if it exists, followed by
    the by a disk specific configuration if it exists. The configuration file
    can override methods or define the following to override the defaults:
        keyfile - path to encrypted keyfile
        disk - path to disk image
        header - path to disk header
        mapper - path to mapper
        mount - path to mount disk at

    Additionally, you can define an "init" function which will be called before
    any operation. This can be used, for example, to check for the existence of
    some external media which is intended to store headers and keys


## ENVIRONMENT VARIABLES
    CDISK_DISKS
        Defines the path to directory of disk files

    CDISK_HEADERS
        Defines path to directory of header files

    CDISK_KEYS
        Defines path to directory of key files

    CDISK_MOUNTS
        Defines path to directory to mount disks at

    CDISK_CONFIGS
        Defines path to directory to look for named disk configs

    CDISK_CONFIG
        Defines path to global config file

## SEE ALSO
    gpg(1), cryptsetup(8)

