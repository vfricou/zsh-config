#!/usr/bin/zsh -e

usage() {

    printf "Usage of command ansible_init :\n"
    printf "  -h : Display this help\n"
    printf "  -r : Roles to create (Format : role1,role2)\n"
    printf "  -p : Playbook project folden\n"
    printf "  -a : Ansible init playbook path\n"
    exit 3
}


while getopts ":r:p:a:h" args
do
    case "${args}" in
        h)
            usage
        ;;
        r)
            O_ROLES="${OPTARG}"
        ;;
        p)
            O_PROJ_PATH="${OPTARG}"
        ;;
        a)
            O_ANSIBLE_INIT_PBK_PATH="${OPTARG}"
        ;;
    esac
done

ROLES=($(echo "${O_ROLES}" | tr ',' '\n'))

ansible_extra_vars="{ \"roles\": ["

for role in "${ROLES[@]}"
do
    ansible_extra_vars="${ansible_extra_vars}\"${role}\","
done
ansible_extra_vars="${ansible_extra_vars}],"
ansible_extra_vars=($(echo "${ansible_extra_vars}" | sed -e 's/,]/]/g'))

ansible_extra_vars="${ansible_extra_vars} \"project_dir\": \"${O_PROJ_PATH}\" }"


printf "Ansible command used : ansible-playbook init.yml -i inv -e %s init.yml\n" "${ansible_extra_vars}"
pushd "${O_ANSIBLE_INIT_PBK_PATH}"
ansible-playbook init.yml -i inv -e ${ansible_extra_vars}
popd
