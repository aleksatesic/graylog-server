#!/bin/bash

err_line="Usage: bash deploy.sh -u <username> -e <test|production>"

info() {
  echo "env:" $environment
  echo "user:" $user
  echo "playbook:" ${playbook}
}

while getopts "u:e:h" optname
  do
    case "${optname}" in
      "u")
        user=${OPTARG} # sudo capable user
        ;;
      "e")
        if [[ ${OPTARG} = "test" ]] || \
           [[ ${OPTARG} = "production" ]]; then
            environment=${OPTARG}
        else
            echo "Environment must be test|production"
            exit 1
        fi
        ;;
      "h")
        echo ${err_line}
        exit 1
        ;;
      "?")
        echo ${err_line}
        exit 1
        ;;
      ":")
        echo "No argument value for option ${OPTARG}"
        exit 1
        ;;
      *)
      # Should not occur
        echo "Unknown error while processing options"
        exit 1
        ;;
    esac
  done

if [ ${user} = "vagrant" ] || [ ${user} = "ubuntu" ]; then
  playbook=deploy-test.yml
  info;
  echo graylog-test
  ANSIBLE_COW_SELECTION=random ansible-playbook -i graylog-test ${playbook} --ask-vault-pass
else
  playbook=deploy-production.yml
  info;
  echo graylog-production
  ansible-playbook -v -i graylog-production ${playbook} --ask-become-pass --ask-vault-pass
fi
