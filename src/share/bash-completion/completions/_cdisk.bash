_cdisk()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="create open close list list-open --config -c --verbose -v"

    case "$prev" in
        open)
            local -r closed="$(comm -23 <(cdisk list) <(cdisk list-open))"
            mapfile -t COMPREPLY < <(compgen -W "$closed" -- "$cur")
            return 0
            ;;
        close)
            local -r disks="$(cdisk list-open)"
            [[ -n "$disks" ]] && mapfile -t COMPREPLY < <(compgen -W "$disks" -- "$cur")
            return 0
            ;;
        create) return 0 ;;
        list|open-all|close-all) return 0 ;;
        *)
        ;;
    esac

    mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
    return 0
}

complete -F _cdisk cdisk
